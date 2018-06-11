<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file = "../top.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>상품판매순위 | 북스미스</title>
</head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/jquery-ui.min.js"></script>
<link rel="stylesheet" href="../css/style.css">
<c:set var="now" value="<%=new java.util.Date()%>"/>
<fmt:formatDate var="date" value="${now}" pattern="yyyyMMdd"/>
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

input[type=text], select {
    width: 8%;
    padding: 6px 10px;
    margin: 8px 0;
    box-sizing: border-box;
    border: 2px solid #ccc;
    -webkit-transition: 0.5s;
    transition: 0.5s;
    outline: none;
}

input[type=text]:focus {
    border: 2px solid #4CAF50;
}

.button {
    background-color: #4CAF50; /* Green */
    border: none;
    color: white;
    padding: 8px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
}
.button2 {
   border-radius: 4px;
}

</style>
<script>
jQuery(function($){
    $.datepicker.regional["ko"] = {
        closeText: "닫기",
        prevText: "이전달",
        nextText: "다음달",
        currentText: "오늘",
        monthNames: ["1월(JAN)","2월(FEB)","3월(MAR)","4월(APR)","5월(MAY)","6월(JUN)", "7월(JUL)","8월(AUG)","9월(SEP)","10월(OCT)","11월(NOV)","12월(DEC)"],
        monthNamesShort: ["1월","2월","3월","4월","5월","6월", "7월","8월","9월","10월","11월","12월"],
        dayNames: ["일","월","화","수","목","금","토"],
        dayNamesShort: ["일","월","화","수","목","금","토"],
        dayNamesMin: ["일","월","화","수","목","금","토"],
        weekHeader: "Wk",
        dateFormat: "yymmdd",
        firstDay: 0,
        isRTL: false,
        showMonthAfterYear: true,
        yearSuffix: ""
    };
   $.datepicker.setDefaults($.datepicker.regional["ko"]);
});
</script>
<script>
$(function() {
    $("#fr_date, #to_date").datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: "yymmdd",
        showButtonPanel: true,
        yearRange: "c-99:c+99",
        maxDate: "+0d"
    });
});

function itemSellCheck(){
   var form = document.itemSellRank;
   if(form.g_code.value == ""){      
      alert("분류를 선택하세요")
      return false;      
   }
   
   if (form.fr_date.value == "") {
         alert("시작일을 지정해주세요")
         return false;
    }
   document.itemSellRank.submit();
}
</script>
<body>
<h1>상품 판매 순위</h1>
<form name="itemSellRank" action="itemRankFind.admin">
   <select name="type">
      <option value="saleCount">판매수</option>
      <option value="price">금액</option>
   </select>
   <select name="g_code">
      <option value="0">전체</option>
      <c:forEach var="gb" items="${gb }">
         <option value="${gb.g_code}">${gb.name }</option>
      </c:forEach>
   </select>
   기간 설정 : 
   <label for="fr_date"><b>시작일</b></label>
   <input type="text" name="fr_date" id="fr_date" size="8" maxlength="8"> 에서
   <label for="to_date"><b>종료일</b></label>
   <input type="text" name="to_date" value="${date}" id="to_date" size="8" maxlength="8"> 까지
   <input type="submit" class="button button2" onclick="return itemSellCheck();" value="검색">
</form>
<div>
    <p>판매량을 합산하여 상품 판매 순위를 집계합니다.</p>
</div>
<hr>
<div>
   <table id="customers">
      <tr>
         <th>순위</th>
         <th width="10%">상품 이미지</th> <!-- 상품 이미지와 상품명 -->
         <th width="50%">상품명</th>
         <th>판매수</th>
         <th>총 판매 금액</th>
      </tr>
      <c:if test="${list == null || list.size() == 0}">
      <tr>
         <td colspan="6">검색 기준에 부합하는 검색 결과가 없습니다.</td>
      </tr>
      </c:if>
      <c:set var="rank" value="1"/>
      <c:forEach var="list" items="${list}">
      <tr align="center">
         <td>${rank}<c:set var="rank" value="${rank+1}"/></td>
         <td align="center"> <!-- 이미지 100x100, 이미지 클릭시 해당 제품 상세 페이지로 이동-->
            <a href="#"><img src="${pageContext.request.contextPath}/resources/files/book/${list.img_name}" width="100" height="100"></a>
         </td>
         <td>${list.bookname}</td>
         <td>${list.saleCount}</td>
         <td>${list.price}</td>
      </tr>
      </c:forEach>
   </table>
</div>
</body>
</html>