<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file = "../top.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%   
 response.setHeader("Cache-Control","no-store");   
 response.setHeader("Pragma","no-cache");   
 response.setDateHeader("Expires",0);   
 if (request.getProtocol().equals("HTTP/1.1")) 
         response.setHeader("Cache-Control", "no-cache"); 
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>회원관리 | 북스미스</title>
<script>
   var result = '${msg}';
   if(result == 'success'){
      alert("회원 삭제 성공!! 회원 목록 페이지로 이동합니다!!");
   }
   if(result == 'error'){
      alert("회원 삭제 실패!! 회원 목록 페이지로 이동합니다!!");
   }
   if(result == 'updateSuccess'){
      alert("등급 수정 성공!! 관리자 회원 목록 페이지로 이동합니다!!");
   }
   if(result == 'updateError'){
      alert("등급 수정 실패!! 관리자 회원 목록 페이지로 이동합니다!!");
   }
</script>
</head>
<body>
<h1>회원 관리</h1>
<hr>
<div class="find">
   <form name="find" action="searchMember.admin">
      <select name="search">
         <option value="id">아이디</option>
         <option value="name">이름</option>
      </select>
   <input type="text" name="searchString" placeholder="Search.."> 
   <input type="submit" class="button" value="검색">
   </form>
</div>
<div>
<table id = "customers">
      <tr bgcolor="skyblue">
         <th width = "10%">번호</th>
         <th width = "20%">이름</th>
         <th width = "20%">아이디</th>
         <th width = "30%">가입날짜</th>
         <th width = "5%">등급</th> 
         <th width = "15%">수정|삭제</th>
      </tr>
       <c:if test="${list==null || list.size()==0}">
      <tr>
         <td colspan="6">등록된 회원이 없습니다.</td>
      </tr>
      </c:if> 
      <c:forEach var="dto" items="${list}">
      <form name="f" action="updateGrade.admin" method="post">       
         <tr align="center">
         <td>${dto.member_code}
         <input type="hidden" name="member_code" value="${dto.member_code }"/>
         </td>
         <td><b><a href="updateMember.admin?member_code=${dto.member_code}">${dto.name}</a></b></td>
         <td>${dto.id}</td>
         <td><fmt:formatDate var="date" value="${dto.joindate}" pattern="yyyy-MM-dd"/>
            ${date}</td>
         <td>
            
            <select name = "grade" size="1" >
            <c:forEach var="i" begin="1" end="5" step="1" >
               <c:if test="${dto.grade==i }">
                  <option value="${i}" selected="selected">${i}</option>
               </c:if>
               <option value="${i}">${i}</option>
            </c:forEach>
            </select>
            
         </td>
         <td><input type="submit" class="button button7" value="수정">|
         <input type="button"  class="button button8" onclick="window.location='deleteMember.admin?member_code=${dto.member_code}'" value = "삭제"/></td>
      </tr>
      </form>
      </c:forEach>
   </table>
</div>
   <br>
<div class="pagination" align="center">
	<c:if test="${count > 0}">
	<c:if test="${startPage > pageBlock}">
		<a href="managerList.admin?pageNum=${startPage-pageBlock}">&laquo;</a>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
	<c:if test="${i == param.pageNum}">
		<a href="managerList.admin?pageNum=${i}" class="active">${i}</a>
	</c:if>
	<c:if test="${i != param.pageNum}">
		<a href="managerList.admin?pageNum=${i}">${i}</a>
	</c:if>
	</c:forEach>
	<c:if test="${endPage<pageCount}">
		<a href="managerList.admin?pageNum=${startPage+pageBlock}">&raquo;</a>
	</c:if>
	</c:if>
</div>
</body>
</html>

<%@ include file="../bottom.jsp" %>