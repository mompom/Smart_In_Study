<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Favicon -->
<link rel="icon" href="images/favicon/favicon.ico">
<title>Smart In Study</title>
<script type="text/javascript" src="http://www.google.com/jsapi"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
<script type="text/javascript">
	google.load('visualization', '1', {
		packages : [ 'corechart' ],
		'language' : 'ko'
	});

	function drawVisualization(dataFromAjax) {
		var data = google.visualization.arrayToDataTable(dataFromAjax);
		new google.visualization.ColumnChart(document.getElementById('map'))
				.draw(data, {
					fontName : "맑은 고딕, Malgon Gothic",
					fontSize : 11,
					forceIFrame : false,
					vAxis : {
						maxValue : 100
					}
				});
	}

	function drawInit() {
		var data = null;
		var table_data = null;

		$.ajax({
			url : 'GraphTest',
			data : {},
			success : function(res) {
				/* table_data = res; */
				table_data = eval("(" + res + ")");
				drawVisualization(table_data);
			}
		});
	}

	google.setOnLoadCallback(drawInit);


	
</script>
</head>
<body>
<button onClick="drawInit()"> 여기 누러</button>
<div id="map"></div>
</body>
</html>