<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<!-- 상대경로로 대상파일의 위치지정 -->
<c:import url="../common/menubar.jsp" />
<hr>
<h2 align="center">${ notice.noticeno } 번 공지 상세보기 (관리자용)</h2>
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
	<tr><td colspan="2">
		<button onclick="javascript:history.go(-1);">목록</button> &nbsp;
		
		<!-- 수정페이지 이동버튼(관리자는수정가능) -->
		<c:url var="nup" value="/upmove.do">
			<c:param name="noticeno" value="${ notice.noticeno }" />
		</c:url>
		<button onclick="javascript:location.href='${ nup }';">수정페이지로이동</button>
		
		<!-- 삭제하기버튼추가(관리자는삭제가능) -->
		<c:url var="ndel" value="/ndel.do">
			<c:param name="noticeno" value="${ notice.noticeno }" />
			<c:if test="${ !empty notice.original_filepath }">
				<c:param name="rfile" value="${ notice.rename_filepath }" />
			</c:if>
		</c:url>
		<button onclick="javascript:location.href='${ ndel }';">글삭제</button>
	</td></tr>
</table>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>