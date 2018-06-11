<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../top.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
</head>
<body>
<h1>작 가 목 록</h1>
<hr>
	<div class="find">
		<form name="find" action="searchWriter">		
			<select id="search" name="searchType">
				<option value="w_name">작가</option>
				<option value="w_code">작가 코드</option>
			</select>
			<input type="text" name="value" placeholder="Search...">
			<input type="submit" class="button" value="검색">
			<input type="button" class="button" style="float:right" onclick="location.href='insertForm.adWriter'" value="작가등록">
		</form>
</div>
<br>
<div align="center" class="writerManager">
	<table id="customers">
		<tr>
			<th>작가 코드</th>
			<th>작가</th>
			<th width="50%">작가 소개</th>
			<th>관리</th>
		</tr>
		<c:if test="${empty wlist}">
		<tr>
			<td colspan="4" align="center">검색 결과가 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="wlist" items="${wlist}">
		<tr align="center">
			<td>${wlist.w_code}</td>
			<td>${wlist.w_name}</td>
			<td>${wlist.w_introduction}</td>
			<td>
				<input type="button" class="button button7" onclick="location.href='deleteWriter.adWriter?w_code=${wlist.w_code}'" value="삭제">
			</td>
		</tr>
		</c:forEach>
	</table>
</div>
<br>
<div class="pagination" align="center">
	<c:if test="${count > 0}">
	<c:if test="${startPage > pageBlock}">
		<a href="list.adWriter?pageNum=${startPage-pageBlock}">&laquo;</a>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
	<c:if test="${i == param.pageNum}">
		<a href="list.adWriter?pageNum=${i}" class="active">${i}</a>
	</c:if>
	<c:if test="${i != param.pageNum}">
		<a href="list.adWriter?pageNum=${i}">${i}</a>
	</c:if>
	</c:forEach>
	<c:if test="${endPage<pageCount}">
		<a href="list.adWriter?pageNum=${startPage+pageBlock}">&raquo;</a>
	</c:if>
	</c:if>
</div>
</body>
</html>
<%@ include file="../bottom.jsp"%>

