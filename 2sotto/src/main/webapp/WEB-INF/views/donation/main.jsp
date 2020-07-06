<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>

<title>홈_슬기로운 반려생활</title>

<%@ include file="/WEB-INF/include/import.jsp"%>




</head>
<body>
	<!-- header -->
	<%@ include file="/WEB-INF/include/headerAndNavi.jsp"%>
	<!-- header -->





	<div class="side_overlay">
		<div class="container">

			<button class="btn btn-primary btn-round"
				onclick="location.href='donationWrite.bit'">글쓰기</button>
			<!-- 탭 아이콘 영역 -->
			<!--  탭영역 음....기다린다 -->
			<div class="card card-nav-tabs">
				<div class="card-header card-header-primary">
					<!-- colors: "header-primary", "header-info", "header-success", "header-warning", "header-danger" -->
					<div class="nav-tabs-navigation">
						<div class="nav-tabs-wrapper">
							<ul class="nav nav-tabs" data-tabs="tabs">
								<li class="nav-item"><a class="nav-link active show"
									href="#donationlist" data-toggle="tab"> <!-- <i class="material-icons">face</i> -->
										<i class="material-icons">favorite</i> 후원글
										<div class="ripple-container"></div></a></li>
								<li class="nav-item"><a class="nav-link" href="#reply"
									data-toggle="tab"> <!-- <i class="material-icons">chat</i> -->
										<i class="material-icons">favorite</i> 댓글 많은 순
										<div class="ripple-container"></div></a></li>
								<li class="nav-item"><a class="nav-link" href="#favorite"
									data-toggle="tab"> <!-- <i class="material-icons">build</i> -->
										<i class="material-icons">camera</i> 좋아요 많은순
										<div class="ripple-container"></div></a></li>
							</ul>
						</div>
					</div>
				</div>

				<div class="card-body">
					<div class="tab-content text-center">
						<div class="tab-pane active show" id="donationlist">
							<!---------- 후원게시판 ------------------>

							<div class="table-responsive">
								<table class="table">
									<thead class=" text-primary">
										<tr>
											<th>글번호</th>
											<th>제목</th>
											<th>작성자</th>
											<th>등록시간</th>
											<th>조회수</th>

										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1</td>
											<td style="cursor:pointer;color:#blue;" onclick="location.href='qaView.bit'">후원이 필요합니다.</td>
											<td>김건휘</td>
											<td>2020.07.06</td>
											<td>1</td>
										</tr>
										<tr>
											<td>2</td>
											<td>후원이 필요합니다.</td>
											<td>김건휘</td>
											<td>2020.07.06</td>
											<td>1</td>
										</tr>
										<tr>
											<td>3</td>
											<td>후원이 필요합니다.</td>
											<td>김건휘</td>
											<td>2020.07.06</td>
											<td>1</td>
										</tr>
										<tr>
											<td>4</td>
											<td>후원이 필요합니다.</td>
											<td>김건휘</td>
											<td>2020.07.06</td>
											<td>1</td>
										</tr>
								</table>
							</div>


						</div>



						<div class="tab-pane" id="reply">
							<!---------- 댓글많은순 ------------------>

							<div class="table-responsive">
								<table class="table">
									<thead class=" text-primary">
										<tr>
											<th>글번호</th>
											<th>제목</th>
											<th>작성자</th>
											<th>등록시간</th>
											<th>조회수</th>

										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1</td>
											<td style="cursor:pointer;color:#blue;" onclick="location.href='qaView.bit'">후원이 필요합니다.</td>
											<td>쿼리안</td>
											<td>2020.07.06</td>
											<td>1</td>
										</tr>
										<tr>
											<td>2</td>
											<td>후원이 필요합니다.</td>
											<td>쿼리안</td>
											<td>2020.07.06</td>
											<td>1</td>
										</tr>
										<tr>
											<td>3</td>
											<td>후원이 필요합니다.</td>
											<td>쿼리안</td>
											<td>2020.07.06</td>
											<td>1</td>
										</tr>
										<tr>
											<td>4</td>
											<td>후원이 필요합니다.</td>
											<td>쿼리안</td>
											<td>2020.07.06</td>
											<td>1</td>
										</tr>
								</table>
							</div>



						</div>

						<!---------- 좋아요 많은순 ------------------>
						<div class="tab-pane" id="favorite">

							<div class="table-responsive">
								<table class="table">
									<thead class=" text-primary">
										<tr>
											<th>글번호</th>
											<th>제목</th>
											<th>작성자</th>
											<th>등록시간</th>
											<th>조회수</th>

										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1</td>
											<td style="cursor:pointer;color:#blue;" onclick="location.href='qaView.bit'">후원이 필요합니다.</td>
											<td>lim</td>
											<td>2020.07.06</td>
											<td>1</td>
										</tr>
										<tr>
											<td>2</td>
											<td>후원이 필요합니다.</td>
											<td>lim</td>
											<td>2020.07.06</td>
											<td>1</td>
										</tr>
										<tr>
											<td>3</td>
											<td>후원이 필요합니다.</td>
											<td>lim</td>
											<td>2020.07.06</td>
											<td>1</td>
										</tr>
										<tr>
											<td>4</td>
											<td>후원이 필요합니다.</td>
											<td>lim</td>
											<td>2020.07.06</td>
											<td>1</td>
										</tr>
								</table>
							</div>



						</div>


						<!-------------- 끝 ---------------->


					</div>
				</div>
			</div>

		</div>
		<!-- container end -->
	</div>
	<!-- side_overlay end -->
	<%@ include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>