<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/franchise.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/normalize.css" />
<link rel="stylesheet" type="text/css" href="css/demo.css" />
<link rel="stylesheet" type="text/css" href="css/component.css" />
<!-- Favicon -->
<link rel="icon" href="images/favicon/favicon.ico">
<title>Smart In Study</title>
<style>
.component {
	line-height: 1.5em;
	margin: 0 auto;
	padding: 2em 0 3em;
	max-width: 55em;
	width: 100%;
}

table {
font-size : small;
}

th{
background-color:#f05f40;
}
.container {
	padding: 0em;
	max-width: 60em;
}

input[type=button]{
    display: -webkit-box;
    width: 35%;
    text-align: center;
    margin: 0 auto;
}
</style>

</head>
<body>

	<div class="container">
	<a href="TurnOn_Sis_Login_MainPage"><i class="fa fa-long-arrow-left" aria-hidden="true">&nbsp 메인페이지 이동</i></a>
		<div id="resultTable">
			<div class="component">
				<table>
					<thead>
						<tr>
							<th>결재 코드</th>
							<th>독서실 코드명</th>
							<th>자리 코드명</th>
							<th>아이디</th>
							<th>시작일</th>
							<th>종료일</th>
							<th>결재가격</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${phaccountid}</td>
							<td>${siscode }</td>
							<td>${sircode }</td>
							<td>${mbid }</td>
							<td>${phdate }</td>
							<td>${phenddate }</td>
							<td>${price }</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
		<input type="button" onClick="TurnOn_Sis_Login_MainPage" value="메인으로 이동"/>
		
		</div>
	</div>
</body>
</html>