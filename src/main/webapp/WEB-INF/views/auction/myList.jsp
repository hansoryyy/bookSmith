<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../top.jsp"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>내 입찰리스트</title>
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
   <h1>내 입찰 리스트</h1>
   <hr>
   <table class="w3-table-all">
      <tr class="w3-purple">
         <th>번호</th>
         <th>상품명</th>
         <th>판매자</th>
         <th>현재 낙찰가</th>
         <th>내 입찰가</th>
         <th>마감 시간</th>
         <th>취하하기</th>
         
      </tr>
      <c:if test="${list.size()==0 }">
         <td colspan="5">내 경매 물품이 없습니다.</td>
      </c:if>
      <c:forEach var="dto" items="${list }">
         <form name="money" action="bidMyList.auction" method="post">
         <tr>
            <td>${dto.a_code }</td>
            <td><a href="content.auction?a_code=${dto.a_code }">${dto.name }</a></td>
            <td>${dto.member_id }</td>
            <td>${dto.money }원</td>
            <td>
               <input type="hidden" name="a_code" value="${dto.a_code }">
               <input type="hidden" name="r_money" value="${dto.money }">
               <input type="hidden" name="time" value="${dto.time }">
               <c:choose>
               		<c:when test="${dto.ready==1 }">
               			<input style="text-align:right;" type="text" size="7" name="money"  placeholder="<fmt:formatNumber value="${dto.money}" pattern="#,###"/>" onkeydown="filterNumber(event);">원
               			<input type="submit" class="w3-button w3-blue" value="입찰">
               		</c:when>
               		<c:otherwise>
               			${dto.money }원
               		</c:otherwise>
               </c:choose>
               <%-- <c:if test="${dto.ready==1}">
                     <input type="submit" class="w3-button w3-blue" value="입찰">
               </c:if> --%>
            </td>
            <td>
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
            <c:if test="${dto.ready==1 }">
            <td>
               <input type="button" onclick="location.href='deleteBidder.auction?bidder_code=${dto.bidder_code}'" class="w3-button w3-green" value="취하하기">
            </td>
            </c:if>
         </tr>
         </form>
      </c:forEach>
      <tr>
         <td colspan="6">
            <input style="float:left;" type="button" onclick="location.href='list.auction'" class="w3-button w3-round w3-purple" value="경매품 목록">
         </td>
      </tr>      
   </table>
   <br>
</body>
</html>
