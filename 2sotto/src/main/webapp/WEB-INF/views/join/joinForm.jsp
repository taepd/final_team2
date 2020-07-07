<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<html>
<head>

<title>회원 가입</title>

<%@ include file="/WEB-INF/include/import.jsp"%>

<!-- 아래 jquery cdn을 주석처리하면 중복체크 속성값이 인풋창 클릭시 리셋되는 문제 발생. 어째서? -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<!-- 카카오 api -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=14e1cd5829baabce1e0239e9778eb76a&libraries=services"></script>
<!-- 카카오 주소 api 호출 -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<style>
.btn-file {
	position: relative;
	overflow: hidden;
}

.btn-file input[type=file] {
	position: absolute;
	top: 0;
	right: 0;
	min-width: 100%;
	min-height: 100%;
	font-size: 100px;
	text-align: right;
	filter: alpha(opacity = 0);
	opacity: 0;
	outline: none;
	background: white;
	cursor: inherit;
	display: block;
}

/*------------------------------------------------------------------
[ Input ]*/

/* .wrap-input100 { */
/* 	display: -webkit-box; */
/* 	display: -webkit-flex; */
/* 	display: -moz-box; */
/* 	display: -ms-flexbox; */
/* 	display: flex; */
/* 	flex-wrap: wrap; */
/* 	align-items: flex-end; */
/* 	width: 100%; */
/* 	/*   height: 80px; */
/* 	padding: 100px; */
/* 	position: relative; */
/* 	border: 1px solid #e6e6e6; */
/* 	border-radius: 10px; */
/* 	margin-bottom: 10px; */
/* } */
.wrap-input100 {
	width: 100%;
	/*   height: 80px; */
	padding: 100px;
	position: relative;
	border: 1px solid #e6e6e6;
	border-radius: 10px;
	margin-bottom: 10px;
	text-align: center;
}

input {
	outline: none;
	margin: 0;
	border: none;
	-webkit-box-shadow: none;
	-moz-box-shadow: none;
	box-shadow: none;
	width: 100%;
	font-size: 14px;
	font-family: inherit;
}

.input--style-4 {
	line-height: 50px;
	background: #fafafa;
	-webkit-box-shadow: inset 0px 1px 3px 0px rgba(0, 0, 0, 0.08);
	-moz-box-shadow: inset 0px 1px 3px 0px rgba(0, 0, 0, 0.08);
	box-shadow: inset 0px 1px 3px 0px rgba(0, 0, 0, 0.08);
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	padding: 0 20px;
	font-size: 16px;
	color: #666;
	-webkit-transition: all 0.4s ease;
	-o-transition: all 0.4s ease;
	-moz-transition: all 0.4s ease;
	transition: all 0.4s ease;
}

.input--style-4::-webkit-input-placeholder {
	/* WebKit, Blink, Edge */
	color: #666;
}

.input--style-4:-moz-placeholder {
	/* Mozilla Firefox 4 to 18 */
	color: #666;
	opacity: 1;
}

.input--style-4::-moz-placeholder {
	/* Mozilla Firefox 19+ */
	color: #666;
	opacity: 1;
}

.input--style-4:-ms-input-placeholder {
	/* Internet Explorer 10-11 */
	color: #666;
}

.input--style-4:-ms-input-placeholder {
	/* Microsoft Edge */
	color: #666;
}

.label {
	font-size: 16px;
	color: #555;
	text-transform: capitalize;
	display: block;
	margin-bottom: 5px;
}

.input-group {
	position: relative;
	margin-bottom: 22px;
}

.input-group-icon {
	position: relative;
}

.input-icon {
	position: absolute;
	font-size: 18px;
	color: #999;
	right: 18px;
	top: 50%;
	-webkit-transform: translateY(-50%);
	-moz-transform: translateY(-50%);
	-ms-transform: translateY(-50%);
	-o-transform: translateY(-50%);
	transform: translateY(-50%);
	cursor: pointer;
}

/* ==========================================================================
   #GRID
   ========================================================================== */
