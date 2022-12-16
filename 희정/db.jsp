<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%
String number= request.getParameter("number");
Statement stmt = null;

try {
InitialContext ctx = new InitialContext();
DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
Connection con = ds.getConnection();

stmt = con.createStatement();
ResultSet result = stmt.executeQuery("SELECT * FROM use.use_table where `use`= '1'");
if(result.next()){ 
	//response.sendRedirect("manager.jsp"); // 페이지이동
	out.println(result.getString(1)+"님 반갑습니다!");
}
else{
	response.sendRedirect("login.html"); 
}
con.close();
} catch (Exception e) {
out.println("DB 에러");
out.println(e.getMessage());
e.printStackTrace();
}
%>