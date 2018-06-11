<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
      function setParentText(code,name){
         opener.document.getElementById("book_code").value = code
         opener.document.getElementById("bookname").value = name
         window.close()
     }
</script>
<div class="bookInsert">
    <br><br>
    <table border="1" width="100%" class="bookInsert">
      <tr bgcolor="green">
         <th>책코드</th>
         <th>책제목</th>
         <th>이미지</th>
         <th></th>
      </tr>
      <c:forEach var="dto" items="${list}">      
      <tr>            
         <td><input type="hidden" id="book_code" value="${dto.book_code}"  />${dto.book_code}</td>
         <td><input type="hidden" id="bookname" value="${dto.bookname}"  />${dto.bookname}</td>
         <td><img class="images" width="100" src="${pageContext.request.contextPath}/resources/img/${dto.img_name}"></td>
         <td>
         <input type="button" value="사용하기" onclick="setParentText('${dto.book_code}','${dto.bookname}')">
         </td>
      </tr>
      </c:forEach>
   </table>
    <input type="button" value="창닫기" onclick="window.close()">
</div>