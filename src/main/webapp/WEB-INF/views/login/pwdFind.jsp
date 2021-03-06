<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
<script type="text/javascript">
   function check(){
      var form = document.pwdFind;
      var email = document.getElementById("email").value;
      var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
      
      if(!form.id.value){
         form.id.focus();
          document.getElementById("idCheck").innerHTML="아이디를 입력해주세요.";
          return false;
      }
      if(!form.email.value){
         form.email.focus(); //포커스를 Password 박스로 이동
            document.getElementById("idCheck").innerHTML="";
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
<div align="center" class="pwdFind">
   <h4>비밀번호를 분실하셨나요?</h4>
    <p>본인 확인 이메일 주소와 입력한 이메일 주소가<br>같아야 비밀번호를 받을 수 있습니다.</p>
   <form name="pwdFind" action="pwdFind.do" method="post" onsubmit="return check()">      
      <input type="text" name="id" id="id" placeholder="아이디"><br>
      <label style="color:red" id="idCheck"></label><br>
      <input type="text" name="email" id="email" placeholder="이메일"><br>
      <label style="color:red" id="emailCheck"></label><br>
      <input type="submit" value="비밀번호 찾기">
   </form>
</div>
</body>
</html>
</body>
</html>