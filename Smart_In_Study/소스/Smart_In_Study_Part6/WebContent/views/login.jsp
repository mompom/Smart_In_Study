<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js" type="text/javascript"></script>
	
<script src="js/common.js"></script>
<style>
.padding{
padding-top : 10px;
}
</style>
<script>
	$(document).ready(function() {

						$.ajax({
									type : "POST",
									url : "SelectLocationlogin",
									data : {
										page : "main"
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
										
										var text = "";
										var texts = "";
										var count = "";

										if ("${siscode}" != "") {
											for (var i = 0; i < parse.length; i++) {
												if (parse[i].siscode == "${siscode}") {
													count = i;
												}
											}
											text += "<input type=\"text\""; 
					text += " value=\""+parse[count].sisname+"\" disabled=\"false\"/>";
											text += "<input type=\"hidden\""; 
					text += " value=\""+parse[count].siscode+"\" class=\"selectLocation\"/>";
											if(parse[count].sisimg1!="comingsoon.jpg"){//오픈예정인 곳은 회원가입 아이디 비밀번호 찾기 비활성화
											texts += "<div style=\"float: left;\">";
											texts += "<a href=\"TurnOn_IdPwFindPage_Member\" class=\"forgot_password\">아이디/비밀번호 찾기</a>";
											texts += "</div>";
											texts += "<div style=\"float: right;\">";
											texts += "<a href=\"TurnOn_JoinPage\" class=\"forgot_password\">회원가입</a>";
											texts += "</div>";
											}
										} else {
											
												text += "<select class=\"selectLocation\">";
												for (var i = 0; i < parse.length; i++) {
													if(parse[i].sisimg1=="comingsoon.jpg"){
														
													}else{
													text += "<option value=\""+parse[i].siscode+"\">";
													text += parse[i].sisname + "";
													text += "</option>";
													}
												}
												text += "</select>";
											
										}
										$("#selectLocation").append(text);
										$(".user_login").append(texts);
									},
									error : function(error) { // 실패
										alert("error");

									}
								});

						$("#login").click(function login() {

											$.ajax({

														type : "POST",
														url : "Login",
														dataType : "json",
														data : {

															mbpw : $("#mbpw").val(),
															mbid : $("#mbid").val(),
															siscode : $(".selectLocation").val()

														},
														timeout : "5000",
														success : function(data) {
															var json = JSON.stringify(data);
															var parse = JSON.parse(json);
															// 성공
															switch (parse.page) {
															case "error:siscode":
																alert("해당 독서실에 아이디가 없습니다. 독서실이나 아이디를 확인해주세요.");
																break;
															case "error:password":
																alert("아이디 혹은 비밀번호를 확인해주세요.");
																break;
															case "success:User":
																if(parse.mbid=="SisAdmin"){
																	location.href = "Main_Login_Admin"
																}else{
																	location.href = "TurnOn_Sis_Login_MainPage"	
																}
																break;
															default:
																break;
															}
														},

														error : function(error) { // 실패
															alert("errorr1");
															console.log(error);
														}
													});

										});
					});

	//로그인
</script>
<div class="container">

	<div id="modal" class="popupContainer" style="display: none;">
		<header class="popupHeader">
			<span class="header_title">Login</span> <span class="modal_close"><i
				class="fa fa-times"></i></span>
		</header>

		<section class="popupBody">

			<!-- Username & Password Login form -->
			<div class="user_login">
			
					<label>지점 선택</label>
					<div id="selectLocation">
					
					</div>
					<label class="padding">아이디</label> <input
						type="text" name="mbid" value="" id="mbid" /> <br /> <label>비밀번호</label>
					<input type="password" name="mbpw" value="" id="mbpw" /> <br />

					<div class="action_btns">
						<div class="one_half last">
							<div>
								<a class="btn btn_red" onclick="" id="login" style="cursor: pointer;">로그인</a>
							</div>
						</div>
					</div>
			</div>

		</section>
	</div>
</div>


<!--로그인 js -->
<!-- <link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css"> -->

<link rel='stylesheet prefetch'
	href='https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,700,700italic,400italic'>
<link rel='stylesheet prefetch'
	href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css'>

<link rel="stylesheet" href="style/loginpage/login.css">
<script
	src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script
	src='https://andwecode.com/wp-content/uploads/2015/10/jquery.leanModal.min_.js'></script>

<script src="style/loginpage/login.js"></script>
