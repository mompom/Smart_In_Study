<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Favicon -->
<link rel="icon" href="images/favicon/favicon.ico">
<title>Smart In Study</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!--  유효성 검사 스크립트  -->
<!-- <script src="js/mb_validation.js"></script> -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.js"></script>
<!-- Daum 주소 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="js/common.js"></script>
<!--  스타일      -->
<link rel="stylesheet" href="css/mb_info.css">
<style>
strong, .c_header .contxt strong{
color: #f05f40!important;
}

.c_header h2{
font-weight : bold;

}

#b_txt_phoneNo_cncl{
border: 1px solid #bfbfbf;
    background: #fff;

min-width: 52px;
    height: 21px;
    padding: 10px 12px 0;
    color: #a3a3a3;
}

 #changeEmail, #changeAdd{
border: 1px solid #bfbfbf;
    background: #fff;
min-width: 52px;
    height: 29px;
    padding: 10px 12px 0;
    color: #a3a3a3;
    cursor:pointer;
}


#postfindo {
border: 1px solid #bfbfbf;
    background: #fff;
    min-width: 52px;
    height: 21px;
    padding: 10px 12px 0;
    color: #a3a3a3;
    height: 29px;
    cursor:pointer;
}


.btn_model:hover ,b:hover ,b.btn2:hover{
background-color: #f05f40;
color: white;
}
</style>


<script>
	/* 수정 취소 버튼 . 토글 */
	$(document).ready(function() {
		
		$('.mb_info_phone').click(function() {
			$('#p_phoneNo').toggle();
			$('#d_phoneNo').toggle();
			
		});
		
		$('.mb_info_email').click(function() {
			$('#d_email').toggle();
			$('#p_email').toggle();
		});
		
		$('.mb_info_address').click(function() {
			$('#d_myLetterEmail').toggle();
			$('#p_myLetterEmail').toggle();
			
		});
	
		//변경할 번호 인증 클릭
		$("#changePhonenumberBtn").click(function(){
			$("#phoneNo").attr("readonly","true");
			$("#authNo").removeAttr("disabled");
			
			mbphonenumber = $("#phoneNo").val();
			
			window1 = open(
					"TurnOn_Join_OtpPage?mbphonenumber="
							+ mbphonenumber,
					"popup",
					"left=1100, top=300, width=315,height=315, toolbars=no, scrollbars=no");

			window2 = open(
					"TurnOn_Join_Otp_IntroPage",
					"popup2",
					"left=600, top=100, width=420,height=560, toolbars=no, scrollbars=no");
		});
		
		//번호 수정취소 버튼
		$("#changePhonenumberBtn3").click(function(){
			
			$("#authNo").attr("disabled","true");
			$("#phoneNo").removeAttr("readonly");
			$('#p_phoneNo').show();
			$('#d_phoneNo').hide();
		});
		
		
		//번호 수정완료 버튼
		$("#changePhonenumberBtn2").click(function(){
			$.ajax({
				type : "POST",
				url : "User_OtpCode",
				data : {
				mbphonenumber : $("#phoneNo").val(),
				user_code : $("#authNo").val(),
				page : "mb_contact_change"
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
				var text = "";
				if(parse.result){
					alert("번호 수정이 완료되었습니다. ");
				if($("#resultPhoneNo").length){$("#resultPhoneNo").remove()}
					text += "<div id=\resultPhoneNo\">";
					text += parse.mbphonenumber;
					text += "</div>";
					
					$("#p_txt_phoneNo").append(text);
					
				}else{
					alert("인증에 실패하였습니다.\n인증번호를 확인해주세요.");
				}
				
				alert(json);	
				},

				error : function(error) { // 실패
				alert("인증번호를 확인해주세요.");
				$(".user_code").focus();

				}
			});
		})
		//이메일 수정
		$("#changeEmail").click(function(){
			alert($("#inpEmail").val());
			var email = $("#inpEmail").val();
			var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
					if(exptext.test(email)==false){
				//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
				alert("이메일형식이 올바르지 않습니다.");
				email.focus();
				
			}else{

			alert($("#inpEmail").val());
			alert($("#mbid").val());
			
	 			$.ajax({
					
					type : "post",
					url : "ChangeEmail",
					data : {
					mbemail : $("#inpEmail").val(),
					mbid : $("#mbid").val()
					},
					
					dataType : "json",
					timeout : "5000",
					
					success : function(data) {
						var json = JSON.stringify(data);
						var parse = JSON.parse(json);

					 // 성공
					  if(parse.result=="scuccess"){
					alert("이메일이 수정되었습니다. \n변경된 이메일 : "+ parse.mbemail+ "");
					 }else{
						 
					 }
					},
					
					// 실패
					error : function(error) { 
						alert("error");
						console.log(error);
					}
	 			
				}); 
				
			
			}
		});
		
		
		//주소 수정
		$("#changeAdd").click(function(){
			
				alert('hi');
				var address = $("#address").val()+ " "+ $("#address2").val();
				alert($("#mbid").val());
				alert(address);
				
				
				if( $("#address").val()!=""){
					alert("true");
					$.ajax({
						type : "post",
						url : "ChangeAdd",
						data : {
							
							mbaddress : address,
							mbid : $("#mbid").val()
							
						},
						
						dataType : "html",
						timeout : "5000",
						
						success : function(data) {
							
						// 성공
						alert("주소가 수정되었습니다. \n변경된 주소 : "+ address+ "");
						
						},

						error : function(error) { // 실패}
							alert("error");
							console.log(error);
						} 
					});		
				}else{
					$("#address").focus();
					alert("제대로된 주소를 입력해주세요.");
				}
		});
	});
