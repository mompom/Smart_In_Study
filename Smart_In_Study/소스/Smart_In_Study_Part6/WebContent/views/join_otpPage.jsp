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
	
	
<Script>
	$(document).ready(function() {
		$.ajax({

			type : "get",
			url : "Otp_QrCode",
			data : {
				mbphonenumber : "${mbphonenumber}"
			},

			dataType : "json",
			timeout : "5000",
			
			success : function(data) {
				// 성공
				var json = JSON.stringify(data);
				var parse = JSON.parse(json);
				var text ="";
				
				text += "<img id=\"qrImg\" src=\""+parse.url+"\" >";

				$("#container").append(text);	
			},
			// 실패
			error : function(error) {
				alert("error");
				console.log(error);
			}
		});
	});
</Script>
</head>
<body>
	<div id="container">
		 
	</div>
</body>
</html>