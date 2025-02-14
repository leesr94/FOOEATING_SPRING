<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

h1{
	text-align: center;
}

td {
	display: block;
	padding-bottom: 5px;
}

tr>td:nth-child(2), span {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

.step-form {
	width: 600px;
	margin: auto;
}

.inputStyle {
	width: 280px;
	height: 25px;
}

.space {
	text-align: right;
}

img{
	margin: auto;
	display: block;
}

.btn {
	width: 290px;
	height: 40px;
	margin: auto;
	display: block;
}

</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">

$(function(){
	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 전달 정보 저장 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	let userId = "${sessionScope.userId}";
	let userName = "${sessionScope.userName}";
	let userEmail = "${sessionScope.userEmail}";
	let userPw = "noData";
	
	
	
	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡ 사용자 정보 유뮤에 따른 입력 ㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	if(userId == "noData"){
		$('#step1').show();
		$('#step2').css("display", "none");
	}
	else {
		$('#step1').css('display', "none");
		$('#step2').show();
	}

		
	
	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 정규 표현식 & 중복 체크 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	
	// 1. 이메일 비동의 시
	// 조건 부합 상태를 저장하는 변수
	let isIdChecked = false;
	let isTelChecked = false;

	// 1-1. 아이디 조건 및 중복 체크
	$('#userId').keyup(function(){
		let userId = $('#userId').val();
		let trueId = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,12}$/;
		
		if(userId === ""){
			$('#idchk').html("");
		}
		// 조건 O
		else if(trueId.test(userId)){
			$('#idchk').html("");
			
			// 중복 체크
			$.ajax({
				url :'/user/idOverlap',
				type : 'post',
				data : {"userId" : userId},
				dataType : "json",
				success : function(data){
					if(data === 1){
						isIdChecked = true;
						$('#idchk').html("사용 가능한 아이디 입니다.");
						$('#idchk').css('color', 'green');
						$('#idchk').css('font-size', '10px');
					}else if(data === 0){
						isIdChecked = false;
						$('#idchk').html("이미 존재하는 아이디 입니다.");
						$('#idchk').css('color', 'red');
						$('#idchk').css('font-size', '10px');
						$('#userId').focus();
					}
				},
				error : function(){
					alert("ajax Error");
				}
			}); // ajax
		
		} 
		// 조건 X
		else if(!trueId.test(userId)){
			isIdChecked = false;
			$('#idchk').html("영문과 숫자를 조합하여 8~12자로 작성해 주세요.");
			$('#idchk').css('color', 'red');
			$('#idchk').css('font-size', '10px');
		}
	}); // userId.keyup
	
	// 1-2. 전화번호 조건 체크
	$('#userTel').keyup(function(){
		let userTel = $('#userTel').val();
		let trueTel = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
		
		if(userTel === ""){
			$('#telchk').html("");
		}
		// 조건 O
		else if(trueTel.test(userTel)){
			$('#telchk').html("");
			
			// 중복 체크
			$.ajax({
				url :'/user/telOverlap',
				type : 'post',
				data : {"userTel" : userTel},
				dataType : "json",
				success : function(data){
					if(data === 1){
						isTelChecked = true;
						$('#telchk').html("사용 가능한 전화번호 입니다.");
						$('#telchk').css('color', 'green');
						$('#telchk').css('font-size', '10px');
					}else if(data === 0){
						isTelChecked = false;
						$('#telchk').html("이미 존재하는 전화번호 입니다.");
						$('#telchk').css('color', 'red');
						$('#telchk').css('font-size', '10px');
						$('#telchk').focus();
					}
				},
				error : function(){
					alert("ajax Error");
				}
			}); // ajax
		}
		// 조건 X
		else if(!trueTel.test(userTel)){
			isTelChecked = false;
			$('#telchk').html("연락처 형식에 맞지 않습니다.");
			$('#telchk').css('color', 'red');
			$('#telchk').css('font-size', '10px');
		}
	}); // userTel.keyup
	

	
	// 2. 이메일 동의 시
	if(userId != "noData"){
		isIdChecked = true;
	}
	
	// 2-1. 전화번호 조건 체크
	$('#userTel2').keyup(function(){
		let userTel = $('#userTel2').val();
		let trueTel = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
		
		if(userTel === ""){
			$('#telchk2').html("");
		}
		// 조건 O
		else if(trueTel.test(userTel)){
			$('#telchk2').html("");
			
			// 중복 체크
			$.ajax({
				url :'/user/telOverlap',
				type : 'post',
				data : {"userTel" : userTel},
				dataType : "json",
				success : function(data){
					if(data === 1){
						isTelChecked = true;
						$('#telchk2').html("사용 가능한 전화번호 입니다.");
						$('#telchk2').css('color', 'green');
						$('#telchk2').css('font-size', '10px');
					}else if(data === 0){
						isTelChecked = false;
						$('#telchk2').html("이미 존재하는 전화번호 입니다.");
						$('#telchk2').css('color', 'red');
						$('#telchk2').css('font-size', '10px');
						$('#telchk2').focus();
					}
				},
				error : function(){
					alert("ajax Error");
				}
			}); // ajax
		}
		// 조건 X
		else if(!trueTel.test(userTel)){
			isTelChecked = false;
			$('#telchk2').html("연락처 형식에 맞지 않습니다.");
			$('#telchk2').css('color', 'red');
			$('#telchk2').css('font-size', '10px');
		}
	}); // userTel2.keyup
	

	
	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 제출 시 유효성 체크 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	$('#submit').click(function(e) {
		if($('#userId').val() === "" && userId === "noData"){
			$('#userId').focus();
			alert("아이디를 입력해 주세요.");
			return false;
		}
		else if($('#userTel').val() === "" && userId === "noData"){
			$('#userTel').focus();
			alert("전화번호를 입력해 주세요.");
			return false;
		}
		else if($('#userTel2').val() === ""){
			$('#userTel2').focus();
			alert("전화번호를 입력해 주세요.");
			return false;
		}
		else if(!isIdChecked){
			$('#userId').focus();
			return false;
		}
		else if(!isTelChecked && userId === "noData"){
			$('#userTel').focus();
			return false;
		}
		else if(!isTelChecked){
			$('#userTel2').focus();
			return false;
		}
		else{
			// 모든 조건 통과 시 데이터 전송
			if(userId !== "noData"){
				userId = userEmail;
				userTel = $('#userTel2').val();
			}else{
				userId = $('#userId').val();
				userTel = $('#userTel').val();
			}
			$.ajax({
				url: '/user/join',
				type: 'post',
				data: {
					"userId" : userId,
					"userPw" : userPw,
					"userName" : userName,
					"userEmail" : userEmail,
					"userTel" : userTel
				},
				success: function(){
					alert("찐성공 kakaoInsertInfo_line208");
				},
				error: function(){
					alert("join_ajax Error");
					alert("회원가입이 완료되었습니다.");
					alert("다음부터는 간편 로그인이 바로 가능합니다.");
					location.href = "/main";
				}
			}); //join_ajax

	    } // else

	}); // submit.click
	
});

