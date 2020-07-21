<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>

<title>동물관리 홈</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-material-datetimepicker/2.7.1/css/bootstrap-material-datetimepicker.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<%@ include file="/WEB-INF/include/import.jsp"%>

<style>
	.fc-toolbar-title, a.fc-col-header-cell-cushion, th {
		color: black;
	}
	
	.icons {
		font-size: 15px;
		color: orange;
	}
	
	#wrapper {
		display: inline-block;
		/* margin: 0 auto; */
	}
	
	.card-img-top {
		margin-top: 16px;
	}
	
	.card {
		margin-left: 10px;
		margin-right: 10px;
	}
	
	#tab-list {
		margin: 0 auto;
	}
	
	#tab-row {
		margin-bottom: 100px;
		margin-top: 73px;
	}
	
	.form-check {
		margin-left: 5px;
		margin-top: 8px;
	}
	
</style>

</head>
<body>

	<%@ include file="/WEB-INF/include/headerAndNavi.jsp"%>
	<c:set value="${petInfoList}" var="petInfo" />

	<div class="container">
		<div class="side_overlay">
			<div class="row">
				<div class="col-12">
							<div class="row">
								
									<div class="card col-4" style="width: 20rem;">
										<img class="card-img-top"
											src="${pageContext.request.contextPath}/assets/images/${pet.petimg}"
											rel="nofollow" alt="card image">
										<div class="card-body">
											<h4>${pet.petname}</h4>
											<p class="card-text" id="petInfo">
												<fmt:parseNumber var="age" value="${pet.age/12}"
													integerOnly="true" />
												${pet.scaname} | ${pet.size == 'small' ? '소형':petInfo.size == 'medium'? '중형':'대형'}${pet.mcategory == '1' ? '견':'묘'}
												| ${pet.weight}kg | <br> ${age}년
												${pet.age%12}개월 | ${pet.sex == 'female' ? '암컷':'수컷' }
												| ${pet.nstate == 'n' ? '중성화X':'중성화O'} | <br>
												${pet.memo}
											</p>
											<div>

												<!-- 나중에 아이콘으로 바꾸기~~~ -->

												<!-- <a><span class="icons"><i class="fas fa-pen"></i></span></a> -->
												<a href="edit.bit?petindex=${pet.petindex}">수정</a>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<!-- <span class="icons"><i class="fas fa-times"></i></span> 삭제 아이콘...-->
												<a href="delete.bit?petindex=${pet.petindex}">삭제</a>
											</div>
										</div>
									</div>
					</div>			
				</div>
			</div>
			<!-- side_overlay end -->

		</div>
		<!-- side_overlay end -->

	</div>
	<!-- container end -->

	<!--  지도 Modal -->
	<div class="modal fade" id="mapModal" tabindex="-1" role="dialog"
		aria-labelledby="myFullsizeModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content"
				style="width: auto; height: 800px; display: table;">
				<div class="modal-header justify-content-center">
					<h2>내 근처 동물 병원 찾기</h2>
				</div>
				<div class="map_wrap">

					<div id="map" style="width: 500px; height: 300px;"></div>

					<!-- 지도크기를 변경할수있다. -->
					<div id="menu_wrap"
						style="height: 300px; width: 485px; position: relative;"
						class="bg_white">
						<!-- 지도 검색창 style="display: none;" 안나오게 하는거-->
						<div class="option">
							<div>
								<!--  <input type="text" value="${user.loc}동물병원" id="keyword" size="15">  -->
								<form onsubmit="searchPlaces(); return false;">
									키워드 : <input type="text" value="${user.loc}동물병원" id="keyword"
										size="15">
									<button type="submit">검색하기</button>
								</form>
							</div>
						</div>
						<hr>
						<ul id="placesList"></ul>
						<div id="pagination"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 지도 modal end -->

	<%@ include file="/WEB-INF/include/footer.jsp"%>
</body>

<!-- fullcalendar -->
<link href='https://unpkg.com/fullcalendar@5.1.0/main.min.css'
	rel='stylesheet' />
<script src='https://unpkg.com/fullcalendar@5.1.0/main.min.js'></script>

<!-- moment.js > 시간 관련 -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.27.0/locale/ko.min.js"></script>
<script
	src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.20.1/moment.min.js'></script>

