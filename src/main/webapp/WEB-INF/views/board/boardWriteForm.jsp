<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>

<h2 align="center">게시원글 등록페이지</h2>
<br>
<!-- form에서 입력된 값들과 첨부파일을 같이 전송해야됨, 반드시 enctype속성을 추가-->
<form action="binsert.do" method="post" enctype="multipart/form-data">
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제목</th><td><input type="text" name="board_title"></td></tr>
	<tr><th>작성자</th><td><input type="text" name="board_writer" readonly value="${ loginMember.userid }"></td></tr>
	
	<tr><th>첨부파일</th><td><input type="file" name="upfile"></td></tr>
			
	<tr><th>글내용</th><td><textarea name="board_content" rows="5" cols="50"></textarea></td></tr>
	<tr><td colspan="2">
		<input type="submit" value="등록하기"> &nbsp;
		<input type="reset" value="작성취소"> &nbsp;
		<button onclick="javascript:history.go(-1); return false;">목록</button></td></tr>
</table>

</form>
<br>

<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>