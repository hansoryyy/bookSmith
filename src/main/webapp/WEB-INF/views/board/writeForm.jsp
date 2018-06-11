<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file = "../top.jsp"%>
<style>
table.type {
    border-collapse: separate;
    border-spacing: 1px;
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    margin: 20px 10px;
}
table.type th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #efefef;
}
table.type .even {
    background: #efefef;
}
table.type td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
}
</style>
<html>
<head>
<title>글쓰기</title>
<script type="text/javascript">
    var openWin;
    function bookCallBack()
     {
         window.name = "parentWForm";
         openWin = window.open("bookCallBack.shopBoard?bookname="+ encodeURIComponent (document.getElementById("bookname").value),
                 "childWForm", "width=800, height=500, resizable = no, scrollbars = no");  
     }
</script>
<script type="text/javascript">
   function check(){
      if (f.writer.value==""){
         alert("이름을 입력해 주세요!!")
         f.writer.focus()
         return false
      }   
      if (f.subject.value==""){
         alert("제목을 입력해 주세요!!")
         f.subject.focus()
         return false
      }
      if (f.content.value==""){
         alert("내용을 입력해 주세요!!")
         f.content.focus()
         return false
      }
      return true
   }
</script>
</head>
<body>
<div align="center">
<form name="f" action="write.shopBoard" method="post" enctype="multipart/form-data">   
   <table width="800" class="type">
      <tr>
         <th bgcolor="skyblue" width="20%">아이디</th>
         <td><input type="hidden" name="writer" value="${userLoginInfo.id }">${userLoginInfo.id }</td>
      </tr>
      <tr>
      	 <th bgcolor="skyblue" width="20%">책 찾기</th>
         <td><input type="text" id="bookname" name="bookname"><input type="button" onclick="bookCallBack()" name="book_code" value="책 검색"readOnly><br>
         <input type="text" id="book_code" name="book_code" size="3"></td>
      </tr>
      <tr>
         <th bgcolor="skyblue" width="20%">평 점</th>
         <td><input type="text" name="rate"></td>
      </tr>
      <tr>
         <th bgcolor="skyblue" width="20%">제 목</th>
         <td><input type="text" name="subject"></td>
      </tr>
      <tr>
         <th bgcolor="skyblue" width="20%">내 용</th>
         <td><textarea rows="12" cols="50" name="content"></textarea></td>
      </tr>
      <tr>
         <th bgcolor="skyblue" width="20%">파 일</th>
         <td><input type="file" name="filename"></td>
      </tr>
   </table>
      <br>
      <input type="submit" value="글쓰기">
      <input type="reset" value="다시작성">
      <input type="button" value="글목록" onclick="location.href='list.shopBoard'">
</form>
</div>
</body>
</html>