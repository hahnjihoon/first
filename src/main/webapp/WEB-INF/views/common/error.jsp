<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
</head>
<body>
<!-- //EL에서 절대경로와 jstl에서 쓰는 절대경로 다르다 -->
<!-- jstl의 절대경로표기는 / 로 시작한다 = /context-root명 과 같다 == /first
	=> 현재프로젝트first/src/main/webapp 을 의미함 = 슬러시만붙이면 webapp까지경로를의미
	context = web application
 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<h1>에러페이지</h1>
<c:set var="e" value="<%= exception %>" />
<c:if test="${ !empty e }">
	<h3>jsp페이지 오류발생 : ${ message }</h3>
</c:if>
<c:if test="${ empty e }">
	<h3>컨트롤러 요청실패 메시지 : ${ message }</h3>
</c:if>
<!-- 컨트롤러 호출은 루트에서 실행시키도록함 -->
<c:url var="movemain" value="/main.do"/>
<a href="${ movemain }">시작페이지로 이동</a>
<hr>
<!-- 상대경로 : 현재문서기준 대상파일까지경로 
	-같은폴더안의 파일이나폴더 지정시 : 파일명.확장자 / 폴더명/파일명.확장자
	-다른폴더안의 파일이나폴더 지정시 : ./(현재폴더) / ../(한단계위로)
	ex) 현재위치(common/error.jsp)에서 views/member/loginPage.jsp로 이동하려면
	   "../member/loginPage.jsp - 상대경로
	   "webapp/resources/images/d7.jpg - 절대경로
-->
<c:import url="footer.jsp" />

</body>
</html>