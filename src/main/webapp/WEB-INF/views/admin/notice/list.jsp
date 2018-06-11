<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../top.jsp" %>
<html>
<head>
<title>공지사항 | 북스미스</title>
</head>
<body>
<h1>공지사항</h1>
<hr>
<div class="find">
<form name="find" action="search.notice">
		<select name="search">
			<option value="subject">제목</option>
			<option value="content">내용</option>
			<option value="writer">글쓴이</option>
		</select>
		<input type="text" name="searchString" maxlength="20" placeholder="검색어를 입력해주세요">
		<input type="submit" class="button" value="찾기">
		<input type="button" style="float:right;" class="button" onclick="location.href='write.notice'" value="글쓰기">
		<br>		
</form>
</div>
<div>	
<table id="customers">
	<tr>
		<th>글 번호</th>
		<th width="50%">글 제목</th>
		<th>작성자</th>
		<th>조회수</th>
		<th>작성일</th>
	</tr>
	<c:if test="${list == null || list.size() == 0}">
	<tr>
		<td colspan="5">등록된 글이 없습니다.</td>
	</tr>
	</c:if>
	<c:forEach var="list" items="${list}">
	<tr>
		<c:set var="num" value="${num-1}"/>
		<td align="center">${list.notice_code}</td>
		<td align="left"><b><a href="content.notice?notice_code=${list.notice_code}">
		${list.subject} (${list.c_count})</a></b></td>
		<td align="center">${list.writer}</td>
		<td align="center">${list.readcount}</td>
		<td align="center">
			<fmt:formatDate value="${list.reg_date}" pattern="MM-dd"/>
		</td>
	</tr>
	</c:forEach>
</table>
</div>
<br>
<div class="pagination" align="center">
	<c:if test="${count > 0}">
	<c:if test="${startPage > pageBlock}">
		<a href="list.notice?pageNum=${startPage-pageBlock}">&laquo;</a>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
	<c:if test="${i == param.pageNum}">
		<a href="list.notice?pageNum=${i}" class="active">${i}</a>
	</c:if>
	<c:if test="${i != param.pageNum}">
		<a href="list.notice?pageNum=${i}">${i}</a>
	</c:if>
	</c:forEach>
	<c:if test="${endPage<pageCount}">
		<a href="list.notice?pageNum=${startPage+pageBlock}">&raquo;</a>
	</c:if>
	</c:if>
</div>	
</body>
</html>
<%@ include file="../bottom.jsp" %>