<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.smith.book.LoginManager,com.smith.book.dto.MemberDTO"%>
<% LoginManager loginManager = LoginManager.getInstance();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<title>Book Smith</title>
<script>
   function menus(id) {
       var x = document.getElementById(id);
       if (x.className.indexOf("w3-show") == -1) {
           x.className += " w3-show";
       } else { 
           x.className = x.className.replace(" w3-show", "");
       }
   }
   function cateOpen(){
      var cate = document.getElementById('cate');
      if(cate.style.display=="none"){
         cate.style.display="inline-block";
      }else{
         cate.style.display="none";  
      }
      
   }
</script>
</head>
<body>

<c:set var="isLogin" value="<%=loginManager.isLogin(session.getId()) %>"/>
   <c:choose >
        <c:when test="${isLogin}">
            <%MemberDTO dto = (MemberDTO)session.getAttribute("userLoginInfo");
         String sId = dto.getId();%>
        </c:when>
        <c:otherwise>
           <%session.setAttribute("userLoginInfo",null);%>
        </c:otherwise>
</c:choose>


<div class="w3-container w3-animate-right w3-card-4" style="background-color:#C72FB3;"> 
   <!-- title div -->
   <div class="w3-row w3-section">
         <div class="w3-col m4 w3-center">
            <a href="main.go" class="w3-btn" style="background-color:#C72FB3;">
            <h1>
            <b class="w3-text-white w3-animate-left w3-animate-opacity" >B</b>ook 
            <b class="w3-text-white fa w3-spin">S</b>
            mith
            </h1>
            </a> 
        </div>
         <div class="w3-col m8">
            <hr>
            <button onclick="menus('menus')" class="w3-btn w3-block" style="background-color:#C72FB3; color:white; text-align:right;">MENU▼</button>  
         </div>
     </div>
     
     <!-- 로그인 등등 메뉴바 -->
     <c:if test="${userLoginInfo ne null}">
        <div id="menus"  class="w3-row w3-hide">
         <div class="w3-col m7 w3-center">
           <p>BookSmith</p>
         </div>
         <c:if test="${userLoginInfo.grade eq 5 }">
            <div class="w3-col m1 w3-center w3-border-bottom">
               <a href="login.admin" class="w3-btn" style="width:100%; background-color:#C72FB3; color:white;">관리자페이지</a>
            </div>
         </c:if>
         <div class="w3-col m1 w3-center w3-border-bottom">
            <a href="mypage.mypage" class="w3-btn" style="width:100%; background-color:#C72FB3; color:white;">마이 페이지</a>
         </div>		
         <div class="w3-col m1 w3-center w3-border-bottom">
            <a href="list_cart" class="w3-btn" style="width:100%; background-color:#C72FB3; color:white;">장바구니</a>
         </div>
         <div class="w3-col m1 w3-center w3-border-bottom">
            <a href="list.auction" class="w3-btn" style="width:100%; background-color:#C72FB3; color:white;">경매</a>
         </div>  
         <div class="w3-col m1 w3-center w3-border-bottom">
            <a href="logout.member" class="w3-btn" style="width:100%; background-color:#C72FB3; color:white;">로그아웃</a>
         </div>    
      </div>
        
     </c:if>
     <c:if test="${userLoginInfo eq null}">
     <div id="menus"  class="w3-row w3-hide">
      <div class="w3-col m8 w3-center">
           <p>BookSmith</p>
      </div>
      <div class="w3-col m1 w3-center w3-border-bottom">
            <a href="login.member" class="w3-btn" style="width:100%; background-color:#C72FB3; color:white;">로그인</a>
         </div>
      <div class="w3-col m1 w3-center w3-border-bottom">
         <a href="join.member" class="w3-btn" style="width:100%; background-color:#C72FB3; color:white;">회원가입</a>
      </div>
      <div class="w3-col m1 w3-center w3-border-bottom">
         <a href="list_cart" class="w3-btn" style="width:100%; background-color:#C72FB3; color:white;">장바구니</a>
      </div>
      <div class="w3-col m1 w3-center w3-border-bottom">
         <a href="orderCheck_guest" class="w3-btn" style="width:100%; background-color:#C72FB3; color:white;">주문조회</a>
      </div>       
   </div>
   </c:if>
   
   
   
   <!-- 검색 바 -->
   
     <div class="w3-row">
       

       
       <div class="w3-col m1 w3-center">
          
          <div class="w3-container">
             <c:set var = "oc" value="0"></c:set>
             <button class="w3-text-white w3-btn" style="background-color:#C72FB3;" onclick="javascript:cateOpen('${oc}')" >분류 ▼</button>
             <div id="cate" class="w3-bar-block w3-card-4 w3-text-white" style="position:absolute;display:none; background-color:#C72FB3; z-index:1;">
                <c:forEach var="dto" items="${genreList}">
                   <c:choose>
                     <c:when test="${(dto.g_code mod 1000) eq 0 }">
                        <hr>
                           <button class="w3-large w3-btn" style="background-color:#C72FB3;" onclick="location.href='bookBygenre.search?g_code=${dto.g_code}&&mode=big&&currentPage=1&&orderBy=readcount'" >
                              <b>${dto.name}</b>
                           </button>
                        <br>
                     </c:when>
                     <c:otherwise>
                        <button class="w3-button" style="background-color:#C72FB3;" onclick="location.href='bookBygenre.search?g_code=${dto.g_code}&&mode=small&&currentPage=1&&orderBy=readcount'">
                           ${dto.name}
                        </button>
                     </c:otherwise>
                  </c:choose>         
                </c:forEach>
             </div>
             
          </div>
                    
       </div>
       
       
      <div class="w3-col m1 w3-center">
      <form name="top_search" action="book.search" method="get">
      <input type="hidden" name="currentPage" value="1">
      <input type="hidden" name="orderBy" value="readcount">
      <input type="hidden" name="bali" value="li">
        <!--  <select id="sf" class="w3-select w3-border" name="searchType" style="width:100%; background-color:#C72FB3; color:white;">
         <option class = "selectF" value="bookname">통합검색</option> 
         <option class = "selectF" value="(bo.bookname">책 이름</option>  
         <option class = "selectF" value="(w_name">작가</option>   
         <option class = "selectF" value="(p_name">출판사</option>
         </select> -->
         <select class="w3-select w3-border" name="searchType" style="width:100%; background-color:#C72FB3; color:white;">
         	 <option value="searchAll">통합검색</option>   
         	 <option value="bookname">도서명</option>   
	         <option value="w_name">작가</option>   
	         <option value="p_name">출판사</option>
         </select>
        </div>
        <div class="w3-col m10 w3-center">
         <input class="w3-input w3-border" name="search" type="text" style="width:100%;" value="${search}">
      </div>
      </form>
      
   <script type ="text/javascript">
      var sf = document.getElementById("sf").options;
      for(var i=0;i<sf.length;i++){
         if(sf[i].value=='${searchType}'){
            sf[i].selected="true";
            break;
         }
      }
   </script>
   </div>
</div>
