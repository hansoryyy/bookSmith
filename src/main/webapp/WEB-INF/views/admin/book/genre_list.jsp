<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file = "../top.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
   function deleteCheck($g_code){
      if(confirm("경고: 소분류까지 삭제됩니다. 정말 삭제하시겠습니까?")==true){
         location.href="deleteBig.adGenre?g_code="+$g_code;
      }
   }
   var result = '${msg}';
   if(result == 'genre'){
      alert("장르에 소속된 책이 있어 삭제 할 수가 없습니다.");
   }   
</script>
</head>


<style>
input[type=text] {
	width: 78%;
	padding: 12px 20px;
	margin: 8px 0;
	box-sizing: border-box;
	border: 2px solid #ccc;
	-webkit-transition: 0.5s;
	transition: 0.5s;	
	outline: none;
	border-radius: 2px;
}
</style>
<body>
<h1>장르 관리</h1>
<hr>
	<table width="100%" border="1" style="border-color:gray;border-style:none;">		
		<tr valign="top">
			<td colspan="2">
				<table id="customers"> <!-- 대분류표 -->
					<tr>
						<th>대분류</th>
					</tr>
						<c:forEach var="dto" items="${b_list}">
						<tr>
							<td>							
							(${dto.g_code})${dto.name}
							<a href="javascript:deleteCheck(${dto.g_code});">
							<img src="${pageContext.request.contextPath}/resources/files/book/x.png"></a> 
							<input style="float:right" type="button" class="button button7" 
							onclick="location.href='littleList.adGenre?g_code=${dto.g_code}'" value="선택">
							</td>
						</tr>
						</c:forEach>
						<tr>												
							<td>
							<form name="f" action="insert.adBig" method="post">
								<input type="text" name="name">
								<input type="submit" class="button" value="추가">
							</form>
							</td>						
						</tr>
				</table>				
			</td>
			<td valign="top">
				<table id="customers"> <!-- 소분류 표 -->
					<tr>
						<th>소분류</th>
					</tr>
					<c:choose>
					<c:when test="${empty s_list}">
						<td>대분류를 선택해 주세요.</td>
					</c:when>
					<c:otherwise>
						<c:forEach var="dto" items="${s_list }">
						<tr>
							<td>
							(${dto.g_code })${dto.name} 
							<input style="float:right" type="button" 
								onclick="location.href='deleteLittle.adGenre?g_code=${dto.g_code}'" class="button button8" value="삭제">
							</td>
						</tr>
						</c:forEach>
						<tr>
							<td>
							<form name="f" action="insert.adSmall" method="post">
								<input type="hidden" name="g_code" value="${g_code}">
								<input type="text" name="name">
								<input type="submit" class="button" value="추가">
							</form>
							</td>
						</tr>						
					</c:otherwise>
					</c:choose>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
<%@ include file="../bottom.jsp" %>
