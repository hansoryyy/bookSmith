<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file = "../top.jsp"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
   <title>출 판 사 관 리</title>
</head>
<body>
<h1>출 판 사 목 록</h1>
<hr>   
<div align="left" class="find">
<form name="find" action="searchPublisher">
   <select id="search" name = "searchType">
      <option value="p_name">출판사</option>
      <option value="p_code">출판사 코드</option>
   </select>
   <input type="text" name="value" placeholder="Search...">
   <input type="submit" class="button" value="검색">
   <input type="button" style="float:right" class="button" onclick="location.href='insertForm.adPublisher'" value="출판사 등록">
</form>
</div>
<br>   
<div align="center" class="publisherManager">      
      <table id="customers">
         <tr>
            <th>출판사 코드</th>
            <th width="20%">출판사</th>
            <th width="50%">출판사 소개</th>
            <th>관리</th>
         </tr>
         <c:if test="${empty plist}">
				<tr>
					<td colspan="4" align="center">검색 결과가 없습니다.</td>
				</tr>
		</c:if>
         <c:forEach var="plist" items="${plist}">         
         <tr align="center">
            <td>${plist.p_code}</td>
            <td>${plist.p_name}</td>
            <td>${plist.p_introduction}</td>
            <td>
               <input type="button" class="button button7" onclick="location.href='deletePublisher.adPublisher?p_code=${plist.p_code}'" value="삭제">            
            </td>
         </tr>
         </c:forEach>
      </table>   
   </div>
   <br>
<div class="pagination" align="center">
	<c:if test="${count > 0}">
	<c:if test="${startPage > pageBlock}">
		<a href="list.adPublisher?pageNum=${startPage-pageBlock}">&laquo;</a>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
	<c:if test="${i == param.pageNum}">
		<a href="list.adPublisher?pageNum=${i}" class="active">${i}</a>
	</c:if>
	<c:if test="${i != param.pageNum}">
		<a href="list.adPublisher?pageNum=${i}">${i}</a>
	</c:if>
	</c:forEach>
	<c:if test="${endPage<pageCount}">
		<a href="list.adPublisher?pageNum=${startPage+pageBlock}">&raquo;</a>
	</c:if>
	</c:if>
</div>
</body>
</html>
<%@ include file="../bottom.jsp" %>

