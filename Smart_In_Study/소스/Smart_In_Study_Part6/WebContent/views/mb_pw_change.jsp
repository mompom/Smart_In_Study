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
<!-- google reCapthcha -->
<script src='https://www.google.com/recaptcha/api.js'></script>
<!-- 유효성 검사  -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.js"></script>
<script src="js/mb_validation.js"></script>
<script src="js/common.js"></script>
<!-- 스타일 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="css/join.css">
<link rel="stylesheet" href="css/mb_info.css">



</head>
<body>
	<div id="content">
		<!-- section_pwconfirm -->
		<div class="section_pwconfirm" style="width: 415px;">
			<div class="spc_header">
				<h2>비밀번호 변경</h2>
				<p class="contxt">
					<a target="_blank" class="link">안전한 비밀번호로 내정보를 보호</a>하세요
				</p>
				<p class="contxt contxt_list">
					<em>다른 아이디/사이트에서 사용한 적 없는 비밀번호</em>
				</p>
				<p class="contxt contxt_list">
					<em>이전에 사용한 적 없는 비밀번호</em>가 안전합니다.
				</p>
			</div>
			<div class="spc_content">
				<form role="form" id="register-form" autocomplete="off"
					action="mb_password_change" method="post">

					<fieldset>
						<legend>비밀번호 변경</legend>
						<!--  패스워드 -->
						<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
								<span class="glyphicon glyphicon-lock"></span>
							</div>
							<div>
								<input name="mbpw" id="password" value="" type="password"
									class="form-control" placeholder="새 비밀번호">
								<input type="text" name="mbid"
											id="mbid" value="${mbid }" style="display: none;">
							</div>
						</div>
						<span class="help-block" id="error"></span>
					</div>
						<!-- 패스워드 재확인 -->
						<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
								<span class="glyphicon glyphicon-lock"></span>
							</div>
							<div>
								<input name="mbspw" value="" type="password"
									class="form-control" placeholder="새 비밀번호 확인">

							</div>
						</div>
						<span class="help-block" id="error"></span>
					</div>
						<div></div>

						<!--캡챠-->
						<div class="captcha_member">
							<div id="captcha_image_legend" style="display: block">
								<div id="image_captcha_div" class="captcha_box">
									<div class="g-recaptcha" id="grecaptcha"
										data-sitekey="6Lc68jUUAAAAAEItKqfwFFpEXvNakkNiSQ1WFEJC"></div>
								</div>
							</div>
						</div>

						<p class="btn_area_btm">
							<button type="submit" id="submit" name="changePw">확인</button>
							<button type="button" onclick="PwCheck">취소</button>
						</p>
					</fieldset>
				</form>
			</div>
		</div>
		<!-- //section_pwconfirm -->
		<div class="resize-triggers">
			<div class="expand-trigger">
				<div style="width: 955px; height: 818px;"></div>
			</div>
			<div class="contract-trigger"></div>
		</div>
	</div>
</body>
</html>