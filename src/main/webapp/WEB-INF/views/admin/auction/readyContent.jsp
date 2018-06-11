<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file = "../top.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/auction/style.css"/>
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
	<h1>${dto.name } 상세 설명</h1>
	<table id="customers">
		<tr>
			<th>번호 / 상품명</th>
			<td>${dto.a_code } / ${dto.name }</td>
			<th>마감 날짜</th>
			<td>
				<span id="leaveTime">
			</td>
		</tr>
		<tr>
			<th>제시 가격</th>
			<td>${dto.money }</td>
			<th>등록 날짜</th>
			
			<td>
				<fmt:formatDate var="date" value="${dto.reg_date}" pattern="yyyy-MM-dd"/>
					${date }
				</td>
		</tr>
		<tr>
			<th>상품 설명</th>
			<td >
				<textarea rows="10" cols="30" readonly="readonly">
				${dto.content }
				</textarea>
			</td>
			<c:if test="${dto.filename!='' }">
				<th>책 이미지</th>
				<td colspan="3">
					<img width="200" src="${pageContext.request.contextPath}/resources/files/auction/${dto.filename}"style="box-shadow: 0px -10px 5px grey;" >
				</td>
			</c:if>
		</tr>
		
		<tr>
			<td colspan="4">
			<div align="center">
				<input type="button" class="button" onclick="location.href='success.auction?a_code=${dto.a_code}'" value="등록">|
				<input type="button" class="button" onclick="location.href='fail.auction?a_code=${dto.a_code}'" value="삭제">
			</div>
			</td>
		</tr>
	</table>
		
</body>
</html>
<%@ include file = "../bottom.jsp"%>