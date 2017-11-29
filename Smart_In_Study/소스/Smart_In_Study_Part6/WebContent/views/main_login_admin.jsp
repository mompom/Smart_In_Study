<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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


<!-- Locator Jquery -->
<script>
	$(document).ready(function() {
		if("${mbid}"=="SisAdmin"){
			$("#logoutBtn").toggle();
		}
		
		$("#bo_cate_ul li a").bind("click", function() {
			if ($("a.pyj").length)
				$("a.pyj").removeClass('pyj');
			// pyj 클래스가 존재한다면 pyj 클래스 삭제
			$(this).addClass('pyj');
			// 클릭된 이것에 pyj 클래스 추가 
			$.ajax({
				type : "POST",
				url : "SelectLocation",
				data : {
					siscode : $(this).attr("id")
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
					var text  ="";
					
					if ($("#sisText").length)
						$("#sisText").remove();
					
					// id = sisText div가 존재한다면 div 삭제
					text += "<div class=\"row\" id=\"sisText\">";
					for(var i = 0 ; i<parse.length ; i++){
						
							text += "<div class=\"col-sm-6 col-md-4\">";
							text += "<div class=\"thumbnail\">";
							text += "<a class=\"lightbox\" href=\"TurnOn_SelectSisPage?siscode="+parse[i].siscode+"\">";
							if(parse[i].sisimg1=="comingsoon.jpg"){
								text += "<img src=\"images/comingsoon.jpg\" alt=\"\" ></a>";
							}else{
								text += "<img src=\"images/"+parse[i].siscode+"/"+parse[i].sisimg1+"\" alt=\"\" ></a>";
							}
							text += "<div class=\"caption\">";
							text += "<h3>" + parse[i].sisname + "</h3>";
							text += "</div>";
							text += "</div></div>";
						
					}
					text += "</div>";
					
					$(".tz-gallery").append(text);
					
				},

				error : function(error) { // 실패
					alert("error");

				}
			});

		});
	});
	
</script>
</head>

