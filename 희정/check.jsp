<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>물품 보관</title>
</head>
<body onload="loadRadio()">
<%
	String radioValue = request.getParameter("storageBox");
	int int_radio = Integer.parseInt(radioValue);
%>
	<form action="pay.jsp" method="post" >
		선택한 사물함은 <p id="radio" name="radio"> 입니다.<br>
		본인 확인을 위해 아래 입력 칸에 본인의 전화번호를 입력해주세요.(ex-01012341234) <br>
		<input type="text" minlength="11" maxlength="11" required> <br>
		<input type="submit" value="결제하러 가기">
	</form>
	<script>
	function loadRadio(){
		var radio = document.getElementById("radio");
		radio.innerHTML(<%=int_radio%>);
	}
	</script>
</body>
</html>