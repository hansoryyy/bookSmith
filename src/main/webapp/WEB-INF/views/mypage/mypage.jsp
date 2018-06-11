<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>
<jsp:include page="mypageSide.jsp" />

<div align="center">
	<h3>최근 주문 내역</h3>
	<table style="width: 70%">
		<c:set var="count" value="0" />
		<c:set var="price" value="0" />
		<c:set var="once" value="0" />
		<c:forEach var="list" items="${olist}">
			<c:set var="count" value="${count+list.qty }" />
			<c:set var="this_code" value="${list.order_code }" />
			<c:if test="${once eq 0 }">
				<c:if test="${code ne this_code }">
					<tr bgcolor="#FFDB0D" style="border-top: 1px solid black;">
						<td colspan="3">주문코드 : ${list.order_code} <br>상태 :
							${list.status }<br> 주문날짜 : ${list.order_date}
						</td>
							<td><div align="center"><input type="button" value="상세정보" style="width:150; height:60" class="button button1" onclick="window.location='mypage_orderDetail.mypage?order_code=${list.order_code}'">
						</div></td>
						
					</tr>
					<c:set var="code" value="${list.order_code }" />
				</c:if>
				<tr>
					<td colspan="3"><div align="center"><a href="#" style="text-decoration: none">${list.bookname}
							<img
							src='${pageContext.request.contextPath}/resources/files/book/${list.img_name}'
							width="150">
					</a></div></td>
			</c:if>
			<c:set var="price" value="${price + list.each_price }" />
			<c:set var="once" value="1" />
		</c:forEach>
			<td>
				<div align="center">
					외 ${count}개
					<h4>
						총 결제금액 :${price }원
					</h4>
				</div>
			</td>
		</tr>
		<c:set var="price" value="0" />
	</table>
	<br>


	<h3>최근 문의 내역</h3>
	<table style="width: 70%">
		<tr bgcolor="#5882FA" style="color:white;" >
			<th width="50%" >글 제목</th>
			<th>작성일</th>
			<th width="10%">답글</th>
			<th>답글작성일</th>
		</tr>
		<c:if test="${qlist eq null || qlist.size() == 0}">
			<tr>
				<td colspan="4">등록된 Q&A가 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="list" items="${qlist}">
			<tr align="center">
				<td><a href="mypage_qnaDetail.mypage?qna_code=${list.qna_code}">
						${list.subject}</a></td>
				<td>${list.reg_date}</td>
				<td align="center">
				<c:choose>
					<c:when test="${list.re_writer eq null}">
						N
					</c:when>
					<c:otherwise>
						Y
					</c:otherwise>
				</c:choose>
				</td>
				<td>${list.re_reg_date}</td>
			</tr>
		</c:forEach>
	</table>








</div>














</td>
</tr>
</table>
</div>
</body>
</html>

