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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
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

</style>
<script>
	$(document).ready(function() {
		
	 	var sisJson = JSON.stringify(${dbSisBean});
		var sisParse = JSON.parse(sisJson); 

		var mbJson = JSON.stringify(${sisMemberList});
		var mbParse = JSON.parse(mbJson);

		var oneSirJson = JSON.stringify(${sisOneSirList});
		var oneSirParse = JSON.parse(oneSirJson);

		var openSirJson = JSON.stringify(${sisOpenSirList});
		var opoenSirsParse = JSON.parse(openSirJson);

		var groupSirJson = JSON.stringify(${sisGroupSirList});
		var groupSirParse = JSON.parse(groupSirJson);
	
		
		var text ="";
 		
		
		
 		if(sisParse.sisstcode=="R1"){
			text += "<h4>독서실이 오픈예정상태입니다. 정보를 등록하고 오픈하세요.</h4>";
			text += "<input type=\"button\" id=\"managementBtn\" value=\"독서실 정보 등록\"/>";
			
			$("#management").hide();
			$("#managementDiv").append(text);
			
		}else{
			// 방 종류 선택
			 $(".selectsir").click(function(){
						
						var oneSir = "";
						var openSir = "";
						var groupSir = "";
					//독립형 1인실
					if($("#selectbox option:selected").val() == "1인실"){
						for(var count = 0 ; count<10 ; count++){ 
							for(var i = 0  ; i<oneSirParse.length ; i++){
								if(oneSirParse[i].sircode=="O"+count){
								
									var j = i;
									var z = 0;
									var k = i;

									while(j<oneSirParse.length){
										if(oneSirParse[j].sircode=="O"+(count+1)){
											break;
										}
										
										
									if(z==0){
										oneSir += "<div class=\"row\">";
										oneSir += "<input type=\"text\" value=\"O"+count+"\" class=\"seetType\" style=\"cursor: not-allowed;\" readonly/>";
										oneSir += "</div>";
									}else{
										oneSir += "<input type=\"button\" id=\"half_toggle\" value=\"O"+count+z+"\" class=\"seetType\"  />";
										if(j%2==0){
											
										}
									}
									z++;
									j++;
									}
								}
							}
						}//END 독립형 1인실
					$("#oneSirDiv").append(oneSir);
				 	}else if($("#selectbox option:selected").val() == "오픈형"){
						//오픈형열람실
						for(var count = 0 ; count<10 ; count++){ 
							for(var i = 0  ; i<opoenSirsParse.length ; i++){
								if(opoenSirsParse[i].sircode=="P"+count){
									
									var j = i;
									var z = 0;
									while(j<opoenSirsParse.length){
										if(opoenSirsParse[j].sircode=="P"+(count+1)){
											break;
										}
										if(z==0){
											openSir += "<div class=\"row\">";
											openSir += "<input type=\"text\" value=\"P"+count+"\" class=\"seetType\"  style=\"cursor: not-allowed;\" readonly/>";
											openSir += "</div>";
										}else{
											openSir += "<input type=\"button\" value=\"P"+count+z+"\" class=\"seetType\"  />";
											if(z==10){
												
											}
										}
									z++;
									j++;
									}
								}
							}
						}//END 오픈형열람실
					$("#openSirDiv").append(openSir);
					}else if($("#selectbox option:selected").val() == "그룹"){
						//그룹스터디룸
						for(var count = 0 ; count<10 ; count++){ 
							for(var i = 0  ; i<groupSirParse.length ; i++){
								if(groupSirParse[i].sircode=="G"+count){
								
									var j = i;
									var z = 0;
									while(j<groupSirParse.length){
										if(groupSirParse[j].sircode=="G"+(count+1)){
											break;
										}
										if(z==0){
											groupSir += "<div class=\"row\">";
											groupSir += "<input type=\"text\" value=\"G"+count+"\" class=\"seetType\" style=\"cursor: not-allowed;\" readonly/>";
											groupSir += "</div>";
										}else{
											groupSir += "<input type=\"button\" id=\"half_toggle\" value=\"G"+count+z+"\" class=\"seetType\" />";
											if(z==4){
											
											}
										}
									z++;
									j++;
									}
								}
							}
						}//END 그룹스터디룸
					$("#groupSirDiv").append(groupSir);
					}
					$("#deletesirbtn").toggle();
					$("#createsirbtn").toggle();
				});
			 
			 $(".deletesir").click(function(){
				$(".seetType").remove();
				$(document).find("br").remove();
				$("#deletesirbtn").toggle();
				$("#createsirbtn").toggle();
				$("#paymentDiv").hide();
			 });
		}

 		//독서실 메인페이지 관리 버튼
		$("#changemainBtn").click(function(){
			location.href="TurnOn_Sis_Admin_ChangemainPage";
		});
 		
 		//회원정보 관리 버튼 
 		$("#mbinfoBtn").click(function(){
 			location.href="TurnOn_Sis_Admin_UserInfoPage";
 		});
 		$("#managementBtn").click(function(){
 			location.href="TurnOn_Sis_Admin_RegisterPage";
 		})
 		$("#salespage").click(function(){
 			location.href="TurnOn_SalesPage_Admin";
 		});
 		$("#mainpage").click(function(){
 			location.href="TurnOn_Sis_Login_MainPage";
 		});
 		$("#sensoradmin").click(function(){
 			location.href="TurnOn_Graph_Page_Admin";
 		});
 		
 		$(document).on("click",".seetType",function(){
			
			  $.ajax({
					type : "POST",
					url : "sircodecheck",
					data : {
						sircode : $(this).val()
					},
					// 전달 값
					dataType : "json",
					// json, xml, html(text): 안쓰면 html
					timeout : "5000",
					// 타임아웃
					success : function(data) {
						var json = JSON.stringify(data);
						var parse = JSON.parse(json);
						 
						if(parse.page != null){
							alert(parse.page);
						}else{
							var msg = "아이디 : "+parse.mbid+"\n";
							msg+= "시작 날짜 : "+parse.startdate+"\n";
							msg+= "종료 날짜 : "+parse.phenddate+"\n";
							msg+= "입실 상태 : "+parse.result+"\n";
							alert(msg);
						}
						
					},
					error : function(data){
						alert("error");
					}
				});
	 	 });//자리선택 END
	 	 
	 	 
	});
</script>
</head>
<body >
	<div class="container">

<a href="TurnOn_Sis_Login_MainPage"><i class="fa fa-long-arrow-left" aria-hidden="true">&nbsp 메인페이지로 이동</i></a>
	<div id="management">
	<select class="half_l" id="selectbox">
		<option value="1인실">1인실</option>
		<option value="그룹">그룹실</option>
		<option value="오픈형">오픈형</option>
	</select>
	<div id="createsirbtn">
	<input type="button" class="selectsir half_r" value="자리유형선택" />
	</div>
	<div id="deletesirbtn" style="display: none;">
	<input type="button" class="deletesir half_r" value="자리유형재선택" />
	</div>
	
	<input type="button" id="changemainBtn" value="독서실 메인페이지 관리" />
	<input type="button" id="mbinfoBtn" value="회원 정보 관리" />
	<input type="button" id="salespage" value="결제 내역 페이지" />
	<input type="button" id="sensoradmin" value="독서실 센서데이터관리" />
	
	</div>
	<div>
	<input type="button" id="mainpage" value="메인페이지" />
	<div id="managementDiv"></div>
	<div id="oneSirDiv" ></div>
	<div id="openSirDiv" ></div>
	<div id="groupSirDiv" ></div>
	</div>
	</div>
</body>
</html>