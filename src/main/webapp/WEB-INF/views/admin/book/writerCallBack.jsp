<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adm/style.css"/>
<script type="text/javascript">
	function setParentText(w_code, w_name){
		opener.document.getElementById("wInput_w_code").value = w_code
        opener.document.getElementById("wInput_w_name").value = w_name
        opener.document.getElementById("wInput_w_introduction").value = document.getElementById("cInput_w_introduction").value
        
    }
</script>
<style>
input[type=text] {
    width: 100%;
    padding: 4px 8px;
    margin: 8px 0;
    box-sizing: border-box;
    border: 1px solid #ccc;
    -webkit-transition: 0.5s;
    transition: 0.5s;
    outline: none;
}
</style>
<div class="bookInsert">
    <b><font size="5" color="gray">작가 목록</font></b>
    <hr>
    <table id="customers" class="bookInsert">
      <tr>
         <th width="15%">작가코드</th>
         <th>이름</th>
         <th width="60%">소개</th>
         <th>선택</th>
      </tr>
      <c:forEach var="dto" items="${wlist}">      
      <tr align="center">            
         <td>${dto.w_code}</td>
         <td>${dto.w_name}</td>
         <td><input type="text" id="cInput_w_introduction" value="${dto.w_introduction}" size="50" readOnly/></td>
         <td>
         <input type="button" class="button button7" value="선택" onclick="setParentText('${dto.w_code}','${dto.w_name}')">
         </td>
      </tr>
      </c:forEach>
   </table>
   <br>
   <input type="button" class="button button7" value="창닫기" onclick="window.close()">
</div>