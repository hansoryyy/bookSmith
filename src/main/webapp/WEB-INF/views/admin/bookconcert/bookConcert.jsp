<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<%@ include file="../top.jsp" %>

<script type="text/javascript">
	function bcf_check(){
		if(bcf.BCname.value==""){
			alert("콘서트명을 입력해주세요.");
			bcf.BCname.focus();
			return
		}
		
		if(bcf.BChost.value==""){
			alert("Host명을 입력해주세요.");
			bcf.BChost.focus();
			return;
		}
		
		if(bcf.BCdate.value==""){
			alert("콘서트 일자 입력해주세요.");
			bcf.BCdate.focus();
			return;
		}
		
		if(bcf.BCtime.value==""){
			alert("콘서트 시간을 입력해주세요.");
			bcf.BCtime.focus();
			return;
		}
		document.bcf.submit();
	}
</script>
<!-- 123 -->
<div class="w3-container">
	<h1>북 콘서트 관리1</h1><hr>
	<c:choose>
		<c:when test="${applicationScope.book_concert ne null}">
		
			<div class="w3-container w3-card-2 w3-padding">
				<h3 class="w3-text-green">현재 등록중인 북콘서트</h3><hr>
				<p>
				${applicationScope.book_concert.BCname}||
				${applicationScope.book_concert.BCdate}/
				${applicationScope.book_concert.BCtime}				
				</p>
				<button onclick="location.href='del.bookConcert'" class="w3-button w3-black w3-hover-green">북 콘서트 해제</button>
			</div>	
				
		</c:when>
		
		<c:otherwise>
		
			<form name="bcf" action="regi.bookConcert" class="w3-container w3-card-4 w3-padding" method="POST" >
			<h3 class="w3-text-green">북 콘서트 등록하기</h3>
			<div class="w3-panel w3-green w3-text-white">
				${msg}
			</div>
			<hr>
			<label>북 콘서트명 :</label>
			<input name="BCname" type="text" class="w3-input w3-text-white w3-black" placeholder="북 콘서트 명을 입력해주세요.">
			<label>HOST명 :</label>
			<input name="BChost" type="text" class="w3-input w3-text-white w3-black" placeholder="HOST명을 입력해주세요.">
			<label>콘서트 일시   </label><br>
			<input name="BCdate" type="date" class="w3-text-white w3-black"> <input name="BCtime" type="time" class="w3-text-white w3-black">
			<br><br>
			<button onclick="javacsript:bcf_check()" class="w3-button w3-black w3-hover-green">북 콘서트 등록</button>
		</form>
		
		</c:otherwise>
	
	</c:choose>
	<br>
</div>

<%@ include file="../bottom.jsp" %>