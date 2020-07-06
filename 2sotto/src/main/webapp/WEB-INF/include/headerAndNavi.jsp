<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>

.fixed-top{
	position: relative;
}
</style>

	<!-- header -->
	<nav class="navbar navbar-default fixed-top" role="navigation-demo">
		<a class="toggle-btn"><span class="toggle-btn"><i class="fas fa-bars"></i></span></a>
		<span id="header-title"><a href="${pageContext.request.contextPath}/index.jsp">슬기로운 반려생활</a></span>
		<ul class="navbar-nav ml-auto">
			<c:choose>
				<c:when test="${userid == null}">
					<li class="nav-item" id="item01">
						<a href="${pageContext.request.contextPath}/login.bit" class="nav-link">로그인</a>
		            </li>
		            <li class="nav-item" id="item02">
		                <a href="${pageContext.request.contextPath}/register.bit" class="btn btn-rose btn-raised btn-round">
		                	시작하기
		                </a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="nav-item" id="item01">
						<a href="${pageContext.request.contextPath}/mypage/main.bit" class="nav-link">마이 페이지</a>
		            </li>
		            <li class="nav-item" id="item02">
		                <a href="${pageContext.request.contextPath}/logout.bit" class="btn btn-rose btn-raised btn-round">
		                	로그아웃
		                </a>
					</li>
				</c:otherwise>
			</c:choose>	
		</ul>
	</nav>
	
	<!-- navi -->
	<div id="wrapSideMenu" class="sidenav">
		<div id="sideMenu">
			<span class="sideMenu-close-icon"><i class="fas fa-times"></i></span>
			<div class="user-pic-wrapper">
				<span class="user-pic"><i class="far fa-user-circle"></i></span>
				<div class="nickname">
					닉네임 자리
					<br>
					포인트 자리
					<br>
					<button class="btn btn-primary btn-sm" onclick="#">Logout</button>
				</div>
				<div class="menuList">
					<ul class="navbar-nav ml-auto">
						<a href="${pageContext.request.contextPath}/management/main.bit"><li>반려동물 관리</li></a>
						<a href="${pageContext.request.contextPath}/blog/main.bit"><li>블로그</li></a>
						<a href="${pageContext.request.contextPath}/management/management.bit"><li>즐겨찾기</li></a>
						<a href="${pageContext.request.contextPath}/mypage/main.bit"><li>마이페이지</li></a>
						<a href="${pageContext.request.contextPath}/management/donationPage.bit"><li>후원게시판</li></a>
						<a href="${pageContext.request.contextPath}/admin/adminMain.bit"><li>관리자</li></a>


					</ul>
				</div>
			</div>
		</div>
	</div>


	
	
