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
	
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
	<!-- js  common : 다음주소 포함 -->
<script src="js/common.js"></script>
<!-- Daum 주소 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<link rel="stylesheet" href="css/franchise.css">
<script>
var rsaddress = "${rsaddress}";
var rsphonenumber = "${rsphonenumber}";
var count = 0;

function checkAddress(address){
	var siscode = "";
	if(address=="서울")siscode = "SEO";
	if(address=="인천")siscode = "ICN";
	if(address=="경기")siscode = "GYU";
	if(address=="강원")siscode = "GAN";
	if(address=="충북")siscode = "CHB";
	if(address=="충남")siscode = "CHN";
	if(address=="대전")siscode = "DAJ";
	if(address=="광주")siscode = "GWA";
	if(address=="전북")siscode = "JEB";
	if(address=="전남")siscode = "JEN";
	if(address=="경북")siscode = "GYB";
	if(address=="경남")siscode = "GYN";
	if(address=="대구")siscode = "DAG";
	if(address=="부산")siscode = "BUS";
	if(address=="울산")siscode = "ULS";
	if(address=="제주")siscode = "JEJ";
	
	return siscode;
}
	$(document).ready(function() {
		var address = "";
		var siscode = "";
		address = rsaddress.substring(0,2);
		
		siscode = checkAddress(address);
		
		$.ajax({
			type : "POST",
			url : "SisCode_Find",
			data : {
				siscode : siscode,
				page : "admin_franchisee_setup"
			},
			// 전달 값
			dataType : "json",
			// json, xml, html(text): 안쓰면 html
			timeout : "5000",
			// 타임아웃

			success : function(data) {
				// 성공
				 if($("#siscode").length)$("#siscode").remove(); 
				var json = JSON.stringify(data);
				var parse = JSON.parse(json);
				 var text ="<input class=\"half_l\" id=\"siscode\" type=\"text\" value=\""+parse.siscode+"\" readonly />";
				
				$("#siscodeText").append(text);
				
			},

			error : function(error) { // 실패
				alert("error");

			}
		});
		
		
		//추가버튼 클릭시
		$("#setup").click(function(){
			
			var roomType = $("select[name=roomType]").val();
			
			if 	(roomType=="방유형"){
 				alert(" 방 유형을 먼저 선택해주세요 ! ");
	 			}

			else{
					var text ="";
				
					text += "<div class=\"btn draw-border\"id=\"setupRoom"+count+"\">";
					text += "<input class=\"half_l\" type=\"text\" id=\"roomType"+count+"\" readonly value=\""+roomType+"\" />";
					text += "<select class=\"hlaf_r\" name=\"seetType"+count+"\">"
			
			
					if(roomType=="1인실"){
						text += "<optgroup label=\"1인실 자리개수\">";
						text += "<option value=\"2\">2</option>";
						text += "<option value=\"4\">4</option>";
						text += "<option value=\"6\">6</option>";
						text += "<option value=\"8\">8</option>";
						text += "<option value=\"10\">10</option>";
				
					}else if(roomType=="오픈형열람실"){
						text += "<optgroup label=\"오픈형열람실 자리개수\">";
						text += "<option value=\"10\">10</option>";
						text += "<option value=\"20\">20</option>";
						text += "<option value=\"30\">30</option>";

					}else if(roomType=="그룹스터디룸"){
						text += "<optgroup label=\"그룹스터디룸 자리개수\">";
						text += "<option value=\"4\">4</option>";
						text += "<option value=\"6\">6</option>";
						text += "<option value=\"8\">8</option>";
		
					}
					text += "</select>";
	         		text += "<input type=\"button\" onClick=\"deleteSetupRoom('"+count+"')\" value=\"삭제\" />";
	         		text += "</div>";
			 
					$("#setup_div").append(text);
					count++;
			
				}
		});
		
		//주소변경시
		$("#changePost").click(function(){
			
			var address = $("#address").val();
			var siscode = "";
			
			address = address.substring(0,2);
			
			siscode = checkAddress(address);
			
			$.ajax({
				type : "POST",
				url : "SisCode_Find",
				data : {
					siscode : siscode,
					page : "admin_franchisee_setup"
				},
				// 전달 값
				dataType : "json",
				// json, xml, html(text): 안쓰면 html
				timeout : "5000",
				// 타임아웃

				success : function(data) {
					// 성공
					if($("#siscode").length)$("#siscode").remove();
					var json = JSON.stringify(data);
					var parse = JSON.parse(json);
					var text ="<input id=\"siscode\" type=\"text\" value=\""+parse.siscode+"\" readonly />";
					
					$("#siscodeText").append(text);
					alert("주소 변경 완료"); 
				},

				error : function(error) { // 실패
					alert("error");

				}
			});
		});
	});
	
	//방 삭제 버튼 클릭
	function deleteSetupRoom(counts){
		$("#setupRoom"+counts).remove();
		count = count-1;
	}
	
	//등록버튼클릭
	function sis_setup(){
		var regExp = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
		 if($("select[name*=seetType]").is(":visible")){
			 if($("#phonenumber").val() == ""){
				 alert("휴대폰 번호가 비어있습니다. 확인해주세요.")
			 }else{
				 if ( !regExp.test($("#phonenumber").val() ) ) {
				      alert("잘못된 휴대폰 번호입니다. -를 제외한 11자리를 입력해주세요.");
				      return false
				}else{
		var roomType ="";
		for(var i = 0 ; i<count ; i++){
			roomType += $("#roomType"+i).val()+","+$("select[name=seetType"+i+"]").val()+",";
		}
		
		
	 	var address = $("#address").val() + $("#address2").val();
		var siscode = $("#siscode").val();
		var phonenumber = $("#phonenumber").val();
		
	 	var form = createForm("sis_Setupfoms","Sis_Setup", "post");

		// createObj(objType,objName, objValue,objPlaceholder);
		createObj("hidden","sisaddress",address, "");
		createObj("hidden","siscode",siscode, "");
		createObj("hidden","sisphonenumber",phonenumber, "");
		createObj("hidden","sisroomType",roomType, "");
		createObj("hidden","page", "admin_franchisee_setup","");

		// relationObj(formName,objName);
		relationObj("sis_Setupfoms","sisaddress");
		relationObj("sis_Setupfoms","siscode");
		relationObj("sis_Setupfoms","sisphonenumber");
		relationObj("sis_Setupfoms","sisroomType");
		relationObj("sis_Setupfoms","page");

		form.submit();
	}
			 }
		 } 
			 else{
		alert("좌석을 추가해주세요");
	}
		 
	}
