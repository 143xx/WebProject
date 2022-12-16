<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>물품 보관</title>
<script>
function size() {
	
	document.write("<h2>카드</h2><p>카드 결제를 선택하셨습니다. <br>아래의 카드단말기에 카드를 인식시켜주세요.</p><button type='button' onclick='location.reload();'>취소</button>")
	
	if(size < 11){
		document.write('소 사이즈 입니다. 1,000입니다.');
	} else if(11 <= size && size <= 20){
		document.write('중 사이즈 입니다. 2,000입니다.');
	} else {
		document.write('대 사이즈 입니다. 3,000입니다.');
	}
}
</script>
<style>
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
</style>
</head>
<body>
<%
	String size= request.getParameter("radio");
%>
<section>
<button class="payBtn" id="cash" style="margin-left:10%;" onclick="size()">카드 결제</button>
<div class="modal">
	<div class="modal-content" style="color: black;">
		<span class="close-button">&times;</span>
        <p id = "pay"></p>
	</div>
</div>

<button class="Btn" id="recover" style="margin-left:10%;">현금 결재</button>
<div class="re-modal">
	<div class="re-modal-content" style="color: black;">
		<span class="re-close-button">&times;</span>
        <h1 class="re-title">물건 찾기</h1>
        <h4>물품 찾기를 선택하셨습니다.</h4>
	</div>
</div>
</section>

<script>
	var modal = document.querySelector(".modal");
	var trigger = document.getElementById("card");
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
	
	var remodal = document.querySelector(".re-modal");
	var trigger2 = document.getElementById("recover");
	var closeButton2 = document.querySelector(".re-close-button");
	function toggleModal2() {
		remodal.classList.toggle("re-show-modal");
		}
	function windowOnClick2(event) {
	  	if (event.target === remodal){
			toggleModal2();
			}
		}
	
	trigger2.addEventListener("click", toggleModal2);
	closeButton2.addEventListener("click", toggleModal2);
	window.addEventListener("click", windowOnClick2);

	
	function cash(){
		document.write("현금 결제를 선택하셨습니다.<br>");
		
		document.write("아래의 현금 투입구에 현금을 넣어주세요.");
		setTimeout(funtion() {
			console.log('결제가 완료되었습니다.');
		}, 10000);
	}
</script>
</body>
</html>