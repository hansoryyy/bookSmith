<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<<jsp:include page="../top.jsp"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/auction/w3.css"/>
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

</script>
<body>
	<h1>${userLoginInfo.id}님의 경매품 리스트</h1>
	<div align="center">
	<table class="w3-table-all">
		<tr class="w3-purple">
			<th>번호</th>
			<th>상품명</th>
			<th>판매자</th>
			<th>현재 낙찰가</th>
			<th>마감 시간</th>
			<th>현재 상태</th>
			
		</tr>
		<c:if test="${list.size()==0 ||list==null}">
			<td colspan="6">내 경매품이 없습니다.</td>
		</c:if>
		<c:forEach var="dto" items="${list }">
		
			<form name="f" action="bidList.auction" method="post">
			
			<tr>
				<td>
					<input type="hidden" name="a_code" value="${dto.a_code }">
					<input type="hidden" name="r_money" value="${dto.money }">
					${dto.a_code }
				</td>
				<td><a href="content.auction?a_code=${dto.a_code }">${dto.name }</a></td>
				<td>${dto.member_id }</td>
				<td>
					<c:choose>
					<c:when test="${dto.leavetime<=0 }">
						최종낙찰가격:${dto.money }원
					</c:when>
					<c:otherwise>
						${dto.money }원
					</c:otherwise>
					</c:choose>
				</td>				
				<td style="color: blue">
					 <c:choose>
						<c:when test="${dto.leavetime<=0 }"><p style="color:red">경매 마감</p></c:when>
						<c:when test="${dto.leavetime<3600 }">
							<fmt:parseNumber var="minute" integerOnly="true" value="${dto.leavetime/60 }"/>
							<fmt:parseNumber var="second" integerOnly="true" value="${dto.leavetime%60 }"/>
							${minute }분 남음
						</c:when>
						<c:when test="${dto.leavetime<86400 }">
							<fmt:parseNumber var="hour" integerOnly="true" value="${dto.leavetime/3600 }"/>
							<fmt:parseNumber var="minute" integerOnly="true" value="${dto.leavetime%3600/60 }"/>
							<fmt:parseNumber var="second" integerOnly="true" value="${dto.leavetime%3600%60 }"/>
							${hour }시간 남음
						</c:when>
						<c:otherwise>
							<fmt:parseNumber var="day" integerOnly="true" value="${dto.leavetime/86400 }"/>
							<fmt:parseNumber var="hour" integerOnly="true" value="${dto.leavetime%86400/3600 }"/>
							<fmt:parseNumber var="minute" integerOnly="true" value="${dto.leavetime%86400%3600/60 }"/>
							<fmt:parseNumber var="second" integerOnly="true" value="${dto.leavetime%86400%3600%60 }"/>
							${day}일 + ${hour}시간 남음
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${dto.ready==0 }">
							<font style="color:blue">승인대기중</font>
						</c:when>
						<c:when test="${dto.ready==1 }">
							<font style="color:GREEN">경매중</font>
						</c:when>
						<c:otherwise>
							<font style="color:red">경매 마감</font>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</form>
			</c:forEach>
			<tr>
				<td colspan="6">
					<input style="float: left;" type="button" onclick="location.href='bring.auction'" class="w3-button w3-round w3-purple" value="경매품 등록">
					<input style="float:right;" type="button" onclick="location.href='list.auction'" class="w3-button w3-round w3-purple" value="경매품 목록">
					<input style="float: right;" type="button" onclick="location.href='myList.auction'" class="w3-button w3-round w3-purple" value="내 입찰품목">
				</td>
			</tr>		
	</table><br>
	
	</div>

</body>
</html>