<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file = "../top.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>도 서 등 록</title>
</head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script type="text/javascript">
    var wOpenWin;
    function writerCallBack()
     {
         window.name = "parentWForm";
         wOpenWin = window.open("writerCallBack.adWriter?w_name="+ encodeURIComponent (document.getElementById("wInput").value),
                 "childWForm", "width=800, height=500, resizable = no, scrollbars = yes");
     }
    var pOpenWin;
    function publisherCallBack()
     {
         window.name = "parentPForm";
         pOpenWin = window.open("publisherCallBack.adPublisher?p_name="+  encodeURIComponent(document.getElementById("pInput").value),
                 "childPForm", "width=800, height=500, resizable = no, scrollbars = yes");
     }
</script>
<script type="text/javascript">
         function selectGenre() {
      $.ajax({
         type: "POST",
         url: "selectGenre.adGenre",
         data: {"bg_code" : $('#bg_code').val()} , 
         success: function(data){
            console.log(data.s_glist);
            var results = data.s_glist;
            var g_code;
            var name;
            var str;
            $("#s_glist").empty();
            $.each(results , function(i){
               g_code = results[i].g_code;
               name = results[i].name;
               str += '<option value='+g_code+'>' +g_code+'::'+name+'</option>';
            })
            $("#s_glist").append(str);
         },
         error : function(){
            alert("error");
         }
      });
   }
</script>
<style>
input[type=text], select {
    width: 25%;
    padding: 6px 10px;
    margin: 8px 0;
    box-sizing: border-box;
    border: 2px solid #ccc;
    -webkit-transition: 0.5s;
    transition: 0.5s;
    outline: none;
}
</style>
<body>
<div align="center" class="bookInsert">
<h1>도서 등록</h1>
<hr>
<form name="bookInsert" action="insert.adBook" method="post" enctype="multipart/form-data">
   <table id="customers">
      <tr>
         <th width="20%">장르</th>
         <td>
            <select name="bg_code" id="bg_code">
               <c:forEach var="glist" items="${glist}">                     
               <c:if test="${glist.g_code % 1000 == 0}">
                <option id="bg_code" value="${glist.g_code }">${glist.g_code } :: ${glist.name }</option>
               </c:if>   
               </c:forEach>
            </select>
            <input type="button" class="button button7" onclick="selectGenre();" value="선택">&nbsp;&nbsp;                        
            <select name="g_code" id="s_glist">               
            </select>
         </td>
      </tr>      
      <tr>
      <th>책이름</th>
         <td>
            <input type="text" name="bookname" class="form-control">
         </td>
      </tr>
      <tr>
         <th>작가</th>
         <td>
            <input type="text" name="wInput" id="wInput" placeholder="작가">
            <input type="button" onclick="writerCallBack()" class="button button7" value="검색"> <br>
               이름 : <input type="text" name="w_name" id="wInput_w_name"><br>
            코드 : <input type="text" name="w_code"id="wInput_w_code">
         </td>
      </tr>
      <tr>
         <th>가격</th>
         <td>
            <input type="text" name="price">
         </td>
      </tr>
      <tr>
         <th>출판사</th>
         <td>
            <input type="text" name="pInput" id="pInput" placeholder="출판사">
            <input type="button" onclick="publisherCallBack()" class="button button7" value="검색"><br>
               이름 : <input type="text" name="p_name" id="pInput_p_name"><br>
            코드 : <input type="text" name="p_code"id="pInput_p_code">
         </td>
      </tr>
      <tr>
         <th>책소개</th>
         <td>
            <input type="text" name="comment">
         </td>
      </tr>
      <tr>
         <th>책 이미지</th>
         <td>
            <input type="file" name="img">
         </td>
      </tr>
      <tr>
         <th>출판일</th>
         <td>
            <input type="text" name="pub_date">
         </td>
      </tr>
      <tr>
         <th>책 고유번호</th>   <!-- IBSN : 책 고유번호 -->
         <td>
            <input type="text" name="IBSN">
         </td>
      </tr>
      <tr>
         <th>수량</th>
         <td>
            <input type="text" name="qty">
         </td>
      </tr>
      <tr>
         <td colspan="2" align="center">
            <input type="submit" class="button" value="등록">
            <input type="reset" class="button button1" onclick="location.href='list.adBook'" value="취소">
         </td>
      </tr>
   
   </table>
   </form>

</div>
</body>
</html>
<%@ include file="../bottom.jsp" %>