<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file = "../top.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/auction/style.css"/>
<body>
	<h1>경매품 신청 리스트</h1>
	<div align="center">
	<table id="customers">
		<tr>
			<th>번호</th>
			<th>상품명</th>
			<th>판매희망자</th>
			<th>최저가</th>
			<th>마감 시간</th>
			<th>등록|취하</th>
			
		</tr>
		<c:if test="${list.size()==0 }">
			<td colspan="6">신청한 경매품이 없습니다.</td>
		</c:if>
		<c:forEach var="dto" items="${list }">
		
			<form name="f" action="bid.auction" method="post">
			<tr>
				<td>
					<input type="hidden" name="a_code" value="${dto.a_code }">
					<input type="hidden" name="r_money" value="${dto.money }">
					${dto.a_code }
				</td>
				<td><a href="readyContent.auction?a_code=${dto.a_code }">${dto.name }</a></td>
				<td>${dto.member_id }</td>
				<td>
					${dto.money }
				</td>				
				<td style="color: blue">
					 ${dto.time }
				</td>
				<td>
					<input type="button" onclick="location.href='success.auction?a_code=${dto.a_code}'" value="등록">|
					<input type="button" onclick="location.href='fail.auction?a_code=${dto.a_code}'" value="취하">
				</td>
			</tr>
			</form>
			</c:forEach>		
	</table><br>
	
	</div>

</body>
</html>
<%@ include file = "../bottom.jsp"%>