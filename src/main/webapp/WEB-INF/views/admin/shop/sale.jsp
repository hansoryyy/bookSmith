<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file = "../top.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>매출현황 | 북스미스</title>
</head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/jquery-ui.min.js"></script>
<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="year"><fmt:formatDate value="${now}" pattern="yyyy"/></c:set>
<c:set var="month"><fmt:formatDate value="${now}" pattern="yyyyMM"/></c:set>
<style>
h1 {
	color: #4CAF50;
}

hr {
	color: #808080;
}

input[type=text] {
    width: 8%;
    padding: 6px 10px;
    margin: 8px 0;
    box-sizing: border-box;
    border: 2px solid #ccc;
    -webkit-transition: 0.5s;
    transition: 0.5s;
    outline: none;
}

input[type=text]:focus {
    border: 2px solid #4CAF50;
}

.button {
    background-color: #4CAF50; /* Green */
    border: none;
    color: white;
    padding: 8px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
}
.button2 {
	border-radius: 4px;
}
</style>
<script>
jQuery(function($){
    $.datepicker.regional["ko"] = {
        closeText: "닫기",
        prevText: "이전달",
        nextText: "다음달",
        currentText: "오늘",
        monthNames: ["1월(JAN)","2월(FEB)","3월(MAR)","4월(APR)","5월(MAY)","6월(JUN)", "7월(JUL)","8월(AUG)","9월(SEP)","10월(OCT)","11월(NOV)","12월(DEC)"],
        monthNamesShort: ["1월","2월","3월","4월","5월","6월", "7월","8월","9월","10월","11월","12월"],
        dayNames: ["일","월","화","수","목","금","토"],
        dayNamesShort: ["일","월","화","수","목","금","토"],
        dayNamesMin: ["일","월","화","수","목","금","토"],
        weekHeader: "Wk",
        dateFormat: "yymmdd",
        firstDay: 0,
        isRTL: false,
        showMonthAfterYear: true,
        yearSuffix: ""
    };
	$.datepicker.setDefaults($.datepicker.regional["ko"]);
});
</script>
<script>
$(function() {
    $("#date, #fr_date, #to_date").datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: "yymmdd",
        showButtonPanel: true,
        yearRange: "c-99:c+99",
        maxDate: "+0d"
    });
});
</script>
<body>
<h1>매출 현황</h1><hr>
	<div class="saleDay">
        <form name="frm_sale_today" action="saleToday.admin" method="get">
        	<strong>일일 매출</strong>
        	<input type="text" name="date" id="date" size="8" maxlength="8" value="${param.date}">
        	<label for="date">일 하루</label>        	
        	<input type="submit" value="확인" class="button button2">
        </form>
    </div>
    
    <div class="saleDay">
        <form name="frm_sale_day" action="saleDate.admin" method="get">
        	<strong>일간 매출</strong>
        	<input type="text" name="fr_date" id="fr_date" size="8" maxlength="8"  value="${param.fr_date}">
        	<label for="fr_date">일 ~</label>        	
  			<input type="text" name="to_date" id="to_date" size="8" maxlength="8"  value="${param.to_date}">
  			<label for="to_date">일</label>  			
        	<input type="submit" value="확인" class="button button2">
        </form>
    </div>

    <div class="saleDay">
        <form name="frm_sale_month" action="saleMonth.admin" method="get">
        	<strong>월간 매출</strong>
        	<input type="text" name="fr_month" id="fr_month" value="${month-1}" size="6" maxlength="6">
        	<label for="fr_month">월 ~</label>
        	<input type="text" name="to_month" id="to_month" value="${month}" size="6" maxlength="6">
        	<label for="to_month">월</label>
        	<input type="submit" value="확인" class="button button2">
        </form>
    </div>

    <div class="saleDay">
        <form name="frm_sale_year" action="saleYear.admin" method="get">
        	<strong>연간 매출</strong>
        	<input type="text" name="fr_year" id="fr_year" value="${year-1}" size="4" maxlength="4">
        	<label for="fr_year">년 ~</label>
        	<input type="text" name="to_year" id="to_year" value="${year}" size="4" maxlength="4">
        	<label for="fr_year">년</label>
        	<input type="submit" value="확인" class="button button2">
        </form>
    </div>