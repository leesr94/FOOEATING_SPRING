<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	
	// 각 step 숨기기
	$("#step1").show();
	$("#step2").hide();
	$("#step3").hide();
	$("#step4").hide();
	
	// 작성 정보를 저장할 객체
	var registInfo = {};
	
	// step1에서 next 클릭 시
	$("#btn-next1").click(function() {
		// 필수 약관 동의하지 않을 경우 alert창
	});
	
	//step2 체크된 영업시간 저장
	var runtime = {
						1 : "휴무", 
						2 : "휴무", 
						3 : "휴무", 
						4 : "휴무", 
						5 : "휴무", 
						6 : "휴무", 
						7 : "휴무"
					};
	var daysArr = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
	
	// step2에서 next 클릭 시
	$("#btn-next2").click(function() {
		// 작성된 데이터 객체에 저장
		registInfo.restName = $("#restName").val();
		registInfo.restCategory = $("#restCategory").val();
		registInfo.restAddr = $("#restAddr_postcode").val() + " " + $("#restAddr1").val() + " " + $("#restAddr2").val();
		registInfo.restTel = $("#restTel").val();
		
		var dayRuntime = "";
		for (var i = 1; i <= 7; i++) {
			if (document.getElementById("time" + i + "1").value !== "" && document.getElementById("time" + i + "2").value !== "") {
				runtime[i] = document.getElementById("time" + i + "1").value + "~" + document.getElementById("time" + i + "2").value
			}
			dayRuntime += daysArr[i - 1] + " " + runtime[i] + " ";
		}
		if ($("#time8").val()) { dayRuntime += "기타 " + $("#time8").val(); }
		registInfo.restRuntime = dayRuntime;
		console.log(registInfo);
	});
	
	// 신청 버튼 클릭 시
	$("#btn-next4").click(function() {
		
	});
	
});
	
function showStep(stepId) {
	var stepNum = Number.parseInt(stepId.substring(5));
	var stepNext = "#step" + (stepNum + 1);
	var stepPrev = "#step" + (stepNum - 1);
	
	console.log(stepId + ", " + stepNum + ", " + stepNext + ", " + stepPrev);
	
	if (stepNum !== 4 || stepNum !== 1) {
		$(stepPrev).hide();
		$(stepId).show();
		$(stepNext).hide();
	}
}

</script>