.row {
	display: -webkit-box;
	display: -webkit-flex;
	display: -moz-box;
	display: -ms-flexbox;
	display: flex;
	-webkit-flex-wrap: wrap;
	-ms-flex-wrap: wrap;
	flex-wrap: wrap;
}

.row-space {
	-webkit-box-pack: justify;
	-webkit-justify-content: space-between;
	-moz-box-pack: justify;
	-ms-flex-pack: justify;
	justify-content: space-between;
}

.col-2 {
	width: -webkit-calc(( 100% - 30px)/2);
	width: -moz-calc(( 100% - 30px)/2);
	width: calc(( 100% - 30px)/2);
}

@media ( max-width : 767px) {
	.col-2 {
		width: 100%;
	}
}
</style>

<script type="text/javascript">
	var validate = new Array;
	$(function() {
		//id검증(이메일 형식)
		$('#userid')
				.keyup(
						function() {
							let email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
							if (!email.test($('#userid').val())) {
								$('.tdemail')
										.html(
												'<b style="color:red">적합하지 않은 이메일 형식입니다.</b>');
								validate[0] = false;
							} else {
								$('.tdemail').html('<b>적합한 이메일입니다.</b>');
								validate[0] = true;
							}
							console.log(validate[0]);
						});

		//nick검증(nick 형식) 필요할것같아서 미리 만들었습니다.
		/*
		$('#nick')
				.keyup(
						function() {
							let nick = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
							if (!nick.test($('#nick').val())) {
								$('.tdnick')
										.html(
												'<b style="color:red">적합하지 않은 닉네임 형식입니다.</b>');
								validate[0] = false;
							} else {
								$('.tdnick').html('<b>아주 멋진 닉네임입니다.</b>');
								validate[0] = true;
							}
							console.log(validate[0]);
						});
						*/

		//password
		$('#pwd')
				.keyup(
						function() {
							let pwd = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{8,20}$/;
							if (!pwd.test($(this).val())) {
								$('.tdpw')
										.html(
												'<b style="color:red">8~20자 사이에 적어도 하나의 영어대문자,숫자, 특수문자가 포함되어야 합니다.</b>');
								validate[1] = false;
							} else {
								$('.tdpw').html('<b>적합한 패스워드입니다.</b>');
								validate[1] = true;
							}
							console.log(validate[1]);
						});
		//password check
		$('#pwdCheck, #pwd').keyup(function() {
			if ($('#pwd').val() != $('#pwdCheck').val()) {
				$('.tdpwch').html('<b style="color:red">비밀번호가 다릅니다.</b>');
				validate[2] = false;
			} else {
				$('.tdpwch').html('<b>비밀번호가 일치합니다.</b>');
				validate[2] = true;
			}
			console.log(validate[2]);
		});

		$('input').focus(function() {
			$(this).css('background-color', "gold");
		});
		$('input').blur(function() {
			$(this).css('background-color', "white");
		});
		//입력 다 했는지 검증
		$('input:not([type=file])').prop("required", true);
		//$('#id').attr("required","required");

		//submit 클릭시 올바르지 않은 입력 검증
		$('button:submit').click(function() {
			for (let i = 0; i < validate.length; i++) {
				if (validate[i] == false) {
					alert("올바르지 않은 입력이 있습니다.");
					console.log(i);
					switch (i) {
					case 0:
						$('#userid').focus();
						return false;
					case 1:
						$('#pwd').focus();
						return false;
					case 2:
						$('#pwdCheck').focus();
						return false;
					}
				}
			}
			if ($('#userid').attr("check_result") == "fail") {
				alert("아이디 중복확인을 해주시기 바랍니다.");
				$('#userid').focus();
				return false;
			}
		});
	});
</script>




