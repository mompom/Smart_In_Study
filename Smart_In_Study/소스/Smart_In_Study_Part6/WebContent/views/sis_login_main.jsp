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

<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript"
	src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

<!-- Locator Jquery -->
<script>

$(document).ready(function() {
		
	$("#logoutBtn").hide();

	
	var siscode = "${siscode}";
			$.ajax({
				type : "POST",
				url : "TurnOn_SelectSisPage_Contents",
				data : {
					siscode : "${siscode}"
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
					
					if(parse[0].sisimg1=="comingsoon.jpg"){
						$("#title").append("오픈예정");
						$("#homeHeading").append("오픈 예정입니다.");
						$("#introtitle").append("");
						$("#intro").append("오픈 준비중입니다.");
						$("#joinBtn").toggle();
						$("#joinBtn2").toggle();
						
					}else{
						$("#title").append(parse[0].sisname);
						$("#homeHeading").append(parse[0].sisname + "에 오신것을 환영합니다.");
						$("#introtitle").append(parse[0].sisname);
						$("#intro").append(parse[0].sisintro);
					}

					var sisphonenumber = parse[0].sisphonenumber;
					sisphonenumber = sisphonenumber.replace(/\D/g, '');
					sisphonenumber = "<br>" + sisphonenumber.slice(0, 3)
							+ "-" + sisphonenumber.slice(3, 7) + "-"
							+ sisphonenumber.slice(7, 15);

					$("#contacts").append(parse[0].sisnumber + sisphonenumber);
					
					if("${mbid}"!=""){
						$("#nav").toggle();
						$("#logoutBtn").toggle();
						$("#loginBtn").toggle();
						$("#joinBtn").toggle();
						$("#joinBtn2").toggle();
					} 
					if(parse[0].sisimg1=="comingsoon.jpg"){
						
					}else{
						$(".masthead").css("background-image","url(images/"+siscode+"/"+parse[0].sisimg1+")");
						$("#sisimg2").attr("href","images/"+siscode+"/"+parse[0].sisimg2);
						$("#sisimg22").attr("src","images/"+siscode+"/"+parse[0].sisimg2);
						$("#sisimg3").attr("href","images/"+siscode+"/"+parse[0].sisimg3);
						$("#sisimg33").attr("src","images/"+siscode+"/"+parse[0].sisimg3);
						$("#sisimg4").attr("href","images/"+siscode+"/"+parse[0].sisimg4);
						$("#sisimg44").attr("src","images/"+siscode+"/"+parse[0].sisimg4);
					}		
					/* 구글맵 자바스크립트 */
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					mapOption = {
						center : new daum.maps.LatLng(0, 0), // 지도의 중심좌표
						level : 3
					// 지도의 확대 레벨
					};

					// 지도를 생성합니다    
					var map = new daum.maps.Map(mapContainer, mapOption);

					// 주소-좌표 변환 객체를 생성합니다
					var geocoder = new daum.maps.services.Geocoder();

					// 주소로 좌표를 검색합니다
					geocoder.addressSearch(
							parse[0].sisaddress,
									function(result, status) {

										// 정상적으로 검색이 완료됐으면 
										if (status === daum.maps.services.Status.OK) {

											var coords = new daum.maps.LatLng(result[0].y,
													result[0].x);

											// 결과값으로 받은 위치를 마커로 표시합니다
											var marker = new daum.maps.Marker({
												map : map,
												position : coords
											});

											// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
											var content = '<div class="customoverlay">'
													+ '  <a href="http://dmaps.kr/6otj7" target="_blank" /*style="border-bottom: solid #f5efef;  border-radius: 6px 6px 0px 0px; */">'
													+ '    <span class="title">'+parse[0].sisname+'</span>'
													+ '  </a>'
													/*  	+ '  <a href="http://dmaps.kr/6otjo" target="_blank" style="border-radius: 0px 0px 6px 6px;">'
														+ '    <span class="title2" style="height:22px ;">찾아오시는 길</span>'
														+ '  </a>'  */
													+ '</div>';

											// 커스텀 오버레이가 표시될 위치입니다 
											var position = coords;

											// 커스텀 오버레이를 생성합니다
											var customOverlay = new daum.maps.CustomOverlay(
													{
														map : map,
														position : position,
														content : content,
														yAnchor : 0.2
													});
											// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
											map.setCenter(coords);
										}
									});
					/**/
					
					$('body')

					.on('click', 'div.six button.btn-search', function(event) {
						event.preventDefault();
						var $input = $('div.six input');
						$input.focus();
						if ($input.val().length() > 0) {
							// submit form
						}
					});
				},

				error : function(error) { // 실패
					alert("error");
				}
			});
			$("#heart").click(function() {
				location.href="http://localhost/Smart_In_Study/";
			});
		});
