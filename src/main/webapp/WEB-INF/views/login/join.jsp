<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>회원가입</title>
</head>
<!-- 도로명주소 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }
                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('address1').value = fullAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('address2').focus();
            }
        }).open();
    }
    function pwchk(){
        pw1 = document.getElementById("pwd1").value;
        if(!pw1.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)) {
           document.getElementById("passwdCheck").innerHTML="비밀번호는 영문(대소문자구분),숫자,특수문자(~!@#$%^&*()-_? 만 허용)를 혼용하여 8~16자를 입력해주세요.";
            return;
        }
        pw2 = document.getElementById("pwd2").value;
        if(pw1 == pw2){          
           document.getElementById("passwdCheck").innerHTML="비밀번호가 일치합니다.";
        }else{
           document.getElementById("passwdCheck").innerHTML="비밀번호가 일치하지 않습니다.";
           document.getElementById("pwd1").value="";
           document.getElementById("pwd2").value="";
        }
     }
    
</script>
<script type="text/javascript">

$(document).ready(function(){
    $('#ajax_request').on('click', function(){
      $.ajax({
         type: "POST",
         url: "duplicationCheck.member",
         data: {"id" : $('#checking').val()},
         success: function(data){
            if(data == 0){
               document.getElementById("idCheck").innerHTML=f.checking.value+"은(는) 사용 가능한 아이디 입니다.";
               f.id.value=f.checking.value;
            }else{
               document.getElementById("idCheck").innerHTML=f.checking.value+"은(는) 이미 가입된 아이디 입니다.";
               f.id.value="";
            }
         }
      });
   });
});
   //input type="text"에 숫자만 입력하기
   function filterNumber(event) {
        var code = event.keyCode;
        if (code > 47 && code < 58) {
             return;
        } 
        if (code > 95 && code < 106) {
             return;
        } 
        //특수키 입력
        if (code === 9 || code === 36 || code === 35 || code === 37 ||
             code === 39 || code === 8 || code === 46) {
            return;
        }
        //하단의 코드는 모든 키가 입력이 안되도록
        event.preventDefault();
   }
   function check(){
      if(f.checking.value==""){
         alert("아이디를 입력해주세요.")
         f.id.focus()
         return
      }
      if(f.id.value==""){
          alert("아이디중복을 확인해주세요.")
          f.id.focus()
          return
       }
      if(f.passwd.value==""){
         alert("비밀번호를 입력해주세요.")
         f.passwd.focus()
         return
      }
      if(f.pwd2.value==""){
          alert("비밀번호를 확인해주세요.")
          f.pwd2.focus()
          return
       }
      if(f.name.value==""){
          alert("이름을 입력해주세요.")
          f.name.focus()
          return
       }
      if(f.birth.value==""){
          alert("생년월일을 입력해주세요.")
          f.birth.focus()
          return
       }
      if(f.email.value==""){
          alert("이메일을 입력해주세요.")
          f.email.focus()
          return
       }
      document.f.submit()
   }

</script>
<body onload="f.id.focus()">
<jsp:include page="../top.jsp"></jsp:include>

