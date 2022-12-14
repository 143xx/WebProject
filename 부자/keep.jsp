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

function checkRadio(){
	var radios = document.getElementsByName('storageBox');
	var lockerChoose = document.getElementById('lockerChoose');
    for (var radio of radios){
        if (radio.checked) {
        	lockerChoose.value = radio.value;
        }
    }
}
</script> 
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
button:hover{
letter-spacing: 2px;
transform: scale(1.2);
cursor: pointer;
	}
button:active{
transform: scale(0.7);
	}
.modal, .re-modal {
        position: fixed;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        opacity: 0;
        visibility: hidden;
        transform: scale(1.1);
        transition: visibility 0s linear 0.25s, opacity 0.25s 0s, transform 0.25s;
    }
.modal-content, .re-modal-content {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: white;
        font-size: 18px;
        padding: 1rem 2rem;
        width: 600px;
        height: 350px;
        border-radius: 0.5rem;
    }
.close-button, .re-close-button{
        float: right;
        width: 1.5rem;
        line-height: 1.5rem;
        text-align: center;
        cursor: pointer;
        border-radius: 0.25rem;
        background-color: lightgray;
    }
.close-button:hover {
        background-color: darkgray;
    }
.show-modal, .re-show-modal {
        opacity: 1;
        visibility: visible;
        transform: scale(1.0);
        transition: visibility 0s linear 0s, opacity 0.25s 0s, transform 0.25s;
    }

#cancel {
    	width: 127px; height: 48px;
    	text-align: center;
    	border: none;
    	margin-top: 20px;
    	cursor: pointer;
    }
#cancel:hover{
    	color: #fff;
    	background-color: #216282;
    	opacity: 0.9;
    }
    table {
    width: 600px;
    margin-left:auto; 
    margin-right:auto;
  }
</style>
</head>
<body onload="findDB()">
<header>LOCKER</header>
<section>
<h1>원하시는 사물함 번호를 눌러주세요.</h1>
<hr>
<form action="pay.jsp" method="post">
	<table class="board" border=1>
	<tbody><tr><th COLSPAN="10">크기: 소(small)</th></tr>
	<tr><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td>
	<td>7</td><td>8</td><td>9</td><td>10</td></tr>

	<tr><td><input type="radio" name="storageBox" id="1" value="1"></td>
	<td><input type="radio" name="storageBox" id="2" value="2"></td>
	<td><input type="radio" name="storageBox" id="3" value="3"></td>
	<td><input type="radio" name="storageBox" id="4" value="4"></td>
	<td><input type="radio" name="storageBox" id="5" value="5"></td>
	<td><input type="radio" name="storageBox" id="6" value="6"></td>
	<td><input type="radio" name="storageBox" id="7" value="7"></td>
	<td><input type="radio" name="storageBox" id="8" value="8"></td>
	<td><input type="radio" name="storageBox" id="9" value="9"></td>
	<td><input type="radio" name="storageBox" id="10" value="10"></td></tr>
	
	<tr><th COLSPAN="10">크기: 중(medium)</th></tr>
	<tr><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td>
	<td>17</td><td>18</td><td>19</td><td>20</td></tr>
<tr><td><input type="radio" name="storageBox" id="11" value="11"></td>
	<td><input type="radio" name="storageBox" id="12" value="12"></td>
	<td><input type="radio" name="storageBox" id="13" value="13"></td>
	<td><input type="radio" name="storageBox" id="14" value="14"></td>
	<td><input type="radio" name="storageBox" id="15" value="15"></td>
	<td><input type="radio" name="storageBox" id="16" value="16"></td>
	<td><input type="radio" name="storageBox" id="17" value="17"></td>
	<td><input type="radio" name="storageBox" id="18" value="18"></td>
	<td><input type="radio" name="storageBox" id="19" value="19"></td>
	<td><input type="radio" name="storageBox" id="20" value="20"></td></tr>

	<tr><th COLSPAN="10">크기: 대(large)</th></tr>
	<tr><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td><td>26</td>
	<td>27</td><td>28</td><td>29</td><td>30</td></tr>
<tr><td><input type="radio" name="storageBox" id="21" value="21"></td>
	<td><input type="radio" name="storageBox" id="22" value="22"></td>
	<td><input type="radio" name="storageBox" id="23" value="23"></td>
	<td><input type="radio" name="storageBox" id="24" value="24"></td>
	<td><input type="radio" name="storageBox" id="25" value="25"></td>
	<td><input type="radio" name="storageBox" id="26" value="26"></td>
	<td><input type="radio" name="storageBox" id="27" value="27"></td>
	<td><input type="radio" name="storageBox" id="28" value="28"></td>
	<td><input type="radio" name="storageBox" id="29" value="29"></td>
	<td><input type="radio" name="storageBox" id="30" value="30"></td></tr>

	</tbody>
	</table>
	<div id="use"></div>
	<br>
	<button class="Btn" id="keep" onclick="checkRadio()">다음</button>
	<button class="Btn" id="keep" onclick="location.href='사물함.html'">이전</button>
</section>
<div class="modal">
	<div class="modal-content" style="color: black;">
		<span class="close-button">&times;</span>
        <h2>선택한 사물함은
        <input type="text" id="lockerChoose" name="lockerChoose" size="5" readonly> 번입니다.</h2><hr>
        <p>본인 확인을 위해 아래 입력 칸에 본인의 전화번호를 입력해주세요.</p>
		<label>전화번호: </label>
		<input type="text" name="phone" id="phone" placeholder="01012341234" minlength="11" maxlength="11" required> <br><br>
		<br>
		<input type="submit" value="결제하러 가기">
	</div>
</div>
</form>
</body>
<script>
	var modal = document.querySelector(".modal");
	var trigger = document.getElementById("keep");
	var closeButton = document.querySelector(".close-button");
	function toggleModal() {
		modal.classList.toggle("show-modal");
		}
	function windowOnClick(event) {
	  	if (event.target === modal){
			toggleModal();
			}
		}
	
	trigger.addEventListener("click", toggleModal);
	closeButton.addEventListener("click", toggleModal);
	window.addEventListener("click", windowOnClick);
</script>
</html>