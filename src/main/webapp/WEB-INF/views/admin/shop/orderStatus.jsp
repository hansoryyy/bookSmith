<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../top.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>주문 내역 수정 | 북스미스</title>
</head>
<% 
 response.setHeader("Cache-Control","no-cache"); 
 response.setHeader("Pragma","no-cache"); 
 response.setDateHeader("Expires",0); 
%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/jquery-ui.min.js"></script>
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
                document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('address1').value = fullAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('address2').focus();
            }
        }).open();
    }
</script>
<script>
jQuery(function($){
    $.datepicker.regional["ko"] = {
        closeText: "닫기",
        prevText: "이전달",
        nextText: "다음달",
        currentText: "오늘",
        monthNames: ["1월(JAN)","2월(FEB)","3월(MAR)","4월(APR)","5월(MAY)","6월(JUN)", "7월(JUL)","8월(AUG)","9월(SEP)","10월(OCT)","11월(NOV)","12월(DEC)"],
        monthNamesShort: ["1월","2월","3월","4월","5월","6월", "7월","8월","9월","10월","11월","12월"],
        dayNames: ["일","월","화","수","목","금","토"],
        dayNamesShort: ["일","월","화","수","목","금","토"],
        dayNamesMin: ["일","월","화","수","목","금","토"],
        weekHeader: "Wk",
        dateFormat: "yymmdd",
        firstDay: 0,
        isRTL: false,
        showMonthAfterYear: true,
        yearSuffix: ""
    };
	$.datepicker.setDefaults($.datepicker.regional["ko"]);
});
$(function() {
    $("#delivery_date").datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: "yy-mm-dd",
        showButtonPanel: true,
        yearRange: "c-99:c+99",
        maxDate: "+0d"
    });
});
</script>
<style>
h1 {
	color: #4CAF50;
}

hr {
	color: #808080;
}

.button {
    background-color: #4CAF50; /* Green */
    border: none;
    color: white;
    padding: 14px 18px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 6px 2px;
    cursor: pointer;
}
.button2 {
	border-radius: 4px;
}

select {
    width: 80%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
    resize: vertical;
}
input[type=text] {
    width: 70%;
    padding: 12px 20px;
    margin: 8px 0;
    border-radius: 4px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    -webkit-transition: 0.5s;
    transition: 0.5s;
    font-size: 16px;
    outline: none;
}
input[type=text]:focus {
    border: 2px solid #4CAF50;
}
textarea {
    width: 50%;
    height: 200px;
    padding: 12px 20px;
    box-sizing: border-box;
    border: 2px solid #ccc;
    border-radius: 4px;
    background-color: #f8f8f8;
    font-size: 16px;
    resize: none;
}
textarea:focus {
    border: 2px solid #4CAF50;
}
#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
}
#customers td, #customers th {
    border: 1px solid #ddd;
    padding: 8px;    
}
#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: center;
    background-color: #4CAF50;
    color: white;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	 $('#orderProductModify').on('click', function(){
		$.ajax({
			type: "POST",
			url: "orderProductModify.admin",
			async : false,
			data: {"name" : $('#name').val(), "qty" : $('#qty').val(), 
				"order_code" : $('#order_code').val(), "order_item_code" : $('#order_item_code').val(), 
				"price" : $('#price').val(), "status" : $('#status').val()},
			success: function(data){
			}
		});
	});
});

$(document).ready(function(){
	 $('#orderAddrModify').on('click', function(){
		$.ajax({
			type: "POST",
			url: "orderAddrModify.admin",
			data: {"status" : $('#status').val(), "tel" : $('#tel').val(), 
				"zipcode" : $('#zipcode').val(), "addr1" : $('#addr1').val(), 
				"addr2" : $('#addr2').val(), "guest_email" : $('#guest_email').val(), 
				"order_code" : $('#order_code').val(), "name" : $('#name').val(),
				"message" : $('#message').val()},
			success: function(data){				
			}
		});
	});
});

