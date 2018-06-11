<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>
<%@include file="mypageSide.jsp"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function execDaumPostcode() {
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
<div align="center">
	<h3>주문 조회</h3>
	<c:set var="code" value="0" />
	<c:set var="price" value="0" />
	<table style="width: 60%">
		<c:forEach var="list" items="${list}">
			<c:set var="this_code" value="${list.order_code }" />
			<c:if test="${code ne this_code }">
				<tr bgcolor="#FFDB0D" style="border-top: 1px solid black;">
					<td colspan="3">주문코드 : ${list.order_code} <br>상태 : ${list.status }<br> 주문날짜 :
						${list.order_date}
					</td>
				</tr>
				<tr bgcolor="#5882FA" style="color: white;">
				</tr>
				<c:set var="code" value="${list.order_code }" />
			</c:if>
			<tr align="center">
				<td><a href="#" style="text-decoration:none"><h4>${list.bookname}</h4> <br> <img
					src='${pageContext.request.contextPath}/resources/files/book/${list.img_name}'
					width="150"></a> &nbsp;&nbsp; ${list.qty}개 / <fmt:formatNumber
						type="currency" currencySymbol="￦" value="${list.each_price}" /></td>
			</tr>
			<c:set var="price" value="${price + list.each_price }" />
		</c:forEach>
		<tr style="border-bottom: 1px solid red;">
			<td colspan="3" align="center">
				<div align="center">
					<h3>
						총 결제금액 :
						<fmt:formatNumber type="currency" currencySymbol="￦"
							value="${price }" />
					</h3>
				</div>
			</td>
		</tr>
		<c:set var="price" value="0" />
	</table>
	<c:set var="once" value="0" />
	<form name="f" method="POST" action="mypage_orderDetailUpdate.mypage">

		<table style="width: 60%">
			<c:forEach var="list" items="${list}">
				<c:choose>
					<c:when test="${list.status eq '주문취소' || list.status eq '배송완료'}">
						<c:if test="${once eq 0 }">
							<tr>
								<th width="80">결제방법</th>
								<td>${list.payment_option }</td>
							</tr>
							<tr>
								<th>택배회사</th>
								<td>${list.delivery_company }</td>
							</tr>
							<tr>
								<th>배송코드</th>
								<td>${list.delivery_code }</td>
							</tr>
							<tr>
								<th>받는사람</th>
								<td>${list.name }</td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td>${list.tel }</td>
							</tr>
							<tr>
								<td>주소</td>
								<td>${list.zipcode }<br>${list.addr1 }<br>${list.addr2 }</td>
							</tr>
							<tr>
								<th>메세지</th>
								<td>${list.message }</td>
							</tr>
							<c:set var="once" value="1" />
						</c:if>
					</c:when>
					<c:otherwise>
						<input type="hidden" name="order_code" value="${list.order_code}" />
						<c:if test="${once eq 0 }">
							<tr>
								<th width="80">결제방법</th>
								<td>${list.payment_option }</td>
							</tr>
							<tr>
								<th>배송상태</th>
								<td>${list.status }</td>
							</tr>
							<tr>
								<th>택배회사</th>
								<td>${list.delivery_company }</td>
							</tr>
							<tr>
								<th>배송코드</th>
								<td>${list.delivery_code }</td>
							</tr>
							<tr>
								<th>받는사람</th>
								<td>
									<div class="col-3 input-effect">
										<input class="effect-22" type="text" placeholder="받는사람"
											name="name" size="5" value="${list.name }"> <label>받는사람</label>
										<span class="focus-bg"></span><br>
									</div>
								</td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td>
									<div class="col-3 input-effect">
										<input class="effect-22" type="text" placeholder="전화번호"
											name="tel" size="12" value="${list.tel }"> <label>전화번호</label>
										<span class="focus-bg"></span><br>
									</div>
								</td>
							</tr>
							<tr>
								<td>주소</td>
								<td><input type="button" onclick="execPostcode()"
									value="우편번호 찾기" class="button button1 btn btn-success"><br>
									<div class="col-3 input-effect">
										<input class="effect-22" type="text" id="postcode"
											placeholder="우편번호" name="zipcode" size="3"
											value="${list.zipcode }"> <label>우편번호</label> <span
											class="focus-bg"></span><br>
									</div>

									<div class="col-3 input-effect">
										<input class="effect-22" type="text" id="address1"
											placeholder="주소" name="addr1" size="50"
											value="${list.addr1 }"> <label>주소</label> <span
											class="focus-bg"></span>
									</div>
									<div class="col-3 input-effect">
										<input class="effect-22" type="text" id="address2"
											placeholder="상세주소" name="addr2" size="50"
											value="${list.addr2 }"> <label>상세주소</label> <span
											class="focus-bg"></span>
									</div></td>
							</tr>
							<tr>
								<th>메세지</th>
								<td>
									<div class="col-3 input-effect">
										<input class="effect-22" type="text" placeholder="메세지"
											name="message" size="20" value="${list.message }"> <label>메세지</label>
										<span class="focus-bg"></span><br>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2"><div align="center">
										<input type="button" value="주문 취소"
											onclick="window.location='mypage_orderDetailCancel.mypage?order_code=${list.order_code}'"
											class="button button1"><br> <br> <input
											type="submit" value="수정" class="button button1"> <input
											type="reset" value="초기화" class="button button1">
									</div></td>
							</tr>
							<c:set var="once" value="1" />
						</c:if>
					</c:otherwise>
				</c:choose>

			</c:forEach>
		</table>
	</form>
</div>
</td>
</tr>
</table>
</div>