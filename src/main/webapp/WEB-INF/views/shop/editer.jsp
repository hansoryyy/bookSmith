<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
function submitG(){
   
   form.content.value=dhtmlframe.document.body.innerHTML;
   document.form.submit();
}
    function htmledit(excute){
       dhtmlframe.document.execCommand(excute);
   }
    $(function() {
        $("#imgInp").on('change', function(){
            readURL(this);
        });
    });

    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
                $('#blah').attr('src', e.target.result);
            }

          reader.readAsDataURL(input.files[0]);
        }
    }
    
    function fileCheck(obj){
       pathpoint = obj.value.lastIndexOf('.');
       filepoint = obj.value.substring(pathpoint+1,obj.length);
       filetype = filepoint.toLowerCase();
       if(filetype=='jpg'||filetype=='png'||filetype=='jpeg'||filetype=='bmp'){
          document.getElementById("bt_call").style.display="inline-block";
       }
       else{
          alert("잘못된 파일확장자입니다.");
          parentObj = obj.parentNode;
          node = parentObj.replaceChild(obj.cloneNode(true),obj);
          document.getElementById("bt_call").style.display="none";
          return false;
       }
    }
</script>
   <div class="w3-border w3-border-black w3-padding-small">
      <label>이미지</label><br>
        <input type="file" name="filename" id="imgInp" onchange="javascript:fileCheck(this)" accept="image/*"/>
        <img id="blah" style="max-width: 100%; height: auto;" src="#" alt="" />
   </div>
   
   <div class="w3-row w3-border w3-section w3-border-black w3-padding-small">
      <div class="w3-half w3-center w3-border-right">
         <b>정렬</b>
      </div>
      <div class="w3-half w3-center">
          <b>글 스타일</b>
       </div>
      <div class="w3-half w3-center w3-border-right">
          <div class="w3-third">
             <A class="w3-btn" href="javascript:htmledit('justifyleft');">좌측정렬</a>
          </div>
          <div class="w3-third">
             <A class="w3-btn" href="javascript:htmledit('justifycenter');">중심정렬</a>
          </div>
          <div class="w3-third">
             <A class="w3-btn" href="javascript:htmledit('justifyright');">우측정렬</a>
          </div>
       </div>
       
      <div class="w3-half w3-center">
          <div class="w3-third">
             <A class="w3-btn" href="javascript:htmledit('bold');">굵게</A>
          </div>
          <div class="w3-third">
             <A class="w3-btn" href="javascript:htmledit('italic');">기울게</A>
          </div>
          <div class="w3-third">
             <A class="w3-btn" href="javascript:htmledit('underline');">밑줄</A>
          </div>
       </div>
    </div>
   <textarea name="content" rows="0" cols="0" style="display:none"></textarea>
<br>
         
                 <iframe id="con2" NAME=dhtmlframe width="100%">
                 
                 </iframe>
                 
                <SCRIPT type="text/javaScript">
         
                dhtmlframe.document.designMode = "On"
            
            </SCRIPT>
            
            <input type="button" onclick="javascript:submitG()" class="w3-btn w3-border-top" value="리뷰 등록">