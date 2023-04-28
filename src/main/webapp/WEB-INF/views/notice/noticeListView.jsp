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
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	showDiv();
	
	$("input[name=item]").on("change", function(){
		showDiv();
	});
});

function showDiv(){
	if($("input[name=item]").eq(0).is(":checked")){
		$("#titleDiv").css("display", "block");
		$("#writerDiv").css("display", "none");
		$("#dateDiv").css("display", "none");
	}
	
	if($("input[name=item]").eq(1).is(":checked")){
		$("#titleDiv").css("display", "none");
		$("#writerDiv").css("display", "block");
		$("#dateDiv").css("display", "none");
	}
	
	if($("input[name=item]").eq(2).is(":checked")){
		$("#titleDiv").css("display", "none");
		$("#writerDiv").css("display", "none");
		$("#dateDiv").css("display", "block");
	}
}
</script>
</head>
<body>
<!-- 상대경로로 대상파일의 위치지정 -->
<c:import url="../common/menubar.jsp" />
<!-- jstl에서 절대경로 표기 : /WEB-INF/views/common/menubr -->
<hr>
<h1 align="center">공지 사항</h1>
<!-- 로그인한 회원이 관리자인 경우 공지사항 등록 버튼 보이게함 -->
<center>
<c:if test="${ loginMember.admin eq 'Y' }">
	<!-- jsp에서jsp로 이동은 반드시 컨트롤러로 이동해야됨 -->
	<%-- <button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/WEB-INF/views/notice/noticeWriterForm.jsp';">공지글등록</button> --%>
	<button onclick="javascript:location.href='movewrite.do';">새공지글등록</button>
</c:if>
</center>
<!-- 검색 항목 -->
<center>
<div>
	<h2>검색할 항목을 선택하시오</h2>
	<input type="radio" name="item" value="title" checked> 제목 &nbsp; &nbsp; &nbsp;
	<input type="radio" name="item" value="writer"> 작성자 &nbsp; &nbsp; &nbsp;
	<input type="radio" name="item" value="date"> 날짜 
</div>
<div id="titleDiv">
	<form action="nsearchTitle.do" method="post">
		<label>검색할 제목을 입력하시오 : <input type="search" name="keyword"></label>
		<input type="submit" value="검색">
	</form>
</div>
<div id="writerDiv">
	<form action="nsearchWriter.do" method="post">
		<label>검색할 작성자아이디를 입력하시오 : <input type="search" name="keyword"></label>
		<input type="submit" value="검색">
	</form>
</div>
<div id="dateDiv">
	<form action="nsearchDate.do" method="post">
		<label>검색할 등록날짜를 입력하시오 : 
		<input type="date" name="begin"> ~ <input type="date" name="end"></label>
		<input type="submit" value="검색">
	</form>
</div>
</center>

<!-- 목록 출력 -->
<br>
<center>
	<button onclick="javascript:location.href='nlist.do';">목록</button>
</center>
<br>
<table align="center" width="500" border="1" cellspacing="0" cellpadding="1">
	<tr><th>번호</th><th>제목</th><th>작성자</th><th>첨부파일</th><th>날짜</th></tr>
	<c:forEach items="${ requestScope.list }" var="n">
		<tr align="center">
			<td>${ n.noticeno }</td>
			<!-- 공지제목클릭시 상세보기로 넘어가게처리 -->
			<c:url var="ndt" value="/ndetail.do">
				<c:param name="noticeno" value="${ n.noticeno }" />
			</c:url>
			<td><a href="${ ndt }">${ n.noticetitle }</a></td>
			<td>${ n.noticewriter }</td>
			<td>
				<c:if test="${ !empty n.original_filepath }">◎</c:if>
				<c:if test="${ empty n.original_filepath }">&nbsp;</c:if>
			</td>
			<td><fmt:formatDate value="${ n.noticedate }" pattern="yyyy-MM-dd" /></td>
			
		</tr>
	</c:forEach>
</table>

<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>