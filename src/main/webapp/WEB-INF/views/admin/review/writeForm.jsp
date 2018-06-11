<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file = "../top.jsp"%>
<html>
<head>
<title>공지사항 글쓰기 | BookSmith</title>
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
<h1>북로그 글쓰기</h1>
<hr>
<div id="noticeWriter" align="center">
<form name="f" action="write.booklog" method="post" enctype="multipart/form-data">   
   <table id="customers">
      <tr>
         <th width="20%">이 름</th>
         <td><input type="text" name="writer"></td>
      </tr>
      <tr>
         <th width="20%">제 목</th>
         <td>
         	<input type="text" name="subject">
         </td>
      </tr>
      <tr>
         <th width="20%">내 용</th>
         <td>
         	<textarea rows="12" cols="50" name="content"></textarea>
         </td>
      </tr>
      <tr>
         <th width="20%">파 일</th>
         <td>
         	<input type="file" name="filename">
         </td>
      </tr>
   </table>
      <br>
      <input type="submit" class="button" value="글쓰기">
      <input type="reset" class="button button3" value="다시작성">
      <input type="button" class="button button1" value="글목록" onclick="location.href='list.booklog'">
</form>
</div>
</body>
</html>
<%@ include file="../bottom.jsp" %>