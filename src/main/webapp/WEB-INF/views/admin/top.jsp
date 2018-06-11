<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="com.smith.book.LoginManager,com.smith.book.dto.LoginDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%	LoginManager loginManager = LoginManager.getInstance();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
   <title>SmithBook | 관리자</title>
   <%-- <c:if test="${sessionScope.grade eq null ||  sessionScope.grade < 4 }"><!-- 쇼핑몰 홈페이지로 -->
      <script type="text/javascript">
         alert("잘못된 접근입니다.");
         location.replace("${pageContext.request.contextPath}/login.admin");    
      </script>      
   </c:if> --%>
   <c:if test="${grade < 5 || log == null}">
   <script>
      alert("잘못된 접근입니다.");
      location.replace('login.admin')
   </script>
</c:if>
</head>
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adm/style.css"/>

   <body>
   grade : [${sessionScope.grade }],
   	현재접속자수: <%=loginManager.getUserCount() %>
      <div id="container">
         <div id="nav"> <!-- 네비게이션 -->
            <ul>
                 <li><a class="active" href="main.admin">Administrator</a></li>
                 <c:choose>
                 <c:when test="${log!=null }"> <!-- 로그인 한사람의 아이디 -->
                    <li style="float:right"><a href="logout.member">로그아웃</a></li>
                 </c:when>
                 <c:otherwise>
                    <li style="float:right"><a href="login.admin">로그인</a></li>
                 </c:otherwise>
                 </c:choose>
                 <li style="float:right"><a href="main.go">쇼핑몰</a></li>
            </ul>
         </div>
         
      <div id="left-sidebar"> <!-- 사이드 메뉴 -->
         <div class="accordion vertical">
          <ul>
              <li>
                  <input type="radio" id="radio-1" name="radio-accordion" />
                  <label for="radio-1">회원 관리</label>
                  <div class="content">
                      <a href="managerList.admin">회원 관리</a>
                         <a href="mailList.admin">이메일 발송</a>
                  </div>
              </li>
              <li>
                  <input type="radio" id="radio-2" name="radio-accordion" />
                  <label for="radio-2">게시판 관리</label>
                  <div class="content">
                      <a href="list.notice">공지사항</a>
                      <a href="list.review">리뷰 게시판</a>
                      <a href="list.qna">1:1문의</a>                      
                  </div>
                 </li>
                 <li>
                  <input type="radio" id="radio-3" name="radio-accordion" />
                    <label for="radio-3">도서 관리</label>
                  <div class="content">
                     <a href="list.adGenre">장르 관리</a> 
                        <a href="list.adBook">책 관리</a>
                      <a href="list.adPublisher">출판사 관리</a>
                      <a href="list.adWriter?g_code='0'">작가 관리</a>                      
                  </div>
                 </li>
                 
                  <li>
                  <input type="radio" id="radio-4" name="radio-accordion" />
                  <label for="radio-4">쇼핑몰 현황</label>
                  <div class="content">
                  		<a href="orderList.admin">주문내역</a>
                      	<a href="saleList.admin">매출현황</a> 
                        <a href="itemSellRank.admin">상품판매순위</a>
                  </div>
              	 </li>
              	
              	
              	<li>
                  <input type="radio" id="radio-5" name="radio-accordion" />
                    <label for="radio-5">경매 관리</label>
                  <div class="content">
                     <a href="readyList.auction">경매 신청서</a> 
                        <a href="finish.auction">경매 시간 경과</a>
                      <a href="closeList.auction">경매 마감 목록</a>                      
                  </div>
                </li> 
                
                
              	<li>
                  <input type="radio" id="radio-6" name="radio-accordion" />
                    <label for="radio-6">북콘서트 관리</label>
                  <div class="content">
                     <a href="admin.bookConcert">북콘서트 등록</a>  
                                
                  </div>
                </li>
          </ul>
         </div>
      </div>
      
      <div id="contents"> <!-- 메인 내용 -->