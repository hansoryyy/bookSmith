<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<title>Spring Web Project</title>
</head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
   function check(){
      var id = '<c:out value="${userLoginInfo.id}"/>';
      if(id == null || id == ""){
    	  alert("로그인이 필요합니다.");
    	  return false; 
      }else{
    	  document.c.submit();
      }
   }
</script>
<script type="text/javascript">
	function pubByteCheckTextarea(oid, tid, maxlength) {
		var isKorean = $(oid).val();
		var strlength = 0;

		for (var i = 0; i < isKorean.length; i++) {
			if (escape(isKorean.charAt(i)).length == 6) {
				strlength++;
			}
			strlength++;
		}

		if (parseInt(maxlength - strlength) <= 0) {
			alert(maxlength + "자 까지 입력 할 수 있습니다.");
			return false;
		} else {
			$(tid).html(strlength + "/" + maxlength);
		}
	};
</script>
<style>
table.type05 {
    border-collapse: separate;
    border-spacing: 1px;
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    margin: 20px 10px;
}
table.type05 th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #efefef;
}
table.type05 .even {
    background: #efefef;
}
table.type05 td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
}
.comment textarea {
	 width: 90%;
    height: 200px;
    padding: 12px 20px;
	
    
}
.comment table {
	width: 700;
}
 .comment input[type=button], input[type=submit] {
    background-color: #0000ff;
    border: none;
    color: white;
    padding: 16px 32px;
    text-decoration: none;
    margin: 4px 2px;
    cursor: pointer;
} 
.comment hr {
   background-color: #ff0000;
}
</style>

<body>
	<div align="center">
	<br>
	<c:set var="upPath" value="${upPath}" />
	<table  class="type05">
		<tr>
			<td colspan="2" align="right" >작성자 : ${getBoard.writer} <br> ${getBoard.reg_date}</td>
		</tr>
		<tr>
			<td align="center"><img class="images" width="100" src="${pageContext.request.contextPath}/resources/img/${bdto.img_name}"></td>
			<td><h3>${bdto.bookname}</h3><br> 평점 : ${getBoard.rate}</td> 
		</tr> 
		<tr>
			<td colspan="2" align="center" class="even"><h2>${getBoard.subject}</h2></td>
		</tr>
		<c:if test="${not empty getBoard.filename}">
		</c:if>
		<tr>
			<td colspan="2"><div align="center"><img class="images" src="${pageContext.request.contextPath}/resources/img/${getBoard.filename}"></div><br>
			<pre>${getBoard.content}</pre></td>
		</tr>
	</table>
	<br>
	
	<div class="comment" width="700">
		<table width="100%">
			<tr align="right">
				<td>
					<form name="c" action="comment.shopBoard" method="post" onSubmit="return check()">
						<textarea name="content" id="content" maxlength="300" class="pull"
							onkeydown="pubByteCheckTextarea('#content','#classCount','300');"
							placeholder="주제와 무관한 댓글, 악플은 삭제될 수 있습니다."></textarea>
						<span class="count" id="classCount">0/300</span><br> <input
							type="hidden" name="id" value="${userLoginInfo.id}" /> <input type="hidden"
							name="board_code" value="${getBoard.board_code}"> 
							<input	type="submit" value="등록"> 
						<hr color="gray">
					</form>
				</td>
			</tr>
			<c:if test="${dto == null || dto.size() == 0}">
				<tr>
					<td>등록된 댓글이 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="dto" items="${dto}">
				<tr>
					<td><b>${dto.id}</b><br><pre>${dto.content}</pre><br>
						<p style="color: gray;">
							<c:choose>
								<c:when test="${dto.leaveTime<60 }">${dto.leaveTime}분 전</c:when>
								<c:when test="${dto.leaveTime<1440 }">
									<fmt:parseNumber var="time" integerOnly="true"
										value="${dto.leaveTime/60 }" />${time }시간 전</c:when>
								<c:otherwise>
									<fmt:formatDate value="${dto.date }" pattern="yyyy-MM-dd" />
								</c:otherwise>
							</c:choose>
						</p>
						<hr color="gray"></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<input type="button" class="button button4"
		onclick="window.location='list.shopBoard'" value="글목록">
		</div>
</body>
</html>
