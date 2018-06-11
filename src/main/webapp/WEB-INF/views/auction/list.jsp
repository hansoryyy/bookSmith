<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../top.jsp"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>경매 | 북스미스</title>
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
<script>
   var result = '${msg}';
   if(result == 'moneyError'){
      alert("100원 단위로 입력해주세요.");
   }
   if(result == 'moreMoney'){
      alert("현재 낙찰가보다 높은 가격으로 입찰 해주셔야 합니다.");
   }
   if(result == 'success'){
      alert("정상 입찰 하였습니다.");
   }
   if(result == 'error'){
      alert("오류가 발생하였습니다. 다시 시도해주세요");
   }
   if(result == 'register'){
      alert("경매품 등록이 완료되었습니다!");
   }
</script>
<body>
<h1>경매품 리스트</h1>
<hr>
<div style="vertical-align:middle;">
<form name="f" action="search.auction">
   <select name="search" id="auction-select w3-border">
      <option value="member_id">판매자</option>
      <option value="name">상품명</option>
      <option value="content">설명 내용</option>
   </select>
   <input type="hidden" name="juso" value="auction/list">
   <input type="text" name="searchString" id="auction-input w3-border" maxlength="20" placeholder="검색어를 입력해주세요">
   <input type="submit" class="w3-button w3-purple" value="찾기">
</form>

</div>
<table class="w3-table-all">
   <tr class="w3-purple">
      <th>번호</th>
      <th>상품명</th>
      <th>판매자</th>
      <th>현재 낙찰가</th>
      <th>마감 시간</th>         
   </tr>
   <c:if test="${list.size()==0 }">
      <td colspan="5">경매품이 없습니다.</td>
   </c:if>   
   <c:forEach var="dto" items="${list }">      
   <form name="f" action="bidList.auction" method="post">
   <tr align="center">   
      <td>
         <input type="hidden" name="a_code" value="${dto.a_code }">
         <input type="hidden" name="r_money" value="${dto.money }">
         <input type="hidden" name="time" value="${dto.time }">
         ${dto.a_code }
      </td>
      <td>
         <a href="content.auction?a_code=${dto.a_code }">${dto.name }</a>
      </td>
      <td>${dto.member_id }</td>
      <td>
         <c:choose>
         <c:when test="${dto.leavetime<=0 }">
         최종낙찰가격: <fmt:formatNumber value="${dto.money}" pattern="#,###"/>원
         </c:when>
         <c:otherwise>
            <input style="text-align:right;" type="text" size="7" name="money"  placeholder="<fmt:formatNumber value="${dto.money}" pattern="#,###"/>" onkeydown="filterNumber(event);">원
            <input type="submit" class="w3-button w3-blue" value="입찰하기">
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
      </tr>   
      </form>
      </c:forEach>
      <tr>
         <td colspan="5">
            <input style="float: left;" type="button" class="w3-button w3-round w3-purple" onclick="location.href='bring.auction'" value="경매 신청서">
            <input style="float: right;" type="button" class="w3-button w3-round w3-purple" onclick="location.href='my.auction'" value="나의 경매품 목록">&nbsp;
            <input style="float: right;" type="button" class="w3-button w3-round w3-purple" onclick="location.href='myList.auction'" value="내 입찰품목">
         </td>
      </tr>   
</table><br>
</body>
</html>