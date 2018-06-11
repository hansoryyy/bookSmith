<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adm/style.css"/>
<script type="text/javascript">
      function setParentText(p_code, p_name){
         opener.document.getElementById("pInput_p_code").value = p_code;
         opener.document.getElementById("pInput_p_name").value = p_name;
         opener.document.getElementById("pInput_p_introduction").value = document.getElementById("cInput_p_introduction").value;
         window.close();
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
    <b><font size="5" color="gray">출판사 목록</font></b>
    <hr>
    <table id="customers" class="bookInsert">
      <tr>
         <th width="15%">작가코드</th>
         <th>이름</th>
         <th width="60%">소개</th>
         <th>선택</th>
      </tr>
      <c:forEach var="dto" items="${plist}">      
      <tr align="center">            
         <td>${dto.p_code}</td>
         <td>${dto.p_name}</td>
         <td><input type="text" id="cInput_p_introduction"  value="${dto.p_introduction}" readOnly/></td>
         <td>
         <input type="button" class="button button7" value="선택" onclick="setParentText('${dto.p_code}','${dto.p_name}')">
         </td>
      </tr>
      </c:forEach>
   </table>
    <input type="button" class="button" value="창닫기" onclick="window.close()">
</div>