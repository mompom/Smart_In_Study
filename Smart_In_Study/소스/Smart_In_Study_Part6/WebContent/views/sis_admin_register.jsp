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
	<link rel="stylesheet" href="css/franchise.css"/>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"/>
		<link rel="stylesheet" type="text/css" href="css/normalize.css" />
		<link rel="stylesheet" type="text/css" href="css/demo.css" />
		<link rel="stylesheet" type="text/css" href="css/component.css" />
<style>
input[type=button]{
	cursor:pointer;
	
}
input[type=button]:hover{
	background-color: #31bc86;
	color:  #fff;
}

h1,h2,h3,h4,h5,h6{
color: #31bc86;
}

input:focus+.input-icon i {
	color: #31bc86;
}

input:focus+.input-icon:after {
	border-right-color: #31bc86;
}

input[type="radio"]:checked+label, input:checked+label:before, select:focus,
	select:active {
	background-color: #31bc86;
	color: #fff;
	border-color: rgba(34, 34, 34, 0.05);
}
input[type="file"]{
height: 50px;
}

</style>
	<!-- js  common : 다음주소 포함 -->
<script src="js/common.js"></script>
<script>
	$(document).ready(function() {
		
		
				var json = JSON.stringify(${dbSisBean});
				var parse = JSON.parse(json);
				var text = "";
				text += "<div class=\"row\">";
				text += "<h4>독서실 명(필수)</h4>";
				text += "<input type=\"text\" id=\"sis_name\" value=\""+parse.sisname+"\" />";
				text += "</div>";
				text += "<div class=\"row\">";
				text += "<h4>독서실 소개(필수)</h4>";
				text += "<input type=\"text\" id=\"sis_intro\" value=\"독서실 소개글을 등록해주세요.\"/>";
				text += "</div>";
				text += "<div class=\"row\">";
				text += "<h4>독서실 주소</h4>";
				text += "<input id=\"sisaddress\" type=\"text\" value=\""+parse.sisaddress+"\" readonly />";
				text += "</div>";
				text += "<div class=\"row\">";
				text += "<h4>독서실 이미지 등록(필수)</h4>";
				text += "<input class=\"half_6\" type=\"file\" name=\"sisimg1\"/>";
				text += "<input class=\"half_4\" type=\"text\" value=\"메인 이미지\" readonly />";
				text += "<input class=\"half_6\" type=\"file\" name=\"sisimg2\"/>";
				text += "<input class=\"half_4\" type=\"text\" value=\"독립형 1인실 이미지\" readonly />";
				text += "<input class=\"half_6\" type=\"file\" name=\"sisimg3\"/>";
				text += "<input class=\"half_4\" type=\"text\" value=\"오픈형 스터디룸 이미지\" readonly />";
				text += "<input class=\"half_6\" type=\"file\" name=\"sisimg4\" />";
				text += "<input class=\"half_4\" type=\"text\" value=\"그룹 스터디룸 이미지\" readonly />";
				text += "</div>";
				text += "<div class=\"row\" style\"padding-top: 10px;\">";
				text += "<h4>독서실 전화번호 등록(선택)</h4>";
				text +=	"<input type=\"text\" id=\"sis_number\" placeholder=\"독서실 전화번호\" />";
				text += "<h4>독서실  관리자 휴대폰 번호(필수)</h4>";
				text += "<input type=\"text\" id=\"sis_phonenumber\" value=\""+parse.sisphonenumber+"\" />";
				text += "</div>";
				text += "<div class=\"row\">";
				text += "<h4>독서실 방 가격설정(필수)</h4>";
				text += "독립형 1인실 (₩/일)  <input type=\"text\" name=\"oneSirPrice\" value=\"\"/> ";
				text += "오픈형 열람실 (₩/일) <input type=\"text\" name=\"openSirPrice\" value=\"\"/>";
				text += "그룹 스터디룸 (₩/일) <input type=\"text\" name=\"groupSirPrice\" value=\"\"/>";
				text += "</div>";
				$("#registerDiv").append(text);
			
	
		
		$("#sis_admin_registerBtn").click(function(){
			
			var sisname = $("#sis_name").val();
			var sisintro = $("#sis_intro").val();
			var sisnumber = "";
			if($("#sis_number").val()==""){}else{sisnumber = $("#sis_number").val();}
			var sisphonenumber = $("#sis_phonenumber").val();
			var sisaddress = $("#sisaddress").val();
				
			var form = document.createElement("form");
			form.name = "registerforms";
			form.method = "post";
			form.action = "Sis_Register";
			form.enctype = "multipart/form-data";
			document.body.appendChild(form);
			
			
			// createObj(objType,objName, objValue,objPlaceholder);
			createObj("hidden","sisname",sisname, "");
			createObj("hidden","sisintro",sisintro, "");
			createObj("hidden","sisnumber",sisnumber, "");
			createObj("hidden","sisphonenumber",sisphonenumber, "");
			createObj("hidden","sisaddress",sisaddress, "");
			createObj("hidden","page", "sis_admin_register","");

			// relationObj(formName,objName);
			relationObj("registerforms","sisname");
			relationObj("registerforms","sisintro");
			relationObj("registerforms","sisphonenumber");
			relationObj("registerforms","sisaddress");
			relationObj("registerforms","sisnumber");
			relationObj("registerforms","sisimg1");
			relationObj("registerforms","sisimg2");
			relationObj("registerforms","sisimg3");
			relationObj("registerforms","sisimg4");
			relationObj("registerforms","oneSirPrice");
			relationObj("registerforms","openSirPrice");
			relationObj("registerforms","groupSirPrice");
			relationObj("registerforms","page");
			
			form.submit();
			
		});

	});
	


</script>
</head>
<body>
<div class="container">
<h1>독서실 관리자 전용 독서실 등록 페이지</h1>
<div id="registerDiv" ></div>
<div class="row">
<input type="button" id="sis_admin_registerBtn" value="등록" style="margin-top: 20px;" />
</div>
</div>
</body>
</html>