<body id="page-top">

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top"
		id="mainNav">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger" href="#page-top">smart
				In Study</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#about">소개</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#services">서비스</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#portfolio">이미지</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#contact">연락처</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="TurnOn_Admin_Franchisee_FindPage">프렌차이즈 요청 확인</a></li>
					<li class="nav-item" id="logoutBtn" style="display:none" >
					<a class="nav-link js-scroll-trigger"
						id="modal_trigger" href="Logout?page=main">로그아웃</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<header class="masthead">
		<div class="header-content">
			<div class="header-content-inner">
				<h1 id="homeHeading">Smart In Study 에 오신것을 환영합니다.</h1>
				<hr>
				<p>기존의 독서실 회원 관리 프로그램에 센서 데이터를 접목시켜 다양한 센서데이터를 한 눈에 시각화 하여 더 많은
					서비스를 편리하게 이용할수 있게 해드리겠습니다.</p>
				<a class="btn btn-primary btn-xl js-scroll-trigger" href="#about">더
					알고싶다면</a>
			</div>
		</div>
	</header>

	<section class="bg-primary" id="about">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 mx-auto text-center">
					<h2 class="section-heading text-white">SMART IN STUDY</h2>
					<hr class="light">
					<p class="text-faded">현재 독서실은 새로운 페러다임을 맞이하고 있습니다. 기존의 많은 독서실이
						프리미엄화 되어 가고 있고 새로운 기능이 추가 되고 있으며 독서실을 찾는 고객도 변화가 있습니다. 학생 뿐만 아니라
						자기개발을 하고자 하는 직장인, 새롭게 창업을 준비하는 1인 창업가, 과외 선생님과 학생 등 다변화되고 있습니다.
						이러한 분위기를 읽고 트랜드를 리드해야 합니다. 온더데스크는 트랜드를 선도하는 최고의 독서실을 만들고자 합니다.
						성공적인 창업을 위해 여러분과 함께 하겠습니다.</p>
					<a class="btn btn-default btn-xl js-scroll-trigger"
						href="#services">저희와 함께해주세요!</a>
				</div>
			</div>
		</div>
	</section>

	<section id="services">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading">At Your Service</h2>
					<hr class="primary">
				</div>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-md-6 text-center">
					<div class="service-box">
						<i class="fa fa-4x fa-diamond text-primary sr-icons"></i>
						<h3>Sturdy Templates</h3>
						<p class="text-muted">Our templates are updated regularly so
							they don't break.</p>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 text-center">
					<div class="service-box">
						<i class="fa fa-4x fa-paper-plane text-primary sr-icons"></i>
						<h3>Ready to Ship</h3>
						<p class="text-muted">You can use this theme as is, or you can
							make changes!</p>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 text-center">
					<div class="service-box">
						<i class="fa fa-4x fa-newspaper-o text-primary sr-icons"></i>
						<h3>Up to Date</h3>
						<p class="text-muted">We update dependencies to keep things
							fresh.</p>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 text-center">
					<div class="service-box">
						<i class="fa fa-4x fa-heart text-primary sr-icons"></i>
						<h3>Made with Love</h3>
						<p class="text-muted">You have to make your websites with love
							these days!</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="p-0" id="portfolio">
		<div class="container-fluid">
			<div class="row no-gutter popup-gallery">

				<!-- 첫번째 사진칸 -->
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="images/portfolio/fullsize/1.jpg">
						<img class="img-fluid" src="images/portfolio/thumbnails/1.jpg"
						alt="">
						<div class="portfolio-box-caption">
							<div class="portfolio-box-caption-content">
								<div class="project-category text-faded">FRONT DESK</div>
								<div class="project-name">프런트 데스크</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="images/portfolio/fullsize/2.jpg">
						<img class="img-fluid" src="images/portfolio/thumbnails/2.jpg"
						alt="">
						<div class="portfolio-box-caption">
							<div class="portfolio-box-caption-content">
								<div class="project-category text-faded">PRIVATE STUDY
									ROOM</div>
								<div class="project-name">독립형 1인실</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="images/portfolio/fullsize/3.jpg">
						<img class="img-fluid" src="images/portfolio/thumbnails/3.jpg"
						alt="">
						<div class="portfolio-box-caption">
							<div class="portfolio-box-caption-content">
								<div class="project-category text-faded">MEN/WOMEN STUDY
									ROOM</div>
								<div class="project-name">남/녀 스터디룸</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="images/portfolio/fullsize/4.jpg">
						<img class="img-fluid" src="images/portfolio/thumbnails/4.jpg"
						alt="">
						<div class="portfolio-box-caption">
							<div class="portfolio-box-caption-content">
								<div class="project-category text-faded">GROUP STUDY ROOM</div>
								<div class="project-name">그룹 스터디룸</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="images/portfolio/fullsize/5.jpg">
						<img class="img-fluid" src="images/portfolio/thumbnails/5.jpg"
						alt="">
						<div class="portfolio-box-caption">
							<div class="portfolio-box-caption-content">
								<div class="project-category text-faded">OPEN STUDY ROOM</div>
								<div class="project-name">광장형 스터디룸</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="images/portfolio/fullsize/6.jpg">
						<img class="img-fluid" src="images/portfolio/thumbnails/6.jpg"
						alt="">
						<div class="portfolio-box-caption">
							<div class="portfolio-box-caption-content">
								<div class="project-category text-faded">CAFE STUDY ROOM</div>
								<div class="project-name">카페식 스터디룸</div>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</section>

	<div class="call-to-action bg-dark">
		<div class="container text-center">
			<h2>지금 저희 SMART IN STUDY에 가입해보세요 !</h2>
			<a class="btn btn-default btn-xl sr-button" href="TurnOn_RequestPage?page=request">프렌차이즈 신청</a>
		</div>
	</div>

	<section id="contact">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 mx-auto text-center">
					<h2 class="section-heading">센터안내</h2>
					<hr class="primary">
					<p>이제는 독서실도 최고급으로 누려야 합니다. 프리미엄 카페스타일 독서실 Smart In Study</p>
				</div>
			</div>
			<!-- 	<div class="center">
				<input id="sabox" type="text" name="search" placeholder="search">
				<button type="submit" class="btn btn-search"></button>
			</div>
 -->

		</div>

		<nav id="bo_cate">

			<ul id="bo_cate_ul">
				<!-- <li><a href="?siscode=SEO">서울특별시</a></li> -->
				<!-- 				<li><input type="button" name="All" class="locator" value="전체" /></li> -->

				<li><a id="All" class="pyj">전체</a></li>
				<li><a id="SEO">서울특별시</a></li>
				<li><a id="ICN">인천광역시</a></li>
				<li><a id="GYU">경기도</a></li>
				<li><a id="GAN">강원도</a></li>
				<li><a id="CHB">충청북도</a></li>
				<li><a id="CHN">충청남도</a></li>
				<li><a id="DAJ">대전광역시</a></li>
				<li><a id="GWA">광주광역시</a></li>
				<li><a id="JEB">전라북도</a></li>
				<li><a id="JEN">전라남도</a></li>
				<li><a id="GYB">경상북도</a></li>
				<li><a id="GYN">경상남도</a></li>
				<li><a id="DAG">대구광역시</a></li>
				<li><a id="BUS">부산광역시</a></li>
				<li><a id="ULS">울산광역시</a></li>
				<li><a id="JEJ">제주도</a></li>

			</ul>
		</nav>

		<div class="container gallery-container">

			<!--  <p class="page-description text-center">Thumbnails With Title And Description</p> -->

			<div class="tz-gallery">
				<div class="row" id="sisText" >${sisText }</div>
			</div>
		</div>

		<div class="row" style="margin: 0px">
			<div class="col-lg-4 ml-auto text-center">
				<i class="fa fa-phone fa-3x sr-contact"></i>
				<p>032-876-3332</p>
			</div>
			<div class="col-lg-4 mr-auto text-center">
				<i class="fa fa-envelope-o fa-3x sr-contact"></i>
				<p>
					<a href="mailto:smartinstudy@gmail.com">Smart In Study</a>
				</p>
			</div>
		</div>
		</div>
	</section>
	<footer id="myFooter">
		<div class="container">
			<div class="row">
				<div class="col-sm-3">
					<h5>Get started</h5>
					<ul>
						<li><a href="#">Home</a></li>
						<li><a href="#">Sign up</a></li>
						<li><a href="#">Downloads</a></li>
					</ul>
				</div>
				<div class="col-sm-3">
					<h5>About us</h5>
					<ul>
						<li><a href="#">Company Information</a></li>
						<li><a href="#">Contact us</a></li>
						<li><a href="#">Reviews</a></li>
					</ul>
				</div>
				<div class="col-sm-3">
					<h5>Support</h5>
					<ul>
						<li><a href="#">FAQ</a></li>
						<li><a href="#">Help desk</a></li>
						<li><a href="#">Forums</a></li>
					</ul>
				</div>
				<div class="col-sm-3">
					<h5>Legal</h5>
					<ul>
						<li><a href="#">Terms of Service</a></li>
						<li><a href="#">Terms of Use</a></li>
						<li><a href="#">Privacy Policy</a></li>
					</ul>
				</div>
			</div>
			<!-- Here we use the Google Embed API to show Google Maps. -->
			<!-- In order for this to work in your project you will need to generate a unique API key.  -->
			<div id="map" style="width: 100%; height: 240px"></div>

		</div>

		<div class="social-networks">
			<a href="#" class="twitter"><i class="fa fa-twitter"></i></a> <a
				href="#" class="facebook"><i class="fa fa-facebook"></i></a> <a
				href="#" class="google"><i class="fa fa-google-plus"></i></a>
		</div>
		<div class="footer-copyright">
			<!-- <p>© 2017 Copyright </p> -->
			<span id=footer_span1> Made with <i class="fa fa-heart pulse"
				style="color: red;"></i> By <a href="">HelloWorld</a>
			</span>
		</div>
	</footer>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3510e5ef407567a25cc912301c87eaaf&libraries=services"></script>


	<!-- Bootstrap core JavaScript -->
	<script src="style/mainpage/jquery/jquery.min.js"></script>
	<script src="style/mainpage/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="style/mainpage/jquery-easing/jquery.easing.min.js"></script>
	<script src="style/mainpage/scrollreveal/scrollreveal.min.js"></script>
	<script
		src="style/mainpage/magnific-popup/jquery.magnific-popup.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="style/mainpage/creative.min.js"></script>
	<script src="style/mainpage/googlemap.js"></script>
	<!--  그림 -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.8.1/baguetteBox.min.js"></script>
	<script>
		baguetteBox.run('.tz-gallery');
	</script>
	<jsp:include page="${request.contextPath}/TurnOn_LoginPage"></jsp:include>
</body>

</html>
