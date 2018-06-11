<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../top.jsp"%>
<%@include file="mypageSide.jsp"%>
<c:set var="upPath" value="${upPath}"/>
<style>
th{
	background-color:#5882FA;
	color:white;
}

</style>

<div align="center">
	<h3>Q&A</h3>
	<table>
		<tr>
			<th width="20%">Q&A번호</th>
			<td>${dto.qna_code}</td>
			<th width="20%">작성자</th>
			<td>${dto.writer}</td>
		</tr>
		<tr>
			<th width="20%">제목</th>
			<td>${dto.subject}</td>
			<th width="20%">작성일</th>
			<td>${dto.reg_date}</td>
		</tr>
		<tr>
			<th width="20%">내용</th>
			<td colspan="3"><textarea rows="20" cols="64" readonly="readonly">${dto.content}</textarea></td>
		</tr>
	<c:if test="${not empty dto.filename}">
		<tr>
			<th width="20%">파일</th>
			<td colspan="3"><img src='${pageContext.request.contextPath}/resources/files/book/${dto.filename}' width="120" ><br>
			<a href="${upPath}/${dto.filename}">${dto.filename}</a></td>
		</tr>
	</c:if>
	</table>
	<br>	
	<br>
	
	<c:if test="${dto.re_writer != null }">
		<h3>답글</h3>
		<table id="customers">
			<tr>
			<th width="20%">Q&A번호</th>
			<td>${dto.qna_code}</td>
			<th width="20%">작성자</th>
			<td>${dto.re_writer}</td>
		</tr>
		<tr>
			<th width="20%">제목</th>
			<td>re:${dto.subject}</td>
			<th width="20%">작성일</th>
			<td>${dto.re_reg_date}</td>
		</tr>
		<tr>
			<th width="20%">내용</th>
			<td colspan="3"><textarea rows="20" cols="64" readonly="readonly">${dto.re_content}</textarea></td>
		</tr>
	<c:if test="${not empty dto.re_filename}">
		<tr>
			<th width="20%">파일</th>
			<td colspan="3"><a href="${upPath}/${dto.re_filename}">${dto.re_filename}</a></td>
		</tr>
	</c:if>
		</table>
	<input type="button" class="button button4" onclick='history.back(); return false;' value="Q&A 목록">
	</c:if>
	<c:if test="${dto.re_content==null }">
	<input type="button" class="button button4" onclick='history.back(); return false;' value="Q&A 목록">
	</c:if>
</div>

</td>
</tr>
</table>
</div>