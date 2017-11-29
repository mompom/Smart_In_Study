<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- Favicon -->
<link rel="icon" href="images/favicon/favicon.ico">
<title>Smart In Study</title>
<!-- jQuery Library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- ================================================
    CSS
    ================================================ -->
<link rel="stylesheet" href="css/franchise.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<script>
function adjust_textarea(h) {
	h.style.height = "100px";
	h.style.height = (h.scrollHeight) + "px";
	
}
$(document).ready(function() {
	
$("#request").click(function() {
	var regExp = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
		if ($("#name").val() == "") {
			alert("이름을 입력해주세요.");
		} else {
			if ($("#phonenumber").val() == "") {
				alert("전화번호를 입력해주세요.");
			} else {
				if ($("#address").val() == ""){
					alert("주소를 입력해주세요.")
				}else{
					if($("#rscontent").val() == ""){
						alert("요청 메세지를 입력해주세요.")
					}else{
						if ( !regExp.test($("#phonenumber").val() ) ) {
						      alert("잘못된 휴대폰 번호입니다. -를 제외한 11자리를 입력해주세요.");
						      return false
						}else{
						var form = createForm("requestforms","Request_Service", "post");
						var address = $("#address").val() + $("#address2").val();
						// createObj(objType,objName, objValue,objPlaceholder);
						createObj("hidden","rsaddress", address, "");
						createObj("hidden","page", "franchisee_request", "");
				
						// relationObj(formName,objName);
						relationObj("requestforms","rsname");
						relationObj("requestforms","rsphonenumber");
						relationObj("requestforms","rsaddress");
						relationObj("requestforms","rscontent");
						relationObj("requestforms","page");
						form.submit();
						}
					}
				}
			}
		}
	});

});
</script>

<meta charset="UTF-8">
<title>SIS :: 프렌차이즈 요청</title>
</head>
<body>


	<div class="container">
		<div class="row">
			<a id="half_l" href="/Smart_In_Study/"><input type="button"
				value="메인페이지"></a> <a id="half_r"
				href="TurnOn_RequestPage?page=find"><input type="button"
				value="내 요청 확인"></a>
		</div>
		<!-- form start -->


		<div class="row">
			<h4>연락처</h4>

			<!--  이름  -->
			<div class="input-group input-group-icon">
				<input id="name" name="rsname" type="text" placeholder="이름" required
					autocomplete="off" />
				<div class="input-icon">
					<i class="fa fa-user"></i>
				</div>
				<span class="help-block" id="error"></span>
			</div>


			<!-- 핸드폰 번호 -->
			<div class="input-group input-group-icon">
				<input id="phonenumber" name="rsphonenumber" type="text"
					placeholder="휴대폰 번호" required autocomplete="off" />
				<div class="input-icon">
					<i class="fa fa-mobile"></i>
				</div>
				<span class="help-block" id="error"></span>
			</div>
			<div class="input-group input-group-icon">

				<input type="text" id="address" placeholder="주소찾기를 눌러주세요 "
					readonly="readonly" required autocomplete="off" />
				<div class="input-icon">
					<i class="fa fa-home"></i>
				</div>

				<div class="input-group input-group-icon">
					<!-- 집 상세 주소 -->
					<input type="text" id="address2" placeholder="상세주소" required
						autocomplete="off" /> <input type="button" id="address3"
						onClick="Postcode()" value="주소찾기"><br> <span
						class="help-block" id="error"></span>
				</div>
				<!-- <input type="text" value="" placeholder="요청 내용" /><br> -->
				<label for="msg"><span style="color: #f05f40">요청 메세지를
						입력해주세요!</span></label>
				<textarea id="rscontent" name="rscontent"
					onkeyup="adjust_textarea(this)" required autocomplete="off"></textarea>
			</div>



		</div>
		<!-- 아임 닝겐입니다 확인  -->
		<!-- 	<div class="g-recaptcha" id="grecaptcha"
				data-sitekey="6Lc68jUUAAAAAEItKqfwFFpEXvNakkNiSQ1WFEJC"></div> -->
		<input type="button" value="신청" id="request" /> <b style="color: red">${message }</b>

	</div>

</body>
<!-- ================================================
    Scripts
    ================================================ -->


<!-- <script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script> -->

<!--  유효성 검사  -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.js"></script>
<script src="js/mb_validation.js"></script>
<!-- Custom JS :: includes Daum Address Api-->
<script src="js/common.js"></script>
<!-- Daum 주소 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- google reCapthcha -->
<script src='https://www.google.com/recaptcha/api.js'></script>

</html>