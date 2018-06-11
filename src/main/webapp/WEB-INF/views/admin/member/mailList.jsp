<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../top.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">

</script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adm/style.css"/>
<h1>이메일 발송 목록</h1>
<hr>
<div align="right">   
   <input type="button" class="button" value="메일작성" onclick="location.href='createMail.admin'">
</div>
<br>
<table id="customers">   
   <tr>      
      <th>번호</th>
      <th width="50%">제목</th>
      <th>작성일</th>
      <th>보내기|삭제</th>
   </tr>
   <c:if test="${list == null || list.size() == 0}">
   <tr>
      <td colspan="4">등록된 메일이 없습니다.</td>
   </tr>
   </c:if>
   <c:forEach var="list" items="${list}">
   <form action="mailSend.admin" method="post">
   <tr align="center">
      <td>${list.mailcode}</td>
      <td align="left">
         <a href="updateMail.admin?mailcode=${list.mailcode}"><b>${list.subject}</b></a>
      </td>
      <td>
         <fmt:formatDate value="${list.regdate}" pattern="MM-dd HH:mm"/>
      </td>         
      <td>
         <input type="hidden" name="mailcode" value="${list.mailcode}">
         <input type="submit" class="button button7" value="보내기">|
         <input type="button" class="button button8" value="삭제" onclick="location.href='deleteMail.admin?mailcode=${list.mailcode}'">         
      </td>
   </tr>
   </form>
   </c:forEach>
</table>
<br>
<div class="pagination" align="center">
   <c:if test="${count > 0}">
   <c:if test="${startPage > pageBlock}">
      <a href="mailList.admin?pageNum=${startPage-pageBlock}">&laquo;</a>
   </c:if>
   <c:forEach var="i" begin="${startPage}" end="${endPage}">
   <c:if test="${i == param.pageNum}">
      <a href="mailList.admin?pageNum=${i}" class="active">${i}</a>
   </c:if>
   <c:if test="${i != param.pageNum}">
      <a href="mailList.admin?pageNum=${i}">${i}</a>
   </c:if>
   </c:forEach>
   <c:if test="${endPage<pageCount}">
      <a href="mailList.admin?pageNum=${startPage+pageBlock}">&raquo;</a>
   </c:if>
   </c:if>
</div>
<%@ include file="../bottom.jsp" %>