</head>
<body>
	
	<div id="step1">
		<h1>step 1</h1>
	
		<input type="checkbox" name="terms" id="chkAll"> 전체 동의하기 <br>
		위치기반서비스 이용약관(선택), 이벤트·혜택 정보 수신(선택) 동의를 포함합니다.
			
		<fieldset>
			<legend>약관</legend>
			[필수] 제1조 블라블라 <br>
			<input type="checkbox" name="terms" id="chk1"> [필수] FOOEATING 이용약관 <br>
			[선택] 제1조 웅앵웅앵 <br>
			<input type="checkbox" name="terms" id="chk2"> [선택] 위치기반서비스 이용약관 <br>
			[선택] 제1조 초키포키 <br>
			<input type="checkbox" name="terms" id="chk3"> [선택] 이벤트·혜택 정보 수신 <br>
		</fieldset>
		
		<input type="button" id="btn-next1" value="다음" onclick="showStep('#step2');">
	</div>
	
	<div id="step2">
		<h1>step 2</h1>
			
		<fieldset>
			<legend>사업장 정보</legend>
			상호명 <br>
			<input type="text" id="restName"> <br>
			
			업종 <br>
			<select id="restCategory">
				<option value="none">업종을 선택해주세요.</option>
				<option value="한식">한식</option>
				<option value="중식">중식</option>
				<option value="양식">양식</option>
				<option value="일식">일식</option>
				<option value="기타">기타</option>
				<option value="디저트">디저트</option>
			</select> <br>
			
			주소 <br>
			<input type="text" id="restAddr_postcode" placeholder="우편번호">
			<input type="button" onclick="" value="우편번호 찾기"> <br>
			<input type="text" id="restAddr1" placeholder="주소">
			<input type="text" id="restAddr2" placeholder="상세주소"> <br>
			
			대표 전화 <br>
			<input type="text" id="restTel" placeholder="- 를 포함하여 입력하세요."> <br>
			
			<%	
				List<String> days = new ArrayList<String>();
				days.add("일요일");
				days.add("월요일");
				days.add("화요일");
				days.add("수요일");
				days.add("목요일");
				days.add("금요일");
				days.add("토요일");
				
				session.setAttribute("days", days);
			%>
			
			영업시간 <br>
			<c:forEach var="day" items="${days}" varStatus="no">
				<input type="checkbox" name="restRuntime" value="${day}"> ${day} 
				<input type="time" id="time${no.count}1"> ~ <input type="time" id="time${no.count}2"> <br>
			</c:forEach>
			<input type="checkbox" name="restRuntime" id="chkRun8" value="기타"> 기타 
			<input type="text" name="restRuntime" id="time8" placeholder="기타 공휴일을 입력하세요."> <br>
			
			편의시설 <br>
			<input type="checkbox" name="restConv" id="chkConWifi"> 무료 와이파이
			<input type="checkbox" name="restConv" id="chkConToilet"> 남/녀 화장실 분리 <br>
			<input type="checkbox" name="restConv" id="chkConNokids"> 노키즈존
			<input type="checkbox" name="restConv" id="chkConGroup"> 단체석 <br>
			<input type="checkbox" name="restConv" id="chkConAnimal"> 반려동물
			<input type="checkbox" name="restConv" id="chkConParking"> 주차 <br>
			<input type="checkbox" name="restConv" id="chkConPackup"> 포장
		</fieldset>
		
		<input type="button" id="btn-prev1" value="이전" onclick="showStep('#step1');">
		<input type="button" id="btn-next2" value="다음" onclick="showStep('#step3');">
	</div>
	
	<div id="step3">
		<h1>step 3</h1>
	
		<fieldset>
			<legend>사업장 정보</legend>
			가게 소개 <br>
			<textarea rows="7" cols="50" id="restDescription">가게 소개글을 입력하세요.</textarea> 0/300 <br>
			
			외관 <input type="file" id="restExterior"> <br>
			
			내부 <input type="file" id="restInterior"> <br>
			
			기타 <input type="file" id="restInterior"> <br>
		</fieldset>
		
		<input type="button" id="btn-prev2" value="이전" onclick="showStep('#step2');">
		<input type="button" id="btn-next3" value="다음" onclick="showStep('#step4');">
	</div>
	
	<div id="step4">
		<h1>step 4</h1>
	
		<fieldset>
			<legend>메뉴 등록 [선택]</legend>
			이름 <br>
			<input type="text" id="menuName1"> <br>
			설명 <br>
			<input type="text" id="menuDescription1"> <br>
			가격 <br>
			<input type="number" id="menuPrice1" min="0">원 <br>
			사진 <br>
			<input type="file" id="menuFile1"> <br>
			
			이름 <br>
			<input type="text" id="menuName2"> <br>
			설명 <br>
			<input type="text" id="menuDescription2"> <br>
			가격 <br>
			<input type="number" id="menuPrice2" min="0">원 <br>
			사진 <br>
			<input type="file" id="menuFile2"> <br>
			
			이름 <br>
			<input type="text" id="menuName3"> <br>
			설명 <br>
			<input type="text" id="menuDescription3"> <br>
			가격 <br>
			<input type="number" id="menuPrice3" min="0">원 <br>
			사진 <br>
			<input type="file" id="menuFile3"> <br>
		</fieldset>
		
		<input type="button" id="btn-prev3" value="이전" onclick="showStep('#step3');">
		<input type="button" id="btn-next4" value="신청">
	</div>
	
</body>
</html>