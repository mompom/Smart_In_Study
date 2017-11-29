<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Favicon -->
<link rel="icon" href="images/favicon/favicon.ico">
<title>Smart In Study</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- 생년월일  -->
<script src="js/dobPicker.min.js"></script>
<!-- js  common : 다음주소 포함 -->
<script src="js/common.js"></script>
<script src="js/mb_validation.js"></script>
<!-- google reCapthcha -->
<script src='https://www.google.com/recaptcha/api.js'></script>
<!-- Daum 주소 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	$(document).ready(function() {
						

						$.dobPicker({
							daySelector : '#dobday', /* Required */
							monthSelector : '#dobmonth', /* Required */
							yearSelector : '#dobyear', /* Required */
							dayDefault : '일', /* Optional */
							monthDefault : '월', /* Optional */
							yearDefault : '년', /* Optional */
							minimumAge : 12, /* Optional */
							maximumAge : 70
						/* Optional */
						});

						//Otp 인증
						$(".rephonenumber").hide();
						$(".user_code").hide();
						$(".User_OtpCode").hide();

						$(".OtpService").click(function() {
											if ($("#phonenum").val() != "") {
												_this = $(this);
												
												var mbphonenumber = $(
														"#phonenum").val();
												$("#phonenum").attr("disabled",
														"true");
												$(".OtpService").toggle();
												$(".rephonenumber").toggle();
												$(".user_code").toggle();
												$(".User_OtpCode").toggle();

												window1 = open(
														"TurnOn_Join_OtpPage?mbphonenumber="
																+ mbphonenumber,
														"popup",
														"left=1100, top=300, width=315,height=315, toolbars=no, scrollbars=no");

												window2 = open(
														"TurnOn_Join_Otp_IntroPage",
														"popup2",
														"left=600, top=100, width=420,height=560, toolbars=no, scrollbars=no");

											} else {

												alert("휴대폰번호를 입력해주세요.");
												$("#phonenum").focus();

											}

										});

						//휴대폰번호 재입력
						$(".rephonenumber").click(function() {
							$("#phonenum").removeAttr("disabled");
							$(".OtpService").toggle();
							$(".rephonenumber").toggle();
							$(".user_code").toggle();
							$(".User_OtpCode").toggle();
							$(".Otp_IntroPage").toggle();
						});

						//인증번호 입력
						$(".User_OtpCode").click(
								function() {
									$.ajax({
										type : "POST",
										url : "User_OtpCode",
										data : {
											user_code : $(".user_code").val()
										},
										// 전달 값
										dataType : "json",
										// json, xml, html(text): 안쓰면 html
										timeout : "5000",
										// 타임아웃

										success : function(data) {
											// 성공

											var json = JSON.stringify(data);
											var parse = JSON.parse(json);

											if (parse.result) {//인증완료
												$("#phonenum").removeAttr(
														"disabled");
												$(".rephonenumber").toggle();
												$(".user_code").toggle();
												$(".User_OtpCode").toggle();
												$("#user_codes2").append(
														"인증이 완료되었습니다.");
												$("#otpcheck").val("success");

											} else { //인증실패
												alert("인증번호를 확인해주세요.");
												$(".user_code").focus();
											}
										},

										error : function(error) { // 실패
											alert("인증번호를 확인해주세요.");
											$(".user_code").focus();

										}
									});
								});
						
						// 로그인 중복체크
						$("#btnId").click(function() {

							$.ajax({

								type : "POST",
								url : "Id_Sis_Check",
								dataType : "json",
								data : {

									mbid : $("#id").val(),
									siscode : "${siscode}"

								},
								timeout : "5000",
								success : function(data) {
									var json = JSON.stringify(data);
									var parse = JSON.parse(json);
									// 성공
									switch (parse.page) {
									case "error:id":
										alert("중복된 아이디 입니다.");
										$('#id').val('').focus();
										break;
									case "error:admincode":
										alert("아이디에 Admin이 들어갑니다. 다른 아이디를 사용해주세요.");
										$('#id').val('').focus();
										break;
									case "success":
										alert("가입가능한 아이디 입니다.");
										$('#idcheck').val('success');
										break;
									default:
										break;
									}
								},

								error : function(error) { // 실패
									alert("로그인 실패");
									console.log(error);
								}
							});

						});

					});
</script>
<Style>
.container {
	max-width: 38em;
	padding: 1em 3em 2em 3em;
	margin: 0em auto;
	background-color: #fff;
	border-radius: 4.2px;
	box-shadow: 0px 3px 10px -2px rgba(0, 0, 0, 0.2);
}

input {
	width: 100%;
	padding: 1em;
	line-height: 1.4;
	height: 41px !important;
	background-color: #f9f9f9;
	border: 1px solid #e5e5e5;
	border-radius: 3px;
	-webkit-transition: 0.35s ease-in-out;
	-moz-transition: 0.35s ease-in-out;
	-o-transition: 0.35s ease-in-out;
	transition: 0.35s ease-in-out;
	transition: all 0.35s ease-in-out;
	
}

#id {
	width: 80%;
}

#btnId {
	width: 20%;
}

#dobyear, #dobmonth, #dobday {
	width: 32%;
}

.col-half{
    padding-right: 10px;
    float: left;
    width: 50%;
}

select {
display: inline-block;
    text-align: center;
    float: left;
    border-radius: 0;
    border-top-left-radius: 3px;
    border-bottom-left-radius: 3px;
    height: 2.4em;
    line-height: 2;
        background-color: #f9f9f9;
    border: 1px solid #e5e5e5;
}

label {
	background-color: #f05f40;
    color: #fff;
    border-color: rgba(34, 34, 34, 0.05);
    display: inline-block;
    width: 50%;
    text-align: center;
    float: left;
    border-radius: 0;
}

