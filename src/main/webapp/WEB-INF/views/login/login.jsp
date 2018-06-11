<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<html>   
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<script type="text/javascript">
   function checkDisable(frm){
       if( frm.idSaveCheck.checked == false ){
         frm.pwSaveCheck.disabled = true;
      } else {
         frm.pwSaveCheck.disabled = false;
      }
   } 
</script>
<body>
   <form name = "f" action="login.member" method="post" class="w3-container w3-display-middle w3-text-white w3-card-2 w3-animation-right" style="width:60%; background-color:#C72FB3;">
   
      <div class="w3-panel w3-text-white w3-padding-16" style="background-color:#C72FB3; text-shadow:1px 1px 0 #444">
           <h4><b>로그인</b></h4>
      </div>
      
      <div class="w3-row">
      
         <div class="w3-col m3 w3-center">
            <label>아이디(ID) |</label>&nbsp;
            <c:choose >
                 <c:when test="${id eq null}">
                    <input type="checkbox" name="idSaveCheck" onClick="checkDisable(this.form)">id저장
                 </c:when>
                 <c:otherwise>
                    <input type="checkbox" name="idSaveCheck" onClick="checkDisable(this.form)" checked>id저장
                 </c:otherwise>
              </c:choose>
         </div>
         
         <div class="w3-col m8 w3-center">
            <p><input class="w3-input w3-border w3-border-purple" value="${id}" name="id" type="text" placeholder="ID"></p>
         </div>
         
      </div>
      <div class="w3-row">
      
         <div class="w3-col m3 w3-center">
            <label>비밀번호(PWD) |</label>
            <c:choose >
                  <c:when test="${passwd eq null}">
                     <input type="checkbox" name="pwSaveCheck" style="background:none;">pw저장
                  </c:when>
                  <c:otherwise>
                     <input type="checkbox" class="w3-btn" name="pwSaveCheck" checked>pw저장
                  </c:otherwise>
                  </c:choose>
         </div>
         <div class="w3-col m8 w3-center">
            <p><input class="w3-input w3-border w3-border-purple" value="${passwd}" name="passwd" type="password" placeholder="PWD"></p>
         </div>
         <div class="w3-col m1 w3-center">
            <p><input class="w3-btn w3-border-white" type="submit" value="로그인"></p>
         </div>
         
      </div>
      <c:if test="${loginError eq 'loginError'}">
      
      <div class="w3-row">
         
         <div class="w3-col m12 w3-center w3-card-4">
            <p class="w3-text-red" style="text-shadow:1px 1px 0 #444"><b>아이디 혹은 비밀번호 오류입니다.</b></p>   
         </div>
         
      </div>
         
      </c:if>
      

        <div class="w3-row">
      
         <div class="w3-col m10 w3-center">
            <p class="w3-text-white" style="text-shadow:1px 1px 0 #444">아직 회원이 아니신가요?</b></p>   
         </div>
         <div class="w3-col m2 w3-center">
            <a href="join.member" class="w3-btn" style="background-color:#C72FB3; color:white;">회원가입</a>
         </div>
         
      </div>
   </form>
</body>
</html>