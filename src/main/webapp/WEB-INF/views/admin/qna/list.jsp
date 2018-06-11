<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../top.jsp" %>
<html>
<head>
</head>
<body>
<h1 align="left">1:1 문의</h1>
<hr>
<div class="find">
<form name="find" action="search.qna">
		<select name="search">
			<option value="subject">제목</option>
			<option value="content">내용</option>
			<option value="writer">작성자</option>
		</select>
		<input type="text" name="searchString" maxlength="20" placeholder="Search...">
		<input type="submit" class="button button1" value="찾기">
		<br>		
</form>
</div>
<br>
<div>	
<table id="customers">
	<tr>
		<th>번호</th>
		<th width="60%">제목</th>
		<th>작성자</th>
		<th>작성일</th>
	</tr>
	<c:if test="${list == null || list.size() == 0}">
	<tr>
		<td colspan="5">등록된 글이 없습니다.</td>
	</tr>
	</c:if>
	<c:forEach var="list" items="${list}">
	<tr align="center">
		<td>${list.qna_code}</td>
		<td align="left">
			<b><a class="sansserif" href="content.qna?qna_code=${list.qna_code}">
      			<c:choose>
      			<c:when test="${list.re_content!=null }">${list.subject }<font style="color:red"> (답글완료)</font></c:when>
      			<c:otherwise> ${list.subject}</c:otherwise>
      			</c:choose>
      		</a></b>
      	</td>
		<td>${list.writer}</td>
		<td>
			<fmt:formatDate value="${list.reg_date}" pattern="MM-dd HH:mm"/>
		</td>
	</tr>
	</c:forEach>
</table>
</div>
<br>
<div class="pagination" align="center">
	<c:if test="${count > 0}">
	<c:if test="${startPage > pageBlock}">
		<a href="list.qna?pageNum=${startPage-pageBlock}">&laquo;</a>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
	<c:if test="${i == param.pageNum}">
		<a href="list.qna?pageNum=${i}" class="active">${i}</a>
	</c:if>
	<c:if test="${i != param.pageNum}">
		<a href="list.qna?pageNum=${i}">${i}</a>
	</c:if>
	</c:forEach>
	<c:if test="${endPage<pageCount}">
		<a href="list.qna?pageNum=${startPage+pageBlock}">&raquo;</a>
	</c:if>
	</c:if>
</div>
</body>
</html>
<%@ include file="../bottom.jsp" %>