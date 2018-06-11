<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../top.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
   function check(){
      var id = '<c:out value="${userLoginInfo.id}"/>';
      if(id == null || id == ""){
    	  alert("로그인이 필요합니다.");
    	  return false; 
      }else{
    	  location.href="write.shopBoard";
      }
   }
</script>
<style>
table.type {
	width:1000;
    border-collapse: separate;
    border-spacing: 1px; 
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    margin: 20px 10px;
}
table.type th {
	align: center;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #efefef;
}
table.type .even {
    background: #efefef;
}
table.type td {
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
}
</style>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<div align="center">
   <h3>북 로그</h3>
<table class="type"> 
   <tr>
      <th align="center" width="5%">글 번호</th>
      <th align="center" width="20%">도서</th>
      <th align="center" width="60%">글 제목</th>
      <th align="center" width="5%">작성자</th> 
      <th align="center" width="5%">조회수</th>
      <th align="center">작성일</th> 
   </tr>
   <c:if test="${list == null || list.size() == 0}">
   <tr>
      <td colspan="6">등록된 글이 없습니다.</td>
   </tr>
   </c:if>
   <c:forEach var="list" items="${list}">
   <tr align="center">
      <c:set var="num" value="${num-1}"/>
      <td align="center">${list.board_code}</td>
      <td align="left"><img class="images" width="30" src="${pageContext.request.contextPath}/resources/img/${list.img_name}">${list.bookname}</td>
      <td align="left"><a class="sansserif" href="content.shopBoard?board_code=${list.board_code}">
      ${list.subject} (${list.c_count})</a></td>
      <td align="center">${list.writer}</td>
      <td align="right">${list.readcount}</td>
      <td align="right">${fn:substring(list.reg_date,0,10)}</td>
   </tr>
   </c:forEach>
</table>
</div>
<br>
<div align="center">
   <c:if test="${count > 0}">
   <c:if test="${startPage > pageBlock}">
      [<a href="list.shopBoard?pageNum=${startPage - pageBlock}">이전</a>]
   </c:if>
   <c:forEach var="i" begin="${startPage}" end="${endPage}">
      [<a href="list.shopBoard?pageNum=${i}">${i}</a>]   
   </c:forEach>
   <c:if test="${endPage<pageCount}">
      [<a href="list.shopBoard?pageNum=${startPage+pageBlock}">다음</a>]
   </c:if>
   </c:if>
   <div class="find">
   <form name="fsearch" action="search.shopBoard">
      <select name="search">
         <option value="subject">제목</option>
         <option value="content">내용</option>
         <option value="writer">글쓴이</option>
      </select>
      <input type="text" name="searchString" maxlength="20" placeholder="검색어를 입력해주세요">
      <input type="submit" class="button" value="찾기">
      <br><br>
   </form>
      <input type="button" class="button button4" onclick="check()"value="글쓰기">
   </div>
</div>
</body>
</html>
