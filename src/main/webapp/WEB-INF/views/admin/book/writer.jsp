<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file = "../top.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>작가 등록</title>
</head>
<body>
<h1>작가 등록</h1>
<hr>
<div align="center" class="mail">
<form name="mail" action="insert.adWriter" method="post">
	<table id="customers">
    	<tr>
        	<th width="20%">작가</th>
            <td>
            	<input type="text"  name="w_name" placeholder="작가">
           	</td>               
        </tr>
        <tr>
        	<th width="20%">작가 소개</th>
        	<td>
            	<textarea name="w_introduction" placeholder="작가 소개"></textarea>
           	</td>
        </tr>
        <tr align="center">
            <td colspan="2">
        	    <input type="submit" class="button" value="등록">
            	<input type="reset" onclick="history.back()" class="button button1" value="취소">
           	</td>
        </tr>   
      </table>   
</form>
</div>
</body>
<%@ include file="../bottom.jsp" %>
</html>