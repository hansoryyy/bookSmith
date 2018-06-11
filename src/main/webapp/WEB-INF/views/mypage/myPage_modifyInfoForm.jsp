<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>
<%@include file="mypageSide.jsp"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function execPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
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
						if (data.userSelectedType === 'R') {
							//법정동명이 있을 경우 추가한다.
							if (data.bname !== '') {
								extraAddr += data.bname;
							}
							// 건물명이 있을 경우 추가한다.
							if (data.buildingName !== '') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
							fullAddr += (extraAddr !== '' ? ' (' + extraAddr
									+ ')' : '');
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
<script type="text/javascript">
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
		if (code === 9 || code === 36 || code === 35 || code === 37
				|| code === 39 || code === 8 || code === 46) {
			return;
		}
		//하단의 코드는 모든 키가 입력이 안되도록
		event.preventDefault();
	}
</script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/adm/input.css" />

<div align="center">
	<form name="f" method="POST" action="myPage_modifyInfo.mypage">
		<input type="hidden" name="member_code"
			value="${loginUser.member_code }" />
		<table width="600" align="center" class="outline">
			<tr>
				<td colspan="2" align=center>회원정보 수정</td>
			</tr>
			<tr>
				<td>이름</td>
				<td>${loginUser.name}</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>
					<div class="col-3 input-effect">
						<input class="effect-22" type="text" name="email"
							value="${loginUser.email}" placeholder="">
							 <label>E-mail</label> <span
							class="focus-bg"></span>
					</div>
				</td>
			</tr>
			<tr>
				<td>연락처</td>
				<td>
					<div class="col-3 input-effect">
						<input class="effect-22" type="text" name="hp1" size="3"
							maxlength="3" onkeydown="filterNumber(event);"
							value="${loginUser.hp1}"> <span class="focus-bg"></span>
					</div>
					<div class="col-3 input-effect">
						<input class="effect-22" type="text" name="hp2" size="4"
							maxlength="3" onkeydown="filterNumber(event);"
							value="${loginUser.hp2}"> <span class="focus-bg"></span>
					</div>
					<div class="col-3 input-effect">
						<input class="effect-22" type="text" name="hp3" size="4"
							maxlength="3" onkeydown="filterNumber(event);"
							value="${loginUser.hp3}"> <span class="focus-bg"></span>
					</div>
				</td>
			</tr>

			<tr>
				<td>주소</td>
				<td>
					<input type="button" onclick="execPostcode()" value="우편번호 찾기" class="button button1 btn btn-success"><br>
					<div class="col-3 input-effect">
						<input class="effect-22" type="text"
							id="postcode" placeholder="우편번호"  name="zipcode" size="3"
							value="${loginUser.zipcode }">
							<label>우편번호</label> <span class="focus-bg"></span><br>
					</div>
					
					<div class="col-3 input-effect">
						<input class="effect-22" type="text"
							id="address1" placeholder="주소" name="addr1" size="50"
							value="${loginUser.addr1 }">
							<label>주소</label> <span class="focus-bg"></span>
					</div>
					<div class="col-3 input-effect">
						<input class="effect-22" type="text"
							id="address2" placeholder="상세주소" name="addr2" size="50"
							value="${loginUser.addr2 }">
							<label>상세주소</label> <span class="focus-bg"></span>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
				<div align="center">
				<input type="submit" value="수정" class="button button1">
					<input type="reset" class="button button1" value="다시작성"> <input type="button" 
					onclick="window.location='myPage.member'" class="button button1" value="취소"></div></td>
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
