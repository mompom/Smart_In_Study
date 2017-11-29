<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- Favicon -->
<link rel="icon" href="images/favicon/favicon.ico">
<title>Smart In Study</title>
<!-- ================================================
    CSS
    ================================================ -->
<link rel="stylesheet" href="css/franchise.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<link rel="stylesheet" type="text/css" href="css/normalize.css" />
		<link rel="stylesheet" type="text/css" href="css/demo.css" />
		<link rel="stylesheet" type="text/css" href="css/component.css" />
<meta charset="UTF-8">

<script>

$(document).ready(function() {
	
	$("#request_find").click(function(){
		if($("#rsname").val() == ""){
			alert("이름을 입력해주세요.");
		}else{
			if($("#rsphonenumber").val() == ""){
				alert("전화번호를 입력해주세요.");
			}else{
		$.ajax({
			type : "POST",
			url : "Request_Find",
			data : {
				rsname : $("#rsname").val(),
				rsphonenumber : $("#rsphonenumber").val()
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
				if(data == ""){
					alert("신청내역이 없습니다. 연락처를 확인해주세요.")
				}else{
				if($("#resultTable").length){$("#resultTable").remove();}
				
				var text ="";
				text += "<div id=\"resultTable\">";
				text += "<div class=\"component\">";
				text += "<table>";
				text += "<thead><tr>";
				text += "<th>번호</th>";
				text += "<th>이름</th>";
				text += "<th>휴대폰 번호</th>";
				text += "<th>현황</th>";
				text += "</tr></thead><tbody>";
				
				for(var i = 0; i<parse.length ; i++){
					text += "<tr onClick=\"request_sequence('"+i+"')\">";
					text += "<td>"+parse[i].rssequence+"</td>";
					text += "<td>"+parse[i].rsname+"</td>";
					text += "<td>"+parse[i].rsphonenumber+"</td>";
					text += "<td>"+parse[i].rsstname+"</td>";
					text += "</tr>";
					text += "<tr id=\"sequence"+i+"\" style=\"display:none\">";
					text += "<td colspan=\"4\">주소 :"+parse[i].rsaddress+"<br>요청사항<br>"+parse[i].rscontent+"</td>";
					text += "</tr>"; 
				}
				text += "</tbody></table>";
				$("#resultFrom").append(text);
				}
			},
			
			error : function(error) { // 실패
				alert("error.");

			}
		});
			}
		}
		
	});
	
		
		
	
});

function request_sequence(i){
	$("#sequence"+i).toggle();
}
</script>
</head>
<body>


	<div class="container">
	<div class="row">
		<a id="half_l" href="/Smart_In_Study/"><input type="button" value="메인페이지"></a>
		<a id="half_r" href="TurnOn_RequestPage?page=request"><input type="button"
			value="프렌차이즈 신청"></a>
			</div>
		<!-- form start -->
		<form role="form" id="register-form" autocomplete="off" action=""
			method="post">


			<div class="row">
				<h4>연락처</h4>

				<!--  이름  -->
				<div class="input-group input-group-icon">
					<input id="rsname" name="rsname" type="text" placeholder="이름" required
						autocomplete="off" />
					<div class="input-icon">
						<i class="fa fa-user"></i>
					</div>
					<span class="help-block" id="error"></span>
				</div>


					<!-- 핸드폰 번호 -->
					<div class="input-group input-group-icon">
						<input id="rsphonenumber" name="rsphonenumber" type="text" placeholder="휴대폰 번호"
							required autocomplete="off" />
						<div class="input-icon">
							<i class="fa fa-mobile"></i>
						</div>
						<span class="help-block" id="error"></span>
					</div>

			</div>
			<!-- 아임 닝겐입니다 확인  -->
			<!-- 	<div class="g-recaptcha" id="grecaptcha"
				data-sitekey="6Lc68jUUAAAAAEItKqfwFFpEXvNakkNiSQ1WFEJC"></div> -->
			<input type="button" value="확인" id="request_find" />
		</form>
		<div id="resultFrom">
		
		</div>
	</div>

</body>
<!-- ================================================
    Scripts
    ================================================ -->

<!-- jQuery Library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- Custom JS :: includes Daum Address Api-->
<script src="js/common.js"></script>
<!-- google reCapthcha -->
<script src='https://www.google.com/recaptcha/api.js'></script>

<!-- /container -->
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
		<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-throttle-debounce/1.1/jquery.ba-throttle-debounce.min.js"></script>
		<script src="js/jquery.stickyheader.js"></script>

</html>