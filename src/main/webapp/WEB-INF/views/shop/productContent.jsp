<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<jsp:include page="/WEB-INF/views/common/common-head.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
   function clear(){
      var tabs = document.getElementsByClassName('tab');
      
      for(var i=0;i<tabs.length;i++){
         tabs[i].style.display="none";
      }
   }
   
   function tab_open(idv){
      clear();
      var w_info = document.getElementById(idv);
      w_info.style.display="block";
   }
   function reviewWrite(){
      var cate = document.getElementById("rev");
      if(cate.style.display=="none"){
         cate.style.display="inline-block";
      }else{
         cate.style.display="none";  
      }
   }
</script>
<script>
   var ctxpath = '${pageContext.request.contextPath}';
   /*
    * @param book_code Book
    */
   
   function add_cart(book_code) {
      var realQty = document.qty.realQty.value;
      $.ajax({
         method : 'GET',
         url : ctxpath + '/insert_cart',
         data : {
            book_code : book_code,
            qty : realQty
         },
         success : function(res) {
            console.log('res 값 :' + res.success);
            if(res.success == 'true'){
               var goCart = confirm("선택한 상품이 장바구니에 담겼습니다.\n장바구니로 이동 하시겠습니까?");
               if (goCart) {
                  location.href = 'list_cart';
              }
         }
      },
   });

}

</script>
<script>
   var ctxpath = '${pageContext.request.contextPath}';
   function purchase(book_code) {
      var realQty = document.qty.realQty.value;"src/main/webapp/resources/css/style_0503.css"
      
      // location.href='buy_direct?book_code='+book_code+'&qty='+realQty;
      
      $.ajax({
          method : 'GET',
          url : ctxpath + '/add_direct_cart',
          data : {
             book_code : book_code,
             qty : realQty
          },
          success : function(res) {
             console.log('res 값 :' + res.success);
             if(res.success){
                
                //location.href=ctxpath+'/buy_direct';
                location.href = res.nextUrl;
             }
          }
      });
   }
