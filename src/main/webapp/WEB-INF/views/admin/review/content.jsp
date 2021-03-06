<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file = "../top.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
</head>
<style>
input[type=text]{
	width: 100%;
    padding: 6px 10px;
    margin: 8px 0;
    border-radius: 2px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    -webkit-transition: 0.5s;
    transition: 0.5s;
    font-size: 16px;
    outline: none;
}
input[type=text]:focus {
    border: 2px solid #4CAF50;
}
textarea {
    width: 100%;
    height: 400px;
    padding: 12px 20px;
    box-sizing: border-box;
    border: 2px solid #ccc;
    border-radius: 4px;
    background-color: #f8f8f8;
    font-size: 16px;
    resize: none;
}
textarea:focus {
    border: 2px solid #4CAF50;
}
</style>
<body>
<br>
<h1>${dto.bookname}</h1>
<hr>
<table id="customers">
<c:if test="${empty dto}">
      <tr>
         <td colspan="6">등록된 글이 없습니다.</td>
      </tr>
</c:if>
<form action="update.review" method="post">	 
	  <tr>
	  	<th>제목</th>
	  	<td colspan="3"><b>${dto.subject}</b></td>
	  </tr> 
	  <tr>
	  	<th>책이미지</th>
	  	<td width="15%" align="center">
      		<img src="${pageContext.request.contextPath}/resources/files/book/${dto.img_name}" width="70px">     		   		
      	</td>
      	<th width="15%">평점</th>
      	<td>${dto.rate}</td>      	
      </tr>      
      <tr>
         <th width="15%">글번호</th>
         <td>${dto.board_code}</td>
         <th width="15%">조회수</th>
         <td>${dto.readcount}</td>
      </tr>      
      <tr>
         <th width="15%">작성자</th>
         <td>${dto.writer}</td>
         <th width="15%">작성일</th>
         <td>
         <fmt:formatDate value="${dto.reg_date}" pattern="MM-dd HH:mm"/>
         </td>
      </tr>
      <c:if test="${not empty dto.filename}">
      <tr>
         <th width="15%">파일</th>
         <td colspan="3"><a href="${pageContext.request.contextPath}/resources/files/notice/${dto.filename}">${dto.filename}</a></td>
      </tr>
  	  </c:if> 
      <tr>
         <th width="15%">글내용</th>
         <td colspan="3"><textarea cols="100%" rows="24" name="content">${dto.content}</textarea></td>
      </tr>   
   </table>
   <br>
   	<input type="hidden" name="board_code" value="${dto.board_code}">
	<input type="submit" class="button" value="수정">
	<input type="button" class="button button3" onclick="location.href='delete.review?board_code=${dto.board_code}'" value="삭제">
	<input type="button" class="button button1" onclick="window.location='list.review'" value="글목록">
</form>
</body>
</html>
<%@ include file="../bottom.jsp" %>