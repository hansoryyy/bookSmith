<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../top.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>MoonGo | 관리자</title>
</head>
<script type="text/javascript">
function mailCheck(){
   var form = document.mail;
   // 아이디 입력
   if(form.subject.value == ""){
      form.subject.focus(); //포커스를 id 박스로 이동
      document.getElementById("subjectCheck").innerHTML="메일 제목을 입력해주세요.";
      document.getElementById("contentCheck").innerHTML="";
      return;
   }
   
   if (form.content.value == "") {
         form.content.focus(); //포커스를 Password 박스로 이동
         document.getElementById("subjectCheck").innerHTML="";
         document.getElementById("contentCheck").innerHTML="메일 내용을 입력해주세요.";        
         return;
    }
   document.mail.submit();
}
</script>
<body>
<div class="mail">
   <h1>회원 메일 수정</h1>
   <hr>
   <form name="email" action="updateMail.admin" method="post">
      <input type="hidden" name="mailcode" value="${dto.mailcode}">
      <table id="customers">
      <tr>
         <th>메일 제목</th>
         <td>
            <input type="text" name="subject" placeholder="${dto.subject}"><br>
            <label style="color:red" id="subjectCheck"></label>
         </td>
      </tr>
      <tr>
         <th>메일 내용</th>
         <td>
            <textarea name="content" placeholder="${dto.content}"></textarea><br>
            <label style="color:red" id="contentCheck"></label><br>            
         </td>
      </tr>
      </table>
      <br>
      <input type="submit" class="button" onclick="mailCheck();" value="저장">
      <input type="reset" class="button button1" onclick="location.href='mailList.admin'" value="취소">      
   </form>
</div>
</body>
</html>
<%@ include file="../bottom.jsp" %>