<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@ page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>물품 보관</title>
<script>
function findDB(){
	<%
	int i=1;
	Statement stmt = null;

	try {
	InitialContext ctx = new InitialContext();
	DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
	Connection con = ds.getConnection();

	stmt = con.createStatement();
	ResultSet result = stmt.executeQuery("SELECT * FROM 'use'.use_table;");
	while(result.next()){ 
		if(result.getInt(2)==1){%>
			var radio = document.getElementById('<%=i%>');
			radio.disabled = true; <%
		}
		else if(result.getInt(2)==0){%>
			var radio = document.getElementById('<%=i%>');
			radio.disabled = false; 
		<%
		}
		i++;
	}
	con.close();
	} catch (Exception e) {
	out.println("DB 에러");
	out.println(e.getMessage());
	e.printStackTrace();
	}
	%>
}
</script> </head>

<body onload="findDB()">
원하시는 사물함 번호를 눌러주세요.
	<form action="check.jsp" method="get">
	<input type="button" onclick="findDB()" value=""> <br>
	크기: 소(small) <br>
	<input type="radio" name="storageBox" id="1" value="1">1
	<input type="radio" name="storageBox" id="2" value="2">2
	<input type="radio" name="storageBox" id="3" value="3">3
	<input type="radio" name="storageBox" id="4" value="4">4
	<input type="radio" name="storageBox" id="5" value="5">5
	<input type="radio" name="storageBox" id="6" value="6">6
	<input type="radio" name="storageBox" id="7" value="7">7
	<input type="radio" name="storageBox" id="" value="8">8
	<input type="radio" name="storageBox" id="2" value="9">9
	<input type="radio" name="storageBox" id="2" value="10">10 <br>
	
	크기: 중(midium) <br>
	<input type="radio" name="storageBox" value="11">11
	<input type="radio" name="storageBox" value="12">12
	<input type="radio" name="storageBox" value="13">13
	<input type="radio" name="storageBox" value="14">14
	<input type="radio" name="storageBox" value="15">15
	<input type="radio" name="storageBox" value="16">16
	<input type="radio" name="storageBox" value="17">17
	<input type="radio" name="storageBox" value="18">18
	<input type="radio" name="storageBox" value="19">19
	<input type="radio" name="storageBox" value="20">20 <br>
	
	크기: 대(large) <br>
	<input type="radio" name="storageBox" value="21">21
	<input type="radio" name="storageBox" value="22">22
	<input type="radio" name="storageBox" value="23">23
	<input type="radio" name="storageBox" value="24">24
	<input type="radio" name="storageBox" value="25">25
	<input type="radio" name="storageBox" value="26">26
	<input type="radio" name="storageBox" value="27">27
	<input type="radio" name="storageBox" value="28">28
	<input type="radio" name="storageBox" value="29">29
	<input type="radio" name="storageBox" value="30">30 <br>
	<div id="use"></div>
	
	<input type="submit" value="다음">
	</form>
</body>
</html>