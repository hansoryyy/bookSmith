<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>
<%@include file="mypageSide.jsp"%>
<div align="center">
	<h3>Q&A 현황</h3>
	<table>
		<tr bgcolor="#5882FA" style="color:white;" >
			<th width="50%" >글 제목</th>
			<th>작성일</th>
			<th width="10%">답글</th>
			<th>답글작성일</th>
		</tr>
		<c:if test="${list == null || list.size() == 0}">
			<tr>
				<td colspan="4">등록된 Q&A가 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="list" items="${list}">
			<tr align="center">
				<td><a href="mypage_qnaDetail.mypage?qna_code=${list.qna_code}">
						${list.subject}</a></td>
				<td>${list.reg_date}</td>
				<td align="center">
				<c:choose>
					<c:when test="${list.re_writer eq null}">
						N
					</c:when>
					<c:otherwise>
						Y
					</c:otherwise>
				</c:choose>
				</td>
				<td>${list.re_reg_date}</td>
			</tr>
		</c:forEach>
	</table>

</div>
</td>
</tr>
</table>
</div>