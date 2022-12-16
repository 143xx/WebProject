<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@ page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<Script>
function findDB(){
	<%
	int i=1;
	Statement stmt = null;

	try {
	InitialContext ctx = new InitialContext();
	DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
	Connection con = ds.getConnection();

	stmt = con.createStatement();
	ResultSet result = stmt.executeQuery("SELECT * FROM locker.이용여부;");
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
</Script>
</head>
<body onload="findDB()">
<input type="button" onclick="findDB()" value="">
<input type='radio' name='1' id='1'  value='1'>
<input type='radio' name='2' id='2'  value='2'>
<input type='radio' name='3' id='3'  value='3'>
<input type='radio' name='4' id='4'  value='4'>
<input type='radio' name='5' id='5'  value='5'>
<input type='radio' name='6' id='6'  value='6'>
<input type='radio' name='7' id='7'  value='7'>
<input type='radio' name='8' id='8'  value='8'>
<input type='radio' name='9' id='9'  value='9'>
<input type='radio' name='10' id='10'  value='10'>
<div id="use"></div>
</body>
</html>