<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file = "../top.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function pubByteCheckTextarea(oid, tid, maxlength){
       var isKorean = $(oid).val();
       var strlength = 0;       

       for(var i = 0; i < isKorean.length; i++){
           if(escape(isKorean.charAt(i)).length == 6){
               strlength++;
           }
           strlength++;
        }

       if(parseInt(maxlength-strlength) <= 0){
         alert(maxlength +"자 까지 입력 할 수 있습니다.");
         return false;
       }else{
           $(tid).html( strlength +"/"+ maxlength);
       }       
    };   
</script>
<body>
<br>
<c:set var="upPath" value="${upPath}"/>
   <h3>${getBoard.subject}</h3>
   <hr>
   <table id="customers">
<c:if test="${empty getBoard}">
      <tr>
         <td colspan="6">등록된 글이 없습니다.</td>
      </tr>
</c:if> 	  
      <tr>
         <th width="20%">글번호</th>
         <td>${getBoard.notice_code}</td>
         <th width="20%">조회수</th>
         <td>${getBoard.readcount}</td>
      </tr>
      <tr>
         <th width="20%">작성자</th>
         <td>${getBoard.writer}</td>         
         <th width="20%">작성일</th>
         <td>
         <fmt:formatDate value="${getBoard.reg_date}" pattern="MM-dd HH:mm"/>
         </td>
      </tr>      
      <tr>
         <th width="20%">글내용</th>
         <td colspan="3"><textarea cols="100%" rows="24" readonly="readonly">${getBoard.content}</textarea></td>
      </tr>
   <c:if test="${not empty getBoard.filename}">
      <tr>
         <th width="20%">파일</th>
         <td colspan="3"><a href="${upPath}/${getBoard.filename}">${getBoard.filename}</a></td>
      </tr>
   </c:if>
   </table>
   <br>
<input type="button" class="button" onclick="location.href='update.board?notice_code=${getBoard.notice_code}'" value="글수정">
<input type="button" class="button button3" onclick="location.href='delete.board?notice_code=${getBoard.notice_code}'" value="글삭제">
<input type="button" class="button button1" onclick="window.location='list.board'" value="글목록">
</body>
</html>
<%@ include file="../bottom.jsp" %>