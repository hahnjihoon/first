<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentPage" value="${ requestScope.page }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<c:import url="../common/menubar.jsp" />
<hr>
<h2 align="center">${ board.board_num } 번 게시글 수정페이지</h2>
<br>

<!-- 원글수정폼-->
<c:if test="${ board.board_lev eq 1 }">
<form action="boriginup.do" method="post" enctype="multipart/form-data">
<input type="hidden" name="board_num" value="${ board.board_num }">
<input type="hidden" name="page" value="${ currentPage }">
<c:if test="${ !empty board.board_original_filename }">
	<input type="hidden" name="board_original_filename" value="${ board.board_original_filename }">
	<input type="hidden" name="board_rename_filename" value="${ board.board_rename_filename }">
</c:if>
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제목</th><td><input type="text" name="board_title" value="${ board.board_title }"></td></tr>
	<tr><th>작성자</th><td><input type="text" name="board_writer" readonly value="${ board.board_writer }"></td></tr>
	
	<tr><th>첨부파일</th>
		<td>
		<!-- 원래 첨부파일이있는경우 -->
		<c:if test="${ !empty board.board_original_filename }">
			${ board.board_original_filename } &nbsp;
			<input type="checkbox" name="delFlag" value="yes"> 파일삭제 <br>
		</c:if>
		<br>
		
		새로첨부 : <input type="file" name="upfile">
		
		</td>
		
	</tr>
			
	<tr><th>글내용</th><td><textarea name="board_content" rows="5" cols="50">${ board.board_content }</textarea></td></tr>
	<tr><<td colspan="2">
		<input type="submit" value="수정하기"> &nbsp;
		<input type="reset" value="수정취소"> &nbsp;
		<button onclick="javascript:history.go(-1); return false;">이전페이지로</button></td></tr>
</table>
</form>
</c:if>

<!-- 댓글대댓글수정폼 -->
<c:if test="${ board.board_lev ne 1 }">
<form action="boreplyup.do" method="post">
<input type="hidden" name="board_num" value="${ board.board_num }">
<input type="hidden" name="page" value="${ currentPage }">

<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제목</th><td><input type="text" name="board_title" value="${ board.board_title }"></td></tr>
	<tr><th>작성자</th><td><input type="text" name="board_writer" readonly value="${ board.board_writer }"></td></tr>
				
	<tr><th>글내용</th><td><textarea name="board_content" rows="5" cols="50">${ board.board_content }</textarea></td></tr>
	<tr><<td colspan="2">
		<input type="submit" value="수정하기"> &nbsp;
		<input type="reset" value="수정취소"> &nbsp;
		<button onclick="javascript:history.go(-1); return false;">이전페이지로</button></td></tr>
</table>
</form>
</c:if>

<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>