</script>

<script type="text/javascript">
google.charts.load('current', {
	'packages' : [ 'corechart' ]
});

google.charts.setOnLoadCallback(drawlinedhtChart);
google.charts.setOnLoadCallback(drawareaChart);
function drawlinedhtChart() {
	var jsonData = $.ajax({
		url : "Sensor/dht/month/all",
		dataType : "json",
		async : false
	}).responseText;

	var options = {
		title : '',
		curveType : 'function',
		backgroundColor : '#222222',
		lineWidth : 5,
		colors : [ 'red', 'blue' ],
		textStyle : {
			color : '#FFFFFF'
		},
		gridlines : {
			color : '#FFFFFF'
		},
		hAxis : {
			color : '#FFFFFF',
			TextStyle : {
				color : '#FFFFFF'
			}
		},
		vAxis : {
			color : '#FFFFFF',
			TextStyle : {
				color : '#FFFFFF'
			}
		},
		legendTextStyle : {
			color : '#FFFFFF'
		},
		legend : {
			position : 'bottom'
		}

	};
	console.log(jsonData);
	if(jsonData =="X" || jsonData == ""){
		$("#linedht_chart").append("<h4 style='color:#F05f40;margin: 0 auto;text-align: center;padding-top: 30%;'>결제가 되지 않은 사용자이거나, 서버 내부 오류입니다. 관리자에게 문의하세요.</h4>")
	}
	else{
	// Create our data table out of JSON data loaded from server.
	var data = new google.visualization.DataTable(jsonData);

	// Instantiate and draw our chart, passing in some options.
	var chart = new google.visualization.LineChart(document
			.getElementById('linedht_chart'));

	chart.draw(data, options);
	}
}

function drawareaChart() {
	var jsonData = $.ajax({
		url : "Sensor/sound/month/all",
		dataType : "json",
		async : false
	}).responseText;

	var options = {
		title : '',
		curveType : 'function',
		backgroundColor : '#222222',
		lineWidth : 5,
		colors : [ 'red', 'blue' ],
		textStyle : {
			color : '#FFFFFF'
		},
		gridlines : {
			color : '#FFFFFF'
		},
		hAxis : {
			color : '#FFFFFF',
			TextStyle : {
				color : '#FFFFFF'
			}
		},
		vAxis : {
			color : '#FFFFFF',
			TextStyle : {
				color : '#FFFFFF'
			}
		},
		legendTextStyle : {
			color : '#FFFFFF'
		},
		legend : {
			position : 'bottom'
		}

	};
	console.log(jsonData);
	if(jsonData =="X" || jsonData == ""){
		$("#area_chart").append("<h4 style='color:#F05f40;margin: 0 auto;text-align: center;padding-top: 30%;'>결제가 되지 않은 사용자이거나, 서버 내부 오류입니다. 관리자에게 문의하세요.</h4>")
	}
	else{
	// Create our data table out of JSON data loaded from server.
	var data = new google.visualization.DataTable(jsonData);

	// Instantiate and draw our chart, passing in some options.
	var chart = new google.visualization.AreaChart(document
			.getElementById('area_chart'));

	chart.draw(data, options);
	}
}
</script>

<style> text{
fill : #FFFFFF;
}

g>g>path[fill="#ffffff"] {
fill: #222222;
}
</style>
</head>

