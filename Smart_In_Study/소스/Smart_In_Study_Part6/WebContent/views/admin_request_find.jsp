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
		<link rel="stylesheet" type="text/css" href="css/normalize.css" />
		<link rel="stylesheet" type="text/css" href="css/demo.css" />
		<link rel="stylesheet" type="text/css" href="css/component.css" />
		<link rel="stylesheet" href="css/franchise.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<!-- js  common : 다음주소 포함 -->
<script src="js/common.js"></script>
<script>

	$(document).ready(function() {
		$(".request_kind").click(function(){
			$.ajax({
				type : "GET",
				url : "Admin_Request_Kind",
				data : {
					rsstcode : $(this).val(),
					page : "admin_request_find"
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
					var text ="";

					
					if($("#resultTable").length){
						$("#resultTable").remove();
					}
					
	 				if(json=="[]"){
						
					}else{
						
						text += "<div id=\"resultTable\">";
						text += "<div class=\"component\">";
						text += "<table>";
						text += "<thead><tr>";
						text += "<th>번호</th>";
						text += "<th>이름</th>";
						text += "<th>휴대폰 번호</th>";
						text += "<th>현황</th>";
						text += "</tr></thead><tbody>";
						
						for(var i = 0; i< parse.length ; i++){
							text += "<tr onClick=\"request_sequence('"+i+"')\">";
							text += "<td>"+(i+1)+"</td>";
							text += "<td>"+parse[i].rsname+"</td>";
							text += "<td>"+parse[i].rsphonenumber+"</td>";
							text += "<td>"+parse[i].rsstname+"</td>";
							text += "</tr>";
							text += "<tr id=\"sequence"+i+"\" style=\"display:none\">";
							text += "<td colspan=\"4\">주소 :"+parse[i].rsaddress;
							
						 	if(parse[i].rsstname=="신청중"){
								text += "<br>요청사항<br>"+parse[i].rscontent;
								text +="<br>";
								text += "<input type=\"button\" onClick=\"turnOn_admin_franchisee_setupPage('"+parse[i].rsaddress+"','"+parse[i].rsphonenumber+"','"+parse[i].rsdate+"')\" value=\"등록\" />"
						 	}
							text += "</td></tr>"; 
						}
						text += "</tbody></table>";
					} 
					
					$("#requestText").append(text);
					
				},

				error : function(error) { // 실패
					alert("error");

				}
			}); 
		});

		
		
	});
	
	//내용 확인
	function request_sequence(i){
		$("#sequence"+i).toggle();
	}
	
	//등록 페이지 이동
	function turnOn_admin_franchisee_setupPage(address, phonenumber, date){
		
		var form = createForm("requestSetupform","TurnOn_Admin_Franchisee_SetupPage", "post");

		
		// createObj(objType,objName, objValue,objPlaceholder);
		createObj("hidden","rsaddress",address, "");
		createObj("hidden","rsphonenumber",phonenumber, "");
		createObj("hidden","rsdate",date, "");
		createObj("hidden","page","admin_request_find", "");

		// relationObj(formName,objName);
		relationObj("requestSetupform","rsaddress");
		relationObj("requestSetupform","rsphonenumber");
		relationObj("requestSetupform","rsdate");
		relationObj("requestSetupform","page");
		
		form.submit();
	}
</script>

<Style>
body{
color:#222;
}
.request_kind{
width : 32.8%;
}

input[type=button]{
	cursor:pointer;
	
}
input[type=button]:hover{
	background-color: #31bc86;
	color: #fff;
</Style>
</head>
<body>
	
	<div class="container">
	<a href="Main_Login_Admin"><input type="button" value="메인페이지"></a>
	<input type="button" class="request_kind" value="신청중" />
	<input type="button" class="request_kind" value="오픈예정" />
	<input type="button" class="request_kind" value="오픈" />
	<div id="requestText">${requestTexts }</div>
	</div>
	
	
</body>
</html>