</script>
</head>
<body>

<img src="${pageContext.request.contextPath}/resources/img/logo.png" width="150px" height="150px">
<h1>추가 정보 입력 안내</h1>
<div style="text-align: center;">원할한 FOOEATING 서비스 이용을 위해 <b>반드시 필요한 정보</b>입니다.</div>



<!-- ${sessionScope.userId eq 'noData'} -->
<!-- 이메일 비동의 & 아이디, 전화번호 입력 -->
<div id="step1">
	<div class="step-form">
		<table style="margin: 40px auto;">
			<tr>
				<td>아이디</td>
				<td><input type="text" name="userId" id="userId" class="inputStyle" placeholder="영문과 숫자 조합하여 8~12자"></td>
				<td id="idchk"></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="tel" name="userTel" id="userTel" class="inputStyle" placeholder="ex) 000-0000-0000"></td>
				<td id="telchk"></td>
				<td class="space"><button type="button" id="btnTelSend">코드발송</button></td>
			</tr>
			<tr>
				<td>전화번호 인증</td>
				<td><input type="text" id="checkCode" maxlength="10" class="inputStyle" placeholder="인증코드 입력" disabled></td>
				<td id="authchk"></td>
				<td class="space"><button type="button" id="btnTelCheck">인증하기</button></td>
			</tr>
		</table>
	</div>
</div>
	
	
	
<!-- 이메일 동의 & 전화번호 입력 -->
<!-- 전화번호인증 아이디 다르게해야함 !!! !!! !! !!!  -->
<div id="step2">
	<div class="step-form">
		<table style="margin: 40px auto;">
			<tr>
				<td>전화번호</td>
				<td><input type="tel" name="userTel2" id="userTel2" class="inputStyle" placeholder="ex) 000-0000-0000"></td>
				<td id="telchk2"></td>
				<td class="space"><button type="button" id="btnTelSend2">코드발송</button></td>
			</tr>
			<tr>
				<td>전화번호 인증</td>
				<td><input type="text" id="checkCode2" maxlength="10" class="inputStyle" placeholder="인증코드 입력" disabled></td>
				<td id="authchk2"></td>
				<td><button type="button" id="btnTelCheck2">인증하기</button></td>
			</tr>
		</table>
	</div>
</div>

<input type="button" class="btn" id="submit" value="입력완료" >

</body>
</html>