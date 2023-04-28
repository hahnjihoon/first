<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="listCount" value="${ requestScope.listCount }" />
<c:set var="startPage" value="${ requestScope.startPage }" />
<c:set var="endPage" value="${ requestScope.endPage }" />
<c:set var="maxPage" value="${ requestScope.maxPage }" />
<c:set var="currentPage" value="${ requestScope.currentPage }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
function showWriteForm(){
	location.href="${ pageContext.servletContext.contextPath }/bwform.do";
	
}

</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>

<h2 align="center">게시글 목록 : 총 ${ listCount } 개</h2>
<c:if test="${ !empty sessionScope.loginMember }">
	<div style="align:center; text-align:center;">
		<button onclick="showWriteForm();">글쓰기</button>
	</div>
</c:if>
<br>
<table align="center" border="1" width="700" cellspacing="0">
	<tr><th>번호</th><th>제목</th><th>작성자</th><th>작성일</th><th>조회수</th><th>첨부파일</th></tr>
	<c:forEach items="${ requestScope.list }" var="b">
		<tr>
			<td>${ b.board_num }</td>
			<td>
			<!-- 제목글자앞에 댓글인지 대댓글인지 표시기호 , 들려쓰기  -->
			<c:if test="${ b.board_lev eq 2 }">&nbsp; &nbsp; ▶ </c:if>
			<c:if test="${ b.board_lev eq 3 }">&nbsp; &nbsp; &nbsp; &nbsp; ▶▶ </c:if>
			<!-- 로그인한회원만 상세보기 볼수있도록 -->
			<c:if test="${ !empty sessionScope.loginMember }">
				<c:url var="bdt" value="bdetail.do">
					<c:param name="board_num" value="${ b.board_num }" />
					<c:param name="page" value="${ currentPage }" />
				</c:url>
				<a href="${ bdt }">${ b.board_title }</a>
			</c:if>
			<c:if test="${ empty sessionScope.loginMember }">
				<a>${ b.board_title }</a>
			</c:if>
						
			</td>
			<td>${ b.board_writer }</td>
			<td><fmt:formatDate value="${ b.board_date }" type="date" pattern="yyyy-MM-dd" /></td>
			<td>${ b.board_readcount }</td>
			<td>
			<c:if test="${ !empty b.board_original_filename }">
			◎
			</c:if>
			<c:if test="${ empty b.board_original_filename }">
			&nbsp;
			</c:if>
			</td>
		</tr>
	</c:forEach>
</table>
<br>
<!-- 페이징처리 -->
<div style="text-align:center;">
<!-- 1페이지로이동 -->
<c:if test="${ currentPage eq 1 }">
	[맨처음] &nbsp;
</c:if>
<c:if test="${ currentPage > 1 }">
	<c:url var="blf" value="/blist.do">
		<c:param name="page" value="1" />
	</c:url>
	<a href="${ blf }">[맨처음]</a>
</c:if>


<!-- 이전페이지그룹으로 이동처리 -->
<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
	<c:url var="blf2" value="/blist.do">
		<c:param name="page" value="${ startPage -10 }" />
	</c:url>
	<a href="${ blf2 }">[이전그룹]</a>
</c:if>
<c:if test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
	[이전그룹] &nbsp;
</c:if>


<!-- 현재페이지속한 페이지그룹 출력 -->
<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
	<c:if test="${ p eq currentPage }">
		<font size="4" color="red"><b>[${ p }]</b></font>
	</c:if>
	<c:if test="${ p ne currentPage }">
		<c:url var="blt5" value="/blist.do">
		<c:param name="page" value="${ p }" />
	</c:url>
	<a href="${ blt5 }">${ p }</a>
	</c:if>
</c:forEach>

<!-- 다음페이지그룹으로 이동처리 -->
<c:if test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
	<c:url var="blf3" value="/blist.do">
		<c:param name="page" value="${ endPage + 10 }" />
	</c:url>
	<a href="${ blf3 }">[다음그룹]</a>
</c:if>
<c:if test="${ !((currentPage - 10) > endPage and (currentPage + 10) < maxPage) }">
	[다음그룹] &nbsp;
</c:if>


<!-- 끝페이지이동 -->
<c:if test="${ currentPage eq maxPage }">
	[맨끝] &nbsp;
</c:if>
<c:if test="${ currentPage < maxPage }">
	<c:url var="blf4" value="/blist.do">
		<c:param name="page" value="${ maxPage }" />
	</c:url>
	<a href="${ blf4 }">[맨끝]</a>
</c:if>
</div>
<br>
<br>
<br>
<br>
<br>




<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>