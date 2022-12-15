<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%
String no="";
String phone="";
String locker="";
String startDate="";
String startTime="";
String endDate="";
String endTime="";
String runtime="";
String coast="1000";

String sort= request.getParameter("sort");

Statement stmt = null;

try {
InitialContext ctx = new InitialContext();
DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
Connection con = ds.getConnection();

stmt = con.createStatement();
int howMuch=0;
String date="";
ResultSet result= stmt.executeQuery("SELECT * FROM locker.이용내역 ORDER BY "+sort+";");
while(result.next()){ 
	no = result.getString(1);
	phone = result.getString(2);
	locker = result.getString(3);
	startDate = result.getString(4);
	startTime = result.getString(5);
	endDate = result.getString(6);
	endTime = result.getString(7);
	runtime = result.getString(8);
	coast = result.getString(9);
	
	out.println("<tr><td>"+result.getString(1)+"</td>"+
	"<td>"+result.getString(2)+"</td>"+"<td>"+result.getString(3)+"</td>"+
	"<td>"+result.getString(4)+"</td>"+"<td>"+result.getString(5)+"</td>"+
	"<td>"+result.getString(6)+"</td>"+"<td>"+result.getString(7)+"</td>"+
	"<td>"+result.getString(8)+"</td>"+"<td>"+result.getString(9)+"</td></tr>");
	
	howMuch+= result.getInt(9);
	if(!date.contains(result.getString(4)))
		date += result.getString(4)+" ";
}
out.print("총 수입: "+howMuch+"원<br>");
String data[]=date.split(" ");

out.println("날짜별로 보기: <select name='date' id='date'>");
for(int i=0;i<data.length;i++){
	out.println("<option value='"+data[i]+"'>"+data[i]+"</option>");
}
out.println("</select>");

con.close();
} catch (Exception e) {
	out.println("MySql 데이터베이스 접속에 문제가 있습니다. <hr>");
	out.println(e.getMessage());
	e.printStackTrace();
}
%>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>