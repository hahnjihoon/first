<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentPage" value="${ requestScope.currentPage }" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<c:import url="../common/menubar.jsp" />
<hr>
<h2 align="center">${ board.board_num } 번 게시글 상세보기</h2>
<br>
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제목</th><td>${ board.board_title }</td></tr>
	<tr><th>작성자</th><td>${ board.board_writer }</td></tr>
	<tr><th>날짜</th>
	<td><fmt:formatDate value="${ board.board_date }" type="date" pattern="yyyy-MM-dd" /></td></tr>
	
	<tr><th>첨부파일</th>
		<td> 
			<!-- 첨부파일있다면다운요청설정 -->
			<c:if test="${ !empty board.board_original_filename }">
				<c:url var="nfd" value="/bfdown.do">
					<c:param name="ofile" value="${ board.board_original_filename }" />
					<c:param name="rfile" value="${ board.board_rename_filename }" />
				</c:url>
				<a href="${ nfd }">${ board.board_original_filename }</a>
			</c:if>
			<!-- 첨부없다면 공백문자처리-->
			<c:if test="${ empty board.board_original_filename }">
			&nbsp;
			</c:if>
		</td>
	</tr>
			
	<tr><th>글내용</th><td>${ board.board_content }</td></tr>
	<tr><td colspan="2">
	
		<button onclick="javascript:location.href='blist.do?page=${ currentPage }';"">목록</button>
		
		<!-- 댓글 작성자x 일반회원o 관리자?아마o -->
		<c:if test="${ requestScope.board.board_writer ne sessionScope.loginMember.userid }">
			<c:url var="brf" value="/breplyform.do">
				<c:param name="board_num" value="${ board.board_num }" />
				<c:param name="page" value="${ currentPage }" />
			</c:url>
			<a href="${ brf }">[댓글달기]</a> &nbsp;
		</c:if>
		
		<!-- 본인이등록한글일때 수정+삭제 기능제공 -->
		<c:if test="${ requestScope.board.board_writer eq sessionScope.loginMember.userid }">
			<c:url var="buf" value="/bupview.do">
				<c:param name="board_num" value="${ board.board_num }" />
				<c:param name="page" value="${ currentPage }" />
			</c:url>
			<a href="${ buf }">[수정페이지로]</a> &nbsp;
			
			<c:url var="bdt" value="/bdel.do">
				<c:param name="board_num" value="${ board.board_num }" />
				<c:param name="board_lev" value="${ board.board_lev }" />
				<c:param name="board_rename_filename" value="${ board.board_rename_filename }" />
			</c:url>
			<a href="${ bdt }">[글삭제]</a>
		</c:if>
		
	</td></tr>
</table>

<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>