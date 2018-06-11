<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>
<%@include file="mypageSide.jsp"%>
<div align="center">
		<input type="button" value="1개월" style="width:120; height:60" class="button button1" onclick="window.location='mypage_orderList.mypage'">
		<input type="button" value="3개월" style="width:120; height:60" class="button button1" onclick="window.location='mypage_orderList.mypage?search=3month'">
		<input type="button" value="전체" style="width:120; height:60" class="button button1" onclick="window.location='mypage_orderList.mypage?search=all'"><br>
	


	<h3>주문 조회</h3>
	<c:if test="${list == null || list.size() == 0}">
		주문 기록이 없습니다.
	</c:if>
	<c:set var="code" value="0" />
	<c:set var="price" value="0" />
	<c:forEach var="list" items="${list}">
		<c:set var="this_code" value="${list.order_code }" />
		<c:choose>
			<c:when test="${code ne this_code }">
				<c:if test="${code ne this_code && code ne 0 }">
					<tr style="border-bottom:1px solid black;">
						<td colspan="3">
							<div align="right"><h3>총 결제금액 : <fmt:formatNumber type="currency" currencySymbol="￦" 
                   			 value="${price }"/></h3></div>
						</td>
					</tr>
					<c:set var="price" value="0" />
					</table>
				</c:if>

				<table style="width:60%">
					<tr bgcolor="#FFDB0D" style="border-top:1px solid black;">
						<td colspan="2">주문코드 : ${list.order_code} <br> 
						상태 : ${list.status }<br>
						주문날짜 : ${list.order_date}
						</td>
						<td align="right"><input type="button" value="상세정보" style="width:100; height:40" class="button button1" onclick="window.location='mypage_orderDetail.mypage?order_code=${list.order_code}'">
						</td>
					</tr>
					<tr bgcolor="#5882FA" style="color: white;">
						<th><div align="center">도서</div></th>
						<th>수량</th>
						<th>금액</th>
					</tr>
			</c:when>
		</c:choose>

					<tr>
						<td><div align="left"><a href="#" style="text-decoration:none"><img src='${pageContext.request.contextPath}/resources/files/book/${list.img_name}' width="120" >
						${list.bookname}
						</a></div>
						</td>
						<td width="10%">${list.qty}</td>
						<td width="10%"><fmt:formatNumber type="currency" currencySymbol="￦" 
                    value="${list.each_price}"/></td>
					</tr>
					<c:set var="price" value="${price + list.each_price }" />

					<c:if test="${code ne this_code }">
						<c:set var="code" value="${list.order_code }" />
					</c:if>
	</c:forEach>
		<tr>
			<td colspan="3">
				<div align="right"><h3>총 결제금액 : <fmt:formatNumber type="currency" currencySymbol="￦" 
                    value="${price }"/></h3></div>
			</td>
		</tr>
		<c:set var="price" value="0" />
	</table>
</div>
</td>
</tr>
</table>
</div>