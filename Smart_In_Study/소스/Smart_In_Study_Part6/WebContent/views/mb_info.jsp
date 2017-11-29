<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <meta http-equiv="refresh" content="5;url=http://localhost/Smart_In_Study/" /> -->
<!-- Favicon -->
<link rel="icon" href="images/favicon/favicon.ico">
<title>Smart In Study</title>
</head>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="css/mb_info.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<style>
#yjj {
	height: 185px;
	overflow: scroll;
	overflow-x: hidden;
}

* {
	font-family: 'Open Sans', 'Helvetica Neue', Arial, sans-serif;
}

.btn2:hover, b:hover , b.btn2:hover{
background-color: #f05f40;
color: white;
}
</style>
<script>
	
	// 아랫 화살표(버튼처럼보이는거) 누르면 텍스트 보임 숨김
	$(document).ready(function() {
		var mbphonenumber = "${mbphonenumber }";
		mbphonenumber = mbphonenumber.replace(/\D/g, '');
		mbphonenumber = "<br>"+mbphonenumber.slice(0,3)+"-"+mbphonenumber.slice(3,7)+"-"+mbphonenumber.slice(7,15); 
		
		$("#mbphone").append(mbphonenumber);
		
		$('.link_help').click(function() {
			$("i", this).toggleClass('.spico ico_arr3_up');
			$(this).siblings('p').slideToggle();
		});
		$("#logout").click(function() {
			$.ajax({

				type : "POST",
				url : "Logout",
				dataType : "HTML",
				timeout : "5000",
				data : {
					mbid : $("#mbid").val()
				},
				success : function(data) {
					// 성공
					alert("로그아웃 완료");
					location.href = "http://localhost/Smart_In_Study/";
				},

				error : function(error) { // 실패
					console.log(error);
				}
			});

		});
	});

	function info_formSubmit(obj) {
		
		switch (obj) {

		case "profilepage":
			$("#profilepageform").submit();
			break;
		case "contactpage":
			$("#contactpageform").submit();
			break;
		case "contactpage":
			$("#contactpageform").submit();
			break;
		case "logout":
			$("#logoutform").submit();
		default:
			break;
		}
	}
</script>
<style>
#yjj {
	height: 185px;
	overflow: scroll;
	overflow-x: hidden;
}

