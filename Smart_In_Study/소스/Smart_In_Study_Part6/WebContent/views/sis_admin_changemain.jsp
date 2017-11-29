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
	<link rel="stylesheet" href="css/franchise.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
	<script src="js/common.js"></script>
	<style>
	body {
	color : #5a5a5a;
	}
	a{
	color: #333;
	text-decoration: none;
	cursor:pointer;
	}
	img{
	display: block;
    width: 100%;
    height: 180px;
    text-align: center;
    margin: 0 auto;
	}
#left {
left : 50%;
}
.half_l{
padding-left : 0em!important;
text-align : center;
}

select {
text-align-last: center;
}

input[type=button]{
	cursor:pointer;
	
}
input[type=button]:hover{
	background-color: #31bc86;
	color:  #fff;
}

h1,h2,h3,h4,h5,h6{
color: #31bc86;
padding-top : 55px;
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
height: 46px;
}

select option {
	background-color: #31bc86;
	color: #fff;
}



/*  보더 라인  */

.draw-border {
  box-shadow: inset 0 0 0 4px #17d83d45;
  color: #17d83d45;
  -webkit-transition: color 0.25s 0.08333s;
  transition: color 0.25s 0.08333s;
  position: relative;
}
.draw-border::before, .draw-border::after {
  border: 0 solid transparent;
  box-sizing: border-box;
  content: '';
  pointer-events: none;
  position: absolute;
  width: 0;
  height: 0;
  bottom: 0;
  right: 0;
}
.draw-border::before {
  border-bottom-width: 4px;
  border-left-width: 4px;
}
.draw-border::after {
  border-top-width: 4px;
  border-right-width: 4px;
}
.draw-border:hover {
  color: #ffe593;
}
.draw-border:hover::before, .draw-border:hover::after {
  border-color: #ffe593;
  -webkit-transition: border-color 0s, width 0.25s, height 0.25s;
  transition: border-color 0s, width 0.25s, height 0.25s;
  width: 100%;
  height: 100%;
}
.draw-border:hover::before {
  -webkit-transition-delay: 0s, 0s, 0.25s;
          transition-delay: 0s, 0s, 0.25s;
}
.draw-border:hover::after {
  -webkit-transition-delay: 0s, 0.25s, 0s;
          transition-delay: 0s, 0.25s, 0s;
}

