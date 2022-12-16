<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*,java.time.LocalDateTime"%>
<%
request.setCharacterEncoding("utf-8"); 
String lockerChoose= request.getParameter("lockerChoose");
String phone= request.getParameter("phone");
session.invalidate();

String size="";
int price=0;


if(Integer.parseInt(lockerChoose) < 11){
	size= "소";
	price=1000;
} else if(11 <= Integer.parseInt(lockerChoose) && Integer.parseInt(lockerChoose) <= 20){
	size= "중";
	price=2000;
} else if(21 <= Integer.parseInt(lockerChoose) && Integer.parseInt(lockerChoose) <= 30) {
	size= "대";
	price=3000;
}
LocalDateTime now = LocalDateTime.now();
int year = now.getYear();
int month = now.getMonthValue();
int dayOfMonth = now.getDayOfMonth();
int hour = now.getHour(); 
int minute = now.getMinute(); 

int updateCount = 0;

String date = year+"-"+month+"-"+dayOfMonth;
String time = hour+":"+minute;
%>
<script>
function pay(how){
	var payTo = document.getElementById("payTo");
	payTo.innerHTML = how+"(으)로 결제합니다";
	showBtn();
	insertDB();
	updateDB();
}

function showBtn() {
  var home = document.getElementById('home');
  home.style.visibility = 'visible';
}

function insertDB(){
	<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	int num=1;

	Statement stmt = null;
	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		Connection con = ds.getConnection();

		stmt = con.createStatement();
		ResultSet result= stmt.executeQuery("SELECT * FROM locker.이용내역;");
		while(result.next()){ 
			num++;
		}
		con.close();
	} catch (Exception e) {
		out.println("MySql 데이터베이스 접속에 문제가 있습니다. <hr>");
		out.println(e.getMessage());
		e.printStackTrace();
	}
	String sql = "INSERT INTO locker.이용내역 (no, phone, locker, startDate, startTime, endDate, endTime,runtime,coast) VALUES(?,?,?,?,?,?,?,?,?)";

	try {
		//책과 다른 부분
		//괄호부분에 context.xml에 설정한 name을 추가함으로써 디비 정보 노출 없이 초기화할수 있다고 하였읍니다
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/mysql");
		conn = ds.getConnection();
		
		pstmt = conn.prepareStatement(sql);

		pstmt.setInt(1, num);
		pstmt.setString(2, phone);
		pstmt.setInt(3, Integer.parseInt(lockerChoose));
		pstmt.setString(4, date);
		pstmt.setString(5, time);
		pstmt.setString(6, "-");
		pstmt.setString(7, "-");
		pstmt.setString(8, "-");
		pstmt.setInt(9, price);
		
		
		pstmt.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}//finally의 끝 %>
}
function updateDB(){
	<% 
	InitialContext ctx = new InitialContext();
	DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
	Connection con = ds.getConnection();
	PreparedStatement pstmt1 = null;
	String sql1 = "update locker.이용여부 set `use` = ? where number = ?;";

	pstmt1 = con.prepareStatement(sql1);
	pstmt1.setInt(1, 1);
	pstmt1.setString(2, lockerChoose);

	// 4) 실행
	pstmt1.executeUpdate();

	// JDBC 자원 닫기
	pstmt1.close();
	con.close();
	%>
}
</script>
<style>
#home {
  visibility : hidden;
}
</style>
<head>
<meta charset="UTF-8">
<title>결제하기</title>
</head>
<body>
<h1>결제</h1><hr>
<h3>결제 정보</h3>
사물함번호: <%= lockerChoose%>(<%=size %>)<br>
전화번호: <%= phone%><br>
선불요금: <%=price %>원<br>
보관날짜: <%=date %><br>
보관시간: <%=time %><br><br>
<input type="button" id="card" value="카드" onclick="pay('카드')">
<input type="button" id="cash" value="현금" onclick="pay('현금')">
<p id="payTo"></p>
<input type="button" id="home" value="메인으로 넘어가기" onclick="location.href='사물함.html'">
</body>
</html>