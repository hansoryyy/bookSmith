<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>

<jsp:include page="/WEB-INF/views/common/common-head.jsp" />


<title>Insert title here</title>
<style type="text/css">
	#msg{
		color:#ff0000;
		// display: none;
		visibility: hidden;
	}
</style>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	var total =  document.getElementById('cart_total');
	   
	
	
   function doPay(){
	   if(guest.name.value==""){
	         alert("수령인을 입력해주세요.")
	         guest.name.focus()
	         return
	     }
	   if(guest.guest_email.value==""){
	         alert("주문 이메일을 입력하세요.")
	         guest.guest_email.focus()
	         return
	      }
	   if(guest.guest_passwd.value==""){
	         alert("주문 비밀번호를 입력해주세요.")
	         guest.guest_passwd.focus()
	         return
	      }
	   if(guest.hp1.value==""){
	         alert("연락처를 제대로 입력하세요.")
	         guest.hp1.focus()
	         return
	      }
	   if(guest.hp2.value==""){
	         alert("연락처를 제대로 입력하세요.")
	         guest.hp2.focus()
	         return
	      }
	   if(guest.hp3.value==""){
	         alert("연락처를 제대로 입력하세요.")
	         guest.hp3.focus()
	         return
	      }
	   if(guest.zipcode.value==""){
	         alert("우편번호를 입력하세요.")
	         guest.zipcode.focus()
	         return
	      }
	   if(guest.addr1.value==""){
	         alert("주소를 입력하세요.")
	         guest.addr1.focus()
	         return
	      }
	   if(guest.addr2.value==""){
	         alert("상세주소를 입력하세요.")
	         guest.addr2.focus()
	         return
	      }
      var IMP = window.IMP; // 생략가능
      var name = document.guest.name.value;
      var hp = document.guest.hp1.value + document.guest.hp2.value + document.guest.hp3.value;
      var email = document.guest.guest_email.value;
      var addr =  document.guest.addr1 + document.guest.addr2
      var zipcode = document.guest.zipcode.value;
      var price = document.cart.total.value;
      IMP.init('imp83045627'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
      IMP.request_pay({
          pg : 'inicis', // version 1.1.0부터 지원.
          pay_method : 'card',
          merchant_uid : 'merchant_' + new Date().getTime(),
          name : name,
          amount : price,
          buyer_email : email,
          buyer_name :  name, 
          buyer_tel :  hp,
          buyer_addr : addr,
          buyer_postcode : zipcode,
          m_redirect_url : 'http://localhost:8080/project/pay.success'
      }, function(rsp) {
          if ( rsp.success ) {
              var msg = '결제가 완료되었습니다.\n';
              msg += '구매자 : '+ name +' \n';
              msg += '상호 명 : BookSmith \n';
              msg += '결제 금액 : ' + price + '\n';
              msg += '카드 승인번호 : ' + rsp.apply_num +'\n';
              document.guest.submit();
              
          } else {
              var msg = '결제에 실패하였습니다.';
              msg += '에러내용 : ' + rsp.error_msg;
              
          }
          alert(msg);
          
      });   
   }
   function doPayM(){
         IMP.init('imp83045627'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
         IMP.request_pay({
             pg : 'inicis', // version 1.1.0부터 지원.
             pay_method : 'card',
             merchant_uid : 'merchant_' + new Date().getTime(),
             name : document.guest.name.value,
             amount : document.cart.total.value,
             buyer_email :document.guest.email.value,
             buyer_name :  name, 
             buyer_tel :  document.guest.hp1.value + document.guest.hp2.value + document.guest.hp3.value,
             buyer_addr : document.guest.addr1 + document.guest.addr2,
             buyer_postcode : document.guest.zipcode.value,
             m_redirect_url : 'http://localhost:8080/project/pay.success'
         }, function(rsp) {
             if ( rsp.success ) {
                 var msg = '결제가 완료되었습니다.';
                 msg += '구매자 : '+ name +' \n';
                 msg += '상호 명 : BookSmith \n';
                 msg += '결제 금액 : ' + price + '\n';
                 msg += '카드 승인번호 : ' + rsp.apply_num +'\n';
                 document.guest.submit();
             } else {
                 var msg = '결제에 실패하였습니다.';
                 msg += '에러내용 : ' + rsp.error_msg;
             }
             alert(msg);
             
         });   
      }
</script>
<script>
   /* doPay = function() {
	   if(guest.name.value==""){
	         alert("수령인을 입력해주세요.")
	         guest.name.focus()
	         return
	     }
	   if(guest.guest_email.value==""){
	         alert("주문 이메일을 입력하세요.")
	         guest.guest_email.focus()
	         return
	      }
	   if(guest.guest_passwd.value==""){
	         alert("주문 비밀번호를 입력해주세요.")
	         guest.guest_passwd.focus()
	         return
	      }
	   if(guest.hp1.value==""){
	         alert("연락처를 제대로 입력하세요.")
	         guest.hp1.focus()
	         return
	      }
	   if(guest.hp2.value==""){
	         alert("연락처를 제대로 입력하세요.")
	         guest.hp2.focus()
	         return
	      }
	   if(guest.hp3.value==""){
	         alert("연락처를 제대로 입력하세요.")
	         guest.hp3.focus()
	         return
	      }
	   if(guest.zipcode.value==""){
	         alert("우편번호를 입력하세요.")
	         guest.zipcode.focus()
	         return
	      }
	   if(guest.addr1.value==""){
	         alert("주소를 입력하세요.")
	         guest.addr1.focus()
	         return
	      }
	   if(guest.addr2.value==""){
	         alert("상세주소를 입력하세요.")
	         guest.addr2.focus()
	         return
	      }
      document.guest.submit();
   } */
  /*  doPayM = function() {
	   if(guest.name.value==""){
	         alert("수령인을 입력해주세요.")
	         guest.name.focus()
	         return
	     }
	   if(guest.email.value==""){
	         alert("이메일을 입력하세요.")
	         guest.email.focus()
	         return
	      }
	   if(guest.hp1.value==""){
	         alert("연락처를 제대로 입력하세요.")
	         guest.hp1.focus()
	         return
	      }
	   if(guest.hp2.value==""){
	         alert("연락처를 제대로 입력하세요.")
	         guest.hp2.focus()
	         return
	      }
	   if(guest.hp3.value==""){
	         alert("연락처를 제대로 입력하세요.")
	         guest.hp3.focus()
	         return
	      }
	   if(guest.zipcode.value==""){
	         alert("우편번호를 입력하세요.")
	         guest.zipcode.focus()
	         return
	      }
	   if(guest.addr1.value==""){
	         alert("주소를 입력하세요.")
	         guest.addr1.focus()
	         return
	      }
	   if(guest.addr2.value==""){
	         alert("상세주소를 입력하세요.")
	         guest.addr2.focus()
	         return
	      }
     document.guest.submit(); 
   } */
    function execPostcode() {
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
<script type="text/javascript">

   var ctxpath = '${pageContext.request.contextPath}';
   
   function delCartItem ( btn, mode ) {
      var book_code = $(btn).attr('id');
      $.ajax ( {
         method : 'GET',
         url : ctxpath + '/delete_cart' ,
         data : {
				book_code : book_code,
				mode : mode	//mode 값이   0이면 바로구매목록 삭제, 1이면  장바구니목록에서 삭제
			},
         success : function( res ){
            if ( res.success == 'true' ) {
               location.reload();
            }else if( res.success =='return') {
               history.go(-2);
            }
         } ,
         
      });
   } 
   function updateCartItem( book_code, qty,  index, mode ){
	   console.log('updateCartItem() 메소드작동');
	   console.log('선택된 book_code : '+ book_code + ', 선택된 수량  :' + qty + ', index값 : ' + index);
	   $.ajax({
			method : 'GET',
			url : ctxpath + '/update_cart',
			data : {
				book_code : book_code,
				qty : qty,
				mode : mode
			},
	         success : function( res ){
	            if ( res.success  ) {
	            	var qty = res.qty;
	            	var each_price = res.each_price;
	            	var price = res.price;
	            	var total = res.total;
	            	
	            	$('#each_price'+index).text(comma('' + each_price));
	            	$('#total').text(comma('' + total));
	            	$('#msg').css({opacity: 0.0, visibility: "visible"}).animate({opacity: 1.0});
	            	setTimeout(
	            			function(){ $('#msg').css({opacity: 1.0, visibility: "visible"}).animate({opacity: 0}, 200) }, 2000);

	            }else{
	            	;
	            }
	        } ,
	         
	   });
   }

   function comma(x) { 
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
 
  
</script>
</head>
<body>
<jsp:include page="../top.jsp"/>


<form name="cart">
 <table width="1050" align = "center">
	<tr><td> 
			
			<br>
			<br>
			 <c:if test="${empty map && empty cart_list && empty dto }">
				 <table class="ui orange table" >
		
					<thead>
         				<tr>
         					<th><div class="text-center">이미지</div></th>
         			 		<th>상품명</th>
    				 		<th width="10%"><div class="text-center">수량</div></th>
    				 		<th><div class="text-center">단가</div></th>
    				 		<th><div class="text-center">금액</div></th>
    						<th width="10%"><div class="text-center">삭제</div></th>
  			 	   	    </tr>
  			   		</thead><tbody><tr><td colspan="6"><div class="text-center">장바구니가 비어 있습니다</div> </td></tr></tbody>
  	
				 </table>
             </c:if>
			
			<c:if test="${not empty dto}">
			
      	
      	  	
             <br>
             
        	  	<c:choose>
				 		<c:when test="${userLoginInfo eq null}">
				 		  	<div align ="center"><strong>
                				<font size="7" face="맑은 고딕" >비회원&nbsp;</font>
                				<font size="7" face="맑은 고딕" color="red" >바로구매 </font>
                				<font size="7" face="맑은 고딕" >결제</font>
           				     </strong></div>
				 		</c:when>
				 		<c:otherwise>
				 			<div align ="center"><strong>
                				<font size="7" face="맑은 고딕" >${userLoginInfo.id}님</font>
                				<font size="7" face="맑은 고딕" color="red" >바로구매 </font>
                				<font size="7" face="맑은 고딕" >결제</font>
           				     </strong></div>
				 		</c:otherwise>
				</c:choose> 
      	  		<br><br>
               	 <c:set var="total" value="${0}" />
               		<table class="ui orange table" >
         			<thead>
         				<tr>
         					<th><div class="text-center">이미지</div></th>
         			 		<th><div class="text-center">상품명</div></th>
    				 		<th>수량</th>
    				 		<th><div class="text-center">단가</div></th>
    				 		<th><div class="text-center">금액</div></th>
    						<th><div class="text-center">삭제</div></th>
  			 	   	    </tr>
  			   		</thead>
  			   		<tbody>
						 <tr>
                       		<td><div class="text-center">
                       			<a href="view.product?book_code=${dto.book_code}" title="상품 상세정보 보러가기">
                       				<img width="50" src="${pageContext.request.contextPath}/resources/files/book/${dto.img_name}">
                       			</a>
                       		</div></td>
                         	<td valign=middle><div class="text-center"><a href="view.product?book_code=${dto.book_code}" title="상품 상세정보 보러가기">${dto.bookname}</a></div></td>
                         	<td><div class="ui form"><div class="field">
							<input type = "text" id="updateQty" value="${dto.qty}" onchange="updateCartItem(${dto.book_code}, this.value , 0, 0);"
							 onkeydown="this.value=this.value.replace(/[^0-9]/g,'')" style="width:50px; height:30px"> 
                         	</div></div></td>
                        	<td><div class="text-right"><span id="up"><fmt:formatNumber pattern="###,###,###" value="${dto.price}"/></span>원 </div></td>
                           	<td><div class="text-right"><span id="each_price0"><fmt:formatNumber pattern="###,###,###" value="${dto.price*dto.qty}"/></span>원 </div></td>
                          	<td><div class="text-center">
                          		<button type="button" class="btn btn-danger" id="${dto.book_code}" onclick="delCartItem(this, 0)">삭제</button>
                          	</div></td>
                   			<c:set var="total" value="${total + dto.price * dto.qty}"/> 
                         </tr>       		<tr>
                    		<td colspan="6">
                    			<div class="text-center"><span id="msg">수량 수정 완료</span></div>
                    			<div class="text-right">
                    				 총 합계 :<span id="total"><fmt:formatNumber pattern="###,###,###" value="${total}" /></span>원 
                    		 	  		   <input id ="cart_total" type="hidden" value="${total}" name="total" />
                    		 	 </div>
                    	    </td>
                    	</tr>  	
              		 </tbody>
           			 </table>
           		
           			
              </c:if>
           <c:if test="${not empty map}">
              <div align ="center"><strong>
                	<font size="7" face="맑은 고딕" >비회원&nbsp;</font>
                	<font size="7" face="맑은 고딕" color="orange" >장바구니 </font>
                	<font size="7" face="맑은 고딕" >결제</font>
                </strong></div>
                <br>
               	 <c:set var="total" value="${0}" />
               		<table class="ui orange table" >
         			<thead>
         				<tr>
         					<th><div class="text-center">이미지</div></th>
         			 		<th><div class="text-center">상품명</div></th>
    				 		<th>수량</th>
    				 		<th><div class="text-center">단가</div></th>
    				 		<th><div class="text-center">금액</div></th>
    						<th><div class="text-center">삭제</div></th>
  			 	   	    </tr>
  			   		</thead>
  			   		<tbody>
					<c:forEach var="map" items="${map}" varStatus="status">
						 <tr>
                       		<td><div class="text-center">
                       			<a href="view.product?book_code=${map.value.book_code}" title="상품 상세정보 보러가기">
                       				<img width="50" src="${pageContext.request.contextPath}/resources/files/book/${map.value.img_name}">
                       			</a>
                       		</div></td>
                         	<td valign=middle><div class="text-center">
                         	<a href="view.product?book_code=${map.value.book_code}" title="상품 상세정보 보러가기">
                         		${ map.value.bookname}</a></div></td>
                         	<td align="center"><div class="ui form"><div class="field">
							<input type = "text" id="updateQty${status.index}" value="${map.value.qty}" onchange="updateCartItem(${map.value.book_code}, this.value ,${status.index}, 1);"
							 onkeydown="this.value=this.value.replace(/[^0-9]/g,'')" style="width:50px; height:30px"> 
                         	</div></div></td>
                        	<td><div class="text-right"><span id="up${status.index}"><fmt:formatNumber pattern="###,###,###" value="${map.value.price}"/></span>원 </div></td>
                           	<td><div class="text-right"><span id="each_price${status.index}"><fmt:formatNumber pattern="###,###,###" value="${ map.value.price*map.value.qty}"/></span>원 </div></td>
                          	<td><div class="text-center">
                          		<button type="button" class="btn btn-danger" id="${map.value.book_code}" onclick="delCartItem(this, 1)">삭제</button>
                          	</div></td>
                   			<c:set var="total" value="${total + map.value.price * map.value.qty}"/> 
                         </tr>
                     </c:forEach>
                  		<tr>
                    		<td colspan="6">
                    		<div class="text-center"><span id="msg">수량 수정 완료</span></div>
                    			<div class="text-right">
                    				 총 합계 :<span id="total"><fmt:formatNumber pattern="###,###,###" value="${total}" /></span>원 
                    		 	  		   <input id ="cart_total" type="hidden" value="${total}" name="total" />
                    		 	 </div>
                    	    </td>
                    	</tr>  	
              		 </tbody>
           			 </table>
           		
           			
              </c:if>
             
               <!-- 회원 -->
               <c:if test="${not empty cart_list}">
                <div align ="center"><strong>
                	<font size="7" face="맑은 고딕" >${userLoginInfo.id}님</font>
                	<font size="7" face="맑은 고딕" color="orange" >장바구니 </font>
                	<font size="7" face="맑은 고딕" >결제</font>
                </strong></div>
                <br>
                
                <c:set var="total" value="${0}" />
               		<table class="ui orange table">
         			<thead>
         				<tr>
         					<th><div class="text-center">이미지</div></th>
         			 		<th><div class="text-center">상품명</div></th>
    				 		<th>수량</th>
    				 		<th><div class="text-center">단가</div></th>
    				 		<th><div class="text-center">금액</div></th>
    						<th><div class="text-center">삭제</div></th>
  			 	   	    </tr>
  			   		</thead>
  			   		<tbody>
					<c:forEach var="list" items="${cart_list}" varStatus="status">
						 <tr>
                       		<td><div class="text-center">
                       		<a href="view.product?book_code=${list.book_code}" title="상품 상세정보 보러가기">
                       			<img width="50" src="${pageContext.request.contextPath}/resources/files/book/${list.img_name}">
                       		</a>
                       		</div></td>
                         	<td><div class="text-center">
                         		<a href="view.product?book_code=${list.book_code}" title="상품 상세정보 보러가기">
                         		${ list.bookname}</a></div></td>
                         	<td><div class="ui form"><div class="field">
							<input type = "text" id="updateQty${status.index}" value="${list.qty}" onchange="updateCartItem(${list.book_code}, this.value ,${status.index}, 1);"
							 onkeydown="this.value=this.value.replace(/[^0-9]/g,'')" style="width:50px; height:30px">
                         	</div></div></td>				
                        	<td><div class="text-right"><span id="up${status.index}"><fmt:formatNumber pattern="###,###,###" value="${ list.price}" /></span>원 </div></td>
                           	<td><div class="text-right"><span id="each_price${status.index}"><fmt:formatNumber pattern="###,###,###" value="${ list.price*list.qty}" /></span>원 </div></td>
                          	<td><div class="text-center">
                          		<button type="button" class="btn btn-danger" id="${list.book_code}" onclick="delCartItem(this, 1)">삭제</button>
                          	</div></td>
                   			<c:set var="total" value="${total + list.price * list.qty}"/> 
                         </tr>
                     </c:forEach>
                  		<tr>
                    		<td colspan="6">
                    		<div class="text-center"><span id="msg">수량 수정 완료</span></div>
                    			<div class="text-right">
                    				 총 합계 :<span id="total"><fmt:formatNumber pattern="###,###,###" value="${total}" /></span>원 
                    		 	  		   <input id ="cart_total" type="hidden" value="${total}" name="total" />
                    		 	 </div>
                    	    </td>
                    	</tr>  	
              		 </tbody>
           			 </table>
              </c:if>
              </td></tr></table>
</form>
<c:if test="${not empty map || not empty cart_list || not empty dto }">              
<table width="900" align = "center">              
<tr><td> 
	<div class="ui form warning">
      <c:choose>
         <c:when test="${not empty member}">
              		 
              		 <br><br>
              		  <div class="ui warning message">
   				 			  <div class="header"> 회원 주문시 유의사항 </div>
    							<ul class="list">
      							  <li>회원 가입시 입력하신 정보가 자동입력 되어있습니다 !</li>
      							  <li>회원 가입시 입력하신 정보가 배송정보와 다를 시 아래에서 수정해주세요 ! (회원정보는 수정되지 않습니다)  </li>
      							  <li>결제 진행중 웹 브라우저 창을 절대 닫지 마세요 ! </li>
    							</ul>
  		 			 </div>
  	
  		 			 <c:choose>
  		 			 		<c:when test="${not empty dto}">
  		 			 			 <form name="guest"  width="600" action="direct_buy.success" method="post">
  		 			 		</c:when>
  		 			 		
  		 			 		<c:otherwise>
  		 			 			 <form name="guest"  width="600" action="memberPay.success" method="post">	
 						    </c:otherwise>
  		 			
  		 			 </c:choose>
  		 			 
  		 			 
         </c:when>
         <c:otherwise>
    
              		 <br><br>
              		 <div class="ui warning message">
   				 			  <div class="header">비회원 주문시 유의사항 !</div>
    							<ul class="list">
      							  <li>비회원으로 주문하시는 고객께서는 이메일과 비밀번호를 꼭 기억하세요 ! 주문조회시 이를 활용합니다 ^^</li>
      							  <li>결제 진행중 웹 브라우저 창을  절대 닫지 마세요 ! </li>
    							</ul>
  		 			 </div>
  	
  		 			 <c:choose>
  		 			 		<c:when test="${not empty dto}">
  		 			 			 <form name="guest"  width="600" action="direct_buy.success" method="post">
  		 			 		</c:when>
  		 			 		
  		 			 		<c:otherwise>
  		 			 			 <form name="guest"  width="600" action="pay.success" method="post">
 						    </c:otherwise>
  		 			
  		 			 </c:choose>
  		 
         </c:otherwise>
      </c:choose>
               
               <br>
               		  <label>이름</label>
               	 	  <div class="field">
               	 	  
    				 	 <input type="text" name="name" style="width:200px;" placeholder="수령자 입력" value="${member.name}" >
    			  	  </div>
  
    				 <c:choose>
                       <c:when test="${not empty member}">
                       <div class="field">
                       		<label>E-mail</label>
                          <input type="email" name="email"  style="width:400px;"  value="${member.email}">
                        </div>
                       </c:when>
                       <c:otherwise>
                       <label>E-mail</label>
                      	 <div class="field">
   							<input type="email" name="guest_email" style="width:400px;" placeholder="이메일 입력">
 			  		  	 </div>
 			  		   <label>비밀번호 설정</label>
 			  		  	 <div class="field">
 			  		      	<input type="password" name="guest_passwd" style="width:170px;" placeholder="비밀번호 설정" >
 			  		  	 </div>
                       </c:otherwise>
                     </c:choose>
                    
                   		 <label>연락처</label>
                   			<div class="inline fields">
                     	<div class="two wide field">
 			  		   		<input type="text" onkeydown="this.value=this.value.replace(/[^0-9]/g,'')" value="${member.hp1 }"type="text" name="hp1"  size="3" maxlength="3" onkeydown="filterNumber(event);" >
 			  		 	</div>
 			  		 	<div class="two wide field">
 			  		   		<input type="text" onkeydown="this.value=this.value.replace(/[^0-9]/g,'')" value="${member.hp2 }"type="text" name="hp2"  size="3" maxlength="4" onkeydown="filterNumber(event);" >
 			  		 	</div>
 			  		 	<div class="two wide field">
 			  		   		<input type="text" onkeydown="this.value=this.value.replace(/[^0-9]/g,'')" value="${member.hp3 }"type="text" name="hp3"  size="3" maxlength="4" onkeydown="filterNumber(event);" >
 			  		 	</div>
 			  		 		</div>
 			  		 		
 			  		 		<label>우편 번호</label>
 			  		 	<div class="field">	
 			  		 		<input type="text" id="postcode" placeholder="우편번호" size="10" name="zipcode" value="${member.zipcode}" style="width:100px;"> &nbsp; 
 			  		 		<input type="button" onclick="execPostcode()" value="주소 찾기" class="btn btn-success" style="height:40px;" ><br>
 			  		 	</div>
 			  		 		<label>주소</label>
 			  		 	<div class="field">
 			  		 		<input type="text" id="address1" placeholder="주소"  name="addr1" size="40" value="${member.addr1}" style="width:400px;"><br><br>
                       	    <input type="text" id="address2" placeholder="상세주소" name="addr2" size="40" value="${member.addr2}" style="width:400px;">
 			  		 	</div>
 			  		 	
 			  		 		<label>요청사항</label>
  						 <div class="field">
    						<textarea name="message" style="width:400px;"></textarea>
 						 </div>
  					</form>
  					 <c:choose>
              			 <c:when test="${not empty member}">
              			 	<div align="center">
  							 <input type="button" value="회원 주문하기" class="btn btn-primary" onclick="doPayM()">
  							</div>	
 					     </c:when>
              		 	 <c:otherwise>
              		 		 <div align="center">
              		 	 		 <input type="button" value="비회원 주문하기" class="btn btn-primary" onclick="doPay()">
              		 		 </div>	
              		 	 </c:otherwise>
         		    </c:choose>
         		   <br>
         		   <br>
             </div>
             </td></tr></table>
             </c:if>
</body>
</html>