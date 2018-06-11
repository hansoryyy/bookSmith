<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script type="text/javascript">
var ctxpath = '${pageContext.request.contextPath}';
/*
 * @param book_code Book
 */

function add_cart(book_code) {
   var qty = 1;
   $.ajax({
         method : 'GET',
         url : ctxpath + '/insert_cart',
         data : {
               book_code : book_code,
               qty : qty
               },
        success : function(res) {
            console.log('res 값 :' + res.success);
         if(res.success == 'true'){
            var goCart = confirm("선택한 상품이 장바구니에 담겼습니다.\n장바구니로 이동 하시겠습니까?");
            if (goCart) {
                     location.href = 'list_cart';
               }else{
                  history.go(0);
               }
            
              }
            },
      }); 
   }
   
   function purchase(book_code) {
       
    
    // location.href='buy_direct?book_code='+book_code+'&qty='+realQty;
    
    $.ajax({
        method : 'GET',
        url : ctxpath + '/add_direct_cart',
        data : {
           book_code : book_code,
           qty : 1
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

<script>
  function getBook(){
      
      document.viewProduct.submit();
   }
   function listDesign(){
      var list = document.getElementsClassName("listDes");
      alert(list);
   }
   function getHtmlText(){
      var seasame = document.getElementById("sameSearch");
      alert("test:"+seasame.getAlign());
   }
</script>
<c:set var="quo" value="${searchList.size()}"/>
<fmt:parseNumber var="quodiv" integerOnly="true" value="${quo div 5}"/>
<fmt:parseNumber var="gi"  integerOnly="true" value="${(currentPage-1) div 5}"/>
<c:set var="stand" value="${(currentPage-1) mod 5}"/>
<c:set var="cnt" value="3"/>
<c:if test="${(quodiv eq stand) and (quo ne 21) and ((quo mod 4) ne 0)}">
   <c:set var="cnt" value="${(quo mod 4)-1}"/>
</c:if>
</head>
<body>

   <jsp:include page="../top.jsp"/>
  
   <c:choose>
   <c:when test="${quo eq 0 }">
      <div class="w3-container">
         <div class="w3-row w3-section">
            <div class="w3-col m12 w3-center">
               등록된 상품이 없습니다.
            </div>
         </div>
      </div>
   </c:when>
   
   <c:otherwise>
   <div class="w3-container " >
      <!-- 상단 부분//정렬 보기 정리 -->
      <div class="w3-row w3-section">
         <div class="w3-col m2 w3-center" style="background-color: #C74696;">
            <button onclick="location.href='${value_rm}?search=${search}&&searchType=${searchType}&&currentPage=${1}&&g_code=${g_code}&&mode=${mode}&&orderBy=${orderBy}&&bali=li'" class="w3-btn" style=" color:white;">▤</button>
            <button onclick="location.href='${value_rm}?search=${search}&&searchType=${searchType}&&currentPage=${1}&&g_code=${g_code}&&mode=${mode}&&orderBy=${orderBy}&&bali=ba'" class="w3-btn" style=" color:white;">▦</button>
          
           
         </div>
         
         <div class="w3-col m10 w3-center" style="background-color: #C74696;">
                <button onclick ="location.href='${value_rm}?search=${search}&&searchType=${searchType}&&currentPage=${1}&&g_code=${g_code}&&mode=${mode}&&orderBy=saleCount desc&&bali=${bali}'" class="w3-btn w3-border-right w3-text-white" >판매량 순</button>
                <button onclick ="location.href='${value_rm}?search=${search}&&searchType=${searchType}&&currentPage=${1}&&g_code=${g_code}&&mode=${mode}&&orderBy=price desc&&bali=${bali}'" class="w3-btn w3-border-right w3-text-white" >높은 가격 순</button>
               <button onclick ="location.href='${value_rm}?search=${search}&&searchType=${searchType}&&currentPage=${1}&&g_code=${g_code}&&mode=${mode}&&orderBy=price asc&&bali=${bali}'" class="w3-btn w3-border-right w3-text-white" >낮은 가격 순</button>
               <button onclick ="location.href='${value_rm}?search=${search}&&searchType=${searchType}&&currentPage=${1}&&g_code=${g_code}&&mode=${mode}&&orderBy=pub_date desc&&bali=${bali}'" class="w3-btn w3-text-white">최신 순</button>
         </div>
      </div>
      <div class="w3-row w3-section">
         <c:choose>
            <c:when test="${bali eq 'li'}">
               <form action="view.product" method="get" name="viewProduct">
               <c:set var="endPoint" value="${quo-1}"/>
               <c:if test="${quo > 20}">
                  <c:set var="endPoint" value="19"/>
               </c:if>
              <c:forEach var="j" begin="0" end="${endPoint}" step="1">
              <div class="w3-row">
                  <input type="hidden" value="${searchList.get(j).book_code}" name="book_code">
                     <div class="w3-col m1 w3-center">
                        <p>
                            
                        </p>
                     </div>             
                     
                  <div class="w3-margin-top w3-col m9 w3-center w3-border w3-round-xxlarge" >
                     <p id="sameSearch" style="text-align: left;" >
                      &nbsp; <img class="images" src="${pageContext.request.contextPath}/resources/files/book/${searchList.get(j).img_name}" width="4%">
                        &nbsp;|&nbsp;
                        <a href="view.product?book_code=${searchList.get(j).book_code}" class="w3-btn">
                        <c:choose>
                           <c:when test = "${fn:contains(searchList.get(j).bookname, search)}">
                               <b class="w3-xlarge">${fn:substringBefore(searchList.get(j).bookname,search)}<label style="background-color:yellow;">${search}</label>${fn:substringAfter(searchList.get(j).bookname,search)}</b>
                           </c:when>
                           
                           <c:otherwise>
                              <b class="w3-xlarge">${searchList.get(j).bookname}</b>
                           </c:otherwise>
                     </c:choose>
                     <c:choose>
                           <c:when test = "${fn:contains(searchList.get(j).w_name, search)}">
                               ${fn:substringBefore(searchList.get(j).w_name,search)}<label style="background-color:yellow;">${search}</label>${fn:substringAfter(searchList.get(j).w_name,search)}
                           </c:when>
                           <c:otherwise>
                              ${searchList.get(j).w_name}
                           </c:otherwise>
                     </c:choose>|
                     <c:choose>
                     <c:when test = "${fn:contains(searchList.get(j).p_name, search)}">
                         ${fn:substringBefore(searchList.get(j).p_name,search)}<label style="background-color:yellow;">${search}</label>${fn:substringAfter(searchList.get(j).p_name,search)}
                     </c:when>
                     <c:otherwise>
                        ${searchList.get(j).p_name}
                     </c:otherwise>
               </c:choose>|
               가격: <fmt:formatNumber value="${searchList.get(j).price}" type="currency" currencySymbol=""/> 원 </a>
               
                        <br>
                     </p>
                  </div>
                  
                  <div class="w3-col m2 w3-center">
                        
                        	<br>
                          <c:choose>
                         <c:when test="${searchList.get(j).qty ==0}">
                            <!-- <label style="color: red">재고가 없습니다 ...관리자에게 문의 주세요 ! </label> -->
                             <button onclick="add_cart('${dto.book_code}')" class="w3-btn w3-text-white w3-round-xxlarge" disabled="disabled" style="width:60%; background-color:#C72FB3;">장바구니 담기</button><br><br>
                             <button onclick="purchase('${dto.book_code}')" class="w3-btn w3-text-white w3-round-xxlarge" disabled="disabled" style="width:60%; background-color:#C72FB3;">바로구매</button>  
                            
                         </c:when>
                         
                          <c:otherwise>
                             <button onclick="javascript:add_cart('${searchList.get(j).book_code}')" class="w3-btn w3-text-white w3-round-large" style="width:50%; background-color:FF8C0A;">장바구니 담기</button><br><br>
                            <button onclick="javascript:purchase('${searchList.get(j).book_code}')" class="w3-btn w3-text-white w3-round-large" style="width:50%; background-color:CD1039;">바로구매</button>
                        </c:otherwise> 
                        </c:choose>
                        
                     </div>
               
               </div>
               <br>
             
               </c:forEach>
               </form>
            </c:when>
            
            <c:otherwise>
            <form action="view.product" method="get" name="viewProduct">
              <c:forEach var="j" begin="${stand * 4}" end="${(stand * 4)+cnt}" step="1">
                  <input type="hidden" value="${searchList.get(j).book_code}" name="book_code">
                  
                  <div class="w3-col m1 w3-center">
                     <p></p>
                  </div>
                  <div class="w3-col m2 w3-center">
                     <a href="view.product?book_code=${searchList.get(j).book_code}"><img class="images" src="${pageContext.request.contextPath}/resources/files/book/${searchList.get(j).img_name}" style="width:200px"></a><br>
                     <c:choose>
                     <c:when test = "${fn:contains(searchList.get(j).bookname, search)}">
                         <b>${fn:substringBefore(searchList.get(j).bookname,search)}<label style="background-color:yellow;">${search}</label>${fn:substringAfter(searchList.get(j).bookname,search)}</b>
                     </c:when>
                     <c:otherwise>
                        ${searchList.get(j).bookname}
                     </c:otherwise>
               </c:choose><br>
               <c:choose>
                     <c:when test = "${fn:contains(searchList.get(j).w_name, search)}">
                         ${fn:substringBefore(searchList.get(j).w_name,search)}<label style="background-color:yellow;">${search}</label>${fn:substringAfter(searchList.get(j).w_name,search)}
                     </c:when>
                     <c:otherwise>
                        ${searchList.get(j).w_name}
                     </c:otherwise>
               </c:choose>|
               <c:choose>
                     <c:when test = "${fn:contains(searchList.get(j).p_name, search)}">
                         ${fn:substringBefore(searchList.get(j).p_name,search)}<label style="background-color:yellow;">${search}</label>${fn:substringAfter(searchList.get(j).p_name,search)}
                     </c:when>
                     <c:otherwise>
                        ${searchList.get(j).p_name}
                     </c:otherwise>
               </c:choose><br>
               가격: <fmt:formatNumber value="${searchList.get(j).price}" type="currency" currencySymbol=""/> 원<br>
         
                  </div>
               </c:forEach>
               </form>
               
            </c:otherwise>
         </c:choose>
      </div>
      <div class="w3-row w3-section w3-center">
         
         <div class="w3-bar w3-border w3-round ">
           <c:choose> 
            <c:when test="${bali eq 'li'}">
            
               <c:if test="${currentPage ne 1}">
                     <a href="${value_rm}?search=${search}&&searchType=${searchType}&&currentPage=${currentPage-5}&&g_code=${g_code}&&mode=${mode}&&orderBy=${orderBy}&&bali=${bali}" class="w3-button">|◀</a>
               </c:if>
               
               <c:if test="${(quo > 20)}">
                  <a href="${value_rm}?search=${search}&&searchType=${searchType}&&currentPage=${currentPage+5}&&g_code=${g_code}&&mode=${mode}&&orderBy=${orderBy}&&bali=${bali}" class="w3-button">▶|</a>
               </c:if>
            
            </c:when>
            
            
            <c:otherwise>
            
               <c:if test="${currentPage ne 1}">
                     <a href="${value_rm}?search=${search}&&searchType=${searchType}&&currentPage=${currentPage-1}&&g_code=${g_code}&&mode=${mode}&&orderBy=${orderBy}&&bali=${bali}" class="w3-button">|◀</a>
               </c:if>
            
               <c:forEach begin="${gi*5}" end="${gi*5+quodiv}" var="i" step="1">
                    <c:choose>
                     <c:when test="${i+1 eq currentPage}">
                        <a href="${value_rm}?search=${search}&&searchType=${searchType}&&currentPage=${i+1}&&g_code=${g_code}&&mode=${mode}&&orderBy=${orderBy}&&bali=${bali}" class="w3-button w3-red">${i+1}</a>      
                     </c:when>
                  
                     <c:otherwise>
                        <a href="${value_rm}?search=${search}&&searchType=${searchType}&&currentPage=${i+1}&&g_code=${g_code}&&mode=${mode}&&orderBy=${orderBy}&&bali=${bali}" class="w3-button">${i+1}</a>
                     </c:otherwise>                  
                     </c:choose>
               </c:forEach>
               <c:if test="${(quo > 20)}">
                  <a href="${value_rm}?search=${search}&&searchType=${searchType}&&currentPage=${currentPage+1}&&g_code=${g_code}&&mode=${mode}&&orderBy=${orderBy}&&bali=${bali}" class="w3-button">▶|</a>
               </c:if>
            
            
            </c:otherwise>
           </c:choose>               
         </div>
      </div>
   </div>   
   </c:otherwise>
</c:choose>
</body>
</html>