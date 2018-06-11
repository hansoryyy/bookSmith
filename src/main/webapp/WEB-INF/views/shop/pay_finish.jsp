<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/views/common/common-head.jsp" />
<title>결제 완료</title>
</head>
<body>
<jsp:include page="../top.jsp"/>
<br><br><br>
<div align="center">
			<font size="7" face="Comic Sans MS" color="#C74696">Thank you !</font> <br>
			<strong><font size="4" face="맑은 고딕" >결제가 성공적으로 이루어졌습니다 !</font></strong><br>
			<font size="3" face="맑은 고딕" >BookSmith를 이용해주셔서 감사합니다 </font>
</div>
<br><br><br>
<div align="center">
		<strong><font size="5" >주문 조회 </font></strong>
		 <img width="25" src="${pageContext.request.contextPath}/resources/files/book/shirushi.png"><br><br>	
	
	<c:choose>
		<c:when test="${userLoginInfo ne null}">
			<button type="submit" class="btn btn-danger" onclick="location.href='mypage_orderList.mypage'">마이페이지</button>
		</c:when>
		<c:otherwise>
			 <button type="submit" class="btn btn-danger" onclick="location.href='orderCheck_guest'">비회원 주문 조회</button>
		</c:otherwise>
	</c:choose>
    
</div>
<br><br><br>





</body>
</html>