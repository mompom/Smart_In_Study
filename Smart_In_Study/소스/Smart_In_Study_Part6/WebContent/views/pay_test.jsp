<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Favicon -->
<link rel="icon" href="images/favicon/favicon.ico">
<title>Smart In Study</title>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script type="text/javascript"
	src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

	<link rel="stylesheet" href="css/franchise.css"/>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"/>
		<link rel="stylesheet" type="text/css" href="css/normalize.css" />
		<link rel="stylesheet" type="text/css" href="css/demo.css" />
		<link rel="stylesheet" type="text/css" href="css/component.css" />

<style>
#half_toggle:nth-child(even){
	width : 50%;
	float : right;
}

#half_toggle:nth-child(odd){
	width : 50%;
	float : left;
}

.ui-datepicker select.ui-datepicker-month, .ui-datepicker select.ui-datepicker-year{
font-size : small;
}

.ui-datepicker .ui-datepicker-title {
    line-height: 2.8em;
</style>
<script>

	var IMP = window.IMP; // 생략가능
	IMP.init('imp29005954'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	$(document).ready(function() {
		

		$( "#datepicker1" ).datepicker({
		    dateFormat: 'yy-mm-dd',
		    prevText: '이전 달',
		    nextText: '다음 달',
		    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    dayNames: ['일','월','화','수','목','금','토'],
		    dayNamesShort: ['일','월','화','수','목','금','토'],
		    dayNamesMin: ['일','월','화','수','목','금','토'],
		    showMonthAfterYear: true,
		    selectOtherMonths: true ,
		    changeMonth: true,
		    changeYear: true,
		    yearSuffix: '년',
			minDate: 0,
			maxDate: "+5D",
			stepMonths: 1
		}); 
		   

		var oneSirJson = JSON.stringify(${sisOneSirList});
		var oneSirParse = JSON.parse(oneSirJson);

		var openSirJson = JSON.stringify(${sisOpenSirList});
		var opoenSirsParse = JSON.parse(openSirJson);

		var groupSirJson = JSON.stringify(${sisGroupSirList});
		var groupSirParse = JSON.parse(groupSirJson);
		
		
		
		
		
		var href = null;
		
		 
		// 방 종류 선택
		 $(".selectsir").click(function(){
					
					var oneSir = "";
					var openSir = "";
					var groupSir = "";
				//독립형 1인실
				if($("#selectbox option:selected").val() == "1인실"){
					for(var count = 0 ; count<10 ; count++){ 
						for(var i = 0  ; i<oneSirParse.length ; i++){
							if(oneSirParse[i].sircode=="O"+count){
							
								var j = i;
								var z = 0;
								while(j<oneSirParse.length){
									if(oneSirParse[j].sircode=="O"+(count+1)){
										break;
									}
								if(z==0){
									oneSir += "<div class=\"row\">";
									oneSir += "<input type=\"text\" value=\"O"+count+"\" class=\"seetType\" style=\"cursor: not-allowed;\" readonly/>";
									oneSir += "</div>";
								}else{
									oneSir += "<input type=\"button\" id=\"half_toggle\" value=\"O"+count+z+"\" class=\"seetType\"  />";
									if(j%2==0){
										
									}
								}
								z++;
								j++;
								}
							}
						}
					}//END 독립형 1인실
				$("#oneSirDiv").append(oneSir);
			 	}else if($("#selectbox option:selected").val() == "오픈형"){
					//오픈형열람실
					for(var count = 0 ; count<10 ; count++){ 
						for(var i = 0  ; i<opoenSirsParse.length ; i++){
							if(opoenSirsParse[i].sircode=="P"+count){
								
								var j = i;
								var z = 0;
								while(j<opoenSirsParse.length){
									if(opoenSirsParse[j].sircode=="P"+(count+1)){
										break;
									}
									if(z==0){
										openSir += "<div class=\"row\">";
										openSir += "<input type=\"text\" value=\"P"+count+"\" class=\"seetType\"  style=\"cursor: not-allowed;\" readonly/>";
										openSir += "</div>";
									}else{
										openSir += "<input type=\"button\" value=\"P"+count+z+"\" class=\"seetType\"  />";
										if(z==10){
										}
									}
								z++;
								j++;
								}
							}
						}
					}//END 오픈형열람실
				$("#openSirDiv").append(openSir);
				}else if($("#selectbox option:selected").val() == "그룹"){
					//그룹스터디룸
					for(var count = 0 ; count<10 ; count++){ 
						for(var i = 0  ; i<groupSirParse.length ; i++){
							if(groupSirParse[i].sircode=="G"+count){
							
								var j = i;
								var z = 0;
								while(j<groupSirParse.length){
									if(groupSirParse[j].sircode=="G"+(count+1)){
										break;
									}
									if(z==0){
										groupSir += "<div class=\"row\">";
										groupSir += "<input type=\"text\" value=\"G"+count+"\" class=\"seetType\" style=\"cursor: not-allowed;\" readonly/>";
										groupSir += "</div>";
									}else{
										groupSir += "<input type=\"button\" id=\"half_toggle\" value=\"G"+count+z+"\" class=\"seetType\" />";
										if(z==4){
										}
									}
								z++;
								j++;
								}
							}
						}
					}//END 그룹스터디룸
				$("#groupSirDiv").append(groupSir);
				}
				$("#deletesirbtn").toggle();
				$("#createsirbtn").toggle();
			});
		 
		 $(".deletesir").click(function(){
			$(".seetType").remove();
//  			$(document).find("br").remove();
 			$("#deletesirbtn").toggle();
			$("#createsirbtn").toggle();
			$("#paymentDiv").hide();
		 });
		 
		 $(document).on("click",".seetType",function(){
			
			  $.ajax({
					type : "POST",
					url : "AddSircode",
					data : {
						sircode : $(this).val()
					},
					// 전달 값
					dataType : "json",
					// json, xml, html(text): 안쓰면 html
					timeout : "5000",
					// 타임아웃
					success : function(data) {
						var json = JSON.stringify(data);
						var parse = JSON.parse(json);
						if(parse.page != null){
							alert(parse.page);
						}else{
						alert(parse.result);
						$("#paymentDiv").show();
						}	
					},
					error : function(data){
						alert("error");
					}
				});
	 	 });//자리선택 END
		 $(".test").click(function() {
			 
			 if($("#datepicker1").val() == ""){
				 alert("날짜를 선택해주세요.");
			 }else{
			 $.ajax({
					type : "POST",
					url : "AddSirprice",
					
					// 전달 값
					dataType : "json",
					// json, xml, html(text): 안쓰면 html
					timeout : "5000",
					// 타임아웃
					success : function(data) {
						var json = JSON.stringify(data);
						var parse = JSON.parse(json);
						if(parse.page != null){
							alert(parse.page);
						}else{
						
						
						 var mbJson = JSON.stringify(${memberinfo});
						 var mbParse = JSON.parse(mbJson);
			 			

			 			
					IMP.request_pay({
						pg : 'danal', // version 1.1.0부터 지원.
						pay_method : 'card',
						merchant_uid : 'SmartInStudy_' + new Date().getTime(),
						name : '주문명:결제테스트',
						amount : parse.result * $("#date option:selected").val(),
						buyer_email : mbParse.mbemail ,
						buyer_name : mbParse.mbname ,
						buyer_tel : mbParse.mbphonenumber ,
						buyer_addr : mbParse.mbaddress ,
						buyer_postcode : '', 
				}, function(rsp) {
					
					if (rsp.success) {
						var msg = '결제가 완료되었습니다.\n';
						msg += '고유ID : ' + rsp.imp_uid + "\n";
						msg += '상점 거래ID : ' + rsp.merchant_uid + "\n";
						msg += '결제 금액 : ' + rsp.paid_amount + "\n";
						msg += '카드 승인번호 : ' + rsp.apply_num + "\n";
						msg += '주문명 : ' + rsp.name + "\n";
						msg += '결제승인/시도된 PG사 : ' + rsp.pg_provider + "\n";
						msg += '주문자 이름 : ' + rsp.buyer_name + "\n";
						msg += '주문자 주소: ' + rsp.buyer_addr + "\n";
						msg += '주문자 우편번호 : ' + rsp.buyer_postcode + "\n";
						msg += '결제승인시각 : ' + rsp.paid_at + "\n";
						$.ajax({
							type : "POST",
							url : "Account_Member",
							data : {
								mbname : rsp.buyer_name ,
								approvalnumber : rsp.apply_num ,
								phaccountid : rsp.imp_uid,
								price : rsp.paid_amount,
								paymentdate : $("#date option:selected").val(),
								startdate :  $("#datepicker1").val()
							},
							// 전달 값
							dataType : "HTML",
							// json, xml, html(text): 안쓰면 html
							timeout : "5000",
							// 타임아웃
							success : function(){
								location.href = "TurnOn_PaymentPage_Member"
							}
						});
					} else {
						var msg = '결제에 실패하였습니다.\n';
						msg += '실패이유 : ' + rsp.error_msg;
					}
					alert(msg);
				
				});
					}
				},
				error : function(data){
					alert("error");
				}
			}); 
			 }
			 });
	});
	
</script>
</head>
<body>
<div class="container">
<div class="row">
<a href="TurnOn_Sis_Login_MainPage"><i class="fa fa-long-arrow-left" aria-hidden="true">&nbsp 이전페이지 이동</i></a>
	<h1>자리 선택</h1>
	<select class="half_l" id="selectbox">
		<option value="1인실">1인실</option>
		<option value="그룹">그룹실</option>
		<option value="오픈형">오픈형</option>
	</select>

	<div id="createsirbtn">
	<input type="button" class="selectsir half_r" value="자리유형선택" />
	</div>
	<div id="deletesirbtn" style="display: none;">
	<input type="button" class="deletesir half_r" value="자리유형재선택" />
	</div>
	
	<div id="oneSirDiv"></div>
	<div id="openSirDiv"></div>
	<div id="groupSirDiv"></div>
	<div id="paymentDiv" style="display: none;">
		<div class="row">
		<input type="text" placeholder="시작날자를 선택해주세요" id="datepicker1" class="half_l" readonly="readonly">
		<select class="half_r" id="date">
			<option value="결재 일수">결제 일수</option>
			<option value="1">1일</option>
			<option value="7">7일</option>
			<option value="30">30일</option>
		</select>
			<input type="button" class="test" value="연동" />
			</div>
	</div>
	</div>
		</div>
</body>
</html>