<!-- SweetAlert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71ca5990924535d51e3f23984b8c42e5&libraries=services"></script>
<script>
$(function() {
	
	console.log('로그인한 유저 아이디: ${sessionScope.user.userid}');
	
	//datetimepicker
	$("#start, #end").bootstrapMaterialDatePicker({
		format: 'YYYY-MM-DD HH:mm',
		lang: 'ko',
		okText: '확인',
		cancelText: '취소'
	});

	var calendarEl = document.getElementById('calendar');
	var addBtnContainer = $('.modalBtnContainer-addEvent');
	var modifyBtnContainer = $('.modalBtnContainer-modifyEvent');

	// 풀캘린더 그리기
	var calendar = new FullCalendar.Calendar(calendarEl, {
		
		editable: true,
		selectable: true,
		locale: 'ko',
		initialView: 'dayGridMonth',
		contentHeight: 1000,
		headerToolbar: {
			left: 'prev,next today',
			center: 'title',
			right: 'dayGridMonth,timeGridWeek,timeGridDay'
		},
		eventColor: '#E6CDED', //default 컬러 설정
		events: getSchedule(),
		select: function(start, end, allDay) {

			// 빈 칸으로 초기화
			$('#allday').prop("checked", false);
			$('#title').val('');
			$('#start').val('');
			$('#end').val('');
			$('#content').val('');

			// 모달 타이틀 바꾸기
			$('#modal-title-for-edit').hide();
			$('#modal-title-for-add').show();

			// 모달 버튼 바꾸기
			modifyBtnContainer.hide();
			addBtnContainer.show();

			// 모달 열기
			$('#createEventModal').modal('show');

			$('#save-event').on('click', function() {

				var start = $('#start').val();
				var end = $('#end').val();
				var titleVal = $('#title').val();
				var contentVal = $('#content').val();
				var petindexVal = $('#petindex').val();
				
				// #allday 체크 여부에 따라 값 부여하기 
				var allday = $('#allday');
				var isallDay = "";
				
				if(allday.is(':checked')) { isallDay = allday.val(); }
				else { isallDay = 0; }
				
				var eventData = {
					userid: '${sessionScope.user.userid}',
					petindex: petindexVal,
					title: titleVal,
					start: moment(start).format('YYYY-MM-DD HH:mm:ss'),
					end: moment(end).format('YYYY-MM-DD HH:mm:ss'),
					content: contentVal,
					allday: isallDay //(allday=true면 네모칸으로 나오고 false면 점으로 나옴)
					// type: editType.val(),
					// username: '사나',
					// backgroundColor: editColor.val(),
					// textColor: '#ffffff',
				};

				if(eventData.title == "") {
					swal('일정명을 입력하세요.');
					return false;
				}

				if(eventData.start > eventData.end) {
					swal('끝나는 날짜가 시작 날짜보다 앞설 수 없습니다.');
					return false;
				}

				calendar.addEvent(eventData);
				//calendar.render();
				$('#createEventModal').modal('hide');

				$.ajax({
					type: "get",
					data: eventData,
					dataType: "JSON",
					url: "insertSchedule.bit",
					success: function(data) {
						console.log(data); //result값인 0(실패) 또는 1(성공) 출력
					},
					error: function(e) {
						console.log("insert에러: "+e);
					}
				});
				
			}); // /.저장하기
			
			
		},
		eventClick: function(info) {

			var schedule = getSchedule();
			console.log("dfdf: "+schedule);
			$.each(schedule, function(index, ele) {
					$.each(ele, function(a, b) {
						console.log("a: "+a);
						console.log("b: "+b);
						});
				});

			// 모달 타이틀 바꾸기
			$('#modal-title-for-add').hide();
			$('#modal-title-for-edit').show();

			// 모달 버튼 바꾸기
			addBtnContainer.hide();
			modifyBtnContainer.show();

			// 모달 열기
			$('#createEventModal').modal('show');

			var title = info.event.title;
			var start = info.event.start;
			var end = info.event.end;
			var allday = info.event.allDay;

			if(end === null) { //null인 경우가 없긴 한데... 사용자 생각하면...-ㅂ-
				end = start;
			}

			console.log(start+"/"+end);
			
			if(allday === true) {
				$('#allday').prop("checked", true);
			} else {
				$('#allday').prop("checked", false);
			}

			$('#start').val(moment(start).format('YYYY-MM-DD HH:mm'));
			
			if(allday === true && end !== start) {
				$('#end').val(moment(end).subtract(1, 'days').format('YYYY-MM-DD HH:mm'));
			} else {
				$('#end').val(moment(end).format('YYYY-MM-DD HH:mm'));
			}
			

			$('#title').val(title);
			$('#content').val(info.event.content); //이건 안 됨;
			//$('#start').val(info.event.start);
			//$('#end').val(info.event.end);

			$('#updateEvent').on('click', function() {
				/*
				$('#title').val('');
				$('#content').val('');
				$('#start').val('');
				$('#end').val('');
				$('#allday').prop("checked", false);
				$('#modal-title-for-add').show();
*/
				$('#createEventModal').modal('hide');
			});

			var event = info.event;
			
			$('#deleteEvent').on('click', function(event) {
				event.remove();
			});
				
		}
		
	});
	
	calendar.render();

	/////////////////////////////////////////////함수 영역/////////////////////////////////////////////

	
	// 일정 불러오기
	function getSchedule() {

		var schedule = [];

		$.ajax({
			url: "getSchedule.bit",
			data: { userid : '${sessionScope.user.userid}' },
			dataType: "json",
			async: false,
			success: function(response) {
				$.each(response.schedule, function(index, element) {
					var viewData = {};
					viewData["title"] = element.title;
					viewData["start"] = element.start;

					if(element.allday == '1') {
						viewData["allDay"] = true;
					} else {
						viewData["allDay"] = false;
					}
					
					if(element.allday == '1' && element.start !== element.end) {
 						viewData["end"] = moment(element.end).add(1, 'days').format('YYYY-MM-DD HH:mm:ss');
					}
					//viewData["end"] = moment(element.end).format('YYYY-MM-DD HH:mm:ss');

					viewData["color"] = '#E6CDED'; //컬럼에 컬러값이 있어야 색깔별로 출력할 수 있을 듯... 어쨌든 여기에 적용하면 적용됨
					console.log("콘텐츠: "+element.content);
					schedule.push(viewData);
				});
			}
		});

		return schedule;
	} // /.getSchedule()
	
}); // /.$(function)

