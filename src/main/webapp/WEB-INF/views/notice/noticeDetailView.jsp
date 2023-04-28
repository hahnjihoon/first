<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- 상대경로로 대상파일의 위치지정 -->
<c:import url="../common/menubar.jsp" />
<hr>
<h2 align="center">${ notice.noticeno } 번 공지 상세보기</h2>
<br>
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제목</th><td>${ notice.noticetitle }</td></tr>
	<tr><th>작성자</th><td>${ notice.noticewriter }</td></tr>
	<tr><th>날짜</th><td>${ notice.noticedate }</td></tr>
	<tr><th>첨부파일</th>
		<td> 
			<!-- 첨부파일있다면다운요청설정 -->
			<c:if test="${ !empty notice.original_filepath }">
				<c:url var="nfd" value="/nfdown.do">
					<c:param name="ofile" value="${ notice.original_filepath }" />
					<c:param name="rfile" value="${ notice.rename_filepath }" />
				</c:url>
				<a href="${ nfd }">${ notice.original_filepath }</a>
				
			</c:if>
			<!-- 첨부없다면 -->
			<c:if test="${ empty notice.original_filepath }">
			&nbsp;
			</c:if>
		</td>
	</tr>
			
	<tr><th>글내용</th><td>${ notice.noticecontent }</td></tr>
	<tr><td colspan="2"><button onclick="javascript:history.go(-1);">목록</button></td></tr>
</table>

<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>