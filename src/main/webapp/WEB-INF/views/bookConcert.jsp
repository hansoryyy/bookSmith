<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<c:choose>
	<c:when test="${applicationScope.book_concert eq null}">
		<div class="w3-container w3-section">
			<h1>현재 북 콘서트는 진행중이 아니며 정상적으로 접근 부탁드립니다.</h1>
		</div>
	</c:when>
	<c:otherwise>
		<div class="w3-container w3-section">
		   <div class="w3-row">
		      <div class="w3-col m9 w3-center">
		         <iframe
		             src="http://player.twitch.tv/?channel=ryawkd&muted=true"
		             height="720"
		             width="1280"
		             frameborder="0"
		             scrolling="no"
		             allowfullscreen="false">
		         </iframe>
		      </div>
		       <div class="w3-col m1 w3-center">
		       	-
		       </div>
		      <div class="w3-col m2 w3-center w3-border" style="height:40%;">
		         <iframe frameborder="0"
				        scrolling="no"
				        id="chat_embed"
				        src="http://www.twitch.tv/embed/hebo/chat"
				        height="600"
				        width="100%">
				</iframe>
		      </div>
		   </div>
		</div>
	</c:otherwise>
</c:choose>

</body>
</html>