</head>
<body>
	<!-- header -->
	<%@ include file="/WEB-INF/include/headerAndNavi.jsp"%>
	<!-- header -->




	<div class="side_overlay">

		<div class="container">


			<h1 class="logo" align="center">
				<a href="register.bit"><b>슬기로운 반려생활</b></a>
			</h1>

			<h3 class="logo" align="center">
				<a href="register.bit"><b>어서오시개, 가입하냥</b></a>
			</h3>
			<br>
			
			
			<div class="card-body">
					<div class="tab-content text-center">
					
				<!-- ============================================================== -->
				<!-- Start Page Content -->
				<!-- ============================================================== -->
				

				<div class="table-responsive">
						<form class="form-horizontal" action="normalJoin.bit"
							enctype="multipart/form-data" method="post">
							<div class="card-body">

								<div class="wrap-input100">
									<div class="form-group row">
										<div class="col-sm-12">

											<div class="row row-space">

												<div class="col-10">
													<div class="input-group">
														<label for="fname" class="label" style="text-align: left">아이디</label>
														<input class="input--style-4" type="text" maxlength="20"
															id="userid" name="userid"
															title="5~16자리의 영문+숫자 조합으로 입력해주세요"
															placeholder="이메일 형식으로 입력해 주세요" check_result="fail">
													</div>
												</div>

												<div class="col-2" style="padding-top: 22px">
													<button type="button" class="btn btn-primary"
														id="btn-idchk" style="padding: 10px 20px">중복확인</button>
												</div>
											</div>
										</div>
										<!-- 적합하지 않은 이메일 형식입니다. -->
										<div class="col-sm-9 tdemail" align="left"></div>
										<!-- 적합하지 않은 이메일 형식입니다. -->
									</div>

									<div class="form-group row">
										<div class="col-sm-12">
											<div class="row row-space">
												<div class="col-10">
													<div class="input-group">
														<label for="lname" class="label" style="text-align: left">비밀번호</label>
														<input class="input--style-4" type="password"
															maxlength="20" id="pwd" name="pwd"
															title="8~20자 사이에 적어도 하나의 영어대문자,숫자, 특수문자가 포함되어야 합니다."
															placeholder="비밀번호를 입력해주세요">
													</div>
												</div>
												<!-- 중복확인 아래 부분 -->
												<div class="col-2"></div>
												<!-- 중복확인 아래 부분 -->
											</div>
										</div>
										<!-- 8~20자 사이에 적어도 하나의 영어대문자,숫자, 특수문자가 포함되어야 합니다. -->
										<div class="col-sm-12 tdpw" align="left"></div>
										<!-- 8~20자 사이에 적어도 하나의 영어대문자,숫자, 특수문자가 포함되어야 합니다. -->
									</div>

									<div class="form-group row">
										<div class="col-sm-12">
											<div class="row row-space">
												<div class="col-10">
													<div class="input-group">
														<label for="email1" class="label" style="text-align: left">비밀번호
															확인</label> <input class="input--style-4" type="password"
															maxlength="20" id="pwdCheck" name="pwdCheck"
															title="패스워드 확인" placeholder="비밀번호를 입력해주세요">
													</div>
												</div>
												<!-- 중복확인 아래 부분 -->
												<div class="col-2"></div>
												<!-- 중복확인 아래 부분 -->
											</div>
										</div>
										<!-- 비밀번호가 다릅니다. -->
										<div class="col-sm-12 tdpwch" align="left"></div>
										<!-- 비밀번호가 다릅니다. -->
									</div>






									<div class="form-group row">
										<div class="col-sm-12">
											<div class="row row-space">
												<div class="col-10">
													<div class="input-group">
														<label for="cono1" class="label" style="text-align: left">닉네임</label>
														<input class="input--style-4" type="text" maxlength="20"
															id="nick" name="nick" title="닉네임"
															placeholder="사용할 닉네임을 입력해 주세요" check_result="fail">
													</div>
												</div>
												<div class="col-2" style="padding-top: 22px">
													<button type="button" class="btn btn-primary"
														id="btn-nickchk" style="padding: 10px 20px">중복확인 </button>
												</div>
											</div>
										</div>
										<!-- 닉네임 응원. -->
										<div class="col-sm-12 tdnick" align="left"></div>
										<!-- 닉네임 응원. -->
									</div>

									<div class="form-group row">
										<div class="col-sm-12">
											<div class="row row-space">
												<div class="col-10">
													<div class="input-group">
														<label for="cono1" class="label" style="text-align: left">휴대폰
															번호</label> <input class="input--style-4" type="text"
															maxlength="20" id="cpnumber" name="cpnumber" title="휴대폰"
															placeholder="휴대폰 번호를 입력해 주세요">
													</div>
												</div>
												<div class="col-2" style="padding-top: 22px">
													<button type="button" class="btn btn-primary"
														id="btn-cpnumberchk" style="padding: 10px 20px">인증 </button>
												</div>
											</div>
										</div>
										<div class="col-sm-12"></div>
									</div>


									<div class="form-group row">
										<div class="col-sm-12">
											<div class="row row-space">
												<div class="col-10">
													<div class="input-group">

														<label for="cono1" class="label" style="text-align: left">주소</label>

														<!-- 카카오 지도 API 적용 -->
														<input class="input--style-4" type="text" maxlength="20"
															size="45" id="loc" name="loc" title="주소-기본주소"
															placeholder="동명(읍,면)으로 검색 (ex.서초동)"> <input
															type="hidden" name="lat" id="lat"> <input
															type="hidden" name="lon" id="lon"> <br> <br>



														<button type="button" id="currentLoc"
															class="btn btn-primary social facebook btn-flat btn-addon mb-3"
															style="padding: 10px 20px">
															<i class="fa fa-crosshairs"></i>현재 위치로 찾기
														</button>

														<!-- 지도로 찾기 잠시 보류 <button type="button" class="btn btn-primary" id="searchMap">지도에서 찾기</button> -->
														<!-- 카카오지도 뿌려지는 곳 -->
														<!-- 	<div id="map" style="width:300px;height:300px;"></div>   -->

														<div id="layer"
															style="border-radius: 10px; margin-bottom: 10px; display: none; position: absolute; overflow: hidden; z-index: 1; top: 0px; left: 0px; max-width: 600px; width: 100%; height: 400px; border: 1px solid #e6e6e6;">
															<img
																src="//t1.daumcdn.net/postcode/resource/images/close.png"
																id="btnCloseLayer"
																style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1; width: 20px"
																alt="닫기 버튼">
														</div>

													</div>
												</div>
												<div class="col-2"></div>
											</div>
										</div>
										<div class="col-sm-12"></div>
									</div>

									<!-- 지도로 찾기 잠시 보류 <button type="button" class="btn btn-primary" id="searchMap">지도에서 찾기</button> -->
									<!-- 카카오지도 뿌려지는 곳 -->
									<!-- 	<div id="map" style="width:300px;height:300px;"></div>   -->

									<div class="form-group row">

										<div class="col-sm-12">
											<div class="row row-space">
												<div class="col-10">
													<div class="input-group">

														<label for="cono1" class="label" style="text-align: left">이미지
															추가</label>

														<div style="float: left;">
															<label class="btn btn-primary btn-default btn-file"
																style="padding: 10px 20px; margin-right: 80px">
																이미지 설정/변경 <input class="input--style-4" type="file"
																name="file" style="display: none;"
																onchange="readURL(this);" multiple>
															</label> &nbsp;&nbsp;&nbsp;&nbsp; <img id="uimg"
																src="upload/${param.umig}" alt="" width="150px"
																height="150px" style="border-radius: 10px;" /> <span
																id="imgFileName">&nbsp;&nbsp;${param.uimg}</span>
														</div>


													</div>
												</div>
												<div class="col-2"></div>
											</div>
										</div>
										<div class="col-sm-12"></div>
									</div>

								</div>
								<!-- wrap -->
							</div>
							<!-- form 다음 -->
							<div class="border-top">
								<div class="card-body" style="text-align: center;">
									<button type="submit" class="btn btn-primary"
										style="padding: 10px 20px">
										<b>전송</b>
									</button>
									<button type="reset" class="btn" style="padding: 10px 20px">취소</button>
								</div>
							</div>

						</form>
					</div>
			
				</div>

			</div>
		
		</div>

	</div>

