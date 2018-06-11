<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file = "../top.jsp"%>
<html>
<head>
<title>글쓰기</title>
<!-- <script type="text/javascript">
   function check(){
      if (f.re_content.value==""){
         alert("내용을 입력해 주세요!!")
         f.re_content.focus()
         return false
      }
      document.f.submit();
      return true
   }
</script> -->
</head>
<style>
input[type=text]{
	width: 100%;
    padding: 6px 10px;
    margin: 8px 0;
    border-radius: 2px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    -webkit-transition: 0.5s;
    transition: 0.5s;
    font-size: 16px;
    outline: none;
}
textarea {
    width: 100%;
    height: 250px;
    padding: 12px 20px;
    box-sizing: border-box;
    border: 2px solid #ccc;
    border-radius: 4px;
    background-color: #f8f8f8;
    font-size: 16px;
    resize: none;
}
textarea:focus {
    border: 2px solid #4CAF50;
}
</style>
<body>
<div align="center">
<form name="f" action="replyPro.qna" method="post" enctype="multipart/form-data">   
   <table id="customers">
      <tr>
         <th width="20%">이 름</th>
         <td><input type="hidden" name="writer" value = "관리자">관리자</td>
      </tr>
      <tr>
         <th width="20%">제 목</th>
         <td><input type="text" value = "re:${qna.subject }" readonly="readonly"></td>
      </tr>
      <tr>
         <th width="20%">문 의 내 용</th>
         <td><textarea rows="6" cols="50" readonly="readonly">${qna.content }</textarea></td>
      </tr>
      <tr>
         <th width="20%">문 의 답 변</th>
         <td><textarea rows="12" cols="50" name="re_content"></textarea></td>
      </tr>
      <tr>
         <th width="20%">파 일</th>
         <td><input type="file" name="re_filename"></td>
      </tr>
   </table>
      <br>
      <input type="submit" class="button" value="답글 쓰기">
      <input type="reset"  class="button button3" value="다시작성">
      <input type="button" class="button button1"value="Q&A목록" onclick="location.href='list.qna'">
</form>
</div>
</body>
</html>
<%@ include file="../bottom.jsp" %>