button:hover , .btn2:hover , b.btn2:hover {
background-color: #f05f40;
color: white;
}
</style>
<body>
<p class="desc_sub">
<a class="more" href="TurnOn_Sis_Login_MainPage"><i class="fa fa-long-arrow-left" aria-hidden="true">&nbsp 이전페이지 이동</i></a></p>
	<div id="content" class="section_home">
		<div class="column">

			<!-- 프로필 설정 -->
			<div class="sh_group">
				<form id="profilepageform" action="TurnOn_ProfilePage" method="POST">
					<div class="sh_header">
						<h2>프로필</h2>
						<a class="link_help"><i id="i_profile"
							class="spico ico_arr3_dn">도움말</i></a>
						<!-- [D] 감추기 보이기 dislay:none/block -->
						<p id="profile" class="contxt" style="display: none">
							Smart In Study 에서의 <em>'나'를 표현하는 프로필</em> 정보입니다. <br> 수정
							화면에서 프로필 사진과 별명을 변경하세요.
						</p>
					</div>
					<div class="sh_content">
						<dl class="sh_lst">
							<dt class="blind">프로필 사진</dt>
							<dd class="pic_desc">
								<a href="#"
									onclick="changeImage();clickcr(this,'imn.prfmodify','','',event);">
									<img
									src="https://phinf.pstatic.net/contact/20171009_45/1507481223609hwkx4_PNG/image.png?type=s160"
									width="80" height="80" alt=""> <span
									class="spimg img_frame"></span>
								</a>
							</dd>
							<dt class="blind">&nbsp;</dt>
							<dd class="intro_desc">&nbsp;</dd>
							<dt class="nic_tit">아이디</dt>
							<dd class="nic_desc">${mbid }</dd>
							<dt class="nic_tit">별명</dt>
							<dd class="nic_desc">${mbnick }</dd>
							<dt class="nic_tit">
								비밀번호 <a href='TurnOn_PasswordPage'>변경하기</a>
							</dt>
						</dl>
					</div>
					<p class="btn_area_btm">
						<a href='javascript:void(0);' class="btn_model"
							onclick="info_formSubmit('profilepage')"><b class="btn2">수정</b></a>
					</p>
				</form>
			</div>
			<!-- -------------------------------------------------------------------------------------------------------------------- -->
			<!-- 활동로그 -->
			<div class="sh_group">
				<div class="sh_header">
					<h2>입&퇴실 기록</h2>
					<a class="link_help"><i id="i_region" class="spico ico_arr3_dn">도움말</i></a>
					<p id="profile" class="contxt" style="display: none">
						Smart In Study 에서 <em>중요 내용을 알려드릴 때 사용</em>하는 연락처 정보입니다. 보다 안전한 정보
						보호를 위해 등록된 연락처의 일부만 보여드립니다. 이름 및 정확한 연락처 정보는 수정 화면에서 확인 가능합니다.
					</p>
				</div>
				<div class="sh_content">
					<dl class="sh_lst2">
						<dd>${inouthistory }</dd>
					</dl>
				</div>
			</div>
			<!-- -------------------------------------------------------------------------------------------------------------------- -->
		</div>
		<div class="column">
			<!-- 연락처 -->
			<div class="sh_group ">
				<form id="contactpageform" action="TurnOn_ContactPage" method="POST">
					<div class="sh_header">
						<h2>연락처</h2>
						<a class="link_help"><i id="i_region"
							class="spico ico_arr3_dn">도움말</i></a>
						<p id="profile" class="contxt" style="display: none">
							Smart In Study 에서 <em>중요 내용을 알려드릴 때 사용</em>하는 연락처 정보입니다. 보다 안전한
							정보 보호를 위해 등록된 연락처의 일부만 보여드립니다. 이름 및 정확한 연락처 정보는 수정 화면에서 확인 가능합니다.
						</p>
					</div>
					<div class="sh_content">
						<dl class="sh_lst2">
							<dt>기본 이메일</dt>
							<dd>${mbemail}</dd>
							<dt>휴대전화</dt>
							<dd>${mbphonenumber }</dd>
							<dt>주소</dt>
							<dd>${mbaddress}</dd>
						</dl>
					</div>
					<p class="btn_area_btm">
						<a href='javascript:void(0);' class="btn_model"
							onclick="info_formSubmit('contactpage')"><b class="btn2">수정</b></a>
					</p>
				</form>
			</div>

			<!-- -------------------------------------------------------------------------------------------------------------------- -->
			<!-- 웹사이트 로그 -->
			<div class="sh_group" id="yjj">
				<div class="sh_header">
					<h2>로그인 기록</h2>
					<a class="link_help"><i id="i_region" class="spico ico_arr3_dn">도움말</i></a>
					<p id="profile" class="contxt" style="display: none">
						Smart In Study 에서 <em>로그인 ＆ 로그아웃 기록</em>입니다. 보다 안전한 정보 보호를 위해 등록된
						연락처의 일부만 보여드립니다. 이름 및 정확한 연락처 정보는 수정 화면에서 확인 가능합니다.
					</p>
				</div>
				<div class="sh_content">
					<dl class="sh_lst2">
						<dd>${historylog }</dd>
					</dl>
				</div>
			</div>
		</div>


		<p class="desc_sub">
			Smart In Study 를 더 이상 이용하지 않는다면 <a class="more">회원탈퇴 바로가기</a>
		</p>
		<form id="logoutform" action="Logout" method="POST">
			<p class="desc_sub">
				<input type="text" name="mbid" id="mbid" value="${mbid }"
					style="display: none;"> <a href='' class="more" onclick=""
					id="logout">로그아웃</a>
			</p>
		</form>
		<div class="resize-triggers">
			<div class="expand-trigger">
				<div style="width: 955px; height: 701px;"></div>
			</div>
			<div class="contract-trigger"></div>

		</div>
	</div>
</body>
</html>