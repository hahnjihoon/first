<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<c:set var="board_num" value="${ requestScope.board_num }" />
<c:set var="currentPage" value="${ requestScope.currentPage }"></c:set>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>

<h2 align="center">${ board_num } 번 게시글 댓글 등록 페이지</h2>
<br>
<!-- form에서 입려된 값들과 -->
<form action="breply.do" method="post">
	<input type="hidden" name="board_ref" value="${ board_num }">
	<input type="hidden" name="page" value="${ currentPage }">
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5"> 
	<tr><th>제목</th><td><input tyhpe="text" name="board_title"></td></tr>
	<tr><th>작성자</th><td><input tyhpe="text" name="board_writer" readonly value="${ loginMember.userid }"></td></tr>
	<tr><th>내용</th><td><textarea name="board_content" rows="5" cols="50"></textarea></td></tr>
	<tr><td colspan="2">
		<input type="submit" value="등록하기"> &nbsp;
		<input type="reset" value="작성취소"> &nbsp;
		<c:url var="bls" value="/blist.do">
			<c:param name="page" value="${ currentPage }" />
		</c:url>
		<button onclick="javascriipt:location.href='${ bls }'; return false;">목록</button></td></tr>
</table>
</form>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>