<%@ include file="/WEB-INF/include/footer.jsp"%>

	<script>
		//카카오 지도
		/* 
		 $('#searchMap').click(function(){
		 var container = document.getElementById('map');
		 var options = {
		 center: new kakao.maps.LatLng(33.450701, 126.570667),
		 level: 3
		 };
		
		 var map = new kakao.maps.Map(container, options);
		 }); */
		//카카오지도 끝
		//카카오 주소
		var element_layer = document.getElementById('layer');
		var themeObj = {};
		function closeDaumPostcode() {
			element_layer.style.display = 'none';
		}
		var element_layer = document.getElementById('layer');
		$("#loc").click(function() {
			sample2_execDaumPostcode()
		})
		$("#btnCloseLayer").click(function() {
			closeDaumPostcode()
		})
		function sample2_execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}
							if (data.userSelectedType === 'R') {
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
							}
							//주소 인풋창에 입력
							$("#loc").val(addr);
							//주소값을 이용해서 좌표값 입력
							addrToCoor(addr);

							element_layer.style.display = 'none';
						},
						width : '100%',
						height : '100%',
						maxSuggestItems : 5,
						theme : themeObj
					}).embed(element_layer);
			element_layer.style.display = 'block';

		}

		//카카오 api활용 주소값으로 좌표값 얻어내기

		function addrToCoor(addr) {

			var geocoder = new daum.maps.services.Geocoder();

			// 주소로 좌표를 검색
			geocoder.addressSearch(addr, function(result, status) {

				// 정상적으로 검색이 완료됐으면,
				if (status == daum.maps.services.Status.OK) {

					$('#lat').val(result[0].y);
					$('#lon').val(result[0].x);

				}
			});
		}

		// html5 geolocation을 이용하여 현재 위치 값 받아내기

		$('#currentLoc')
				.click(
						function getLocation() {
							if (navigator.geolocation) { // GPS를 지원하면
								navigator.geolocation
										.getCurrentPosition(
												function(position) {
													alert(position.coords.latitude
															+ ' '
															+ position.coords.longitude);
													//위도/경도 값 저장
													$('#lat')
															.val(
																	position.coords.latitude);
													$('#lon')
															.val(
																	position.coords.longitude);

													console
															.log($('#lat')
																	.val());
													console
															.log($('#lon')
																	.val());
													//카카오 지도 api 라이브러리 활용, 좌표에서 주소로 변환 // 
													var geocoder = new kakao.maps.services.Geocoder();

													var coord = new kakao.maps.LatLng(
															position.coords.latitude,
															position.coords.longitude);
													var callback = function(
															result, status) {
														let currentAddr = result[0].address.address_name;
														if (status === kakao.maps.services.Status.OK) {
															console
																	.log('그런 너를 마주칠까 '
																			+ currentAddr
																			+ '을 못가');
														}
														$("#loc").val(
																currentAddr);

													};

													geocoder.coord2Address(
															coord.getLng(),
															coord.getLat(),
															callback);

													//카카오 지도api 라이브러리 활용, 좌표에서 주소로 변환 끝 //

												}, function(error) {
													console.error(error);
												}, {
													enableHighAccuracy : false,
													maximumAge : 0,
													timeout : Infinity
												});
							} else {
								alert('GPS를 지원하지 않습니다');
							}
						});
		//html5 geolocation을 이용하여 현재 위치 값 받아내기 끝
	</script>

	<script type="text/javascript">
		//***********************************//
		// 이미지 파일 업로드시 이미지 미리보기
		//***********************************//
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#img').attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
			$('#imgFileName').html(input.files[0].name);
		};

		//***********************************//
		//  아이디 중복 체크
		//***********************************//	

		$('#btn-idchk')
				.click(
						function() {
							//아이디 적합성 체크
							let email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
							if (!email.test($('#userid').val())) {
								alert('적합하지 않은 이메일 형식입니다');
								$('#userid').focus();
								return;
							}
							;
							//아이디 중복 체크
							$('#userid').change(function() {
								//$('#id_check_sucess').hide();
								$('#btn-idchk').show();
								$('#userid').attr("check_result", "fail");
							});
							

							if ($('#userid').val() == '') {
								alert('이메일을 입력해주세요.')
								return;
							}

							console.log($('#userid').val());

							$.ajax({
								type : "POST",
								url : 'join/idCheck.bit',
								data : {
									userid : $('#userid').val()
								},
								datatype : 'json',
								success : function(data) {
									console.log(data);
									if (data[0] != null) {
										alert("이미 존재하는 아이디 입니다.");
										$("#userid").val('');
										$("#userid").focus();
										return;
									} else {
										alert("사용가능한 아이디 입니다.");
										$('#userid').attr("check_result",
												"success");
										// $('#id_check_sucess').show();
										//$('#btn-idchk').hide();
										return;
									}
								}
							});
						});


		//***********************************//
		//  닉네임 중복 체크
		//***********************************//	

		$('#btn-nickchk')
				.click(
						function() {
							
							//닉네임 중복 체크
							$('#nick').change(function() {
								//$('#id_check_sucess').hide();
								$('#btn-nicchk').show();
								$('#nick').attr("check_result", "fail");
							});
							

							if ($('#nick').val() == '') {
								alert('닉네임을 입력해주세요.')
								return;
							}

							console.log($('#nick').val());

							$.ajax({
								type : "POST",
								url : 'join/nickCheck.bit', 
								data : {
									nick : $('#nick').val()
								},
								datatype : 'json',
								success : function(data) {
									console.log(data);
									if (data[0] != null) {
										alert("이미 존재하는 닉네임 입니다.");
										$("#nick").val('');
										$("#nick").focus();
										return;
									} else {
										alert("사용가능한 닉네임 입니다.");
										$('#nick').attr("check_result",
												"success");
										// $('#id_check_sucess').show();
										//$('#btn-idchk').hide();
										return;
									}
								}
							});
						});

		//***********************************//
		//  휴대폰번호 중복 체크
		//***********************************//	

		$('#btn-cpnumberchk')
				.click(
						/* function() {
							//휴대폰 번호 적합성 체크
							let cpnumber = /^\d{3}-\d{3,4}-\d{4}$/;
							if (!cpnumber.test($('#cpnumber').val())) {
								alert('적합하지 않은 휴대폰 번호 형식입니다');
								$('#cpnumber').focus();
								return;
							}
							;
							//휴대폰 중복 체크
							$('#cpnumber').change(function() {
								//$('#id_check_sucess').hide();
								$('#btn-cpnumberchk').show();
								$('#cpnumber').attr("check_result", "fail");
						 	});
							

							if ($('#cpnumber').val() == '') {
								alert('휴대폰 번호를 입력해주세요.')
								return;
							}

							console.log($('#cpnumber').val());

							$.ajax({
								type : "POST",
								url : 'join/cpnumberCheck.bit',
								data : {
									cpnumber : $('#cpnumber').val()
								},
								datatype : 'json',
								success : function(data) {
									console.log(data);
									if (data[0] != null) {
										alert("이미 존재하는 휴대폰 번호 입니다.");
										$("#cpnumber").val('');
										$("#cpnumber").focus();
										return;
									} else {
										alert("사용가능한 휴대폰 번호 입니다.");
										$('#cpnumber').attr("check_result",
												"success");
										// $('#id_check_sucess').show();
										//$('#btn-idchk').hide();
										return;
									}
								}
							});
						});  */

		
	</script>


	<script>
		/*colorpicker*/
		$('.demo').each(function() {
			//
			// Dear reader, it's actually very easy to initialize MiniColors. For example:
			//
			//  $(selector).minicolors();
			//
			// The way I've done it below is just for the demo, so don't get confused
			// by it. Also, data- attributes aren't supported at this time...they're
			// only used for this demo.
			//
			$(this).minicolors({
				control : $(this).attr('data-control') || 'hue',
				position : $(this).attr('data-position') || 'bottom left',
				change : function(value, opacity) {
					if (!value)
						return;
					if (opacity)
						value += ', ' + opacity;
					if (typeof console === 'object') {
						console.log(value);
					}
				},
				theme : 'bootstrap'
			});

		});
		/*datwpicker*/
		$('.mydatepicker').datepicker();
		$('#datepicker-autoclose').datepicker({
			autoclose : true,
			todayHighlight : true
		});
		var quill = new Quill('#editor', {
			theme : 'snow'
		})
	</script>
</body>
</html>