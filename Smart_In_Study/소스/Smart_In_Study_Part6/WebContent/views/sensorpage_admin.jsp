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
<title>Smart In Study made by HelloWorld</title>
<!-- 제이쿼리 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- 그래프  -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript"
	src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript">
	// Load the Visualization API and the piechart package.
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawlinedustChart1);
	google.charts.setOnLoadCallback(drawlinedustChart2);
	google.charts.setOnLoadCallback(drawlinedustChart3);
	
	google.charts.setOnLoadCallback(drawlinedhtChart1);
	google.charts.setOnLoadCallback(drawlinedhtChart2);
	google.charts.setOnLoadCallback(drawlinedhtChart3);
	
	google.charts.setOnLoadCallback(drawareaChart1);
	google.charts.setOnLoadCallback(drawareaChart2);
	google.charts.setOnLoadCallback(drawareaChart3);
	

	
	
	function drawlinedustChart1() {
		var jsonData = $.ajax({
			url : "Sensor/admin/dust/P0",
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
			},
			tooltip:{color:'#222222'} 
		};
		if(jsonData =="X" || jsonData == null){
			$("#linedust_chart").append("<h4 style='color:#F05f40;margin: 0 auto;text-align: center;padding-top: 30%;'>결제가 되지 않은 사용자이거나, 서버 내부 오류입니다. 관리자에게 문의하세요.</h4>")
		}
		else{
		// Create our data table out of JSON data loaded from server.
		var data = new google.visualization.DataTable(jsonData);

		// Instantiate and draw our chart, passing in some options.
		var chart = new google.visualization.LineChart(document
				.getElementById('linedust_chart1'));

		chart.draw(data, options);
		}
	}
	
	function drawlinedustChart2() {
		var jsonData = $.ajax({
			url : "Sensor/admin/dust/G0",
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
			},
			tooltip:{color:'#222222'} 
		};
		if(jsonData =="X" || jsonData == null){
			$("#linedust_chart").append("<h4 style='color:#F05f40;margin: 0 auto;text-align: center;padding-top: 30%;'>결제가 되지 않은 사용자이거나, 서버 내부 오류입니다. 관리자에게 문의하세요.</h4>")
		}
		else{
		// Create our data table out of JSON data loaded from server.
		var data = new google.visualization.DataTable(jsonData);

		// Instantiate and draw our chart, passing in some options.
		var chart = new google.visualization.LineChart(document
				.getElementById('linedust_chart2'));

		chart.draw(data, options);
		}
	}
	
	function drawlinedustChart3() {
		var jsonData = $.ajax({
			url : "Sensor/admin/dust/O0",
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
			},
			tooltip:{color:'#222222'} 
		};
		if(jsonData =="X" || jsonData == null){
			$("#linedust_chart").append("<h4 style='color:#F05f40;margin: 0 auto;text-align: center;padding-top: 30%;'>결제가 되지 않은 사용자이거나, 서버 내부 오류입니다. 관리자에게 문의하세요.</h4>")
		}
		else{
		// Create our data table out of JSON data loaded from server.
		var data = new google.visualization.DataTable(jsonData);

		// Instantiate and draw our chart, passing in some options.
		var chart = new google.visualization.LineChart(document
				.getElementById('linedust_chart3'));

		chart.draw(data, options);
		}
	}

	function drawlinedhtChart1() {
		var jsonData = $.ajax({
			url : "Sensor/admin/dht/P0",
			dataType : "json",
			async : false
		}).responseText;

		var options = {
			title : '',
			curveType : 'function',
			backgroundColor : '#222222',
			lineWidth : 5,
			colors : [ 'red', 'blue','yellow','orange' ],
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
		if(jsonData =="X" || jsonData == null){
			$("#linedht_chart").append("<h4 style='color:#F05f40;margin: 0 auto;text-align: center;padding-top: 30%;'>결제가 되지 않은 사용자이거나, 서버 내부 오류입니다. 관리자에게 문의하세요.</h4>")
		}
		else{
		// Create our data table out of JSON data loaded from server.
		var data = new google.visualization.DataTable(jsonData);

		// Instantiate and draw our chart, passing in some options.
		var chart = new google.visualization.LineChart(document
				.getElementById('linedht_chart1'));

		chart.draw(data, options);
		}
	}
	
	function drawlinedhtChart2() {
		var jsonData = $.ajax({
			url : "Sensor/admin/dht/G0",
			dataType : "json",
			async : false
		}).responseText;

		var options = {
			title : '',
			curveType : 'function',
			backgroundColor : '#222222',
			lineWidth : 5,
			colors : [ 'red', 'blue','yellow','orange' ],
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
		if(jsonData =="X" || jsonData == null){
			$("#linedht_chart").append("<h4 style='color:#F05f40;margin: 0 auto;text-align: center;padding-top: 30%;'>결제가 되지 않은 사용자이거나, 서버 내부 오류입니다. 관리자에게 문의하세요.</h4>")
		}
		else{
		// Create our data table out of JSON data loaded from server.
		var data = new google.visualization.DataTable(jsonData);

		// Instantiate and draw our chart, passing in some options.
		var chart = new google.visualization.LineChart(document
				.getElementById('linedht_chart2'));

		chart.draw(data, options);
		}
	}
	
	function drawlinedhtChart3() {
		var jsonData = $.ajax({
			url : "Sensor/admin/dht/O0",
			dataType : "json",
			async : false
		}).responseText;

		var options = {
			title : '',
			curveType : 'function',
			backgroundColor : '#222222',
			lineWidth : 5,
			colors : [ 'red', 'blue','yellow','orange' ],
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
		if(jsonData =="X" || jsonData == null){
			$("#linedht_chart").append("<h4 style='color:#F05f40;margin: 0 auto;text-align: center;padding-top: 30%;'>결제가 되지 않은 사용자이거나, 서버 내부 오류입니다. 관리자에게 문의하세요.</h4>")
		}
		else{
		// Create our data table out of JSON data loaded from server.
		var data = new google.visualization.DataTable(jsonData);

		// Instantiate and draw our chart, passing in some options.
		var chart = new google.visualization.LineChart(document
				.getElementById('linedht_chart3'));

		chart.draw(data, options);
		}
	}

	function drawareaChart1() {
		var jsonData = $.ajax({
			url : "Sensor/admin/sound/P0",
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
		if(jsonData =="X" || jsonData == null){
			$("#area_chart").append("<h4 style='color:#F05f40;margin: 0 auto;text-align: center;padding-top: 30%;'>결제가 되지 않은 사용자이거나, 서버 내부 오류입니다. 관리자에게 문의하세요.</h4>")
		}
		else{
		// Create our data table out of JSON data loaded from server.
		var data = new google.visualization.DataTable(jsonData);

		// Instantiate and draw our chart, passing in some options.
		var chart = new google.visualization.AreaChart(document
				.getElementById('area_chart1'));

		chart.draw(data, options);
		}
	}
	
	function drawareaChart2() {
		var jsonData = $.ajax({
			url : "Sensor/admin/sound/G0",
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
		if(jsonData =="X" || jsonData == null){
			$("#area_chart").append("<h4 style='color:#F05f40;margin: 0 auto;text-align: center;padding-top: 30%;'>결제가 되지 않은 사용자이거나, 서버 내부 오류입니다. 관리자에게 문의하세요.</h4>")
		}
		else{
		// Create our data table out of JSON data loaded from server.
		var data = new google.visualization.DataTable(jsonData);

		// Instantiate and draw our chart, passing in some options.
		var chart = new google.visualization.AreaChart(document
				.getElementById('area_chart2'));

		chart.draw(data, options);
		}
	}
	
	function drawareaChart3() {
		var jsonData = $.ajax({
			url : "Sensor/admin/sound/O0",
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
		if(jsonData =="X" || jsonData == null){
			$("#area_chart").append("<h4 style='color:#F05f40;margin: 0 auto;text-align: center;padding-top: 30%;'>결제가 되지 않은 사용자이거나, 서버 내부 오류입니다. 관리자에게 문의하세요.</h4>")
		}
		else{
		// Create our data table out of JSON data loaded from server.
		var data = new google.visualization.DataTable(jsonData);

		// Instantiate and draw our chart, passing in some options.
		var chart = new google.visualization.AreaChart(document
				.getElementById('area_chart3'));

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

</head>

<body id="page-top">

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top"
		id="mainNav">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger"
				href="TurnOn_Sis_Login_MainPage">smart In Study</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#DHT">온습도</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#DUST">공기질</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#SOUND">소음</a></li>
					
					<!-- <li class="nav-item" id="loginBtn" ><a class="nav-link js-scroll-trigger"
						id="modal_trigger" href="#modal">Login</a></li> -->
				</ul>
			</div>
		</div>
	</nav>

	<header class="masthead">
		<div class="header-content">
			<div class="header-content-inner">
				<h1 id="homeHeading">회원님의 자리의 주변 센서 데이터입니다.</h1>
				<hr>
				<p>센서 데이터는 참고용으로만 사용 바랍니다.</p>

			</div>
		</div>
	</header>

	
	<section class="bg-dark" id="DHT">
		<div class="container">

			<h2 class="section-heading">P번방 온습도</h2>
			<hr class="light">

			<div id="linedht_chart1"
				style="width: 1000px; height: 500px; margin: auto;"></div>
			<h2 class="section-heading">G번방 온습도</h2>
			<hr class="light">	
				<div id="linedht_chart2"
				style="width: 1000px; height: 500px; margin: auto;"></div>
				<h2 class="section-heading">O번방 온습도</h2>
			<hr class="light">
				<div id="linedht_chart3"
				style="width: 1000px; height: 500px; margin: auto;"></div>
		</div>
	</section>

	<header class="masthead"
		style="height: 20%; min-height: 30% !important">
		<div class="header-content">
			<div class="header-content-inner"></div>
		</div>
	</header>

	<section class="bg-dark" id="DUST">
		<div class="container">

			<h2 class="section-heading">P번방 공기질</h2>
			<hr class="light">

			<div id="linedust_chart1"
				style="width: 1000px; height: 500px; margin: auto;"></div>
				<h2 class="section-heading">G번방 공기질</h2>
			<hr class="light">
				<div id="linedust_chart2"
				style="width: 1000px; height: 500px; margin: auto;"></div>
				<h2 class="section-heading">O번방 공기질</h2>
			<hr class="light">
				<div id="linedust_chart3"
				style="width: 1000px; height: 500px; margin: auto;"></div>
		</div>
	</section>

	<header class="masthead"
		style="height: 20%; min-height: 30% !important">
		<div class="header-content">
			<div class="header-content-inner"></div>
		</div>
	</header>

	<section class="bg-dark" id="SOUND">
		<div class="container">
			<h2 class="section-heading">P번방 소음</h2>
			<hr class="light">

			<div id="area_chart1"
				style="width: 1000px; height: 500px; margin: auto;"></div>
			<h2 class="section-heading">G번방 소음</h2>
			<hr class="light">	
				<div id="area_chart2"
				style="width: 1000px; height: 500px; margin: auto;"></div>
				<h2 class="section-heading">O번방 소음</h2>
			<hr class="light">
				<div id="area_chart3"
				style="width: 1000px; height: 500px; margin: auto;"></div>
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
