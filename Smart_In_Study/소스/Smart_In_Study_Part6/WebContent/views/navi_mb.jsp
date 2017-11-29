<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="SIS 메인 페이지">
<meta name="author" content="HelloWorld">
<!-- <meta http-equiv="refresh" content="5;url=http://localhost/test/join.html" /> -->
<!--  위에 있는거 사용하면 5초마다 페이지 리프레쉬 됨 다른 페이지로 바꿀수도있음 -->
<!-- Favicon -->
<link rel="icon" href="images/favicon/favicon.ico">
<title>Smart In Study</title>
<!-- 제이쿼리 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Bootstrap core CSS -->
<link href="style/mainpage/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="style/mainpage/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic'
	rel='stylesheet' type='text/css'>

<!-- Plugin CSS -->
<link href="style/mainpage/magnific-popup/magnific-popup.css"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="style/mainpage/creative.min.css" rel="stylesheet">
<link href="style/mainpage/main_footer.css" rel="stylesheet">

<!-- 나눔 스퀘어 라운드 폰트 -->
<link rel="stylesheet"
	href="https://cdn.rawgit.com/studio392/NanumSquareRound/master/NanumSquareRound.css" />
<!-- 겔러리 -->
<link href="https://fonts.googleapis.com/css?family=Droid+Sans:400,700"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.8.1/baguetteBox.min.css">
<link rel="stylesheet" href="style/mainpage/thumbnail-gallery.css">


<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
	<div class="container">
		<a class="navbar-brand js-scroll-trigger" id="title" href="#page-top">
			<%-- $("#title").append 타이틀 위치--%>
		</a>
		<button class="navbar-toggler navbar-toggler-right" type="button"
			data-toggle="collapse" data-target="#navbarResponsive"
			aria-controls="navbarResponsive" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>


		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="TurnOn_InfoPage">마이인포</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="TurnOn_Graph_Page">센서페이지</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="TurnOn_AccountPage_Member">결제하기</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="TurnOn_InfoPage"><i class="fa fa-user"
						aria-hidden="true"></i>${mbid }님</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="Logout?page=sis_main"><i class="fa fa-sign-out"
						aria-hidden="true"></i>로그아웃</a></li>
			</ul>
		</div>
	</div>
</nav>



<!-- Bootstrap core JavaScript -->
<script src="style/mainpage/jquery/jquery.min.js"></script>
<script src="style/mainpage/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Plugin JavaScript -->
<script src="style/mainpage/jquery-easing/jquery.easing.min.js"></script>
<script src="style/mainpage/scrollreveal/scrollreveal.min.js"></script>
<script src="style/mainpage/magnific-popup/jquery.magnific-popup.min.js"></script>

<!-- Custom scripts for this template -->
<script src="style/mainpage/creative.min.js"></script>