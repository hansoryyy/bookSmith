<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="top.jsp" %>
<h1>최근 가입 회원 리스트</h1><hr>
<table id="customers">
   <tr>
      <th>회원번호</th>
      <th width="50%">이름</th>
      <th>아이디</th>
      <th>가입날짜</th>
   </tr>
   <c:if  test="${m_list==null || m_list.size()==0 }">
      <td colspan="4">등록된 회원이 없습니다.</td>
   </c:if>
   <c:forEach var="dto" items="${m_list }">
      <tr align="center">
         <td>${dto.member_code }</td>
         <td>
            <b><a href="updateMember.admin?member_code=${dto.member_code }">${dto.name }</a></b>
         </td>
         <td>${dto.id }</td>
         <td>
            <fmt:formatDate value="${dto.joindate}" pattern="yyyy-MM-dd"/>
         </td>
      </tr>
   </c:forEach>
</table>
<div align="center">                          
   <input type="button" onclick="window.location='managerList.admin'" class="button" value="전체 보기">
</div>
<hr>
<h1>최신 리뷰 리스트</h1><hr>
<table id="customers">
   <tr>
      <th>번호</th>
      <th width="60%">내용</th>
      <th>작성자</th>
      <th>작성일</th>
      <th>조회수</th>
   </tr>
   <c:if  test="${empty c_list}">
      <td colspan="5">등록된 글이 없습니다.</td>
   </c:if>
   <c:forEach var="dto" items="${c_list}">
      <tr align="center">
         <td>${dto.board_code}</td>
            <td align="left"><b><a href="list.review">${dto.content}</a></b>
         </td>
         <td>${dto.writer}</td>
         <td>
            <fmt:formatDate value="${dto.reg_date}" pattern="yyyy-MM-dd"/>
         </td>
         <td>${dto.readcount}</td>
      </tr>
   </c:forEach>
</table>
<div align="center">
   <input type="button" onclick="window.location='list.review'" class="button" value="전체 보기">
</div>
<%@ include file="bottom.jsp" %>