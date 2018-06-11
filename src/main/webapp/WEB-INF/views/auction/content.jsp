<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file = "../top.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/auction/style.css"/>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
//input type="text"에 숫자만 입력하기
function filterNumber(event) {
  	var code = event.keyCode;
  	if (code > 47 && code < 58) {
  	  	return;
  	} 
  	if (code > 95 && code < 106) {
  	  	return;
  	} 
  	//특수키 입력
  	if (code === 9 || code === 36 || code === 35 || code === 37 ||
  	     code === 39 || code === 8 || code === 46) {
  	    return;
  	}
  	//하단의 코드는 모든 키가 입력이 안되도록
  	event.preventDefault();
}


	function Moneycheck(){
		if(money.money.value<=money.r_money.value){
			alert("현재 입찰금액보다 더 큰 수를 넣어주세요");
			return;
		}
		if(money.money.value%100){
			alert("100원 단위로 입찰해 주세요");
			return;
		}
		
		document.money.submit();
	}
</script>

<script>
	var timecount = setInterval("leaveTime()",1000);
	var leavetime ="<c:out value='${dto.leavetime}'/>";
	leavetime = parseInt(leavetime);
	function leaveTime(){
		var res;
		var day=0;
		var hour=0;
		var minute=0;
		var second=0;
		leavetime--;
		if(leavetime<=0){
			res = "경매 마감";
			clearInterval(timecount); // 중지
		}else if(leavetime<3600){
			minute = leavetime/60;
			second = leavetime%60;
			minute = parseInt(minute);
			second = parseInt(second);
			if (minute < 10) {
				minute = "0" + minute;
			}
			if (second < 10) {
				second = "0" + second;
			}
			res = minute+":"+second;
		}else if(leavetime<86400){
			hour = leavetime/3600;
			minute = leavetime%3600/60;
			second = leavetime%3600%60;
			hour = parseInt(hour);
			minute = parseInt(minute);
			second = parseInt(second);
			if (minute < 10) {
				minute = "0" + minute;
			}
			if (second < 10) {
				second = "0" + second;
			}
			res = hour+":"+minute+":"+second;
		}else{
			day = leavetime/86400;
			hour = leavetime%86400/3600;
			minute = leavetime%86400%3600/60;
			second = leavetime%86400%3600%60;
			day = parseInt(day);
			hour = parseInt(hour);
			minute = parseInt(minute);
			second = parseInt(second);
			if (minute < 10) {
				minute = "0" + minute;
			}
			if (second < 10) {
				second = "0" + second;
			}
			res = day+"일 + "+hour+":"+minute+":"+second;
		}
		document.getElementById("leaveTime").innerHTML = res;
		
	}
	
</script>
<body>
	<h1>경매 상세목록</h1>
	<div align="center">
	<form name="money" action="bid.auction" method="post">
	<table class="w3-table-all">
		<tr>
			<th class="w3-purple">상품명</th>
			<td>${dto.name }</td>
			<th class="w3-purple">마감 시간</th>
			<td>
				<span id="leaveTime">
				<c:choose>
						<c:when test="${dto.leavetime<0 }"><p style="color:red">경매 마감</p></c:when>
						<c:when test="${dto.leavetime<3600 }">
							<fmt:parseNumber var="minute" integerOnly="true" value="${dto.leavetime/60 }"/>
							<fmt:parseNumber var="second" integerOnly="true" value="${dto.leavetime%60 }"/>
							${minute }:${second }						</c:when>
						<c:when test="${dto.leavetime<86400 }">
							<fmt:parseNumber var="hour" integerOnly="true" value="${dto.leavetime/3600 }"/>
							<fmt:parseNumber var="minute" integerOnly="true" value="${dto.leavetime%3600/60 }"/>
							<fmt:parseNumber var="second" integerOnly="true" value="${dto.leavetime%3600%60 }"/>
							${hour }:${minute }:${second }
						</c:when>
						<c:otherwise>
							<fmt:parseNumber var="day" integerOnly="true" value="${dto.leavetime/86400 }"/>
							<fmt:parseNumber var="hour" integerOnly="true" value="${dto.leavetime%86400/3600 }"/>
							<fmt:parseNumber var="minute" integerOnly="true" value="${dto.leavetime%86400%3600/60 }"/>
							<fmt:parseNumber var="second" integerOnly="true" value="${dto.leavetime%86400%3600%60 }"/>
							<c:if test="${minute<10 }">
								<c:set var="minute" value="'0${minute }'"/>
							</c:if>
							<c:if test="${second<10 }">
								<c:set var="second" value="0${second }"/>
							</c:if>
							${day}일 + ${hour}:${minute }:${second}
						</c:otherwise>
					</c:choose>
				</span>
			</td>
		</tr>
		<tr>
			<th class="w3-purple">판매자</th>
			<td>${dto.member_id }</td>
			<th class="w3-purple">경매 시작 날짜</th>
			<td>
				<fmt:formatDate var="date" value="${dto.reg_date}" pattern="yyyy-MM-dd"/>
				${date }
			</td>
		</tr>
		<tr>
			<th class="w3-purple">
				<c:choose>
				<c:when test="${highest==''}">
					현재 입찰 가격
				</c:when>
				<c:otherwise>
					최종 낙찰 가격
				</c:otherwise>
				</c:choose>
			</th>
			<td colspan="3">
				<input type="hidden" name="r_money" value="${dto.money }">
				<input type="hidden" name="a_code" value="${dto.a_code }">
				<input type="hidden" name="time" value="${dto.time }">
				<c:choose>
					<c:when test="${highest==''}">
						<input type="text" size="7" name="money" value="${dto.money }" onkeydown="filterNumber(event);">원
					</c:when>
					<c:otherwise>
						${dto.money }원
					</c:otherwise>
				</c:choose>
				
			</td>
		</tr>
		<tr>
			<th class="w3-purple">상품 설명</th>
			<td>
				<textarea rows="10" cols="30" readonly="readonly">${dto.content }</textarea> 
			</td>
			<c:if test="${not empty dto.filename}">
			<th class="w3-purple">책 이미지</th>
				<td>
					<img width="200" src="${pageContext.request.contextPath}/resources/files/auction/${dto.filename}"style="box-shadow: 0px -10px 5px grey;" >
				</td>
			</c:if>
		</tr>
		<tr>
			<td colspan="4">
				<c:choose>
					<c:when test="${highest!=''}">
						${highest }님이 최종적으로 낙찰하셨습니다!!
					</c:when>
					<c:when test="${dto.member_id== userLoginInfo.id}">
						<input style="float:left" onclick="location.href='delete.auction?a_code=${dto.a_code}'" type="button"  class="click" value="취하하기">
						<input style="float: right;" type="button" class="click" onclick="location.href='list.auction'" value="경매품 목록">
					</c:when>
					<c:otherwise>
						<input style="float:left" onclick="Moneycheck()" type="button"  class="click" value="입찰하기">
						<input style="float: right;" type="button" class="click" onclick="location.href='list.auction'" value="경매품 목록">
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</table>
	
	</form>
	</div>
</body>
</html>