</script>

</head>
<body>
	<div id="content">
		<div class="c_header">
			<h2>연락처 수정</h2>
			<p class="contxt">
				<strong>${mbid}</strong>님의 연락처 정보입니다.<br> 회원정보는 개인정보처리방침에 따라
				안전하게 보호되며, 회원님의 명백한 동의 없이 공개 또는 제 3자에게 제공되지 않습니다. <a
					href="http://www.law.go.kr/lsInfoP.do?lsiSeq=173223&efYd=20150724#0000"
					target="_blank" onclick="">개인정보처리방침</a>
			</p>
		</div>

		<table border="0" class="tbl_model">
			<caption>
				<span class="blind">연락처 수정 입력</span>
			</caption>
			<colgroup>
				<col style="width: 22%">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">
						<div class="thcell">
							사용자 <span class="word_br">이름</span>
						</div>
					</th>

					<td>
						<form id="" name="">
							<div class="tdcell">
								<p class="contxt_tit">${mbname }</p>
								<p class="contxt_desc">실명 정보(이름, 생년월일, 성별, 개인 고유 식별 정보)가 변경된
									경우 본인 확인을 통해 정보를 수정하실 수 있습니다.</p>
								<!-- <p class="btn_area_btm">
									<a class="btn_model"><b class="btn2">수정</b></a>
								</p> -->
							</div>
						</form>
					</td>
				</tr>

				<!--  휴대전화  -->
				<tr>
					<th scope="row">
						<div class="thcell">휴대전화</div>
					</th>
					<td>
						<form>
							<div class="tdcell">
								<p id="p_txt_phoneNo" class="contxt_tit"><div id="resultPhoneNo">${mbphonenumber}</div></p>
								<p class="contxt_desc">아이디, 비밀번호 찾기 등 본인확인이 필요한 경우 또는 유료 결제
									등 네이버로부터 알림을 받을 때 사용할 휴대전화입니다.</p>
								<div id="d_phoneNo" style="display: none">
									<p id="p_txt_phoneNo_changeYn" class="contxt_tit2">
										<label for="phoneNo">변경할 휴대전화</label>
									</p>
									<p class="contxt_webctrl">

											<input type="text" id="phoneNo" name="phoneNo" maxlength="14"
											onkeydown="check_num_ajax2('phoneNo', '2', 'e_phoneNo','e_authNo');">
										<a id="changePhonenumberBtn" class="btn_model">
										<span class="btn4">인증</span></a>
									</p>
									<p id="e_phoneNo" class="contxt_alert"></p>

									<p class="contxt_tit2">
										<label for="authNo">인증번호 입력</label>
									</p>
									<p class="contxt_webctrl">
										<input type="text" id="authNo" name="authNo" value=""
											maxlength="6"
											onkeydown="check_num_ajax2('authNo', '2', 'e_authNo','e_phoneNo');"
											disabled class="focus" style="width: 254px">
									</p>
									<p id="e_authNo" class="contxt_alert"></p>

									<p class="btn_area_btm">
										<a id="changePhonenumberBtn2" class="btn_model">
										<b id="b_txt_phoneNo_reg" class="btn3">수정완료</b></a> 
										<a id="changePhonenumberBtn3" class="btn_model">
										<b id="b_txt_phoneNo_cncl" class="mb_info_phone">수정취소</b></a>
									</p>
								</div>
								<p id="p_phoneNo" class="btn_area_btm">
									<a href="#" onclick="" class="btn_model"><b
										class="mb_info_phone">수정</b></a>
								</p>
							</div>
						</form>
					</td>
				</tr>


				<!--  이메일     -->
				<tr>
					<th scope="row">
						<div class="thcell">
							<span class="word_br">이메일</span>
						</div>
					</th>
					<td>
						<form role="form" id="register-form" autocomplete="off"
							action="ChangeEmail" method="post">
							<div class="tdcell">
								<p id="p_txt_myLetterEmail" class="contxt_tit">${mbemail}</p>
								<p class="contxt_desc">이벤트 등 다양한 네이버의 소식 및 알림을 받기 위해 사용할 이메일
									주소입니다.</p>
								<div id="d_email" style="display: none">
									<p class="contxt_tit2">
										<label for="myLetterEmail">변경할 이메일</label>
									</p>
									<p class="contxt_desc">변경할 이메일 주소를 입력하세요.(예 :
										abc@google.com)</p>
									<p class="contxt_webctrl">
										<input type="text" name="mbemail" id="inpEmail" value=""
											style="width: 254px">
										<input type="text" name="mbid"
											id="mbid" value="${mbid }" style="display: none;">
										<input type="button" value="수정" class="btn_model" id="changeEmail"/>
									</p>
									<!-- <p id="e_myLetterEmail" class="contxt_alert"></p>
									<p class="btn_area_btm">
										<a href="#" onclick="" class="btn_model"><b class="btn3">수정완료</b></a>
										
									<a href="#" onclick="" class="btn_model"><b
										class="mb_info_email">수정취소</b></a> 

									</p> -->
								</div>
								<p id="p_email" class="btn_area_btm">
									<a href="#" onclick="" class="btn_model"><b
										class="mb_info_email">수정</b></a>
										
								</p>
							</div>
						</form>
					</td>
				</tr>


				<!--  주소     -->
				<tr>
					<th scope="row">
						<div class="thcell">
							<span class="word_br">주소</span>
						</div>
					</th>
					<td>
					<form role="form" id="register-form" autocomplete="off" Action="ChangeAdd" Method="POST">
						<div class="tdcell">
							<p id="p_txt_myLetterEmail" class="contxt_tit">${mbaddress}</p>
								
							<p class="contxt_desc">이벤트 등 다양한 네이버의 소식 및 알림을 받기 위해 사용할
								주소입니다.</p>

							<div id="d_myLetterEmail" style="display: none;">
								<p class="contxt_tit2">
									<label for="myLetterEmail">변경할 주소</label>
								</p>
								<p class="contxt_desc">변경할 주소를 입력하세요.</p>
								<p class="contxt_webctrl">
								
									<input type="text" id="address" placeholder="주소" readonly="readonly" style="width:70%;">
									<input type="text" id="address2" placeholder="상세주소" style="width:70%;">
									<input type="text" name="mbid"
											id="mbid" value="${mbid }" style="display: none;">
											<br>
											
												<input type="button" id="postfindo"
										onClick="Postcode()" value="우편번호 찾기">
									<input type="button" value="수정" class="btn_model" id="changeAdd"/>
											

									<!-- 	<input type="text" name="myLetterEmail" id="myLetterEmail"
										value="" style="width: 254px"> -->
								</p>
								<p id="e_myLetterEmail" class="contxt_alert"></p><!-- 
								<p class="btn_area_btm">
									<a href="#" onclick="" class="btn_model"><b class="btn3">수정완료</b></a>
									<a href="#" onclick="" class="btn_model"><b
										class="mb_info_address">수정취소</b></a>
								</p> -->
							</div>
							<p id="p_myLetterEmail" class="btn_area_btm"
								style="display: block;">
								<a href="#" onclick=""
									id="dodododo" class="btn_model"><b  class="mb_info_address">수정</b></a>
							</p>
						</div>
						</form>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="resize-triggers">
			<div class="expand-trigger">
				<div style="width: 601px; height: 1033px;"></div>
			</div>
			<div class="contract-trigger"></div>
		</div>
	</div>
</body>
</html>