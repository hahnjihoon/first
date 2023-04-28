<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first main page</title>
<style type="text/css">
div.lineA {
	height: 100px;
	border: 1px dolid gray;
	float: left;
	position: relative;
	left: 120px;
	margin: 5px;
	padding: 5px;
}
div#banner {
	width: 750px;
	padding: 0;
}
div#banner img {
	margin: 0;
	padding: 0;
	width: 750px;
	height: 110px;
}
div#loginBox {
	width: 274px;
	font-size: 9pt;
	text-align: left;
	padding-left: 20px;
}
div#loginBox button {
	width: 250px;
	height: 35px;
	background-color: navy;
	color: white;
	margin-top: 10px;
	margin-bottom: 15px;
	font-size: 14pt;
	font-weight: bold;
}
section {
	position: relative;
	left: 120px;
}
section>div {
	width: 360px;
	background: #ccffff;
}
section div table {
	width: 350px;
	background: white;
}
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	/*주기적으로자동실행하려면 자바스크립트 내장함수 setInterval(실행시킬함수명, 시간간격밀리초) 사용*/
	/* setInterval(function(){
		console.log("setInterval() 에 의해 자동실행 확인");
		
	}, 100); */
	
	
	//최근 등록한 공지글 3개출력되게하는 함수
	$.ajax({
		url: "ntop3.do",
		type: "post",
		dataType: "json",
		success: function(data){
			console.log("success : "+data);  //Object로 받아짐 기본적으로
			
			//Object로받은걸 String으로 바꿈
			var jsonStr = JSON.stringify(data);
			
			//String으로바꾼걸 실제사용할 json객체로 바꿈
			var json = JSON.parse(jsonStr);
			
			var values = "";
			for(var i in json.list){ //i변수가 자동으로1씩증가
				values += "<tr><td>"+json.list[i].noticeno+"</td><td><a href='ndetail.do?noticeno="+json.list[i].noticeno+"'>"
						+decodeURIComponent(json.list[i].noticetitle).replace(/\+/gi, " ")+"</a></td><td>"+json.list[i].noticedate+"</td></tr>";
						
				
				
			} //for in문 닫기
			
			$("#newnotice").html($("#newnotice").html()+values);
			
		},
		error: function(jqXHR, textstatus, errorthrown){
			console.log("error : "+jqXHR+", "+textstatus+", "+errorthrown);
		}
		
	});
	
	
	//조회수 많은 인기게시원글 상위3개 조회출력
	$.ajax({
		url: "btop3.do",
		type: "post",
		dataType: "json",
		success: function(data){
			console.log("success : "+data);  //Object로 받아짐 기본적으로
			
			//Object로받은걸 String으로 바꿈
			var jsonStr = JSON.stringify(data);
			
			//String으로바꾼걸 실제사용할 json객체로 바꿈
			var json = JSON.parse(jsonStr);
			
			var values = "";
			for(var i in json.list){ //i변수가 자동으로1씩증가
				values += "<tr><td>"+json.list[i].board_num+"</td><td><a href='bdetail.do?board_num="+json.list[i].board_num+"'>"
						+decodeURIComponent(json.list[i].board_title).replace(/\+/gi, " ")+"</a></td><td>"+json.list[i].board_readcount+"</td></tr>";
						
				
				
			} //for in문 닫기
			
			$("#toplist").html($("#toplist").html()+values);
			
		},
		error: function(jqXHR, textstatus, errorthrown){
			console.log("error : "+jqXHR+", "+textstatus+", "+errorthrown);
		}
		
	});
	
});



function movePage(){
	location.href = "loginPage.do";
}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr style="clear:both;">
<center>
	<!-- 배너이미지 표시 -->
	<div id="banner" class="lineA">
		<img src="${ pageContext.servletContext.contextPath }/resources/images/photo2.jpg">	
	</div>
	<c:if test="${ empty loginMember }">
		<div id="loginBox" class="lineA">
			first 사이트방문 환영<br>
			<button onclick="movePage();">로그인하세요</button>
			<br><a>아이디/비밀번호 조회</a> &nbsp; &nbsp;
			<a href="enrollPage.do">회원가입</a>
		</div>
	</c:if>
	<!-- 로그인한경우 : 일반회원 -->
	<c:if test="${ !empty loginMember and loginMember.admin ne 'Y' }">
		<div id="loginBox" class="lineA">
			${ sessionScope.loginMember.username } 님<br>
			<button onclick="javascript:location.href='logout.do';">로그아웃</button>
			<br><a>쪽지</a> &nbsp; &nbsp; <a>메일</a> &nbsp;&nbsp; 
			<c:url var="callMyInfo2" value="myinfo.do">
				<c:param name="userid" value="${ loginMember.userid }" />
			</c:url>
			<a href="${ callMyInfo2 }">My Page</a>
		</div>
	</c:if>
	<!-- 로그인한경우 : 관리자 -->
	<c:if test="${ !empty loginMember and loginMember.admin eq 'Y'}" >
		<div id="loginBox" class="lineA">
			${ sessionScope.loginMember.username } 님<br>
			<button onclick="javascript:location.href='logout.do';">로그아웃</button>
			<br>
			<c:url var="callMyInfo" value="/myinfo.do">
				<c:param name="userid" value="${ loginMember.userid }" />
			</c:url>
			<a href="${ callMyInfo }">My Page</a>
		</div>
	</c:if>
</center>
<hr stryle="clear:both;">
<section>
	<!-- 노티스보드끝나면 최근등록 공지글3개조회출력할것 -->
	<div style="float:left; border: 1px solid navy; padding: 5px; margin: 5px;">
		<h4>최근 공지글</h4>
		<table id="newnotice" border="1" cellspacing="0">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>날짜</th>
			</tr>
		</table>
	</div>
	
	<!-- 보드끝나면 조회수많은 게시글 3개 조회출력할것 -->
	<div style="float:left; border: 1px solid navy; padding: 5px; margin: 5px;">
		<h4>인기 게시글</h4>
		<table id="toplist" border="1" cellspacing="0">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>조회수</th>
			</tr>
		</table>
	</div>
</section>

<hr style="clear:both;">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>