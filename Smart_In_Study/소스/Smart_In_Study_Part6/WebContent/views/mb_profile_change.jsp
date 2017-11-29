<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Favicon -->
<link rel="icon" href="images/favicon/favicon.ico">
<title>Smart In Study</title>
<link rel="stylesheet" href="css/mb_info.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js">
	
</script>
<script src="js/mb_validation.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.js"></script>
</head>
<body>
	<div id="content">
		<div class="c_header">
			<h2>프로필 수정</h2>
			<p class="contxt">Smart In Study 대표 프로필과 별명을 수정 하실 수 있습니다.</p>
		</div>

		<table border="0" class="tbl_model">
			<caption>
				<span class="blind">프로필 수정</span>
			</caption>
			<colgroup>
				<col style="width: 22%">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">
						<div class="thcell">프로필 사진</div>
					</th>
					<td>
						<div class="tdcell">
							<div class="profile_photo">
								<img id="imgThumb"
									src="https://phinf.pstatic.net/contact/20171008_185/1507435526157ooH13_JPEG/image.jpg?type=s160"
									width="100" height="100"> <span class="mask"></span>
							</div>
							<p class="btn_area_btm">
								<span class="btn_file"> <label for="inputImage"
									class="btn_model"><b id="btnChangeProfile" class="btn2">사진변경</b></label>
									<input type="file" id="inputImage" name="profileImage"
									accept="image/*">
								</span> <a href="" class="btn_model"><b id="btnDelete" class="btn2">삭제</b></a>
							</p>
						</div>
					</td>
				</tr>

				<tr>
					<!--  별명 변경   -->
					<th scope="row">
						<div class="thcell">
							<label for="inpNickname">별명</label>
						</div>
					</th>
					<td>
						<form role="form" id="register-form" autocomplete="off"
							action="ChangeNick" method="post">
							<div class="tdcell">
								<p class="contxt_webctrl nickname">
									<input type="text" name="nickname" value="${mbnick }"
										style="width: 254px"> 
										<input type="text" name="mbnick"
										id="inpNickname" value="" style="width: 254px">

									<!-- Enter 입력으로 submit이 되는걸 방지하기 위한 Input -->
									<!-- <input type="text" style="display: none;"> <a
										onClick="startAjax();" class="btn_model"><b
										id="btnConfirm" class="btn8 btn_disable">수정</b></a> -->
									<input type="text" name="mbid" id="mbid" value="${mbid }"
										style="display: none;">
									<button type="submit" id="submit" name="changeNick">
										수정</button>
								<div id="test"></div>

								</p>

							</div>

						</form>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="btn_wrap">
			<a href="javascript:;" class="btn_model"><b id="btnConfirm"
				class="btn8 btn_disable">적용</b></a> <a href="javascript:;"
				class="btn_model"><b id="btnCancel" class="btn2">취소</b></a>
		</div>
		<div class="resize-triggers">
			<div class="expand-trigger">
				<div style="width: 955px; height: 597px;"></div>
			</div>
			<div class="contract-trigger"></div>
		</div>
	</div>
</body>
</html>