<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file = "sale.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>매출현황 | 북스미스</title>
</head>
<style>
h1 {
	color: #4CAF50;
}

hr {
	color: #808080;
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
<body>
<h1>${param.fr_date} ~ ${param.to_date} 일간 매출현황</h1><hr>
<div>
	<table id="customers">
		<tr>
			<th>주문일</th>
			<th>주문수</th>
			<th>주문합계</th>	
		</tr>
		<c:if test="${empty list}">
		<tr>
			<td colspan="3">검색 기준에 부합하는 검색 결과가 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${list}">
		<tr align="right">		
			<td align="center">${list.date}</td>
			<td align="center">${list.qty}</td>
			<td><b><fmt:formatNumber value="${list.money}" pattern="#,###"/></b></td>
		</tr>
			<c:set var="moneySum" value="${moneySum + list.money}"/>
		</c:forEach>
		<tr align="right" bgcolor="lightGray">
			<td colspan="2" align="center"><b>합 계</b></td>			
			<td><b><fmt:formatNumber value="${moneySum}" pattern="#,###"/></b></td>
		</tr>
	</table>
</div>
</body>
</html>