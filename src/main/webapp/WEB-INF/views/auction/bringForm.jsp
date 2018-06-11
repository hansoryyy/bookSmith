<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../top.jsp"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>경매 물품 등록 | 북스미스</title>
</head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/auction/w3.css"/>
<script>
$(function() {
  $( "#datepicker1" ).datepicker({
    dateFormat: 'yy-mm-dd',
    minDate: 0
  });
});
</script>
<script type="text/javascript">
   function check(){
      if(f.money.value%100){
         alert("100원 단위로 최저가를 정해주세요");
         return;
      }
      var date = new Date();
         var year = date.getFullYear();//년도
         var month = date.getMonth()+1;//월
         if((month+"").length<2){
            month = "0"+month;
         }
         var day = date.getDate(); //일
         if((day+"").length<2){
            day = "0" + day;
         }
         var today = year+month+day;
         var inputDate = document.f.date.value;
         var dateSplit = inputDate.split("-");
         year = dateSplit[0];
         month = dateSplit[1];
         day = dateSplit[2];
         inputDate = year+""+month+""+day;
         
         if(parseInt(inputDate)<parseInt(today)){
            alert("오늘 이후로 마감 날짜를 정해주세요;");
            return;
         }
      
      document.f.submit()
   }
</script>
<body>
	<div align="center">
   <form name="f" action="bring.auction" method="post" enctype="multipart/form-data">
   <h2>경매 물품 등록</h2>
   <hr>
   <table class="w3-table-all">
      <tr>
         <th width="10%" class="w3-purple">상품명</th>
         <td><input type="text" name="name" id="auction-input w3-border"></td>
      </tr>
      <tr>
         <th width="10%" class="w3-purple">최저가</th>
         <td><input style="text-align:right;" type="text" name="money" id="auction-input w3-border">원</td>
      </tr>
      <tr>
         <th width="10%" class="w3-purple" >마감 시간</th><br>
         <td>
         <input type="text" name="date" id="datepicker1" value="날짜 입력" id="auction-input w3-border">
         <select name="time" class="auction-select">
            <c:forEach var="i" begin="1" end="24" step="1" >
               <option value="${i }">${i }</option>
            </c:forEach>         
         </select>시
         </td>
      </tr>
      <tr>
         <th width="10%" class="w3-purple">상품 설명</th>
         <td>
            <textarea rows="20" cols="50" name="content"></textarea>
         </td>         
      </tr>
      <tr>
         <th width="10%" class="w3-purple">파일</th>
         <td>
            <input type="file" name="filename" id="auction-input w3-border">
         </td>
      </tr>
   </table>
   <br>
   <input type="button" onclick="check()" class="w3-button w3-round w3-blue" value="물품 올리기">
   <input type="button" value="취소" onclick="history.back()" class="w3-button w3-round w3-gray">   
</form>
</div>
</body>
</html>