$(document).ready(function(){
	 $('#paymentStatusModify').on('click', function(){
		$.ajax({
			type: "POST",
			url: "paymentStatusModify.admin",
			data: {"delivery_code" : $('#delivery_code').val(), "delivery_company" : $('#delivery_company').val(), 
				"order_date" : $('#order_date').val(), "order_code" : $('#order_code').val()},
			success: function(data){				
			}
		});
	});
});
</script>
<body>
<h1>주문 내역 수정</h1>
<hr>
<h3>주문상품 목록</h3>
<div id="orderProduct">
<table id="customers">
	<tr>		
		<th width="10%">이미지</th>
		<th width="38%">상품명</th>	
		<th width="12%">상태</th>
		<th width="10%">수량</th>
		<th width="10%">판매가</th>
		<th width="10%">소계</th> <!-- 수량 * 판매가 -->
		<th width="10%">수정</th>
	</tr>
	<c:forEach var="list" items="${list}">
	<form name="orderProduct" action="orderProductModify.admin" method="get">
	<tr align="center">		
		<td>
         	<img src="${pageContext.request.contextPath}/resources/files/book/${list.img_name}" width="80" height="120">
      	</td>
		<td>${list.bookname}</td>
		<td>
			<select id="status" name="status" style="text-align:center;">
				<option value="준비"<c:if test="${list.status == '준비'}">selected</c:if>>준비</option>
				<option value="배송"<c:if test="${list.status == '배송'}">selected</c:if>>배송</option>
				<option value="완료"<c:if test="${list.status == '완료'}">selected</c:if>>완료</option>
				<option value="취소"<c:if test="${list.status == '취소'}">selected</c:if>>취소</option>
				<option value="반품"<c:if test="${list.status == '반품'}">selected</c:if>>반품</option>
				<option value="품절"<c:if test="${list.status == '품절'}">selected</c:if>>품절</option>
			</select>			
		</td>
		<td>
			<input type="text" style="text-align:center;" name="qty" id="qty" value="${list.qty}">
		</td>
		<td>${list.price}</td>
		<td>${list.qty * list.price}</td>
		<td>
			<input type="hidden" name="price" value="${list.price}">
			<input type="hidden" name="order_item_code" value="${list.order_item_code}">	
			<input type="hidden" name="order_code" value="${param.order_code}">		
			<input type="submit" class="button" value="수정">
		</td>
			
	</tr>
	<c:set var="priceSum" value="${priceSum + (list.qty * list.price)}"/>	
	</form>
	</c:forEach>
</table>
<br>

<input type="reset" class="button button1" onclick="location.href='orderList.admin'" value="목록">
</div>
<br>
<hr>

<h3>주문 결제 내역</h3>
<div id="orderPaymentList">
<table id="customers">
	<tr>
		<th width="50%">주문번호</th>
		<th>결제방법</th>
		<th>주문총액</th>
		<th>주문취소</th>
	</tr>
	<tr align="center">
		<td>${dto.order_code}</td>
		<td>${dto.payment_option}</td>		
		<td align="right"><fmt:formatNumber value="${priceSum}" pattern="#,###"/>원</td>
		<td align="right">0원</td>
	</tr>
</table>
</div>
<hr>

<h3>결제 상세 정보</h3>
<div id="paymentStatus">
<form name="paymentStatus" method="post">
<table id="customers">
	<tr>
		<th>주문자</th>
		<th>결제 취소/환불 금액</th>
		<th>운송장번호</th>
		<th>배송회사</th>
		<th>배송일시</th>
	</tr>
	<tr align="center">
		<td>${dto.name}</td>
		<td align="right">
			<input type="text" name="order_withdrawal" id="order_withdrawal" style="text-align:right" value="${dto.order_withdrawal}">원
		</td>
		<td>
			<input type="text" name="delivery_code" id="delivery_code" style="text-align:center" value="${dto.delivery_code}">
		</td>
		<td>
			<input type="text" name="delivery_company" id="delivery_company" style="text-align:center" value="${dto.delivery_company}">
		</td>
		<td>
			<fmt:formatDate var="orderDate" value="${dto.order_date}" pattern="yy-MM-dd"/>
			<input type="text" name="delivery_date" style="text-align:center" id="delivery_date" value="${orderDate}">
		</td>
	</tr>
</table>
<br>
<input type="hidden" name="order_code" value="${param.order_code}">
<input type="submit" class="button" id="paymentStatusModify" value="결제/배송내역 수정">&nbsp;
<input type="reset" class="button button1" onclick="location.href='orderList.admin'" value="목록">
</form>
</div>
<hr>

<h3>주문자 배송지 정보</h3>
<div id="orderAddr">
<form name="orderAddr" method="post">
<table id="customers">
	<tr>
		<th width="15%">이름</th>
		<td>
			<input type="text" name="name" id="name" value="${dto.name}">
		</td>
	</tr>
	<tr>
		<th width="15%">연락처</th>
		<td>
			<input type="text" name="tel" id="tel" value="${dto.tel}">
		</td>
	</tr>
	<tr>		
		<th width="15%">주소</th>
		<td>
			<input type="text" id="zipcode" placeholder="우편번호" size="10" name="zipcode" value="${dto.zipcode}">
			<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="button"><br>
			<div class="form-group" >
		    	<input type="text" id="addr1" name="addr1" size="40" value="${dto.addr1}">
			</div>
			<div class="form-group">  
		   		<input type="text" id="addr2" name="addr2" size="40" value="${dto.addr2}">
           	</div>
		</td>
	</tr>
	<tr>
		<th width="15%">E-mail</th>
		<td>
			<input type="text" name="guest_email" id="guest_email" value="${dto.guest_email}">
		</td>
	</tr>
	<tr>
		<th width="15%">배송 메시지</th>
		<td>
			<textarea name="message" id="message">${dto.message}</textarea>
		</td>
	</tr>
</table>
<br>
<input type="hidden" name="order_code" id="order_code" value="${param.order_code}">
<input type="submit" class="button" id="orderAddrModify" value="주문자/배송지 정보 수정">&nbsp;
<input type="reset" class="button button1" onclick="location.href='orderList.admin'" value="목록">
</form>
</div>
</body>
</html>
<%@ include file="../bottom.jsp" %>