<form name="f" action="join.member" class="w3-container w3-center w3-section w3-text-purple w3-card-2 w3-light-grey w3-animation-bottom" method="post">
    <input type="hidden" id="id" name="id" value=""/>
     <div class="w3-row w3-text-white" style="background-color:#C72FB3;">
           
           <div class="w3-col m1 w3-center">
              <a href="main.go" class="w3-btn">
                 <b class="w3-text-white w3-animate-left w3-animate-opacity" >B</b>ook 
                    <b class="w3-text-white fa w3-spin">S</b>
                  mith
               </a>
           </div>
           <div class="w3-col m1 w3-center">
              <h4>회원가입</h4>
           </div>
           <div class="w3-col m8 w3-center">
              <p></p>
           </div>
           <div class="w3-col m1 w3-right">
              <input class="w3-btn w3-text-white w3-xlarge" type="button" onclick="check()" value="가입하기">
           </div>
     </div> 
    
     <div class="w3-row">
      <div class="w3-col m1 w3-center">
         <p>&nbsp;
         아이디(ID)</p>
      </div>
      <div class="w3-col m4 w3-center">
         <p><input class="w3-input w3-border w3-border-purple" id="checking" name="checking" type="text" placeholder="ID" value="${id}"></p>
      </div>
      <div class="w3-col m1 w3-center">
         <p><input class="w3-button w3-purple w3-text-white w3-hover-white" type="button" id="ajax_request" value="id중복체크"></p>
      </div>
      <div class="w3-col m1 w3-center">
         <p>&nbsp;
         비밀번호(PWD)</p>
      </div>
      <div class="w3-col m5 w3-center">
         <p><input class="w3-input w3-border w3-border-purple" id="pwd1" name="passwd" type="password" placeholder="PASSWORD"></p>
      </div>      
   </div>
   <hr color="purple">
   
   
   <div class="w3-row">
      <div class="w3-col m6 w3-center">
         <p><label style="color:red" id="passwdCheck"></label></p>
         <p><label style="color:red" id="idCheck"></label></p>
      </div>
      <div class="w3-col m1 w3-center">
         <p>&nbsp;
         비밀번호    확인</p>
      </div>
      <div class="w3-col m5 w3-center">
         <p><input class="w3-input w3-border w3-border-purple"  id="pwd2" onchange="pwchk()" name="passwd1" type="password" placeholder="비밀번호 확인"></p>
      </div>
   
   </div>
   <hr color="purple">
   
   <div class="w3-row">
      <div class="w3-col m1 w3-center">
         <p>&nbsp;
         이름(NAME)</p>
      </div>
      <div class="w3-col m5 w3-center">
         <p><input class="w3-input w3-border w3-border-purple" name="name" type="text" placeholder="NAME"></p>
      </div>
      <div class="w3-col m1 w3-center">
         <p>&nbsp;
         성별(GENDER)</p>
      </div>
      <div class="w3-col m2 w3-center">
         <p>
            <input class="w3-radio" type="radio" name="gender" value="m" checked>
             <label>남자</label>
          </p>
      </div>   
      <div class="w3-col m3 w3-center">
         <p>
             <input class="w3-radio" type="radio" name="gender" value="f">
              <label>여자</label>
          </p>
      </div>
   </div>
   <hr color="purple">
   
   <div class="w3-row">
      <div class="w3-col m1 w3-center">
         <p>&nbsp;
         생년월일(BIRTH)</p>
      </div>
      <div class="w3-col m5 w3-center">
         <p><input class="w3-input w3-border w3-border-purple" type="text" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" onkeydown="filterNumber(event);" placeholder="8자리로 입력하세요" name="birth" class="box" maxlength="8"></p>
      </div>
      
   </div>
   <hr color="purple">
   <div class="w3-row">
      <div class="w3-col m1 w3-center">
         <p>&nbsp;
         E-메일(E-MAIL)</p>
      </div>
      <div class="w3-col m5 w3-center">
         <p><input class="w3-input w3-border w3-border-purple" name="email" type="text" placeholder="E-mail"></p>
      </div>
      <div class="w3-col m1 w3-center">
         <p>&nbsp;
         E-메일 수신 여부</p>
      </div>
      <div class="w3-col m2 w3-center">
         <p>
            <input class="w3-radio" type="radio" name="mail" value="y" checked>
             <label>예</label>
          </p>
      </div>   
      <div class="w3-col m3 w3-center">
         <p>
             <input class="w3-radio" type="radio" name="mail" value="n">
              <label>아니오</label>
          </p>
      </div>
      
   </div>
   <hr color="purple">
   
   <div class="w3-row">
      <div class="w3-col m1 w3-center">
         <p>&nbsp;
         연락처</p>
      </div>
      <div class="w3-col m1 w3-center">
         <p><input type="text" name="hp1" class="w3-input w3-border w3-border-purple" maxlength="3" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" onkeydown="filterNumber(event);"></p>
      </div>
      <div class="w3-col m1 w3-center">
         <p>-</p>
      </div>
      <div class="w3-col m2 w3-center">
         <p><input type="text" name="hp2" class="w3-input w3-border w3-border-purple" maxlength="4" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" onkeydown="filterNumber(event);"></p>
      </div>
      <div class="w3-col m1 w3-center">
         <p>-</p>
      </div>
      <div class="w3-col m2 w3-center">
         <p><input type="text" name="hp3" class="w3-input w3-border w3-border-purple" maxlength="4" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" onkeydown="filterNumber(event);"></p>
      </div>
   </div>
   <hr color="purple">
   
   <div class="w3-row">
      <div class="w3-col m1 w3-center">
         <p>&nbsp;
         우편번호</p>
      </div>
      <div class="w3-col m2 w3-center">
         <p>
            <input class="w3-input w3-border w3-border-purple" type="text" id="postcode" placeholder="우편번호" name="zipcode" value="${loginUser.zipcode }">
         </p>
      </div>
      <div class="w3-col m1 w3-center">
         <p><input class="w3-button w3-purple w3-text-white w3-hover-white" type="button" onclick="execDaumPostcode()" value="우편번호 찾기"></p>
      </div>
      <div class="w3-col m4 w3-center">
         
            <P>
               <input class="w3-input w3-border w3-border-purple" type="text" id="address1" placeholder="주소"  name="addr1" value="${loginUser.address1 }">
            </P>
        
      </div>
      <div class="w3-col m4 w3-center">
           <p>
                <input class="w3-input w3-border w3-border-purple" type="text" id="address2" placeholder="상세주소" name="addr2" value="${loginUser.address2 }">
            </p>
      </div>
      
   </div>
   
</form>


</body>
</html>