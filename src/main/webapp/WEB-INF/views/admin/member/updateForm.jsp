<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file = "../top.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<!-- 도로명주소 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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
</script>
<script type = "text/javascript">
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
   if(f.id.value==""){
      alert("아이디를 입력해주세요.")
      f.id.focus()
      return
   }
   if(f.passwd.value==""){
      alert("비밀번호를 입력해주세요.")
      f.passwd.focus()
      return
   }
   if(!f.passwd.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)) {
       alert("비밀번호는 영문(대소문자구분),숫자,특수문자(~!@#$%^&*()-_? 만 허용)를 혼용하여 8~16자를 입력해주세요.");
       return false;
   }
   document.f.submit()
}
var openWin;
function idOverlapCheck()
{
     window.name = "parentForm";
      openWin = window.open("idOverlapCheck.member",
                "childForm", "width=400, height=250, resizable = no, scrollbars = no");    
}

</script>
</head>
<body>
<div id="memberModify">   
   <form name="f" action="updatePro.admin" method="post">
      <h1>♣ 회원 수정 페이지</h1>
      <hr>
      <table id="customers">
         <tr>                        
         	<th width="15%">아이디</th>            
            <td>
            	<input type="text" name="id" class="smith" value="${dto.id }" readonly>
            </td>
         </tr>
         <tr>
            <th width="15%">이름</th>
            <td>
            	<input type="text" name="name" class="smith" value="${dto.name }" readonly>
            </td>
         </tr>
         <tr>
            <th width="15%">비밀번호</th>
            <td>
            	<input type = "password" name="passwd" value="${dto.passwd }">
            </td>
         </tr>
         <tr>   
            <th width="15%">성별</th>
            <td>
            <c:choose>
            <c:when test="${dto.gender=='f' }">여자</c:when>
            <c:otherwise>남자</c:otherwise>
            </c:choose>
            </td>
         </tr>
         <tr>
            <th width="15%">생년월일</th>
            <td>
            	<input type = "text" name="birth" value = "${dto.birth }" readonly>
            </td>
         </tr>
         <tr>
            <th width="15%">이메일</th>
            <td>
            	<input type = "text" name="email" value= "${dto.email }">
            </td>
         </tr>
         <tr>
            <th width="15%">연락처</th>
            <td>
               <input type = "text" name="hp1" size="3" maxlength="3" value = "${dto.hp1 }"/>
               <input type = "text" name="hp2" size="4" maxlength="4" value = "${dto.hp2 }"/>
               <input type = "text" name="hp3" size="4" maxlength="4" value = "${dto.hp3 }"/>
            </td>
         </tr>
         <tr>
            <th width="15%">주소</th>
            <td>
               <input type = "text" id="postcode" class="postcode" name="zipcode" value="${dto.zipcode }"/>
               <input type="button" onclick="execDaumPostcode()" class="button button7" value="우편번호 찾기"><br>
               <div class="form-group" >
                  <input type = "text" id="address1" name="addr1" size="40" value = "${dto.addr1 }"/>
               </div>
               <div class="form-group" >
                  <input type = "text" id="address2" name="addr2" size="40" value="${dto.addr2 }"/>
               </div>
            </td>
         </tr>
      </table>
      <br>
      <input type="hidden" name="member_code" value="${dto.member_code}">
      <input type="submit" class="button" value="수정하기"/>
      <input type="button" onclick="history.back()" class="button button1" value="취소"/>
   </form>
</div>
</body>
</html>
<%@ include file = "../bottom.jsp" %>