#address2{
 background-color: #ffffff;
}

h3{
 color : #f05f40;
}

.btn-info {
	background-color: #f05f40;
	border-color: #f1785e9e;
	
}
.btn-primary , .btn-primary:hover{
    background-color: #f9f9f9;
    border: 1px solid #e5e5e5;
    color: #222
} 
.btn-primary.active, .btn-primary:active, .open>.dropdown-toggle.btn-primary, btn .btn-primary:active focus{
background-color: #f05f40;
	border-color: #f1785e9e;
}

.form-footer{
text-align: center;
}

.form-group{
    text-align: -webkit-center;
}

.btn-info:hover{ 
background-color: #f12f05;
	border-color: #f1785e9e;
}

</Style>
</head>

<body>
	<div class="container">
		<div class="signup-form-container">

			<!-- form start -->
			<form role="form" id="register-form" autocomplete="off" action="Join"
				method="post">
				<div class="form-header">
					<h3 class="form-title"
						style="margin-top: 30px; margin-bottom: 30px">
						<i class="fa fa-user"></i> 회원가입
					</h3>
				</div>

				<div class="form-body">

					<!-- 아이디 -->
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
								<span class="glyphicon glyphicon-user"></span>
							</div>
							<div>
								<input name="mbid" id="id" value="" type="text"
									class="form-control" placeholder="아이디"> <input
									type="button" id="btnId" value="중복확인" /> <input type="hidden"
									id="idcheck" value="${idcheck }" />
							</div>
						</div>
						<%-- 	<h5>${idchecked }</h5> --%>
						<span class="help-block" id="error"></span>
					</div>

					<!-- 패스워드 -->
					<div class="row">
						<!-- 패스워드 입력 -->
						<div class="form-group col-lg-6">
							<div class="input-group">
								<div class="input-group-addon">
									<span class="glyphicon glyphicon-lock"></span>
								</div>
								<input name="mbpw" id="password" type="password"
									class="form-control" placeholder="패스워드">
							</div>
							<span class="help-block" id="error"></span>
						</div>

						<!-- 패스워드 재입력 -->
						<div class="form-group col-lg-6">
							<div class="input-group">
								<div class="input-group-addon">
									<span class="glyphicon glyphicon-lock"></span>
								</div>
								<input name="mbspw" type="password" class="form-control"
									placeholder="패스워드 재확인">
							</div>
							<span class="help-block" id="error"></span>
						</div>
					</div>

					<!-- 사용자 이름 -->
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
								<span class="glyphicon glyphicon-user"></span>
							</div>
							<input name="mbname" type="text" class="form-control"
								placeholder="이름">
						</div>
						<span class="help-block" id="error"></span>
					</div>

					<!-- 사용자 닉네임 -->
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
								<span class="glyphicon glyphicon-user"></span>
							</div>
							<input name="mbnick" type="text" class="form-control"
								placeholder="닉네임">
						</div>
						<span class="help-block" id="error"></span>
					</div>

					
					
					<div class="form-group">
						<div class="input-group" style="width: 80%;">
					
					<div class="col-half" style="width : 60%;">
						<select id="dobday"></select> <select id="dobmonth"></select> <select
							id="dobyear"></select>
					</div>

					<!-- 성별  :: 라디오 버튼 -->
				<!-- 	<div class="col-half"> -->
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active"> <input type="radio"
								name="gender" id="option1" value="남자" checked="checked"
								autocomplete="off"> 남자
							</label> <label class="btn btn-primary"> <input type="radio"
								name="gender" id="option2" value="여자" autocomplete="off">
								여자
							</label>
						</div>
					<!-- </div> -->
					</div></div>
					
					<!-- 핸드폰 번호 -->
					<div class="form-group">
						<div id="user_codes" class="input-group">
							
								<div class="input-group-addon">
									<span class="glyphicon glyphicon-phone"></span>
								</div>

								<input id="phonenum" name="mbphonenumber" type="text"
									class="form-control" placeholder="휴대폰 번호" value="">
									
									
									 <input
									type="button" value="인증하기" class="OtpService" /> 
									<div id="user_codes2">
									<input
									type="button" value="번호 재입력" class="rephonenumber" /> <input
									type="text" value="" class="user_code" placeholder="인증번호" /> <input
									type="button" value="확인" class="User_OtpCode" /> <input
									type="hidden" value="" id="otpcheck" />

							</div>
						</div>
						<span class="help-block" id="error"></span>
					</div>

					<!-- 사용자 주소 -->
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
								<span class="glyphicon glyphicon-user"></span>
							</div>
							<input type="text" id="address" placeholder="주소"
								readonly="readonly"> <input type="text" id="address2"
								placeholder="상세주소"> <input type="button"
								onClick="Postcode()" value="우편번호 찾기">
						</div>
						<span class="help-block" id="error"></span>
					</div>

					<!-- 메일 입력 -->
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
								<span class="glyphicon glyphicon-envelope"></span>
							</div>
							<input name="mbemail" type="text" class="form-control"
								placeholder="이메일">
						</div>
						<span class="help-block" id="error"></span>
					</div>
				</div>

				<!-- 아임 닝겐입니다 확인  -->
				
					<div class="form-group">
						<div class="input-group">
				<div class="g-recaptcha" id="grecaptcha"
					data-sitekey="6Lc68jUUAAAAAEItKqfwFFpEXvNakkNiSQ1WFEJC"></div>
					</div>
					</div>

				<!-- 회원가입 버튼 -->
				<div class="form-footer">

					<!-- <button type="submit" class="btn btn-info"> -->
					<button type="submit" id="submit" name="join" class="btn btn-info">
						<span class="glyphicon glyphicon-log-in"></span> 회원가입
					</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
