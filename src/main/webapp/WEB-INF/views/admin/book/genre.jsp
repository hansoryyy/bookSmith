<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- student.jsp -->
<html>
<head>
	<title>장르 관리</title>
</head>
<body>
<div class="container-fluid">
  <div class="row">
  	<div class="col-xs-3">
  	</div>
  	<div class="col-xs-9">
  	</div>
  </div>
</div>

	<div align="center">
	
		<hr color="green" width="300">
		<h2>대 분 류 등 록</h2>
		<hr color="green" width="300">
		
		<form name="f" action="insert.adBig" method="post">
			<table border="1">
				<tr><td>
					대분류 : <input type="text" name="name">
				</td></tr>
				<tr><td align = "center">
					<input type="submit" value="등록">
					<input type="reset" value="취소">
				</td></tr>	
			</table>	
		</form>

		
		<hr color="green" width="300">
		<h2>소 분 류 등 록</h2>
		<hr color="green" width="300">
		
		<form name="f" action="insert.adSmall" method="post">
			<table border="1">
				<tr><td>
				대분류 선택  : 
					<select name="g_code">
						<c:forEach var="blist" items="${blist}">		
							<option value="${blist.g_code}">${blist.g_code} :: ${blist.name} </option>
						</c:forEach>
					</select>
					소분류 작성 : <input type="text" name="name">
				</td></tr>
				<tr><td align = "center">
					<input type="submit" value="등록">
					<input type="reset" value="취소">
				</td></tr>	
			</table>	
		</form>
		
	 	<table border="1">
			<tr>
				<th>코드</th>
				<th>소분류</th>
				<th>삭제</th>
			</tr>
			<c:forEach var="glist" items="${glist}">
			<c:if test="${glist.g_code % 1000 == 0}">
 				<c:set var="bg" value="${glist.name}"/>
			</c:if>				
			<tr>
				<td align = "center">${glist.g_code}</td>
				<td align = "left">${bg}::${glist.name}</td>
				<td align = "center">
				<a href="delete.adGenre?g_code=${glist.g_code}">삭제</a>
				</td>
			</tr>
			</c:forEach>
		</table>	
	
	</div>
</body>
</html>