</script>

<style>
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
</head>
<body>
	<div class="container">
		<h3>독서실 규모 설정</h3>
<div id="siscodeText" style="disply: hidden;"></div>
		<div class="row">
			<h4>방 유형 선택 ＆ 자리 개수 선택</h4>

	<div class="input-group input-group-icon">
			<select name="roomType">
			<option selected="selected"> 방유형 </option>
				<option value="1인실">1인실</option>
				<option value="오픈형열람실">오픈형열람실</option>
				<option value="그룹스터디룸">그룹스터디룸</option>
			</select>
			 <input type="button" id="setup" value="추가" class="half_r"/>
			 <div class="input-icon" id="left">
			 <i class="fa fa-plus" aria-hidden="true"></i></div>
			 	</div>
			<div id="setup_div"></div>
		</div>
	

			<!--  주소  -->
		<div class="input-group input-group-icon" style="padding-top : 8px;">

			<input type="text" id="address" placeholder="주소찾기를 눌러주세요 "
				readonly="readonly" required autocomplete="off"
				style="cursor: not-allowed;" value="${rsaddress}" />
			<div class="input-icon">
				<i class="fa fa-home"></i>
			</div>

			<div class="input-group input-group-icon" >
				<!-- 집 상세 주소 -->
				<input type="text" id="address2" placeholder="상세주소" required
					autocomplete="off" /> <input type="button" id="address3"
					onClick="Postcode()" value="주소찾기"><br> <span
					class="help-block" id="error"></span>
			</div>
		</div>

		<!-- <input type="text" placeholder="지점번호 초기 :null" value="" /><br> -->
			<div class="input-group input-group-icon" >
		<input type="text" id="phonenumber" placeholder="독서실 번호 휴대폰번호"
			value="${rsphonenumber }" /> <div class="input-icon">
					<i class="fa fa-mobile"></i>
				</div>
				</div>
		<!-- <input type="text" placeholder="사진1234 default" value="" /><br> -->
		<!-- 
<input type="text" placeholder="상태코드 default : 오픈예정" value="" /><br> -->
		<input type="button" onClick="sis_setup()" value="등록" />
	</div>
</body>
</html>