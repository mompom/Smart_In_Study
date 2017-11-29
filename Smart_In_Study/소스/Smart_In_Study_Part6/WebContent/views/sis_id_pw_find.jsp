<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Favicon -->
<link rel="icon" href="images/favicon/favicon.ico">
<title>Smart In Study</title>
<!-- ================================================
    CSS
    ================================================ -->
<link rel="stylesheet" href="css/franchise.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<!-- JQuery  -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		
		$("#pwFind_mailBtn").click(function() {
			$("#pwFind_mail").toggle();
		}); 
		
		//아이디 찾기
		$("#idFind").click(function() {
			if ($("#mbname").val() == "") {
				alert("이름을 입력해주세요.");
			} else {
				if ($("#mbemail").val() == "") {
					alert("이메일을 입력해주세요.");
				} else {
					$("#idFind").hide();

					if ($("#message").length) {
						$("#message").remove()
					}

					$.ajax({
						type : "POST",
						url : "IdFind_Member",
						data : {
							mbname : $("#mbname").val(),
							mbemail : $("#mbemail").val()
						},
						// 전달 값
						dataType : "json",
						// json, xml, html(text): 안쓰면 html
						timeout : "100000",
						// 타임아웃

						success : function(data) {
							// 성공
							$("#idFind").show();
							var json = JSON.stringify(data);
							var parse = JSON.parse(json);
							var text = "";

							text += "<div id=\"message\" >";
							text += parse.result;
							text += "</div>";

							$("#resutDiv").append(text);
						},

						error : function(error) { // 실패
							alert("error");

						}
					});

				}
			}
		});
		/* OTP 로 비밀번호 찾기 */
		//인증하기 버튼 클릭
		$("#otpBtn").click(function() {
			if ($("#mbid2").val() == "") {
				alert("아이디를 입력해주세요.");
			} else {
				if ($("#mbphonenumber2").val() == "") {
					alert("전화번호를 입력해주세요.");
				} else {
					$.ajax({
						type : "POST",
						url : "IdPhoneCheck",
						data : {
							mbid : $("#mbid2").val(),
							mbphonenumber : $("#mbphonenumber2").val()
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

							if (parse.result == "일치") {
								$("#passwordFind_mail").show()
								$("#otpBtn").toggle();
								$("#user_code_Div").toggle();
								$("#mbphonenumber2").attr("disabled", "true");

							} else {
								alert("아이디 또는 휴대폰번호가 일치하지 않습니다.");
							}

						},

						error : function(error) { // 실패
							alert("error");

						}
					});
				}
			}

		});

		//확인 버튼 클릭
		$("#user_otpCode").click(function() {

			$.ajax({
				type : "POST",
				url : "PwFind_Otp_Member",
				data : {
					user_code : $("#user_code").val()
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

					if (parse.result) {
						alert("인증되었습니다. 비밀번호 변경페이지로 이동합니다.");
						location.href = "http://localhost/Smart_In_Study/TurnOn_PasswordPage";
					} else {
						alert("인증번호가 일치하지 않습니다.");
					}
				},

				error : function(error) { // 실패
					alert("error");

				}
			});

		});

		//번호 재입력 버튼 클릭
		$("#phnenumResetBtn").click(function() {
			$("#otpBtn").toggle();
			$("#user_code_Div").toggle();
			$("#mbphonenumber2").removeAttr("disabled");
		});
		/* END OTP로 비밀번호 찾기 */

		/* 메일로 비밀번호 찾기 */
		//메일로 비밀번호찾기 버튼 클릭
	/* 	$("#pwFind_mailBtn").click(function() {
			$("#pwFind_mail").toggle();
		}); */
		//메일로 비밀번호 찾기
		$("#passwordFind_mail").click(function() {
			if ($("#mbname3").val() == "") {
				alert("이름을 입력해주세요.");
			} else {
				if ($("#mbid3").val() == "") {
					alert("아이디를 입력해주세요.");
				} else {
					if ($("#mbemail3").val() == "") {
						alert("이메일을 입력해주세요.");
					}
					$("#passwordFind_mail").hide();
					if ($("#messages").length) {
						$("#messages").remove()
					}

					$.ajax({
						type : "POST",
						url : "PwFind_Email_Member",
						data : {
							mbname : $("#mbname3").val(),
							mbid : $("#mbid3").val(),
							mbemail : $("#mbemail3").val()
						},
						// 전달 값
						dataType : "json",
						// json, xml, html(text): 안쓰면 html
						timeout : "100000",
						// 타임아웃

						success : function(data) {
							// 성공
							$("#passwordFind_mail").show();
							var json = JSON.stringify(data);
							var parse = JSON.parse(json);
							var text = "";

							text += "<div id=\"messages\" >";
							text += parse.result;
							text += "</div>";

							$("#pwFind_mail").append(text);

						},

						error : function(error) { // 실패
							alert("error");

						}
					});
				}
			}
		});
		/* END 메일로 비밀번호 찾기 */
	});
