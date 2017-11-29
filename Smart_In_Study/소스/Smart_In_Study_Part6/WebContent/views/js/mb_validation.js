//JavaScript Validation For Registration Page

$(function()

		{

	// id validation
	var idregex = /^[a-zA-Z0-9]+$/;
	$.validator.addMethod("validid", function(value, element) {
		return this.optional(element) || idregex.test(value);
	});

	// name validation
	var nameregex = /^[가-힣a-zA-Z]+$/;
	$.validator.addMethod("validname", function(value, element) {
		return this.optional(element) || nameregex.test(value);
	});

	// nick validation
	var nickregex = /^[가-힣a-zA-Z]+$/;
	$.validator.addMethod("validnick", function(value, element) {
		return this.optional(element) || nickregex.test(value);
	});

	// birth validation
	var birthregex = /^([0-9])+$/;
	$.validator.addMethod("validbirth", function(value, element) {
		return this.optional(element) || birthregex.test(value);
	});

	// age validation
	var ageregex = /^([0-9])+$/;
	$.validator.addMethod("validage", function(value, element) {
		return this.optional(element) || ageregex.test(value);
	});

	// phone validation
	var phoneregex = /^[0-9-]+$/;
	$.validator.addMethod("validphone", function(value, element) {
		return this.optional(element) || phoneregex.test(value);
	});

	// valid email pattern
	var eregex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	$.validator.addMethod("validemail", function(value, element) {
		return this.optional(element) || eregex.test(value);
	});

	$("#register-form")
	.validate(
			{
				rules : {
					mbid : {
						required : true,
						validid : true,
						minlength : 5,
						maxlength : 15
					},

					mbpw : {
						required : true,
						minlength : 5,
						maxlength : 15
					},

					mbspw : {
						required : true,
						equalTo : '#password'
					},

					mbname : {
						required : true,
						validname : true,
						minlength : 2,
						maxlength : 5
					},
					mbnick : {
						required : true,
						validnick : true,
						minlength : 2,
						maxlength : 10
					},

					mbbirth : {
						required : true,
						validbirth : true,
						minlength : 6,
						maxlength : 6
					},

					mbage : {
						required : true,
						validage : true,
						minlength : 1,
						maxlength : 2
					},

					mbphonenumber : {
						required : true,
						validphone : true,
						minlength : 11,
						maxlength : 11
					},

					mbemail : {
						required : true,
						validemail : true
					},

					rsname : {
						required : true,
						validemail : true,
						minlength : 2,
						maxlength : 5
					},
					rsphonenumber : {
						required : true,
						validphone : true,
						minlength : 11,
						maxlength : 11
					},

				},

				messages : {
					mbid : {
						required : "아이디를 입력해주세요.",
						validid : "아이디를 제대로 입력해주세요.(대/소문자,숫자만)",
						minlength : "아이디 5자리 이상 입력해주세요.",
						maxlength : "아이디 15자리를 넘어가지 말아주세요."
					},

					mbpw : {
						required : "패스워드를 입력해주세요.",
						minlength : "패스워드 5자리 이상 입력해주세요.",
						maxlength : "패스워드 15자리를 넘어가지 말아주세요."
					},

					mbspw : {
						required : "패스워드를 재입력해주세요.",
						equalTo : "패스워드가 일치하지 않습니다."
					},

					mbname : {
						required : "이름을 입력해주세요.",
						validname : "이름을 제대로 입력해주세요.(한글만)",
						minlength : "이름을 최소 2글자 입력해주세요.",
						maxlength : "이름을 5글자 넘기지 말아주세요."
					},

					mbnick : {
						required : "닉네임을 입력해주세요.",
						validname : "닉네임을 제대로 입력해주세요.(한글만)",
						minlength : "닉네임을 최소 2글자 입력해주세요.",
						maxlength : "닉네임을 10글자 넘기지 말아주세요."
					},

					mbbirth : {
						required : "생년월일을 입력해주세요.",
						validbirth : "생년월일을 제대로 입력해주세요.(ex.901010)",
						minlength : "숫자 6자리를 입력해주세요.",
						maxlength : "숫자 6자리를 입력해주세요."
					},

					mbage : {
						required : "나이를 입력해주세요.",
						validage : "나이를 제대로 입력해주세요.(숫자)",
						minlength : "최소 1자리를 입력해주세요.",
						maxlength : "최대 2자리를 입력해주세요."
					},

					mbemail : {
						required : "메일을 입력해주세요.",
						validemail : "메일을 제대로 입력해주세요."
					},

					mbphonenumber : {
						required : "핸드폰 번호를 입력해주세요.",
						validphone : "핸드폰 번호를 제대로 입력해주세요.",
						minlength : "하이픈(-)과 함께 11자리 입력해주세요.",
						maxlength : "하이픈(-)과 함께 11자리 입력해주세요."
					},
					rsname : {
						required : "이름을 입력해주세요.",
						validname : "이름을 제대로 입력해주세요.(한글만)",
						minlength : "이름을 최소 2글자 입력해주세요.",
						maxlength : "이름을 5글자 넘기지 말아주세요."
					},
					rsphonenumber : {
						required : "핸드폰 번호를 입력해주세요.",
						validphone : "핸드폰 번호를 제대로 입력해주세요.",
						minlength : "하이픈(-)을 제외한 11자리 입력해주세요.",
						maxlength : "하이픈(-)을 제외한 11자리 입력해주세요."
					},
				},

				errorPlacement : function(error, element) {
					$(element).closest('.form-group').find(
					'.help-block').html(error.html());
				},

				highlight : function(element) {
					$(element).closest('.form-group').removeClass(
					'has-success').addClass('has-error');
				},

				unhighlight : function(element, errorClass, validClass) {
					$(element).closest('.form-group').removeClass(
					'has-error').addClass('has-success');
					$(element).closest('.form-group').find(
					'.help-block').html('');
				},

				submitHandler : function(form) {
								var name = $("#submit").attr('name');
								
								
								switch (name) {
								
								case "join":		
									var idcheck = $("#idcheck").val();
									var otpcheck = $("#otpcheck").val();
									if (idcheck == ""){
										alert("중복확인을 해주세요.");
									}else{
										if (otpcheck == ""){
											alert("핸드폰 인증을 받아주세요.")
										}else{
											if (grecaptcha.getResponse() == "") {
												alert("스팸방지코드를 확인해 주세요.");
											} else {
												var birthday = $("#dobyear").val()+ $("#dobmonth").val()+ $("#dobday").val();
												var address = $("#address").val()+ " "+ $("#address2").val();
												var genders = $(".btn-group input:checked").val();
												var form = createForm("joinforms","Join", "post");


												// createObj(objType,objName, objValue,objPlaceholder);
												createObj("hidden","mbbirthday",birthday, "");
												createObj("hidden","mbgender",genders, "");
												createObj("hidden","mbaddress",address, "");
												createObj("hidden","page", "join","");

												// relationObj(formName,objName);
												relationObj("joinforms","mbid");
												relationObj("joinforms","mbpw");
												relationObj("joinforms","mbnick");
												relationObj("joinforms","mbname");
												relationObj("joinforms","mbbirthday");
												relationObj("joinforms","mbgender");
												relationObj("joinforms","mbphonenumber");
												relationObj("joinforms","mbemail");
												relationObj("joinforms","mbaddress");
												relationObj("joinforms","page");

												form.submit();
												/* 로그인 된 상태로 페이지 이동해야함. */
											}
										}
									}
									break;

								case "changeNick":
									$.ajax({
										type : "post",
										url : "ChangeNick",
										data : {mbnick : $("#inpNickname").val(),mbid : $("#mbid").val()
										},
										// 전달 값
										dataType : "html",
										// json, xml,html
										
										//(text):안쓰면 html
										timeout : "5000",
										// 타임아웃
										success : function(data) {
											// 성공
											alert("닉네임이 수정되었습니다.\n변경된 닉네임 : "+ $("#inpNickname").val()+ "");
										},

										error : function(error) { // 실패
											alert("error");
											console.log(error);
										}
									});
									break;
									
								case "changePw":
									if (grecaptcha.getResponse() == "") {
										alert("스팸방지코드를 확인해 주세요.");
									} else {
										$.ajax({
											type : "post",
											url : "ChangePw",
											data : {mbpw : $("#password").val(),
													mbid : $("#mbid").val()
											},
											// 전달 값
											dataType : "html",
											// json, xml,html
											
											//(text):안쓰면 html
											timeout : "10000",
											// 타임아웃
											success : function(data) {
												// 성공
												
												location.href="TurnOn_SelectSisPage";
												alert("비밀번호가 수정되었습니다."+ "");
												
												
											},
	
											error : function(error) { // 실패
												alert("error");
												console.log(error);
											}
										});
									}
									break;
									
								default:
									break;
								}
							}
						});
			});