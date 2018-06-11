<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>
<%@include file="mypageSide.jsp"%>
<div align="center">
	<form name="f" method="POST" action="mypage_qna.mypage" enctype="multipart/form-data">
		<input type="hidden" name=writer value="${userLoginInfo.id }" />
		<input type="hidden" name=m_code value="${userLoginInfo.member_code }" />
		<table width="600" align="center">
			<tr>
				<td colspan="2" align=center>qna</td>
			</tr>
			<tr>
				<td width="100">작성자 : ${userLoginInfo.id}</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="col-3 input-effect">
						<input class="effect-22" type="text" name="subject" size="20"
							placeholder="제목"> <label>제목</label> <span
							class="focus-bg"></span>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2"><div align="left">
						<textarea rows="10" cols="50" name="content"></textarea>
					</div></td>
			</tr>
			<tr>
         		<td><input type="file" name="filename"></td>
      		</tr>
			<tr>
				<td>
					<div align="center">
						<input type="submit" value="등록" class="button button1"><input
							type="button" onclick="window.location='myPage.member'"
							class="button button1" value="취소">
					</div>
				</td>
			</tr>

		</table>
	</form>
</div>
</td>
</tr>
</table>
</div>