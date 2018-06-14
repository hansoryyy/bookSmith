<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/WEB-INF/views/common/common-head.jsp" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="${pageContext.request.contextPath}/resources/css/semantic.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/semantic.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/guest_check.css" rel="stylesheet">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<title>비회원 주문내역 확인</title>
<style type="text/css">
.nopadding {
	padding : 0 !important;
}
</style>
<script>
	$(document).ready(function() {
		document.getElementById('order').innerHTML = "";
	});  


	function renderOrder (order ) {
		
	}
	function orderCheck() {
		console.log('버튼작동');
		var guest_email = document.guestCheck.guest_email.value
		var guest_passwd = document.guestCheck.guest_passwd.value
		var ctxpath = '${pageContext.request.contextPath}';
	 	var message = '<h4>BookSmith의 회원이신가요 ? 로그인후 마이페이지에서 확인하세요 !'
					 +'</h4><br><button type="submit" class="btn btn-danger" onclick="location.href=\'login.member\'">로그인 하러가기</button>' ;

		$
				.ajax ( {
					method : 'POST',
					url : ctxpath + '/orderCheck_guest',
					dataType : 'json',
					data : {
						guest_email : guest_email,
						guest_passwd : guest_passwd
					},
					success : function(res) {
							$("member").empty();
						if (res.check.length == 0) {
							$("#member").append(message);
							document.getElementById('order').innerHTML = "";
							document.getElementById('yesOrder').innerHTML = "";
							document.getElementById('noOrder').innerHTML = "<h3>존재하지 않는 주문입니다...\n 이메일과 비밀번호를 확인하세요 ! </h3>";
						} else {
							$("#member").empty()
							document.getElementById('noOrder').innerHTML = "";
							document.getElementById('yesOrder').innerHTML = "<h3>총"
									+ res.check.length + "건의 주문이 조회되었습니다.</h3>";

							var order = res.check;
							var items;
							var str;
							var total = 0;
							
							$.each ( order, function(i) {
								
								items = order[i].items;
								str += '<thead><tr><th>수령인</th><th>연락처</th><th>배송지</th><th>주문일자</th><th>요구사항</th><th>결제수단</th><th>배송상태</th><th>배송사</th><th>운송장번호</th></tr> </thead>';
								var ot = $('#orderTemplate').text();
								var htmlOrder = ot.replace('{phone}', order[i].tel)
								  .replace('{name}', order[i].name )
								  .replace('{addr}', '우편번호 :' + order[i].zipcode + "<br/>" + order[i].addr1 + '<br/>' + order[i].addr2)
								  .replace('{oderdate}', order[i].o_date )
								  .replace('{message}', order[i].message )
								  .replace('{pay}', order[i].payment_option )
								  .replace('{dstate}','<font size="4" color="red">'+order[i].status+'</font>')
								  .replace('{dcompany}', order[i].delivery_company )
								  .replace('{dnum}', order[i].delivery_code ) ;
								  
								 
								
								var htmlItems = '<table class="table"><tr><th>이미지</th><th>주문상품</th><th>단가</th><th>주문수량</th><th>합계</th></tr>';
									
								$.each( items, function(j) {
									var oit = $('#orderItemTemplate').text();
									var imgPath ='"><img width="90" src="${pageContext.request.contextPath}/resources/files/book/';
									var bookname = items[j].bookname;
									var tmp =  '<a href="view.product?book_code='+items[j].book_code+ imgPath +items[j].img_name+'"></a>';
									var tmp2 = '<a href="view.product?book_code='+items[j].book_code+'"><font size="4" color="green">'+bookname+'</font></a>';
									//var tmp = '<img width="90" src="${pageContext.request.contextPath}/resources/files/book/'+items[j].img_name+'">';
									//var tmp = '<a href="${pageContext.request.contextPath}/'++'/img/'+items[j].img_name+'">';
									var htmlOrderItem = oit.replace('{image_url}', tmp )
									                       .replace('{book_name}', tmp2)
									                       .replace('{unit_price}', comma(items[j].each_price/items[j].qty)+'원')
									                       .replace('{qty}', items[j].qty  )
									                       .replace('{price}',comma(items[j].each_price) +'원' );
															
									htmlItems += htmlOrderItem;
									total = total + items[j].each_price;
								});
								htmlItems += '</table>';
								// str += htmlItems;
								htmlOrder = htmlOrder.replace('{item_area}', htmlItems);
								htmlOrder = htmlOrder.replace('{tprice}', '<div align="right"><font size="4" color="blue">총 금액  : '+comma(total)+'원</font></div>');
								str += htmlOrder;
							});
							
							$("#order").append(str);
						} // end if-else
					}
				}); // end ajax

	}
	
	function comma(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
</script>

</head>

<body>
	<jsp:include page="../top.jsp" />

	
	
	<br>
	<br>
	<table width="400" align="center">
	<tr><td>
	<form name="guestCheck" >
  	<div class="form-group">
   	 <label for="exampleInputEmail1">비회원 주문 이메일</label>
    	<input type="email" class="form-control" id="exampleInputEmail1" name="guest_email" aria-describedby="emailHelp" placeholder="주문시 입력한 이메일 입력 ...">
		<br>
   	 	<label for="exampleInputPassword1">비회원 주문 비밀번호</label>
    	<input type="password" class="form-control" id="exampleInputPassword1" name="guest_passwd" placeholder="주문시 입력한 비밀번호 입력 ...">
    	<br>
    	&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<input type="button" class="btn btn-primary" onclick="orderCheck();" value="조회하기" /> 	
  	</div><br>
  	
  		
  		<div align="center">
			<label style="color: red" id="noOrder"></label>
			<label style="color: blue" id="yesOrder"></label>
  		</div><br><br>
  		
	</form>
	</td></tr></table>
	

	<div align = "center" id="member">
		<h4>BookSmith의 회원이신가요 ? 로그인후 마이페이지에서 확인하세요 !</h4><br>
		
  		<button type="submit" class="btn btn-danger" onclick="location.href='login.member'">로그인 하러가기</button>
  	</div>
  	
  	
	<br>
	<table width="1400" align="center">
	 	<tr><td>
	 	
		<table id="order" class="ui pink table">
		</table>
		
	
	</td></tr></table>
	
	<br>
	<br>


</body>
<script type="text/x-template" id="orderTemplate">

				<tr>
					<td>{name}</td>
					<td>{phone}</td>
					<td>{addr}</td>
					<td>{oderdate}</td>
					<td>{message}</td>
					<td>{pay}</td>
					<td>{dstate}</td>
					<td>{dcompany}</td>
					<td>{dnum}</td>
				</tr>
				<tr>
					<td colspan="2"></td>
					<td colspan="7" class="nopadding">
						{item_area}
					</td>
				</tr>
				
				<tr>
					<td colspan="9" align="right">{tprice}</td>
				</tr>

</script>
<script type="text/x-template" id="orderItemTemplate" >
<tr>
	<td>{image_url}</td>
	<td>{book_name}</td>
	<td>{unit_price}</td>
	<td>{qty}</td>
	<td>{price}</td>
</tr>
</script>
</html>