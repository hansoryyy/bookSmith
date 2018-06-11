<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file = "../top.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
</head>
<style>
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
<div align="center">
   <h1>1:1 문의</h1>
   <table id = "customers">
   	  <tr>
   	  	<th width="20%">제목</th>
   	  	<td><b><font style="color:blue">${getBoard.subject}</font></b></td>
   	  </tr>  
      <tr>
      	<th width="20%">번호</th>
        <td>${getBoard.qna_code}</td>                     
      </tr>
      <tr>
      	<th width="20%">작성자</th>
        <td>${getBoard.writer}</td>
      </tr>
      <tr>
      	<th width="20%">작성일</th>
        <td colspan="3">
        	<fmt:formatDate value="${getBoard.reg_date}" pattern="MM-dd HH:mm"/>        	
        </td>
      </tr>         
      <c:if test="${not empty getBoard.filename}">
      <tr>
         <th bgcolor="skyblue" width="20%">파일</th>
         <td colspan="3">
         	<img src="${pageContext.request.contextPath}/resources/files/qna/${getBoard.filename}"/>
         </td>
      </tr>
   	  </c:if>
      <tr>
         <th width="20%">내용</th>
         <td colspan="3"><textarea rows="20" cols="64" readonly="readonly">${getBoard.content}</textarea></td>
      </tr>   
   </table>
   <br>
   <hr>
      
   <c:if test="${getBoard.re_writer != null }">
      <h1>답글</h1>
      <table id="customers">
      <tr>
      	<th width="20%">제목</th>
        <td>
        	<b>re:&nbsp;<font style="color:red">${getBoard.subject}</font></b>
        </td>              
      </tr>
      <tr>
      	<th width="20%">번호</th>
        <td>${getBoard.qna_code}</td>
      </tr>
      <tr>
      	<th width="20%">작성자</th>
      	<td>${getBoard.re_writer}</td>        
      </tr>
      <tr>
      	<th width="20%">작성일</th>
        <td>
        	<fmt:formatDate value="${getBoard.re_reg_date}" pattern="MM-dd HH:mm"/>
        </td>
      </tr>      
      <tr>
         <th width="20%">내용</th>
         <td colspan="3"><textarea rows="20" cols="64" readonly="readonly">${getBoard.re_content}</textarea></td>
      </tr>
      <c:if test="${not empty getBoard.re_filename}">
      <tr>
         <th width="20%">파일</th>
         <td colspan="3"><a href="${pageContext.request.contextPath}/resources/files/qna/${getBoard.filename}">${getBoard.re_filename}</a></td>
      </tr>
      </c:if>
      </table>
   <input type="button" class="button button3" onclick="window.location='delete.qna?qna_code=${getBoard.qna_code}'" value="삭제하기">
   <input type="button" class="button button1" onclick="window.location='list.qna'" value="Q&A 목록">
   </c:if>
   <c:if test="${getBoard.re_content==null }">
   <input type="button" class="button" onclick="window.location='reply.qna?qna_code=${getBoard.qna_code}'" value="답글쓰기">
   <input type="button" class="button button3" onclick="window.location='delete.qna?qna_code=${getBoard.qna_code}'" value="삭제하기">
   <input type="button" class="button button1" onclick="window.location='list.qna'" value="1:1문의 목록">
   </c:if>
</div>