<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*,java.time.LocalDateTime, java.util.Date, java.text.SimpleDateFormat"%>
<%
String phone= request.getParameter("phone");
Statement stmt = null;

String no ="";
String locker ="";
String startD ="";
String startT ="";
String endD ="";
String endT ="";
String runtime ="";
String coast ="";

String size="";

LocalDateTime now = LocalDateTime.now();
int year = now.getYear();
int month = now.getMonthValue();
int dayOfMonth = now.getDayOfMonth();
int hour = now.getHour(); 
int minute = now.getMinute(); 

int updateCount = 0;

String date = year+"-"+month+"-"+dayOfMonth;
String time = hour+":"+minute;

try {
InitialContext ctx = new InitialContext();
DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
Connection con = ds.getConnection();

stmt = con.createStatement();
ResultSet result = stmt.executeQuery("SELECT * FROM locker.이용내역 where phone='"+phone+ "' and endDate='-';");
if(result.next()){ 
	//response.sendRedirect("manager.jsp"); // 페이지이동
	no = result.getString(1);
	locker = result.getString(3);
	startD = result.getString(4);
	startT = result.getString(5);
	endD = result.getString(6);
	endT = result.getString(7);
	runtime = result.getString(8);
	coast = result.getString(9); 
}

if(Integer.parseInt(locker) < 11){
	size= "소";
} else if(11 <= Integer.parseInt(locker) && Integer.parseInt(locker) <= 20){
	size= "중";
} else if(21 <= Integer.parseInt(locker) && Integer.parseInt(locker) <= 30) {
	size= "대";
}
con.close();
} catch (Exception e) {
out.println("DB 에러");
out.println(e.getMessage());
e.printStackTrace();
}

InitialContext ctx = new InitialContext();
DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
Connection conn = ds.getConnection();
PreparedStatement pstmt1 = null;
String sql1 = "update locker.이용여부 set `use` = ? where number = ?;";

pstmt1 = conn.prepareStatement(sql1);
pstmt1.setInt(1, 0);
pstmt1.setString(2, locker);

// 4) 실행
pstmt1.executeUpdate();

// JDBC 자원 닫기
pstmt1.close();
conn.close();

InitialContext ctx2 = new InitialContext();
DataSource ds2 = (DataSource) ctx2.lookup("java:comp/env/jdbc/mysql");
Connection conn2 = ds2.getConnection();
PreparedStatement pstmt2 = null;

String dateStart = startD+" "+startT;
String dateStop = date+" "+time;

SimpleDateFormat format = new SimpleDateFormat("yy-MM-dd HH:mm");

Date d1 = null;
Date d2 = null;

d1 = format.parse(dateStart);
d2 = format.parse(dateStop);

// Get msec from each, and subtract.
long diff = d2.getTime() - d1.getTime();     
long diffMinutes = diff / (60 * 1000);         
long diffHours = diff / (60 * 60 * 1000);                      

String runT = Long.toString(diffMinutes);


String sql2 = "update locker.이용내역 set endDate = ?, endTime = ?, runtime=?, coast=? where no = ?;";

int takeCoast =1000;
if(Integer.parseInt(runT)>60){
	int c = (Integer.parseInt(runT)-60)/10;

	takeCoast = 1000+(c*200);
}

pstmt2 = conn2.prepareStatement(sql2);
pstmt2.setString(1, date);
pstmt2.setString(2, time);
pstmt2.setString(3, runT);
pstmt2.setInt(4, takeCoast);
pstmt2.setInt(5, Integer.parseInt(no));

// 4) 실행
pstmt2.executeUpdate();

// JDBC 자원 닫기
pstmt2.close();
conn2.close();
%>
<style>
		html, body { margin: 0; padding: 0; height: 100%; }
		header { width: 100%; height: 20%; 
			background: linear-gradient(pink, white); 
			font: 32pt Arial bold;
			text-align: center;
			font-family: "Times New Roman", "Times", serif; }
		section { width: 100%; height: 70%; float: left;	
			font-family: "Times New Roman", "Times", serif;
			text-align: center; }
table {
    width: 600px;
    margin-left:auto; 
    margin-right:auto;
  }
</style>
<head>
<meta charset="UTF-8">
<title>물건 찾기 완료</title>
</head>
<body>
<header>LOCKER</header>
<section>
<h1>이용해주셔서 감사합니다!</h1><hr>
<h3>이용 정보</h3>
<table class="board" border=1>
	<tbody>
	<tr><td>사물함번호</td><td><b><%= locker%>(<%=size %>)</b></td></tr>
	<tr><td>전화번호</td><td><b><%= phone%></b></td></tr>
	<tr><td>보관날짜</td><td><b><%= startD%></b></td></tr>
	<tr><td>보관시간</td><td><b><%= startT%></b></td></tr>	
	<tr><td>찾은날짜</td><td><b><%= date%></b></td></tr>
	<tr><td>찾은시간</td><td><b><%= time%></b></td></tr>	
	<tr><td>이용시간</td><td><b><%= runT%>분</b></td></tr>
	<tr><td>지불한요금</td><td><b><%= takeCoast%>원</b></td></tr>	
	</tbody></table><br>
<input type="button" id="home" value="메인으로 넘어가기" onclick="location.href='사물함.html'">
</section>
</body>
</html>