</script>
</head>
<body>
<jsp:include page="../top.jsp"/>
<BR><BR>
<div class="w3-container"> 

   <div class="w3-row w3-section">
      <div class="w3-col m2 w3-center">
         <img width="200" src="${pageContext.request.contextPath}/resources/files/book/${dto.img_name}">
      </div>
      <div class="w3-col m5 w3-left">
           <p class="w3-section">
            <h1><strong>${dto.bookname}</strong></h1>
               ${dto.w_name } 지음 | ${dto.p_name } 출판 | ${fn:substring(dto.pub_date,0,10) } 출간 
           </p>
          <c:choose>
          	<c:when test="${dto.avg_rate ==0}"> 
          		<strong><font size="3" color="green">&nbsp;※ 평점이 아직 없습니다... 리뷰를 남겨주세요 !</font></strong>
          	</c:when>
          	<c:otherwise>
          		<c:set var="img" value="star${dto.avg_rate}.0.png"/><img alt="" src="${pageContext.request.contextPath}/resources/files/book/${img}"/>
          		&nbsp;<strong><font size="4">평점 : ${dto.avg_rate} 점</font></strong>
          	</c:otherwise>
          </c:choose>
 
           <hr>
           <p class="w3-section">
              판매가 : <fmt:formatNumber value="${dto.price }" type="currency" currencySymbol=""/> 원
           </p>
           <hr>
           <p class="w3-section">
          
              <label for="proForm_qty">주문수량</label>
              <form name = "qty">
                 <input type="text" name ="realQty" value="1" maxlength="3" style="width:40px; height:30px">
              </form>
           
            <c:if test="${dto.qty ==0}">
              <label style="color: red">재고가 없습니다 ...관리자에게 문의 주세요 ! </label>
            </c:if>
              <!-- <span>
                 <button>
                    <img src="http://image.kyobobook.co.kr/ink/images/common/btn_plus.gif" alt="수량 더하기" />
                     </button>
                     <button>
                        <img src="http://image.kyobobook.co.kr/ink/images/common/btn_minus.gif" alt="수량 빼기" />
                     </button>
              </span> -->
              
           </p>
         
            <p class="w3-section"> 
             <c:choose>
             	<c:when test="${dto.qty ==0}">
       			
               	 	<button onclick="add_cart('${dto.book_code}')" class="w3-btn w3-text-white" disabled="disabled" style="background-color:#C72FB3;">장바구니 담기</button>
              		<button onclick="purchase('${dto.book_code}')" class="w3-btn w3-text-white" disabled="disabled" style="background-color:#C72FB3;">바로구매</button>
             	</c:when>
            	 <c:otherwise> 
             	 	<button onclick="add_cart('${dto.book_code}')" class="w3-btn w3-text-white" style="background-color:#C72FB3;">장바구니 담기</button>
             	 	<button onclick="purchase('${dto.book_code}')" class="w3-btn w3-text-white" style="background-color:#C72FB3;">바로구매</button>
            	 </c:otherwise>
             </c:choose>	 
               <c:if test="${userLoginInfo ne null}">
                  <button onclick="javascript:reviewWrite()" class="w3-btn w3-text-white" style="background-color:#C72FB3;">리뷰작성</button>
               </c:if>
            </p>
            
              <form name="form" class="w3-container w3-card-4 w3-section w3-light-grey" id="rev"  action="write.shopBoard" method="post" enctype="multipart/form-data"  style="display:none;">
                 <input type="hidden" name="book_code" value="${dto.book_code}">
                 <input type="hidden" name="writer" value="${userLoginInfo.id}">
                 <label>제목</label>
                 <input type="text" name="subject" class="w3-input" style="height:25px">
                 <br>
                 <label>평점</label>
                 <select name="rate">
                  <option value="0">0</option>
                  <option value="0.5">0.5</option>
                  <option value="1">1</option>
                  <option value="1.5">1.5</option>
                  <option value="2">2</option>
                  <option value="2.5">2.5</option>
                  <option value="3">3</option>
                  <option value="3.5">3.5</option>
                  <option value="4">4</option>
                  <option value="4.5">4.5</option>
                  <option value="5">5</option>
              	 </select>	
                 <br><br>
                 <label>작성자</label>
                 &nbsp;${userLoginInfo.id}<br>
                 <br>
                 
                 <jsp:include page="editer.jsp"/>
                 
                 <input type="reset" class="w3-btn w3-border-top" value="다시 쓰기">
            </form>
            
         </div>
      <div class="w3-col m5 w3-left">
         <div class="w3-container w3-animate-right w3-card-4" style="background-color:#C72FB3;">
            <button onclick="javascript:tab_open('w_info')" class="w3-btn w3-purple">저자 소개</button>
            <button onclick="javascript:tab_open('b_info')" class="w3-btn w3-purple">책 소개</button>
            <button onclick="javascript:tab_open('review')" class="w3-btn w3-purple">Review Board (총 ${dto.review_count}건) </button>
            <button onclick="" class="w3-btn w3-purple">etc</button> 
         </div>
         <div class="tab" id="w_info" style="display:none;">
            ${dto.w_introduction }
         </div>
         <div class="tab" id="b_info" style="display:none;">
            ${dto.comment }
         </div>
         <div class="tab" id="review" style="height:50%; display:none;  overflow-x: hidden; overflow-y: scroll;">
     	  <c:forEach var="dto" items="${reviewList}">
               <hr>
                    <div style="float:left;"><c:set var="img" value="star${dto.rate }.png"/> <img alt="" src="${pageContext.request.contextPath}/resources/files/book/${img}"/></div>
                    <div style="float:right;">${dto.writer}</div><br><br>
                    <div style="float:left;"><b>${dto.subject}</b></div>
                    <div style="float:right;">${fn:substring(dto.reg_date,0,16)}</div><br>
                      <pre >${dto.content}</pre>
               <hr>
            </c:forEach>
            <c:if test="${reviewList.size() > 5}">
            <button class ="w3-button w3-center">more reviews..</button>
            </c:if>
         </div>
      </div>
   </div>
   
</div>



</body>
</html>