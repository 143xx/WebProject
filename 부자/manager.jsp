<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<html>
<head>
<meta charset="UTF-8">
<title>무인 사물함 관리자페이지</title>
<script>
var ok = 0;
var xmlhttp = false;
if (window.XMLHttpRequest) {
	xmlhttp = new XMLHttpRequest( );
	xmlhttp.overrideMimeType('text/xml');
	}
function findDB( ) {
	var sort = document.getElementById('sort').value;
	var locker_ = document.getElementById('locker_').value;
	var date_s = document.getElementById('date_s').value;
	
	var url = 'viewDB.jsp?';
	var qry = "sort="+sort+"&locker_="+locker_+"&date_s="+date_s;
	xmlhttp.open('POST', url, true);
	xmlhttp.onreadystatechange = getNums;
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.send(qry);
	optionLocker();
	optionDate();

}
function getNums( ) {
	if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
	document.getElementById('table').innerHTML = xmlhttp.responseText;
	} else {
	document.getElementById('table').innerHTML = 'Error: preSearch Failed!';
	}
}
function optionLocker( ) {
	var locker = document.getElementById('locker_');

	if(locker.options.length==1){
		for(i=1;i<31;i++){
			var objOption = document.createElement("option");
			
			objOption.text = i;
		    objOption.value = i;
		    locker.options.add(objOption);	
		}
	}
}

function optionDate( ) {
	<% Statement stmt = null;%>
	if(ok==0){
		<%
		try {
			InitialContext ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
			Connection con = ds.getConnection();
	
			stmt = con.createStatement();
			ResultSet result = stmt.executeQuery("SELECT * FROM locker.이용내역;");
			String date_arr="";
			while(result.next()){ 
				if(!date_arr.contains(result.getString(4)))
					date_arr += result.getString(4)+" ";
			}
			String data[]=date_arr.split(" ");%>
			var date_s = document.getElementById('date_s');
			if(date_s.options.length==1){
			<% for(int i=0;i<data.length;i++){ %>
					var option = document.createElement("option");
					option.text = "<%=data[i]%>";
					option.value = "<%=data[i]%>";
				    date_s.options.add(option);	
			<% }
			con.close();
			} catch (Exception e) {
			out.println("DB 에러");
			out.println(e.getMessage());
			e.printStackTrace();
			} %>
			ok=1;
		}
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
	</label>
	
<label>사물함: <select name="locker_" id="locker_">
	<option SELECTED value="0">전체</option>
	</select></label>
	
<label>날짜: <select name="date_s" id="date_s">
	<option SELECTED value="0">전체</option>
	 
	</select><input type="button" value="조회" onclick="findDB()"></label>
	<br><br>
<table class="board" border=1>
<thead><tr><th>일련번호</th><th>전화번호</th>
<th>사물함번호</th><th>보관날짜</th><th>보관시간</th>
<th>꺼낸날짜</th><th>꺼낸시간</th><th>총이용시간</th><th>요금</th></tr></thead>
<tbody id="table"></tbody>
</table>
<br>
<label id="howCoast"></label>
<input type="button" value="메인화면으로 돌아가기" onclick="location.href='사물함.html'">
</body>