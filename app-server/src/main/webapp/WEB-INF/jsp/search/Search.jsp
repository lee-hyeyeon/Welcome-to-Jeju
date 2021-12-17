<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set scope="page" var="contextRoot" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet" href="${contextRoot}/css/home.css?ver=1">
<link rel="stylesheet" href="${contextRoot}/css/theme_list.css">

<style>
.checkbox-inline {
	background-color: transparent;
	color: black;
	font-family: inherit;
	font-size: x-large;
	position: relative;
	left: 150px;
}
</style>

<br>
<br>
<br>
<h1 style="text-align: center;">검색 하기</h1>
<div class="dash-board">
<form id="search-form" action="${contextRoot}/app/search/all">
<br>
<div class="select" style="margin-left: -120px;">
	<label class="checkbox-inline"> 
	<input type="checkbox" name="option" id="inlineCheckbox1" value="all"> 전체검색
	</label> 
	<label class="checkbox-inline"> 
	<input type="checkbox" name="option" id="inlineCheckbox2" value="publicTheme"> 유저테마
	</label> 
	<label class="checkbox-inline"> 
	<input type="checkbox" name="option" id="inlineCheckbox3" value="shareTheme"> 참여테마
	</label> 
	<label class="checkbox-inline"> 
	<input type="checkbox" name="option" id="inlineCheckbox4" value="user"> 유저
	</label> 
	<br>
	</div>
	<div class="search-container">
		<input type="text" placeholder="⌨ 키워드를 입력해주세요!" name="keyword" id="search-bar">
		<button class="search-icon">
			<i class="fas fa-search"></i>
		</button>
	</div>
</form>
</div>
<div class="dash-board">
	<div class="hot-curators">
		<div class="title">
			<span>🔎 '${keyword}'로 검색한 유저 목록</span>
			<div class="sub"># 유저 검색하기</div>
		</div>
		<ul class="hot-curators-list .owl-carousel2">
			<c:forEach items="${userList}" var="user">
				<li><a href="../user/themelist?no=${user.no}" class="content">
						<div class="icon">${user.emoji}</div>
						<div class="curator-name">${user.nickname}</div>
						<div class="theme-count">${user.registeredDate}</div>
				</a></li>
			</c:forEach>
		</ul>
	</div>
	<br> <br> <br>

	<div class="hot-theme">
		<div class="title">
			<span>🔎 '${keyword}'로 검색한 유저 테마 목록</span>
			<div class="sub"># 유저 테마 검색하기</div>
		</div>
		<ul class="theme-list">
			<c:forEach items="${publicThemeList}" var="theme">
				<a class="list-container" href="../place/list?no=${theme.no}">
					<li>
						<div class="content">

							<c:if test="${!empty theme.emoji}">
								<div class="icon">${theme.emoji}</div>
							</c:if>
							<c:if test="${empty theme.emoji}">
								<div class="icon">🏄</div>
							</c:if>
							<div class="theme-title">${theme.title}</div>
						</div> <!-- .content -->
				</li>
				</a>
			</c:forEach>
			<c:forEach begin="0" end="${3-(fn:length(publicThemeList)%3)-1}">
				<a class="list-container" style="visibility: hidden;">
					<li>
						<div class="content">
							<div class="icon">${theme.no}</div>
							<div class="theme-title">${theme.title}</div>
						</div> <!-- .content -->
				</li>
				</a>
			</c:forEach>
		</ul>
	</div>

	<div class="hot-theme">
		<div class="title">
			<span>🔎 '${keyword}'로 검색한 참여 테마 목록</span>
			<div class="sub"># 참여 테마 검색하기</div>
		</div>
		<ul class="theme-list">
			<c:forEach items="${shareThemeList}" var="theme">
				<a class="list-container" href="../place/list?no=${theme.no}">
					<li>
						<div class="content">

							<c:if test="${!empty theme.emoji}">
								<div class="icon">${theme.emoji}</div>
							</c:if>
							<c:if test="${empty theme.emoji}">
								<div class="icon">🏄</div>
							</c:if>
							<div class="theme-title">${theme.title}</div>
						</div> <!-- .content -->
				</li>
				</a>
			</c:forEach>
			<c:forEach begin="0" end="${3-(fn:length(shareThemeList)%3)-1}">
				<a class="list-container" style="visibility: hidden;">
					<li>
						<div class="content">
							<div class="icon">${theme.no}</div>
							<div class="theme-title">${theme.title}</div>
						</div> <!-- .content -->
				</li>
				</a>
			</c:forEach>
		</ul>
	</div>

</div>
