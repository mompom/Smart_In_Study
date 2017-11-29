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
<script src="js/common.js"></script>
<link rel="stylesheet" href="css/franchise.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<link rel="stylesheet" type="text/css" href="css/normalize.css" />
		<link rel="stylesheet" type="text/css" href="css/demo.css" />
		<link rel="stylesheet" type="text/css" href="css/component.css" />
		
		<style>
		h3{
		color:#31bc86;
		}
		</style>
<script>
$(document).ready(function() {
	var memberJson = JSON.stringify(${dbMemberBean});
	var memberParse = JSON.parse(memberJson); 
	var text="";
	text += "<div id=\"resultTable\">";
	text += "<div class=\"component\">";
	text +="<table>";
	text += "<thead><tr>";
	text +="<th>아이디</th>";
	text +="<th>이름</th>";
	text +="<th>닉네임</th>";
	text +="<th>성별</th>";
	text +="<th>자리번호</th>";
	text +="</tr></thead><tbody>";
	
		for(var i = 0 ; i<memberParse.length ; i++ ){
			if((memberParse[i].mbid).indexOf('Admin')!=-1){
				
			}else{
			text +="<tr onClick=\"showSoundSensor('"+i+"')\">";
			text +="<td>"+memberParse[i].mbid+"</td>";
			text +="<td>"+memberParse[i].mbname+"</td>";
			text +="<td>"+memberParse[i].mbnick+"</td>";
			text +="<td>"+memberParse[i].mbgender+"</td>";
			text +="<td>"+memberParse[i].sircode+"</td>";
			text +="<tr id=\"memberSound"+i+"\" style=\"display:none;\"><td colspan=\"5\"></td><tr>";
			text +="</tr>"
			}
		}
	text +="</tbody></table>";
	
	$("#userinfo").append(text);
	
});

function showSoundSensor(i){
	$("#memberSound"+i).toggle();
}
</script>
</head>
<body>
<div class="container">
<a href="TurnOn_Sis_Admin_ManagementPage"><i class="fa fa-long-arrow-left" aria-hidden="true">&nbsp 이전페이지 이동</i></a>
			<div class="row">
				<h3>회원 명단</h3>
	<div id="userinfo"></div>
	</div>
	</div>
</body>
</html>