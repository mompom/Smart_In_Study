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

					if(parse[0].sisnumber==undefined){
						$("#contacts").append(sisphonenumber);
					}else{
						$("#contacts").append(parse[0].sisnumber + sisphonenumber);
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
					/**
					 * AbstractOverlay를 상속받을 객체를 선언합니다.
					 */
					function TooltipMarker(position, tooltipText) {
						this.position = position;
						var node = this.node = document.createElement('div');
						node.className = 'node';

						var tooltip = document.createElement('div');
						tooltip.className = 'tooltip',

						tooltip.appendChild(document.createTextNode(tooltipText));
						node.appendChild(tooltip);

						// 툴팁 엘리먼트에 마우스 인터렉션에 따라 보임/숨김 기능을 하도록 이벤트를 등록합니다.
						node.onmouseover = function() {
							tooltip.style.display = 'block';
						};
						node.onmouseout = function() {
							tooltip.style.display = 'none';
						};
					}

					// AbstractOverlay 상속. 프로토타입 체인을 연결합니다.
					TooltipMarker.prototype = new daum.maps.AbstractOverlay;

					// AbstractOverlay의 필수 구현 메소드.
					// setMap(map)을 호출했을 경우에 수행됩니다.
					// AbstractOverlay의 getPanels() 메소드로 MapPanel 객체를 가져오고
					// 거기에서 오버레이 레이어를 얻어 생성자에서 만든 엘리먼트를 자식 노드로 넣어줍니다.
					TooltipMarker.prototype.onAdd = function() {
						var panel = this.getPanels().overlayLayer;
						panel.appendChild(this.node);
					};

					// AbstractOverlay의 필수 구현 메소드.
					// setMap(null)을 호출했을 경우에 수행됩니다.
					// 생성자에서 만든 엘리먼트를 오버레이 레이어에서 제거합니다.
					TooltipMarker.prototype.onRemove = function() {
						this.node.parentNode.removeChild(this.node);
					};

					// AbstractOverlay의 필수 구현 메소드.
					// 지도의 속성 값들이 변화할 때마다 호출됩니다. (zoom, center, mapType)
					// 엘리먼트의 위치를 재조정 해 주어야 합니다.
					TooltipMarker.prototype.draw = function() {
						// 화면 좌표와 지도의 좌표를 매핑시켜주는 projection객체
						var projection = this.getProjection();

						// overlayLayer는 지도와 함께 움직이는 layer이므로
						// 지도 내부의 위치를 반영해주는 pointFromCoords를 사용합니다.
						var point = projection.pointFromCoords(this.position);

						// 내부 엘리먼트의 크기를 얻어서
						var width = this.node.offsetWidth;
						var height = this.node.offsetHeight;

						// 해당 위치의 정중앙에 위치하도록 top, left를 지정합니다.
						this.node.style.left = (point.x - width / 2) + "px";
						this.node.style.top = (point.y - height / 2) + "px";
					};

					// 좌표를 반환하는 메소드
					TooltipMarker.prototype.getPosition = function() {
						return this.position;
					};

					/**
					 * 지도 영역 외부에 존재하는 마커를 추적하는 기능을 가진 객체입니다.
					 * 클리핑 알고리즘을 사용하여 tracker의 좌표를 구하고 있습니다.
					 */
					function MarkerTracker(map, target) {
						// 클리핑을 위한 outcode
						var OUTCODE = {
							INSIDE : 0, // 0b0000
							TOP : 8, //0b1000
							RIGHT : 2, // 0b0010
							BOTTOM : 4, // 0b0100
							LEFT : 1
						// 0b0001
						};

						// viewport 영역을 구하기 위한 buffer값
						// target의 크기가 60x60 이므로 
						// 여기서는 지도 bounds에서 상하좌우 30px의 여분을 가진 bounds를 구하기 위해 사용합니다.
						var BOUNDS_BUFFER = 30;

						// 클리핑 알고리즘으로 tracker의 좌표를 구하기 위한 buffer값
						// 지도 bounds를 기준으로 상하좌우 buffer값 만큼 축소한 내부 사각형을 구하게 됩니다.
						// 그리고 그 사각형으로 target위치와 지도 중심 사이의 선을 클리핑 합니다.
						// 여기서는 tracker의 크기를 고려하여 40px로 잡습니다.
						var CLIP_BUFFER = 40;

						// trakcer 엘리먼트
						var tracker = document.createElement('div');
						tracker.className = 'tracker';

						// 내부 아이콘
						var icon = document.createElement('div');
						icon.className = 'icon';

						// 외부에 있는 target의 위치에 따라 회전하는 말풍선 모양의 엘리먼트
						var balloon = document.createElement('div');
						balloon.className = 'balloon';

						tracker.appendChild(balloon);
						tracker.appendChild(icon);

						map.getNode().appendChild(tracker);

						// traker를 클릭하면 target의 위치를 지도 중심으로 지정합니다.
						tracker.onclick = function() {
							map.setCenter(target.getPosition());
							setVisible(false);
						};

						// target의 위치를 추적하는 함수
						function tracking() {
							var proj = map.getProjection();

							// 지도의 영역을 구합니다.
							var bounds = map.getBounds();

							// 지도의 영역을 기준으로 확장된 영역을 구합니다.
							var extBounds = extendBounds(bounds, proj);

							// target이 확장된 영역에 속하는지 판단하고
							if (extBounds.contain(target.getPosition())) {
								// 속하면 tracker를 숨깁니다.
								setVisible(false);
							} else {
								// target이 영역 밖에 있으면 계산을 시작합니다.

								// 지도 bounds를 기준으로 클리핑할 top, right, bottom, left를 재계산합니다.
								//
								//  +-------------------------+
								//  | Map Bounds              |
								//  |   +-----------------+   |
								//  |   | Clipping Rect   |   |
								//  |   |                 |   |
								//  |   |        *       (A)  |     A
								//  |   |                 |   |
								//  |   |                 |   |
								//  |   +----(B)---------(C)  |
								//  |                         |
								//  +-------------------------+
								//
								//        B
								//
								//                                       C
								// * 은 지도의 중심,
								// A, B, C가 TooltipMarker의 위치,
								// (A), (B), (C)는 각 TooltipMarker에 대응하는 tracker입니다.
								// 지도 중심과 각 TooltipMarker를 연결하는 선분이 있다고 가정할 때,
								// 그 선분과 Clipping Rect와 만나는 지점의 좌표를 구해서
								// tracker의 위치(top, left)값을 지정해주려고 합니다.
								// tracker 자체의 크기가 있기 때문에 원래 지도 영역보다 안쪽의 가상 영역을 그려
								// 클리핑된 지점을 tracker의 위치로 사용합니다.
								// 실제 tracker의 position은 화면 좌표가 될 것이므로 
								// 계산을 위해 좌표 변환 메소드를 사용하여 모두 화면 좌표로 변환시킵니다.

								// TooltipMarker의 위치
								var pos = proj.containerPointFromCoords(target
										.getPosition());

								// 지도 중심의 위치
								var center = proj.containerPointFromCoords(map.getCenter());

								// 현재 보이는 지도의 영역의 남서쪽 화면 좌표
								var sw = proj.containerPointFromCoords(bounds
										.getSouthWest());

								// 현재 보이는 지도의 영역의 북동쪽 화면 좌표
								var ne = proj.containerPointFromCoords(bounds
										.getNorthEast());

								// 클리핑할 가상의 내부 영역을 만듭니다.
								var top = ne.y + CLIP_BUFFER;
								var right = ne.x - CLIP_BUFFER;
								var bottom = sw.y - CLIP_BUFFER;
								var left = sw.x + CLIP_BUFFER;

								// 계산된 모든 좌표를 클리핑 로직에 넣어 좌표를 얻습니다.
								var clipPosition = getClipPosition(top, right, bottom,
										left, center, pos);

								// 클리핑된 좌표를 tracker의 위치로 사용합니다.
								tracker.style.top = clipPosition.y + 'px';
								tracker.style.left = clipPosition.x + 'px';

								// 말풍선의 회전각을 얻습니다.
								var angle = getAngle(center, pos);

								// 회전각을 CSS transform을 사용하여 지정합니다.
								// 브라우저 종류에따라 표현되지 않을 수도 있습니다.
								// http://caniuse.com/#feat=transforms2d
								balloon.style.cssText += '-ms-transform: rotate(' + angle
										+ 'deg);' + '-webkit-transform: rotate(' + angle
										+ 'deg);' + 'transform: rotate(' + angle + 'deg);';

								// target이 영역 밖에 있을 경우 tracker를 노출합니다.
								setVisible(true);
							}
						}

						// 상하좌우로 BOUNDS_BUFFER(30px)만큼 bounds를 확장 하는 함수
						//
						//  +-----------------------------+
						//  |              ^              |
						//  |              |              |
						//  |     +-----------------+     |
						//  |     |                 |     |
						//  |     |                 |     |
						//  |  <- |    Map Bounds   | ->  |
						//  |     |                 |     |
						//  |     |                 |     |
						//  |     +-----------------+     |
						//  |              |              |
						//  |              v              |
						//  +-----------------------------+
						//  
						// 여기서는 TooltipMaker가 완전히 안보이게 되는 시점의 영역을 구하기 위해서 사용됩니다.
						// TooltipMarker는 60x60 의 크기를 가지고 있기 때문에 
						// 지도에서 완전히 사라지려면 지도 영역을 상하좌우 30px만큼 더 드래그해야 합니다.
						// 이 함수는 현재 보이는 지도 bounds에서 상하좌우 30px만큼 확장한 bounds를 리턴합니다.
						// 이 확장된 영역은 TooltipMarker가 화면에서 보이는지를 판단하는 영역으로 사용됩니다.
						function extendBounds(bounds, proj) {
							// 주어진 bounds는 지도 좌표 정보로 표현되어 있습니다.
							// 이것을 BOUNDS_BUFFER 픽셀 만큼 확장하기 위해서는
							// 픽셀 단위인 화면 좌표로 변환해야 합니다.
							var sw = proj.pointFromCoords(bounds.getSouthWest());
							var ne = proj.pointFromCoords(bounds.getNorthEast());

							// 확장을 위해 각 좌표에 BOUNDS_BUFFER가 가진 수치만큼 더하거나 빼줍니다.
							sw.x -= BOUNDS_BUFFER;
							sw.y += BOUNDS_BUFFER;

							ne.x += BOUNDS_BUFFER;
							ne.y -= BOUNDS_BUFFER;

							// 그리고나서 다시 지도 좌표로 변환한 extBounds를 리턴합니다.
							// extBounds는 기존의 bounds에서 상하좌우 30px만큼 확장된 영역 객체입니다.  
							return new daum.maps.LatLngBounds(proj.coordsFromPoint(sw),
									proj.coordsFromPoint(ne));

						}

						// Cohen–Sutherland clipping algorithm
						// 자세한 내용은 아래 위키에서...
						// https://en.wikipedia.org/wiki/Cohen%E2%80%93Sutherland_algorithm
						function getClipPosition(top, right, bottom, left, inner, outer) {
							function calcOutcode(x, y) {
								var outcode = OUTCODE.INSIDE;

								if (x < left) {
									outcode |= OUTCODE.LEFT;
								} else if (x > right) {
									outcode |= OUTCODE.RIGHT;
								}

								if (y < top) {
									outcode |= OUTCODE.TOP;
								} else if (y > bottom) {
									outcode |= OUTCODE.BOTTOM;
								}

								return outcode;
							}

							var ix = inner.x;
							var iy = inner.y;
							var ox = outer.x;
							var oy = outer.y;

							var code = calcOutcode(ox, oy);

							while (true) {
								if (!code) {
									break;
								}

								if (code & OUTCODE.TOP) {
									ox = ox + (ix - ox) / (iy - oy) * (top - oy);
									oy = top;
								} else if (code & OUTCODE.RIGHT) {
									oy = oy + (iy - oy) / (ix - ox) * (right - ox);
									ox = right;
								} else if (code & OUTCODE.BOTTOM) {
									ox = ox + (ix - ox) / (iy - oy) * (bottom - oy);
									oy = bottom;
								} else if (code & OUTCODE.LEFT) {
									oy = oy + (iy - oy) / (ix - ox) * (left - ox);
									ox = left;
								}

								code = calcOutcode(ox, oy);
							}

							return {
								x : ox,
								y : oy
							};
						}

						// 말풍선의 회전각을 구하기 위한 함수
						// 말풍선의 anchor가 TooltipMarker가 있는 방향을 바라보도록 회전시킬 각을 구합니다.
						function getAngle(center, target) {
							var dx = target.x - center.x;
							var dy = center.y - target.y;
							var deg = Math.atan2(dy, dx) * 180 / Math.PI;

							return ((-deg + 360) % 360 | 0) + 90;
						}

						// tracker의 보임/숨김을 지정하는 함수
						function setVisible(visible) {
							tracker.style.display = visible ? 'block' : 'none';
						}

						// Map 객체의 'zoom_start' 이벤트 핸들러
						function hideTracker() {
							setVisible(false);
						}

						// target의 추적을 실행합니다.
						this.run = function() {
							daum.maps.event.addListener(map, 'zoom_start', hideTracker);
							daum.maps.event.addListener(map, 'zoom_changed', tracking);
							daum.maps.event.addListener(map, 'center_changed', tracking);
							tracking();
						};

						// target의 추적을 중지합니다.
						this.stop = function() {
							daum.maps.event.removeListener(map, 'zoom_start', hideTracker);
							daum.maps.event.removeListener(map, 'zoom_changed', tracking);
							daum.maps.event.removeListener(map, 'center_changed', tracking);
							setVisible(false);
						};
					}

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
					geocoder.addressSearch(parse[0].sisaddress,function(result, status) {

										// 정상적으로 검색이 완료됐으면 
										if (status === daum.maps.services.Status.OK) {

											var coords = new daum.maps.LatLng(result[0].y, result[0].x);

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
											var position = coords

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
	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top"
		id="mainNav">
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
						href="#about">소개</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#services">서비스</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#contact">연락처</a></li>
					<li class="nav-item" id="loginBtn"><a class="nav-link js-scroll-trigger"
						id="modal_trigger" href="#modal">로그인</a></li>
					<li class="nav-item" id="joinBtn"><a class="nav-link js-scroll-trigger"
						id="modal_trigger" href="TurnOn_JoinPage">회원가입</a></li>
					<li class="nav-item" id="logoutBtn"><a class="nav-link js-scroll-trigger"
						id="modal_trigger" href="Logout?page=sis_main">로그아웃</a></li>
					
				</ul>
			</div>
		</div>
	</nav>

	<header class="masthead" >
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

	<section  class="bg-dark" id="services">
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
			<h2></h2>
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
	<jsp:include page="${request.contextPath}/TurnOn_LoginPage"></jsp:include>
</body>

</html>
