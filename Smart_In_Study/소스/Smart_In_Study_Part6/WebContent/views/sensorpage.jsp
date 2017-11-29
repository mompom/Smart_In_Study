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
	google.charts.setOnLoadCallback(drawlinedustChart);
	google.charts.setOnLoadCallback(drawlinedhtChart);
	google.charts.setOnLoadCallback(drawareaChart);
	google.charts.setOnLoadCallback(drawsteppedChart);
	google.charts.setOnLoadCallback(drawbarirChart);
	google.charts.setOnLoadCallback(drawbarhirChart);
	google.charts.setOnLoadCallback(drawcolumnChart);

	
	
	function drawlinedustChart() {
		var jsonData = $.ajax({
			url : "Sensor/dust/month/personal",
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
				.getElementById('linedust_chart'));

		chart.draw(data, options);
		}
	}

	function drawlinedhtChart() {
		var jsonData = $.ajax({
			url : "Sensor/dht/month/personal",
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
				.getElementById('linedht_chart'));

		chart.draw(data, options);
		}
	}

	function drawareaChart() {
		var jsonData = $.ajax({
			url : "Sensor/sound/month/personal",
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
				.getElementById('area_chart'));

		chart.draw(data, options);
		}
	}

	function drawbarirChart() {
		var jsonData = $.ajax({
			url : "Sensor/ir/month/personal",
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
		if(jsonData =="X" || jsonData == null){
			$("#barir_chart").append("<h4 style='color:#F05f40;margin: 0 auto;text-align: center;padding-top: 30%;'>결제가 되지 않은 사용자이거나, 서버 내부 오류입니다. 관리자에게 문의하세요.</h4>")
		}
		else{
		// Create our data table out of JSON data loaded from server.
		var data = new google.visualization.DataTable(jsonData);

		// Instantiate and draw our chart, passing in some options.
		var chart = new google.visualization.BarChart(document
				.getElementById('barir_chart'));

		chart.draw(data, options);
		}
	}

	function drawbarhirChart() {
		var jsonData = $.ajax({
			url : "Sensor/hir/month/personal",
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
		if(jsonData =="X" || jsonData == null){
			$("#barhir_chart").append("<h4 style='color:#F05f40;margin: 0 auto;text-align: center;padding-top: 30%;'>결제가 되지 않은 사용자이거나, 서버 내부 오류입니다. 관리자에게 문의하세요.</h4>")
		}
		else{
		// Create our data table out of JSON data loaded from server.
		var data = new google.visualization.DataTable(jsonData);

		// Instantiate and draw our chart, passing in some options.
		var chart = new google.visualization.BarChart(document
				.getElementById('barhir_chart'));

		chart.draw(data, options);
		}
	}

	function drawsteppedChart() {
		var jsonData = $.ajax({
			url : "Sensor/light/month/personal",
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
					color : '#FFFFFF!important'
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
			isStacked : true

		};
		console.log(jsonData);
		if(jsonData =="X" || jsonData == null){
			$("#stepped_chart").append("<h4 style='color:#F05f40;margin: 0 auto;text-align: center;padding-top: 30%;'>결제가 되지 않은 사용자이거나, 서버 내부 오류입니다. 관리자에게 문의하세요.</h4>")
		}
		else{
		// Create our data table out of JSON data loaded from server.
		var data = new google.visualization.DataTable(jsonData);

		// Instantiate and draw our chart, passing in some options.
		var chart = new google.visualization.SteppedAreaChart(document
				.getElementById('stepped_chart'));

		chart.draw(data, options);
		}
	}

	function drawcolumnChart() {
		var jsonData = $.ajax({
			url : "Sensor/rfid/day/aa",
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
				color : '#FFFFFF!important'
			},
			gridlines : {
				color : '#FFFFFF'
			},
			hAxis : {
				color : 'white!important',
				TextStyle : {
					color : '#FFFFFF!important'
				}
			},
			vAxis : {
				color : '#FFFFFF!important',
				TextStyle : {
					color : '#FFFFFF!important'
				}
			},
			legendTextStyle : {
				color : '#FFFFFF!important'
			},
			legend : {
				position : 'bottom'
			},
			isStacked : true

		};
		if(jsonData =="X" || jsonData == null){
			$("#column_chart").append("<h4 style='color:#F05f40;margin: 0 auto;text-align: center;padding-top: 30%;'>결제가 되지 않은 사용자이거나, 서버 내부 오류입니다. 관리자에게 문의하세요.</h4>")
		}
		else{
		// Create our data table out of JSON data loaded from server.
		var data = new google.visualization.DataTable(jsonData);

		// Instantiate and draw our chart, passing in some options.
		var chart = new google.visualization.SteppedAreaChart(document
				.getElementById('column_chart'));

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
						href="#HIR">좌석에 위치한 시간</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#IR">자세</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#DHT">온습도</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#DUST">공기질</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#SOUND">소음</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#LIGHT">자리 전등 밝기</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#USEDTIME">일일 독서실 사용 시간</a></li>
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

	<section class="bg-dark" id="HIR">
		<div class="container">
			<h2 class="section-heading">좌석에 위치한 시간</h2>
			<hr class="light">

			<div id="barhir_chart"
				style="width: 1000px; height: 500px; margin: auto;"></div>
		</div>
	</section>

	<header class="masthead"
		style="height: 20%; min-height: 30% !important">
		<div class="header-content">
			<div class="header-content-inner"></div>
		</div>
	</header>

	<section class="bg-dark" id="IR">
		<div class="container">

			<h2 class="section-heading">자세</h2>
			<hr class="light">

			<div id="barir_chart"
				style="width: 1000px; height: 500px; margin: auto;"></div>
		</div>
	</section>

	<header class="masthead"
		style="height: 20%; min-height: 30% !important">
		<div class="header-content">
			<div class="header-content-inner"></div>
		</div>
	</header>

	<section class="bg-dark" id="DHT">
		<div class="container">

			<h2 class="section-heading">온습도</h2>
			<hr class="light">

			<div id="linedht_chart"
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

			<h2 class="section-heading">공기질</h2>
			<hr class="light">

			<div id="linedust_chart"
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
			<h2 class="section-heading">소음</h2>
			<hr class="light">

			<div id="area_chart"
				style="width: 1000px; height: 500px; margin: auto;"></div>
		</div>
	</section>

	<header class="masthead"
		style="height: 20%; min-height: 30% !important">
		<div class="header-content">
			<div class="header-content-inner"></div>
		</div>
	</header>

	<section class="bg-dark" id="LIGHT">
		<div class="container">
			<h2 class="section-heading">자리 전등 밝기</h2>
			<hr class="light">

			<div id="stepped_chart"
				style="width: 1000px; height: 500px; margin: auto;"></div>
		</div>
	</section>

	<header class="masthead"
		style="height: 20%; min-height: 30% !important">
		<div class="header-content">
			<div class="header-content-inner"></div>
		</div>
	</header>

	<section class="bg-dark" id="USEDTIME">
		<div class="container">
			<h2 class="section-heading">일일 독서실 사용 시간</h2>
			<hr class="light">

			<div id="column_chart"
				style="width: 1000px; height: 500px; margin: auto;"></div>
		</div>
	</section>





	<footer id="myFooter">
		

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
