<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file = "../top.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<h1>마감 경매품 리스트</h1>
	<div align="center">
	<table id="customers">
		<tr>
			<th>번호</th>
			<th>상품명</th>
			<th>판매자</th>
			<th>최종 낙찰가</th>
			
		</tr>
		<c:if test="${list.size()==0 }">
			<td colspan="5">마감 된 경매품이 없습니다.</td>
		</c:if>
		<c:forEach var="dto" items="${list }">	
			<tr>
				<td>
					<input type="hidden" name="a_code" value="${dto.a_code }">
					${dto.a_code }
				</td>
				<td><a href="content.adAuction?a_code=${dto.a_code }">${dto.name }</a></td>
				<td>${dto.member_id }</td>
				<td>최종낙찰가격:${dto.money }원</td>				
			</tr>
			</c:forEach>
			<tr>
				<td colspan="5">
					<input style="float: right;" type="button" onclick="location.href='finish.auction'" value="시간끝난 리스트">
					<input style="float: left;" type="button" onclick="location.href='readyList.auction'" value="신청서 리스트">
				</td>
			</tr>		
	</table><br>
	
	</div>

</body>
</html>
<%@ include file = "../bottom.jsp"%>