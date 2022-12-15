<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<html>
<head>
<meta charset="UTF-8">
<title>무인 사물함 관리자페이지</title>
<script>
var xmlhttp = false;
if (window.XMLHttpRequest) {
	xmlhttp = new XMLHttpRequest( );
	xmlhttp.overrideMimeType('text/xml');
	}
function findDB( ) {
	var sort = document.getElementById('sort').value;
	var url = 'viewDB.jsp?';
	var qry = "sort="+sort;
	xmlhttp.open('POST', url, true);
	xmlhttp.onreadystatechange = getNums;
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.send(qry);
	}
function getNums( ) {
	if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
	document.getElementById('table').innerHTML = xmlhttp.responseText;
	} else {
	document.getElementById('table').innerHTML = 'Error: preSearch Failed!';
	}
}
</script>
</head>
<body>
<h1>관리자 페이지</h1>
<hr>
<label>정렬: <select name="sort" id="sort">
	<option SELECTED value="no">오래된순으로 보기</option>
	<option value="no desc">최신순으로 보기</option>
	<option value="runtime desc">이용시간 큰 순서로 보기</option>
	<option value="runtime">이용시간 작은 순서로 보기</option>
	<option value="coast desc">이용 요금 큰 순서로 보기</option>
	<option value="coast">이용 요금 작은 순서로 보기</option>
	</select>
	<input type="button" value="조회" onclick="findDB()"></label>
	<br><br>
<table class="board" border=1>
<thead><tr><th>일련번호</th><th>전화번호</th>
<th>사물함번호</th><th>보관날짜</th><th>보관시간</th>
<th>꺼낸날짜</th><th>꺼낸시간</th><th>총이용시간</th><th>요금</th></tr></thead>
<tbody id="table"></tbody>
</table>
<br>
<label id="howCoast"></label>
</body>