</script>


</head>
<body>
	<div class="container">
		<div class="row">
			<h4>아이디 찾기</h4>
			<div id="idFind_Div">
				<div class="input-group input-group-icon">
					<input id="mbname" type="text" placeholder="이름" required
						autocomplete="off" />
					<div class="input-icon">
						<i class="fa fa-user"></i>
					</div>

					<div class="input-group input-group-icon">
						<input type="text" id="mbemail" value="" placeholder="이메일"
							required autocomplete="off" />
						<div class="input-icon">
							<i class="fa fa-envelope"></i>
						</div>

						<input type="button"  id="idFind" value="확인"  style="padding-left : 0em;"/>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<h4>비밀번호 찾기 - 가입된 OTP로 찾기</h4>
			<div id="pwFind_OTP">
				<div class="input-group input-group-icon">
					<input type="text" id="mbid2" value="" placeholder="아이디" />
					<div class="input-icon">
						<i class="fa fa-user"></i>
					</div>
					<div class="input-group input-group-icon">
						<input type="text" id="mbphonenumber2" value=""
							placeholder="휴대폰번호" />
						<div class="input-icon">
							<i class="fa fa-mobile"></i>
						</div>

						<input type="button" id="otpBtn" value="인증하기" style="padding-left : 0em;" />
						<div id="user_code_Div" style="display: none">
						<!-- 	<input type="button" id="phnenumResetBtn" value="번호 재입력" /> -->
							<div class="input-group input-group-icon">
							<input type="text" value="" id="user_code" placeholder="인증번호" />
								<div class="input-icon">
						<i class="fa fa-key"></i>
					</div>
							<input type="button" value="확인" id="user_otpCode" style="padding-left : 0em;" />
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>

			<div class="row">
			
				<input type="button" id="pwFind_mailBtn" value="이메일로 비밀번호 찾기" />
				<div id="pwFind_mail" style="display: none">
				<h4>이메일로 비밀번호 찾기</h4>
					<div class="input-group input-group-icon">
					<input type="text" id="mbname3" value="" placeholder="이름" />
					<div class="input-icon">
						<i class="fa fa-user"></i>
					</div>
					
					<div class="input-group input-group-icon">
					<input type="text" id="mbid3" value="" placeholder="아이디" />
					<div class="input-icon">
						<i class="fa fa-user"></i>
					</div>
					<div class="input-group input-group-icon">
					<input type="text" id="mbemail3" value="" placeholder="이메일" />
					<div class="input-icon">
						<i class="fa fa-envelope"></i>
					</div>
					<input type="button" id="passwordFind_mail"
						value="확인" style="padding-left : 0em;"/>
					</div>	</div>	</div>	
					
					
							
						
			
		</div>
	</div>
	</div>
</body>
</html>