<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<title>Home</title>

<style type="text/css">
   #recommandImg{
      
      transition: 0.5s all ease;
      -webkit-transition: 0.5s all ease;
      -moz-transition: 0.5s all ease;
      -ms-transition: 0.5s all ease;
      -o-transition: 0.5s all ease;
   }
   
   #recommandImg:hover{
   /* X 축*/
      -ms-transform: rotateX(15deg);
      -webkit-transform: rotateX(15deg);
      transform: rotateY(15deg); 
   
       /* Y 축*/   
      -ms-transform: rotateY(30deg);
      -webkit-transform: rotateY(30deg);
      transform: rotateY(30deg);
     
   }
   
   #recommandImg:hover img{
         border-right-width:15px; 
       border-right-color:white;
       border-right-style:double;
   }
   
    #reco{
    
       border-top-width:15px; 
       border-top-color:white;
       border-top-style:dotted;
    }
    
    #conte{
       text-align: left;
       line-height: 2;
       word-spacing: 10px;
    }
</style>
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
</script>
</head>

<body>
   <jsp:include page="top.jsp"/>

     <div class="w3-container">
      <div class="w3-row w3-section w3-light-grey" id="reco">
            <div class="w3-col m4 w3-center">
               <p></p>
            </div>
            <div class="w3-col m8 w3-center">
               <h3>오늘의 추천 책</h3>
            </div>
            <div class="w3-col m4 w3-center" id="recommandImg">
               <a href="view.product?book_code=${recommand.book_code}">
                     <img width="200" src="${pageContext.request.contextPath}/resources/files/book/${recommand.img_name}"style="box-shadow: 0px -10px 5px grey;" >
                  </a>
            </div>
            <div class="w3-col m8 w3-center">
               <p class="w3-section">
                     <h1><strong>${recommand.bookname}</strong></h1>
                     
                     <p class="w3-leftbar w3-border-black w3-padding-small" id="conte">■ 책소개<br>${recommand.comment }</p>
                    ${recommand.w_name } 지음 | ${recommand.p_name } 출판 | ${fn:substring(dto.pub_date,0,10) } 출간
               </p>
            </div>
      </div>
      <div class="w3-row w3-section w3-light-grey w3-padding">
      	<div class="w3-container w3-animate-right w3-card-4" style="background-color:#C72FB3;">
            <button onclick="javascript:tab_open('best')" class="w3-button w3-hover-purple" style="background-color:#C72FB3;">BEST</button>
            <button onclick="javascript:tab_open('new')" class="w3-button w3-hover-purple" style="background-color:#C72FB3;">신간</button>
            <button onclick="javascript:tab_open('bc')" class="w3-button w3-hover-purple" style="background-color:#C72FB3;">Book Concert</button>
        </div>
        <div id="best" class="tab w3-row w3-section w3-light-grey w3-padding">
        <c:forEach var="dto" items="${bestList}">
            <div class="w3-col m3 w3-center w3-padding" >
                <p id="recommandImg">
                <a href="view.product?book_code=${dto.book_code}" title="상품 상세정보 보러가기">
               		<img  width="190" src="${pageContext.request.contextPath}/resources/files/book/${dto.img_name}"style="box-shadow: 0px -10px 5px grey;" >
                 </a>  
                 	<br>
                </p>
             </div>
        </c:forEach>
        </div> 
        <div id="new" class="tab w3-row w3-section w3-light-grey w3-padding" style="display:none;">
        <c:forEach var="dto" items="${newList}">
            <div class="w3-col m3 w3-center w3-padding" >
                <p id="recommandImg">
                <a href="view.product?book_code=${dto.book_code}" title="상품 상세정보 보러가기">
               		<img  width="190" src="${pageContext.request.contextPath}/resources/files/book/${dto.img_name}"style="box-shadow: 0px -10px 5px grey;" >
                </a>
                   	<br>
                </p>
             </div>
        </c:forEach>
        
        </div> 
        
        <div id="bc" class="tab w3-row w3-section w3-light-grey w3-padding" style="display:none;">
        	<c:choose>
        		<c:when test="${applicationScope.book_concert eq null}">
        			<h1 style="text-align: center;">현 재 진 행 중 인 북 콘 서 트 는 없 습 니 다</h1>
        		</c:when>
        		<c:otherwise>
        			<a href="book_concert" class="w3-button w3-hover-green w3-xxxlarge">${applicationScope.book_concert.BCname}</a><br>
        			<label>날짜</label>
        			${applicationScope.book_concert.BCdate} | ${applicationScope.book_concert.BCtime}
        		</c:otherwise>
        	</c:choose>
        </div> 
      </div>
      
   </div>
 <!--   <a href = "login.admin"><h1>관리자 로그인</h1></a>
   <a href = "main.admin"><h1>관리자 메인</h1></a>
   <a href="listBig.go?g_code=1000"><h1>대분류 리스트</h1></a>
   <a href="list.auction"><h1>경매 리스트</h1></a>
   <a href="test.tessss"><h1>pub</h1></a>
   <a href="book_concert"><h1>북콘서트</h1></a>
   <a href="pay_success"><h1>결제 성공페이지</h1></a> -->
   		
   ${msg}
   ${userLoginInfo.id}
   
</body>
</html>