<!-- management  main ajax 페이징 부분-->
/* ajax 시작 */
$(function (){

	//페이징 비동기 시작(Mrecord)
	function page(cp){
		console.log('cp='+cp);
		$('#zero_config_paginate').empty();
		var pageSize = $('#paging option:selected').val();
		var totalmrecordcount = $('#totalmrecordcount').val();

		var pageCount;
		console.log('pageSize= '+pageSize);
		console.log('totalmrecordcount= '+ totalmrecordcount);
		if((totalmrecordcount % pageSize) == 0){
			pageCount = totalmrecordcount/pageSize;
		}else if(totalmrecordcount/pageSize<1){
			pageCount=1;
		}else{
		
			pageCount = Math.floor(totalmrecordcount/pageSize + 1); 
		}
		
		console.log('pageCount = '+pageCount);
		let tmp="";
		console.log('시피 = '+cp);
		if(cp>1){
			tmp +='<a href="getMrecordList.bit?cp=${cpage-1}&ps='+pageSize+'" cp="'+(cp-1)+'" ps="'+pageSize+'">이전</a>';
		}
		//page 목록 나열하기
		for(var i=1;i<=pageCount; i++){
			if(cp==i){
				tmp +=('<font color="red">['+i+']</font>');
			}else{
				tmp +=('<a href="getMrecordList.bit?cp='+i+'&ps='+pageSize+'" cp="'+i+'" ps="'+pageSize+'" >['+i+']</a>');
			}
		}
		//다음 링크
		if(cp<pageCount){
			tmp += '<a href="getMrecordList.bit?cp=${cpage+1}&ps='+pageSize+'" cp="'+(cp+1)+'" ps="'+pageSize+'">다음</a>';
		};
		$('#zero_config_paginate').append(tmp);
	};

	/* 페이징 비동기  끝*/
});


//카카오 지도 script

$('#mapModal').on('shown.bs.modal', function () {


// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.4923615, 127.02928809999999), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 




//HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {
    
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
        
        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
        
        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
            message = '<div style="padding:5px;">현재 위치입니다.</div>'; // 인포윈도우에 표시될 내용입니다
        
        // 마커와 인포윈도우를 표시합니다
        displayMarker(locPosition, message);
        console.log(navigator)
        //위치를 가지고오는건데 못찾는다....
      });
    
} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation을 사용할수 없어요..'
        
    displayMarker(locPosition, message);
}

//지도에 마커와 인포윈도우를 표시하는 함수입니다
function displayMarker(locPosition, message) {

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({  
        map: map, 
        position: locPosition
    }); 
    
    var iwContent = message, // 인포윈도우에 표시할 내용
        iwRemoveable = true;

    // 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({
        content : iwContent,
        removable : iwRemoveable
    });
    
    // 인포윈도우를 마커위에 표시합니다 
    infowindow.open(map, marker);
    
    // 지도 중심좌표를 접속위치로 변경합니다
    map.setCenter(locPosition);      
}    


// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다

function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}

}); 
//카카오 지도 script

</script>
</html>