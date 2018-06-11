<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp" %>
<%@include file="mypageSide.jsp" %>
<script type="text/javascript">
function check(){
		if(f.passwd.value==""){
			alert("비밀번호를 입력해주세요.")
			f.passwd.focus()
			return
		}
		if(!f.passwd.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)) {
		    alert("비밀번호는 영문(대소문자구분),숫자,특수문자(~!@#$%^&*()-_? 만 허용)를 혼용하여 8~16자를 입력해주세요.");
		    return false;
		}
		if(f.passwd.value === f.passwd2.value){
			document.f.submit()
		}else{
			alert("비밀번호가 같지 않습니다.")
			return
		}
		document.f.submit()
	}
</script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/adm/input.css" />

<div align="center">
	<form name="f" method="POST" action="myPage_modifyPw.mypage">
		<input type="hidden" name="member_code" value="${loginUser.member_code }"/>
		<table width="600" align="center" class="outline">
			<tr>
				<td colspan="2" align=center>비밀번호 수정</td>
			</tr>
			<tr>
				<td width="150">이름</td>
				<td>${loginUser.name}</td>
			</tr>
			<tr>
				<td width="150">비밀번호</td>
				<td>
				<div class="col-3 input-effect">
				<input class="effect-22" type="password" name="passwd" placeholder="비밀번호">
							 <label>비밀번호</label> <span
							class="focus-bg"></span></div>
				</td>
			</tr>
			<tr>
				<td width="150">비밀번호 확인</td>
				<td>
				<div class="col-3 input-effect">
				<input class="effect-22" type="password" name="passwd2" placeholder="비밀번호 확인">
							 <label>비밀번호 확인</label> <span
							class="focus-bg"></span></div>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="button" class="button button1" onclick="check()" value="수정">
				<input type="button" class="button button1" onclick="window.location='myPage.member'" value="취소">
				</td>
			</tr>
			
		</table>
	</form>
</div>
</td>
</tr>
</table>
</div>
</body>
</html>