<body id="page-top">

	<!-- Navi Bar -->
	<script>
	$(document).ready(function(){
		if("${mbstcode}"=="M0"){$("#navi_mb").remove();
		}else{$("#navi_admin").remove();}
	});
	</script>
	
	<div id="navi_mb"><%@include file="/views/navi_mb.jsp"%></div>
	<div id="navi_admin"><%@include file="/views/navi_admin.jsp"%></div>
	
	<!-- End Navi Bar -->
	<header class="masthead">
		<div class="header-content">
			<div class="header-content-inner">
				<h1 id="homeHeading">
					<%-- $("#homeHeading").append 홈타이틀 위치--%>
				</h1>
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
					<h2 id="introtitle" class="section-heading text-white">
						<%-- $("#introtitle").append 내용 타이틀 위치--%>
					</h2>
					<hr class="light">
					<p id="intro" class="text-faded">
						<%-- $("#intro").append 내용  위치--%>
					</p>
					<a class="btn btn-default btn-xl js-scroll-trigger" id="joinBtn2" href="TurnOn_JoinPage">가입하기</a>
				</div>
			</div>
		</div>
	</section>


	<section class="p-0" id="portfolio">
		<div class="container-fluid">
			<div class="row no-gutter popup-gallery">

				<!-- 첫번째 사진칸 -->
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" id="sisimg2" href="">
						<img class="img-fluid" id="sisimg22" src="" alt="">
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
				<!-- 두번째 사진 -->
					<a class="portfolio-box" id="sisimg3" >
						<img class="img-fluid" id="sisimg33" 
						alt="">
						<div class="portfolio-box-caption">
							<div class="portfolio-box-caption-content">
								<div class="project-category text-faded">OEPN STUDY
									ROOM</div>
								<div class="project-name">오픈형 스터디룸</div>
							</div>
						</div>
					</a>
				</div>
				
				<div class="col-lg-4 col-sm-6">
				<!-- 세번째 사진 -->
					<a class="portfolio-box" id="sisimg4" href="">
						<img class="img-fluid" id="sisimg44" src="" alt="">
						<div class="portfolio-box-caption">
							<div class="portfolio-box-caption-content">
								<div class="project-category text-faded">GROUP STUDY ROOM</div>
								<div class="project-name">그룹 스터디룸</div>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</section>

	<section class="bg-dark" id="services">
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
				<h2 class="section-heading">우리 독서실 온습도</h2>
				<div id="linedht_chart"
				style="width: 1000px; height: 500px; margin: auto;"></div>
				<h2 class="section-heading">우리 독서실 소음</h2>
					<div id="area_chart"
				style="width: 1000px; height: 500px; margin: auto;"></div>
			</div>
		</div>
	</section>

	<div class="call-to-action bg-dark">
		<div class="container text-center">
			<h2>지금 저희 SMART IN STUDY에 가입해보세요 !</h2>
			<a class="btn btn-default btn-xl sr-button" href="TurnOn_JoinPage">지금
				가입하기!</a>
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
		</div>

		<div class="container gallery-container">
			<div class="tz-gallery">
				<div class="row" id="sisText">${sisText }</div>
			</div>
		</div>
		<div class="row" style="margin: 0px">
			<div class="col-lg-4 ml-auto text-center">
				<i class="fa fa-phone fa-3x sr-contact"></i>
				<p id="contacts">
					<%-- $("#contacts").append 연락처 위치 --%>
				</p>
			</div>
			<div class="col-lg-4 mr-auto text-center">
				<i class="fa fa-envelope-o fa-3x sr-contact"></i>
				<p>
					<a href="mailto:smartinstudy@gmail.com">Smart In Study</a>
				</p>
			</div>
		</div>
	</section>
	<footer id="myFooter">
		<div class="container">
			<div class="row">
				
			</div>
			<!-- Here we use the Google Embed API to show Google Maps. -->
			<!-- In order for this to work in your project you will need to generate a unique API key.  -->
			<div id="map" style="width: 100%; height: 320px"></div>

		</div>

		
		<div class="footer-copyright">
			<!-- <p>© 2017 Copyright </p> -->
			<span id=footer_span1> Made with <i id="heart"
				class="fa fa-heart pulse" style="color: red;"></i> By <a href="http://localhost/Smart_In_Study/">HelloWorld</a>
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
	<script src="style/mainpage/googlemap2.js"></script>
	<!--  그림 -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.8.1/baguetteBox.min.js"></script>
	<script>
		baguetteBox.run('.tz-gallery');
	</script>
</body>

</html>
