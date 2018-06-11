<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
<c:if test="${message != null}">
   alert(${message})
</c:if>
<script type="text/javascript">
   function check(){
      var form = document.idFind;
      var email = document.getElementById("email").value;
      var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
      
      if(!form.name.value){
         form.name.focus();
          document.getElementById("nameCheck").innerHTML="이름을 입력해주세요.";
          return false;
      }
      if(!form.email.value){
         form.email.focus(); //포커스를 Password 박스로 이동
            document.getElementById("nameCheck").innerHTML="";
            document.getElementById("emailCheck").innerHTML="이메일을 입력해주세요.";
          return false;
      }
      if(exptext.test(email) == false){
         form.email.focus();
         // 이메일 형식이 알파벳+숫자@알파벳+숫자 형식이 아닐 경우
         document.getElementById("emailCheck").innerHTML="이메일 형식이 올바르지 않습니다.";
         document.getElementById("email").value="";
         return false;
      }
      document.login.submit();
   }
</script>
<body>
<div align="center" class="idFind">
      <h4>아이디를 분실하셨나요?</h4>
        <p>본인 확인 이메일 주소와 입력한 이메일 주소가 <br>같아야 아이디를 받을 수 있습니다.</p>
   <form name="idFind" action="idFind.do" method="post" onsubmit="return check()">      
      <input type="text" name="name" id="name" placeholder="이름"><br>
      <label style="color:red" id="nameCheck"></label><br>
      <input type="text" name="email" id="email" placeholder="이메일"><br>
      <label style="color:red" id="emailCheck"></label><br>
      <input type="submit" value="아이디 찾기">
   </form>
</div>
</body>
</html>