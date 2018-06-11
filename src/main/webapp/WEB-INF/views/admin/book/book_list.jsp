<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ include file = "../top.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<h1>도서 관리</h1>
<hr>
<div align="left" class="find">
<form name="find" action="searchBook.adBook">
<select name="search">
   <option value="bookname">도서명</option>
   <option value="book_code">도서코드</option>
   <option value="w_name">작가</option>
</select>
<input type="text" name="searchString">
<input type="submit" class="button" value="검색">
</form>
 <input style="float: right;" type="button" class="button" onclick="location.href='insert.adBook'" value="도서 등록">
</div>
<br>
<table id="customers">
   <tr>
      <th width="6%">도서코드</th>
      <th width="7%">이미지</th>
      <th width="20%">도서명</th>
      <th>작가</th>
      <th width="10%">판매 가격</th>
      <th>재고</th>
      <th>판매</th>
      <th>품절</th>
      <th>관리</th>      
   </tr>
   <c:if test="${list ==null || list.size()==0 }">
	   <tr align="center">
	   	<td colspan="10">등록된 책이 없습니다.</td>
	   </tr>
   </c:if>
   
   
   	<c:forEach var="dto" items="${list }">
   	<form name="f" action="updateBook.adBook" method="post">
   	<tr align="center">
   		<td>
   			<input type="hidden" name="book_code" value="${dto.book_code }"/>
   			${dto.book_code }
   		</td>
   		<td>
            <img src="${pageContext.request.contextPath}/resources/files/book/${dto.img_name}" width="70px">
        </td>
   		<td>
   			<a href="view.product?book_code=${dto.book_code}" title="상품 상세정보 보러가기">
   				${dto.bookname}
   			</a>
   		</td>
   		<td>${dto.w_name }</td>
   		<td align="right"><input type="text" name="price" size="3" value="${dto.price }" />원</td>
   		<td align="right"><input type="text" name="qty" size="3" value="${dto.qty }" />개</td>
   		<td>	
   			<c:choose>
   			<c:when test="${dto.qty>0 }"><input type="checkbox" checked="checked"></c:when>
   			<c:otherwise><input type="checkbox"></c:otherwise>
   			</c:choose>
   		</td>
   		<td>
   			<c:choose>
   			<c:when test="${dto.qty==0 }"><input type="checkbox" checked="checked"></c:when>
   			<c:otherwise><input type="checkbox"></c:otherwise>
   			</c:choose>
   		</td>
   		<td>
   			<input type="submit" class="button button7" value="수정"/>|
			<input type="button" class="button button8" onclick="location.href='deleteBook.adBook?book_code=${dto.book_code}'" value="삭제"/>
   		</td>
   	</tr>
   	</form>
   	</c:forEach>
</table>
<br>
<div class="pagination" align="center">
	<c:if test="${count > 0}">
	<c:if test="${startPage > pageBlock}">
		<a href="list.adBook?pageNum=${startPage-pageBlock}">&laquo;</a>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
	<c:if test="${i == param.pageNum}">
		<a href="list.adBook?pageNum=${i}" class="active">${i}</a>
	</c:if>
	<c:if test="${i != param.pageNum}">
		<a href="list.adBook?pageNum=${i}">${i}</a>
	</c:if>
	</c:forEach>
	<c:if test="${endPage<pageCount}">
		<a href="list.adBook?pageNum=${startPage+pageBlock}">&raquo;</a>
	</c:if>
	</c:if>
</div>

</body>
</html>
<%@ include file="../bottom.jsp" %>