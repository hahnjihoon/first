<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
<style type="text/css">
table th {
	background-color:#99ffff;
}
table#outer { border:2px solid navy; }
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	//전송버튼눌렷을때 입력값들대한 유효성 검사
	function validate(){
		//validation 체크검사 코드 구현
		//서버 컨트롤러로 전송할 값들이 유효한 값인지 검사하는거
		
		//암호 암호확인 검사 같은값인지확인작업
		var pwdValue = document.getElementById("userpwd").value;
		var pwdValue2 = document.getElementById("userpwd2").value;
		
		if(pwdValue !== pwdValue2){
			alert("암호와 암호확읜의 값이 일치하지않습니다\n"
					+"다시입력하세요");
			document.getElementById("userpwd").select();
			return false; //전송취소
		}
		
		return true; //검사문제없어서 여기까지오면 전송해라
	}
	
	//아이디중복체크확인을 위한 ajax 실행 처리용함수
	//웹에서 서버로 요청하면 서버는처리하고 결과로 다른페이지를 내보냄
	//클라이언트 브라우저에서는 요청결과에 대해 페이지가 항상 새로고침됨
	//에이작스는 페이지를 새로고침하지않고 현재페이지안에서 일부분으로 서버와 통신
	function dupCheckId(){
		$.ajax({
			url: "idchk.do",
			type: "post",
			data: { userid: $("#userid").val() },
			success: function(data){
				console.log("success : "+ data );
				if(data == "ok"){
					alert("사용가능한 아이디입니다");
					$("#userpwd").focus();
				}else{
					alert("이미 사용중인 아이디입니다\n 다시입력하시오");
					$("#userid").select();
				}
			},
			error: function(jqXHR, textstatus, errorthrown){
				console.log("error : "+jqXHR + ", "+textstatus+", "+errorthrown);
			}
			
		});
		
	}
</script>
</head>
<body>
<center>
	<h1 align="center">회원 가입 페이지</h1>
	<br>
	<form action="enroll.do" method="post" onsubmit="return validate();">
	<table id="outer" align="center" width="500" cellspacing="5" cellpadding="0">
	<tr>
		<th colspan="2">회원정보 입력하시오(*표시는 필수항목)</th>
	</tr>
	<tr>
		<th width="120">* 이 름</th>
		<td><input type="text" name="username" required></td>
	</tr>
	<tr>
		<th width="120">* 아이디</th>
		<td><input type="text" name="userid" id="userid" required>
		&nbsp; &nbsp; 
		<input type="button" value="중복체크" onclick="return dupCheckId();"></td>
	</tr>
	<tr>
		<th width="120">* 암 호</th>
		<td><input type="password" name="userpwd" id="userpwd" required></td>
	</tr>
	<tr>
		<th width="120">* 암호확인</th>
		<td><input type="password" id="userpwd2"></td>
	</tr>
	<tr>
		<th width="120">* 성 별</th>
		<td><input type="radio" name="gender" value="M" checked>남자
		<input type="radio" name="gender" value="F">여자
		</td>
	</tr>
	<tr>
		<th width="120">* 나 이</th>
		<td><input type="number" name="age" min="19" max="100" value="20"></td>
	</tr>
	<tr>
		<th width="120">* 전화번호</th>
		<td><input type="tel" name="phone" required></td>
	</tr>
	<tr>
		<th width="120">* 이메일</th>
		<td><input type="email" name="email" required></td>
	</tr>
	<tr>
		<th width="120">취 미</th>
		<td>
			<table width="350">
			<tr>
				<td><input type="checkbox" name="hobby" value="game"> 게임</td>
				<td><input type="checkbox" name="hobby" value="reading"> 독서</td>
				<td><input type="checkbox" name="hobby" value="climb"> 등산</td>
			</tr>
			<tr>
				<td><input type="checkbox" name="hobby" value="sport"> 운동</td>
				<td><input type="checkbox" name="hobby" value="music"> 음악듣기</td>
				<td><input type="checkbox" name="hobby" value="movie"> 영화보기</td>
			</tr>
			<tr>
				<td><input type="checkbox" name="hobby" value="travel"> 여행</td>
				<td><input type="checkbox" name="hobby" value="cook"> 요리</td>
				<td><input type="checkbox" name="hobby" value="etc" checked> 기타</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr>
		<th width="120">추가사항</th>
		<td><textarea name="etc" rows="5" cols="50"></textarea></td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="가입하기"> &nbsp;
			<input type="reset" value="작성취소"> &nbsp;
			<a href="main.do">시작페이지로 이동</a>
		</th>
	</tr>
	</table>
	</form>
</center>
</body>
</html>