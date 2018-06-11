<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adm/style.css">
<script type="text/javascript">
function check(){
   var form = document.login;
   // 아이디 입력
   if(form.id.value == ""){
      form.id.focus(); //포커스를 id 박스로 이동
      document.getElementById("passwdCheck").innerHTML="";
      document.getElementById("idCheck").innerHTML="아이디를 입력해주세요.";
      return;
   }
   
   if (form.passwd.value == "") {
         form.passwd.focus(); //포커스를 Password 박스로 이동
         document.getElementById("idCheck").innerHTML="";
         document.getElementById("passwdCheck").innerHTML="비밀번호를 입력해주세요.";
         return;
    }
   document.login.submit();
}
</script>
<body>
<div align="center" class="login">
   <h1><a href="main.admin">BookSmith</a></h1>
   <form name="login" action="login.admin" method="post">
      <input type="text" name="id" placeholder="아이디" maxlength="41"><br>
      <label  style="color:red" id="idCheck"></label><br>
      <input type="password" name="passwd" placeholder="패스워드" maxlength="16"><br>
      <label style="color:red" id="passwdCheck"></label>
      <c:if test ="${l_error!=null }">
         <label style="color:red">아이디 또는 비밀번호를 확인해주세요!</label>
      </c:if>
      <br><br>
      <input type="button" onclick="check();" class="loginButton" value="로그인">
   </form> 
</div>
</body>
</html>