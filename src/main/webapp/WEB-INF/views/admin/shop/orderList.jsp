<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../top.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>주문내역 | 북스미스</title>
</head>
<%
 response.setHeader("Cache-Control","no-cache"); 
 response.setHeader("Pragma","no-cache"); 
 response.setDateHeader("Expires",0); 
%>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<style>
h1 {
	color: #4CAF50;
}

hr {
	color: #808080;
}

.button {
    background-color: #4CAF50; /* Green */
    border: none;
    color: white;
    padding: 14px 18px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 6px 2px;
    cursor: pointer;
}
.button2 {
	border-radius: 4px;
}

.button3 {
	background-color: #4CAF50; /* Green */
    border: none;
    color: white;
    padding: 4px 6px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 12px;
    margin: 6px 2px;
    cursor: pointer;
	border-radius: 4px;
}

select {
    width: 15%;
    box-sizing: border-box;
    border: 2px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
    background-color: white;
    background-image: url('searchicon.png');
    background-position: 10px 10px; 
    background-repeat: no-repeat;
    padding: 12px 20px 12px 40px;
}
input[type=text] {
    width: 25%;
    box-sizing: border-box;
    border: 2px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
    background-color: white;
    background-image: url('searchicon.png');
    background-position: 10px 10px; 
    background-repeat: no-repeat;
    padding: 12px 20px 12px 40px;
}
input[type=text]:focus {
    border: 2px solid #4CAF50;
}
#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
}
#customers td, #customers th {
    border: 1px solid #ddd;
    padding: 8px;    
}
#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: center;
    background-color: #4CAF50;
    color: white;
}
</style>
<script>
function orderSearchCheck(){
	var form = document.orderSearch;	
	if (form.searchString.value == "") {
         alert("검색어를 입력해주세요!!")
         form.searchString.focus();
         return false;
    }
	document.orderSearch.submit();
}
</script>

<body>
<h1>주문 내역</h1><hr>
<form name="orderSearch" action="orderSearch.admin">
	<select name="search">
		<option value="order_code">주문번호</option>
		<option value="name">주문자</option>
		<option value="member_id">회원ID</option>
		<option value="tel">주문자 연락처</option>
		<option value="delivery_code">운송장번호</option>
	</select>
	<input type="text" name="searchString" placeholder="Search...">
	<input type="submit" id="orderFind" class="button" onclick="return orderSearchCheck();" value="검색">
</form>
<br>
<div class="order">
	<table id="customers">
		<tr>
			<th width="20%" rowspan="2" colspan="2">주문번호</th>
			<th width="15%">주문자</th><th width="15%">주문자 연락처</th>
			<th width="15%">받는분</th><th rowspan="3">주문합계</th>
			<th rowspan="3">입금 합계</th><th rowspan="3">주문취소</th>
			<th rowspan="3" width="5%">보기</th>		
		</tr>
		<tr>
			<th>회원ID</th><th>주문상품수</th><th>누적주문수</th>
		</tr>
		<tr>
			<th>주문상태</th><th>결제수단</th><th>운송장번호</th><th>배송회사</th><th>주문일자</th>
		</tr>
		<c:if test="${empty list}">
		<tr>
			<td colspan="9">검색 기준에 부합하는 검색 결과가 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${list}">
		<tr align="center">
			<td rowspan="2" colspan="2">${list.order_code}</td>
			<td width="15%">${list.name}</td>
			<td width="15%">${list.tel}</td>
			<td width="15%">${list.name}</td>
			<td rowspan="3"><fmt:formatNumber value="${list.each_price}" pattern="#,###"/></td>
			<td rowspan="3"><fmt:formatNumber value="${list.each_price}" pattern="#,###"/></td>
			<td rowspan="3"><font style="color:red;">${list.order_withdrawal}</font></td>
			<td rowspan="3" width="5%">
				<input type="button" onclick="location.href='orderStatus.admin?order_code=${list.order_code}'" class="button button7" value="보기">
			</td>
		</tr>
		<tr align="center">
			<td>${list.member_id}</td><td>${list.qty}건</td><td>${list.qty}건</td>
		</tr>
		<tr align="center">
			<td>${list.status}</td>
			<td>${list.payment_option}</td>
			<td>${list.delivery_code}</td>
			<td>${list.delivery_company}</td>
			<td><fmt:formatDate value="${list.order_date}" pattern="yy-MM-dd HH:mm"/></td>
			<c:set var="priceSum" value="${priceSum + list.each_price}"/>
			<c:set var="depositSum" value="${depositSum + list.each_price}"/>
			<c:set var="qtySum" value="${qtySum + list.qty}"/>
		</tr>
		</c:forEach>
		<tr align="center" bgcolor="lightGray">
			<td colspan="3"></td>
			<td><b>${qtySum}건</b></td>
			<td><b>합 계</b></td>
			<td><b><fmt:formatNumber value="${priceSum}" pattern="#,###"/></b>
			</td>
			<td><b><fmt:formatNumber value="${depositSum}" pattern="#,###"/></b></td>
			<td><b>0</b></td><td></td>
		</tr>
	</table>
</div>
<br>
<div class="pagination" align="center">
	<c:if test="${count > 0}">
	<c:if test="${startPage > pageBlock}">
		<a href="orderList.admin?pageNum=${startPage-pageBlock}">&laquo;</a>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
	<c:if test="${i == param.pageNum}">
		<a href="orderList.admin?pageNum=${i}" class="active">${i}</a>
	</c:if>
	<c:if test="${i != param.pageNum}">
		<a href="orderList.admin?pageNum=${i}">${i}</a>
	</c:if>
	</c:forEach>
	<c:if test="${endPage<pageCount}">
		<a href="orderList.admin?pageNum=${startPage+pageBlock}">&raquo;</a>
	</c:if>
	</c:if>
</div>
</body>
</html>
<%@ include file="../bottom.jsp" %>