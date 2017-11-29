<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Favicon -->
<link rel="icon" href="images/favicon/favicon.ico">
<title>Smart In Study</title>
<style>
	h1,h2,h3,h4{
		padding: 0px;
		margin: 0px;
	}

	.caption-style-2{
		list-style-type: none;
		margin: 0px;
		padding: 0px;
		
	}

	.caption-style-2 li{
		float: left;
		padding: 0px;
		position: relative;
		overflow: hidden;
	}

	.caption-style-2 li:hover .caption{
		opacity: 1;
		transform: translateY(-100px);
		-webkit-transform:translateY(-100px);
		-moz-transform:translateY(-100px);
		-ms-transform:translateY(-100px);
		-o-transform:translateY(-100px);

	}


	.caption-style-2 img{
		margin: 0px;
		padding: 0px;
		float: left;
		z-index: 4;
	}


	.caption-style-2 .caption{
		cursor: pointer;
		position: absolute;
		opacity: 0;
		top:300px;
		-webkit-transition:all 0.15s ease-in-out;
		-moz-transition:all 0.15s ease-in-out;
		-o-transition:all 0.15s ease-in-out;
		-ms-transition:all 0.15s ease-in-out;
		transition:all 0.15s ease-in-out;

	}
	.caption-style-2 .blur{
		background-color: rgba(0,0,0,0.7);
		height: 300px;
		width: 400px;
		z-index: 5;
		position: absolute;
	}

	.caption-style-2 .caption-text h1{
		text-transform: uppercase;
		font-size: 18px;
	}
	.caption-style-2 .caption-text{
		z-index: 10;
		color: #fff;
		position: absolute;
		width: 400px;
		height: 300px;
		text-align: center;
		top:20px;
	}


	/** Nav Menu */
	ul.nav-menu{
		padding: 0px;
		margin: 0px;
		list-style-type: none;
		width: 490px;
		margin: 60px auto;
	}

	ul.nav-menu li{
		display: inline;
		margin-right: 10px;
		padding:10px;
		border: 1px solid #ddd;
	}

	ul.nav-menu li a{
		color: #eee;
		text-decoration: none;
		text-transform: uppercase;
	}

	ul.nav-menu li a:hover, ul.nav-menu li a.active{
		color: #2c3e50;
	} 
	/** content **/
	.content{
		margin-top: 100px;
		margin-left: 100px;
		width: 700px;
	}
	.content h1, .content h2{
		font-family: "Source Sans Pro",sans-serif;
		color: #ecf0f1;
		padding: 0px;
		margin: 0px;
		font-weight: normal;
	}

	.content h1{
		font-weight: 900;
		font-size: 64px;
	}

	.content h2{
		font-size:26px;
	}

	.content p{
		color: #ecf0f1;
		font-family: "Lato";
		line-height: 28px;
		font-size: 15px;
		padding-top: 50px;
	}

	p.credit{
		padding-top: 20px;
		font-size: 12px;
	}

	p a{
		color: #ecf0f1;
	}

	/** fork icon**/
	.fork{
		position: absolute;
		top:0px;
		left: 0px;
	}

	</style>
</head>
<body>
	
<b> 스마트폰에서 Google OTP 를 다운받아 받아주세요 </b>
	<div class="container-a2">
		<ul class="caption-style-2">
			<li>
				<img id="android-otp" src="images/android-otp.jpg" alt="안드로이드 OTP">
				<div class="caption">
					<div class="blur"></div>
					<div class="caption-text">
						<h1>Android OTP</h1>
						<p>Google Store 에서 다운받아주세요/p>
					</div>
				</div>
			</li>
			<li>
				<img id="apple-otp" src="images/apple-otp.jpg" alt="IOS OTP">
				<div class="caption">
					<div class="blur"></div>
					<div class="caption-text">
						<h1>IOS OTP</h1>
						<p>Apple Store 에서 다운받아주세요</p>
					</div>
				</div>
			</li>
		</ul>
	</div>
</body>
</html>
<!-- <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join_otp_intro</title>
</head>
<body>
<b>스마트폰의 Google Store, Apple Store에서 앱을 <br>다운받아 Qr코드를 활용해주세요.</b>
<img id="android-otp" src="images/android-otp.jpg" ><br>
<img id="apple-otp" src="images/apple-otp.jpg" >
</body>
</html> -->