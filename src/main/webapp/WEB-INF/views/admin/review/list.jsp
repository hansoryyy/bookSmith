<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../top.jsp" %>
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
</style>
<body>
<h1 align="left">리뷰 목록</h1>
<hr>
<div class="find">
<form name="find" action="search.review">
	<select name="search">
		<option value="writer">작성자</option>
		<option value="subject">제목</option>
		<option value="content">내용</option>		
	</select>
	<input type="text" name="searchString" maxlength="20" placeholder="Search...">
	<input type="submit" class="button button1" value="찾기">
</form>
</div>
<br>
<div>
<table id="customers">
	<tr>
		<th>번호</th>		
		<th width="50%">제목</th>
		<th>글쓴이</th>
		<th>날짜</th>
		<th>조회</th>
	</tr>
	<c:if test="${list == null || list.size() == 0}">
	<tr>
		<td colspan="5">등록된 글이 없습니다.</td>
	</tr>
	</c:if>	
	<c:forEach var="list" items="${list}">
	<form action="update.review" method="post">	
	<tr align="center">	
		<td>${list.board_code}</td>		
		<td align="left"><b><a href="content.review?board_code=${list.board_code}">${list.subject}</a></b></td>
		<td>${list.writer}</td>		
		<td>
			<fmt:formatDate value="${list.reg_date}" pattern="MM-dd"/>
		</td>
		<td>${list.readcount}</td>	
	</tr>
	</form>
	</c:forEach>		
</table>
</div>
<br>
<div class="pagination" align="center">
	<c:if test="${count > 0}">
	<c:if test="${startPage > pageBlock}">
		<a href="list.review?pageNum=${startPage-pageBlock}">&laquo;</a>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
	<c:if test="${i == param.pageNum}">
		<a href="list.review?pageNum=${i}" class="active">${i}</a>
	</c:if>
	<c:if test="${i != param.pageNum}">
		<a href="list.review?pageNum=${i}">${i}</a>
	</c:if>
	</c:forEach>
	<c:if test="${endPage<pageCount}">
		<a href="list.review?pageNum=${startPage+pageBlock}">&raquo;</a>
	</c:if>
	</c:if>
</div>	
</body>
</html>