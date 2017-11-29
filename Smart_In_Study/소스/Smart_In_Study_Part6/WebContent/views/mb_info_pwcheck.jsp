<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Favicon -->
<link rel="icon" href="images/favicon/favicon.ico">
<title>Smart In Study</title></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="css/mb_info.css">
<style>
.sh_group{
max-width: 38em;
    padding: 1em 3em 2em 3em;
    margin: 0em auto;
    background-color: #fff;
    border-radius: 4.2px;
    box-shadow: 0px 3px 10px -2px rgba(0, 0, 0, 0.2);
}

.btn2:hover {
background-color:#f05f40;
color:#fff;
}
</style>
<script>



// 아랫 화살표(버튼처럼보이는거) 누르면 텍스트 보임 숨김
	$(document).ready(function() {
		$('.link_help').click(function() {
			$("i", this).toggleClass('.spico ico_arr3_up');
			 $(this).siblings('p').toggle();
		});
	});
	
	var RecaptchaOptions = {
	   lang : 'kr',
	   theme: 'blackglass'
	};
	
	function pwCheck(){
		
		$("#pwcheck-form").submit();
	}
</script>
</head>
<body>
<div id="content">
		<div class="column">

			<div class="sh_group " id="yj">
				<div class="sh_header">
					<h2>비밀번호 확인</h2>
					<a class="link_help"><i id="i_userInfo" class="spico ico_arr3_dn">도움말</i></a>
					<p id="profile" class="contxt" style="display: block">
					Smart In Study 에서 회원정보 수정을 위해 <em>비밀번호</em>를 재확인 부탁드립니다.
					</p>
				</div>


				<div class="sh_content">
					<form action="PwCheck" id="pwcheck-form" method="post">
					<!-- 	<input type="hidden" name="mbid" value=""> -->
						 <input id="pwcheck" type="password" name="mbpw" placeholder="password">
					</form>
				</div>
				<p class="btn_area_btm" style="text-align: center;">
					<a onclick="pwCheck()" class="btn_model"><b class="btn2">입력</b></a>
				</p>
			</div>
		</div>
		<font color="red">${message}</font>
		<!-- 멤버 업데이트. 실패시 -->
		<div class="column">
			<!-- 일반아이디 연락처 -->

		</div>
	</div>
</body>
</html>