.btn {
  background: none;
  border: none;
  cursor: pointer;
  line-height: 1.5;
  font: 700 1.2rem 'Roboto Slab', sans-serif;
  padding: 4px 4px;
  letter-spacing: 0.05rem;
}
.btn:focus {
  outline: 2px dotted #55d7dc;
}
</style>
<script>
	$(document).ready(function() {
		var sisJson = JSON.stringify(${dbSisBean});
		var sisParse = JSON.parse(sisJson); 
		
		var sisnintroText ="";
		sisnintroText += "<div =\"row\">";
		sisnintroText += "<h4 style=\"padding-top:0px;\">독서실 소개</h4>";
		sisnintroText += "<input class=\"half_6\" type=\"text\" id=\"sisintroText\" value=\""+sisParse[0].sisintro+"\" readonly />";
		sisnintroText += "<input class=\"half_6\" type=\"text\" id=\"sisintroText2\" value=\"\" style=\"display:none;\"/>";
		sisnintroText += "<input class=\"half_4\" type=\"button\" id=\"sisintroChangeBtn\" value=\"수정\" />";
		sisnintroText += "<input class=\"half_2\" type=\"button\" id=\"sisintroChangeBtn2\" value=\"수정완료\" style=\"display:none\"/>";
		sisnintroText += "<input class=\"half_2\" type=\"button\" id=\"sisintroChangeBtn3\" value=\"취소\" style=\"display:none\"/>";
		sisnintroText += "</div>";
		$("#sisintroDiv").append(sisnintroText);
		
		var sisimg1Text ="";
		sisimg1Text += "<div =\"row\">";
		sisimg1Text += "<h4>메인페이지 이미지</h4>";
		sisimg1Text +="<img id=\"sisimg1\" src=\"images/"+sisParse[0].siscode+"/"+sisParse[0].sisimg1+"\">";
		sisimg1Text +="<input class=\"half_6\" type=\"file\" name=\"sisimg1\" />";
		sisimg1Text +="<input class=\"half_4\" type=\"button\" id=\"sisimg1ChangeBtn\" value=\"수정\" />";
		sisimg1Text +="</div>";
		$("#sisimg1Div").append(sisimg1Text);
		
		var sisimg2Text ="";
		sisimg2Text +="<div =\"row\">";
		sisimg2Text +="<h4>독립형 1인실</h4>";
		sisimg2Text +="<img id=\"sisimg2\" src=\"images/"+sisParse[0].siscode+"/"+sisParse[0].sisimg2+"\">";
		sisimg2Text +="<input class=\"half_6\" type=\"file\" name=\"sisimg2\" />";
		sisimg2Text +="<input class=\"half_4\" type=\"button\" id=\"sisimg2ChangeBtn\" value=\"수정\" />";
		sisimg2Text +="</div>";
		$("#sisimg2Div").append(sisimg2Text);
		
		var sisimg3Text ="";
		sisimg3Text +="<div =\"row\">";
		sisimg3Text +="<h4>오픈형 열람실</h4>";
		sisimg3Text +="<img id=\"sisimg3\" src=\"images/"+sisParse[0].siscode+"/"+sisParse[0].sisimg3+"\">";
		sisimg3Text +="<input class=\"half_6\" type=\"file\" name=\"sisimg3\" />";
		sisimg3Text +="<input class=\"half_4\" type=\"button\" id=\"sisimg3ChangeBtn\" value=\"수정\" />";
		sisimg3Text +="</div>";
		$("#sisimg3Div").append(sisimg3Text);
			
		var sisimg4Text ="";
		sisimg4Text +="<div =\"row\">";
		sisimg4Text +="<h4>그룹 스터디룸</h4>";
		sisimg4Text +="<img id=\"sisimg4\" src=\"images/"+sisParse[0].siscode+"/"+sisParse[0].sisimg4+"\">";
		sisimg4Text +="<input class=\"half_6\" type=\"file\" name=\"sisimg4\" />";
		sisimg4Text +="<input class=\"half_4\" type=\"button\" id=\"sisimg4ChangeBtn\" value=\"수정\" />";
		sisimg4Text +="</div>";
		$("#sisimg4Div").append(sisimg4Text);
		
		var sisphonenumberText ="";
		sisphonenumberText +="<div =\"row\">";
		sisphonenumberText +="<h4>독서실 담당자 번호</h4>";
		sisphonenumberText += "<input class=\"half_6\" type=\"text\" id=\"sisphonenumberText\" value=\""+sisParse[0].sisphonenumber+"\" readonly />";
		sisphonenumberText += "<input class=\"half_6\" type=\"text\" id=\"sisphonenumberText2\" value=\"\" style=\"display:none;\"/>";
		sisphonenumberText += "<input class=\"half_4\" type=\"button\" id=\"sisphonenumberChangeBtn\" value=\"수정\" />";
		sisphonenumberText += "<input class=\"half_2\" type=\"button\" id=\"sisphonenumberChangeBtn2\" value=\"수정완료\" style=\"display:none\"/>";
		sisphonenumberText += "<input class=\"half_2\" type=\"button\" id=\"sisphonenumberChangeBtn3\" value=\"취소\" style=\"display:none\"/>";
		sisphonenumberText +="</div>";
		$("#sisphonenumberDiv").append(sisphonenumberText);
		
		//소개 수정버튼
		$("#sisintroChangeBtn").click(function(){
			$("#sisintroText").toggle();
			$("#sisintroText2").toggle();
			$("#sisintroText2").focus();
			$("#sisintroChangeBtn").toggle();
			$("#sisintroChangeBtn2").toggle();
			$("#sisintroChangeBtn3").toggle();
		});
		
		//취소버튼 클릭
		$("#sisintroChangeBtn3").click(function(){
			$("#sisintroChangeBtn").toggle();
			$("#sisintroChangeBtn2").toggle();
			$("#sisintroChangeBtn3").toggle();
			$("#sisintroText").toggle();
			$("#sisintroText2").toggle();
		});
		
		//수정완료버튼 클릭
		$("#sisintroChangeBtn2").click(function(){
			if($("#sisintroText2").val() == ""){
				alert("독서실 소개칸이 비어있습니다. 확인해주세요.");
			}else{
			$.ajax({
				type : "POST",
				url : "Sis_Admin_ChangeMain_Intro",
				data : {
					sisintro : $("#sisintroText2").val()
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
					
					if($("#notice").length){$("#notice").remove()}
					
					$("#noticeDiv").append(parse.result);
					$("#sisintroText").toggle();
					$("#sisintroText2").toggle();
					$("#sisintroText").val(parse.sisintro);
					$("#sisintroChangeBtn").toggle();
					$("#sisintroChangeBtn2").toggle();
					$("#sisintroChangeBtn3").toggle();
					
				},

				error : function(error) { // 실패
					alert("error");

				}
			});
			}
		});
		
		
		//메인페이지 이미지 수정
		$("#sisimg1ChangeBtn").click(function(){
			if($("input[name=sisimg1]").val() == ""){
			alert("선택된 이미지가 없습니다. 이미지를 선택해주세요.");
			}else{
			var form = document.createElement("form");
			form.name = "changeimgforms";
			form.method = "post";
			form.action = "Sis_Admin_ChangeMain_Img";
			form.enctype = "multipart/form-data";
			document.body.appendChild(form);

			createObj("hidden","page", "sisimg1","");

			relationObj("changeimgforms","sisimg1");
			relationObj("changeimgforms","page");

			form.submit();
			}
		});
		
		//독립형 1인실 이미지 수정
		$("#sisimg2ChangeBtn").click(function(){
			if($("input[name=sisimg2]").val() == ""){
				alert("선택된 이미지가 없습니다. 이미지를 선택해주세요.");
				}else{
			var form = document.createElement("form");
			form.name = "changeimgforms";
			form.method = "post";
			form.action = "Sis_Admin_ChangeMain_Img";
			form.enctype = "multipart/form-data";
			document.body.appendChild(form);

			createObj("hidden","page", "sisimg2","");

			relationObj("changeimgforms","sisimg2");
			relationObj("changeimgforms","page");

			form.submit();
				}
		});
		
		//오픈형 열람실 이미지 수정
		$("#sisimg3ChangeBtn").click(function(){
			if($("input[name=sisimg3]").val() == ""){
				alert("선택된 이미지가 없습니다. 이미지를 선택해주세요.");
				}else{
			var form = document.createElement("form");
			form.name = "changeimgforms";
			form.method = "post";
			form.action = "Sis_Admin_ChangeMain_Img";
			form.enctype = "multipart/form-data";
			document.body.appendChild(form);

			createObj("hidden","page", "sisimg3","");

			relationObj("changeimgforms","sisimg3");
			relationObj("changeimgforms","page");

			form.submit();
				}
		});
		
		//그룹스터디룸 이미지 수정
		$("#sisimg4ChangeBtn").click(function(){
			if($("input[name=sisimg4]").val() == ""){
				alert("선택된 이미지가 없습니다. 이미지를 선택해주세요.");
				}else{
			var form = document.createElement("form");
			form.name = "changeimgforms";
			form.method = "post";
			form.action = "Sis_Admin_ChangeMain_Img";
			form.enctype = "multipart/form-data";
			document.body.appendChild(form);

			createObj("hidden","page", "sisimg4","");

			relationObj("changeimgforms","sisimg4");
			relationObj("changeimgforms","page");

			form.submit();
				}
		});
		
		
		//담당자 수정버튼
		$("#sisphonenumberChangeBtn").click(function(){
			$("#sisphonenumberText").toggle();
			$("#sisphonenumberText2").toggle();
			$("#sisphonenumberText2").focus();
			$("#sisphonenumberChangeBtn").toggle();
			$("#sisphonenumberChangeBtn2").toggle();
			$("#sisphonenumberChangeBtn3").toggle();
		});
		
		//담당자 취소버튼 클릭
		$("#sisphonenumberChangeBtn3").click(function(){
			$("#sisphonenumberChangeBtn").toggle();
			$("#sisphonenumberChangeBtn2").toggle();
			$("#sisphonenumberChangeBtn3").toggle();
			$("#sisphonenumberText").toggle();
			$("#sisphonenumberText2").toggle();
		});
		
		//담당자 번호 수정 완료 버튼
		$("#sisphonenumberChangeBtn2").click(function(){
			if($("#sisphonenumberText2").val() == ""){
				alert("담당자 번호 수정칸을 확인해주세요.");
			}else{
			$.ajax({
				type : "POST",
				url : "Sis_Admin_ChangeMain_Phonenumber",
				data : {
					sisphonenumber : $("#sisphonenumberText2").val()
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
					
					if($("#notice").length){$("#notice").remove()}
					
					$("#noticeDiv").append(parse.result);
					$("#sisphonenumberText").toggle();
					$("#sisphonenumberText2").toggle();
					$("#sisphonenumberText").val(parse.sisphonenumber);
					$("#sisphonenumberChangeBtn").toggle();
					$("#sisphonenumberChangeBtn2").toggle();
					$("#sisphonenumberChangeBtn3").toggle();
					
				},

				error : function(error) { // 실패
					alert("error");

				}
			});
			}
			
		});
		
	});
	
	
</script>
</head>
<body>
<div class="container" style="padding-bottom: 100px;">
		
	<a href="TurnOn_Sis_Admin_ManagementPage" ><i class="fa fa-long-arrow-left" aria-hidden="true">&nbsp 이전페이지 이동</i></a>
	<div id="noticeDiv">${message}</div> 
	<div id="sisintroDiv" style="width:100%"></div>
	<div id="sisphonenumberDiv"></div>
	<div id="sisimg1Div"></div>
	<div id="sisimg2Div"></div>
	<div id="sisimg3Div"></div>
	<div id="sisimg4Div"></div>
	
	</div>
</body>
</html>