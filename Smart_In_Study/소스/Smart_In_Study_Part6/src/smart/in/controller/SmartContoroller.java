package smart.in.controller;

import java.io.File;
import java.io.IOException;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import smart.in.beans.DbPaymentBean;
import smart.in.beans.DbSensorBean;
import smart.in.beans.GoalsBean;
import smart.in.beans.MemberBean;
import smart.in.beans.OtpBean;
import smart.in.beans.PaymentBean;
import smart.in.beans.RequestBean;
import smart.in.beans.SensorBean;
import smart.in.beans.SisBean;
import smart.in.service.AdminService;
import smart.in.service.AjaxService;
import smart.in.service.MemberService;
import smart.in.service.OtpService;
import smart.in.service.SensorService;
import smart.in.utils.Session;

@Controller
public class SmartContoroller {

	private ModelAndView mav = null;

	@Autowired
	AdminService adminService;

	@Autowired
	MemberService memberService;

	@Autowired
	SensorService sensorService;

	@Autowired
	AjaxService ajaxService;

	@Autowired
	OtpService otpService;

	@Autowired
	private Session session;

	/* View Controller */

	// 메인페이지 호출(지역 독서실정보와 함께)
	@RequestMapping(value = "/", method = RequestMethod.GET)
	// Client에서 넘어올 데이터가 없는 경우 , 보안이 필요없는 경우 GET 방식
	public ModelAndView main() throws Exception {
		mav = adminService.entrance(1);

		session.removeAttribute("siscode");

		return mav;
	}

	// 최종 관리자의 메인페이지 로그인
	@RequestMapping(value = "/Main_Login_Admin", method = RequestMethod.GET)
	// Client에서 넘어올 데이터가 없는 경우 , 보안이 필요없는 경우 GET 방식
	public ModelAndView login_main() throws Exception {
		mav = adminService.entrance(2);

		return mav;
	}

	// 최종 관리자의 프렌차이즈 요청 확인 페이지 이동
	@RequestMapping(value = "/TurnOn_Admin_Franchisee_FindPage", method = RequestMethod.GET)
	// Client에서 넘어올 데이터가 없는 경우 , 보안이 필요없는 경우 GET 방식
	public ModelAndView turnOn_admin_franchisee_findPage() throws Exception {

		mav = adminService.entrance(9);

		return mav;
	}

	// 최종 관리자의 프렌차이즈 요청 확인 페이지의 현황 종류 선택(Ajax)
	@RequestMapping(value = "/Admin_Request_Kind", method = RequestMethod.GET, produces = "application/text;charset=UTF-8")
	// Client에서 넘어올 데이터가 없는 경우 , 보안이 필요없는 경우 GET 방식
	public @ResponseBody String admin_request_kind(RequestBean requestBean) throws Exception {
		String result = "";
		result = (String) ajaxService.entrance(11, requestBean);

		return result;
	}

	// 최종 관리자의 프렌차이즈 요청확인 페이지에서 Setup페이지로 이동
	@RequestMapping(value = "/TurnOn_Admin_Franchisee_SetupPage", method = RequestMethod.POST)
	// Client에서 넘어올 데이터가 없는 경우 , 보안이 필요없는 경우 GET 방식
	public ModelAndView turnOn_admin_franchisee_setupPage(RequestBean requestBean) throws Exception {
		mav = new ModelAndView();

		session.setAttribute("rsaddress", requestBean.getRsaddress());
		mav.addObject("rsaddress", requestBean.getRsaddress());
		mav.addObject("rsphonenumber", requestBean.getRsphonenumber());

		mav.setViewName("admin_franchisee_setup");
		return mav;
	}

	// 메인페이지 내에서 지역 선택(Ajax)
	@RequestMapping(value = "/SelectLocation", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public @ResponseBody String selectLocation(@ModelAttribute SisBean sisBean) throws Exception {
		String result = "";

		result = (String) ajaxService.entrance(1, sisBean);

		return result;
	}

	// 메인페이지 로그인에서 지역 선택(Ajax)
	@RequestMapping(value = "/SelectLocationlogin", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public @ResponseBody String slectLocationlogin(@ModelAttribute SisBean sisBean) throws Exception {
		String result = "";
		result = (String) ajaxService.entrance(3);

		return result;
	}

	// 메인 페이지 내에서 독서실 클릭
	@RequestMapping(value = "/TurnOn_SelectSisPage", method = RequestMethod.GET)
	public ModelAndView turnOn_selectSisPage(@ModelAttribute SisBean sisBean) throws Exception {

		mav = memberService.entrance(5, sisBean);

		return mav;
	}

	// 로그인된 독서실 페이지 이동
	@RequestMapping(value = "/TurnOn_Sis_Login_MainPage", method = RequestMethod.GET)
	public ModelAndView turnOn_sis_login_mainPage() throws Exception {

		mav = new ModelAndView();
		mav.setViewName("sis_login_main");
		return mav;
	}

	// 독서실 내용 출력
	@RequestMapping(value = "/TurnOn_SelectSisPage_Contents", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public @ResponseBody String turnOn_selectSisPage_contents(@ModelAttribute SisBean sisBean) throws Exception {

		String result = (String) ajaxService.entrance(6, sisBean);

		return result;
	}

	// jsp:include를 통한 login페이지 호출
	@RequestMapping(value = "/TurnOn_LoginPage", method = RequestMethod.GET)
	// Client에서 넘어올 데이터가 없는 경우 , 보안이 필요없는 경우 GET 방식
	public String turnOn_loginPage(@ModelAttribute MemberBean memberBean) throws Exception {

		return "login";
	}

	// join에서 otppage 팝업창 호출
	@RequestMapping(value = "/TurnOn_Join_OtpPage", method = RequestMethod.GET)
	// Client에서 넘어올 데이터가 없는 경우 , 보안이 필요없는 경우 GET 방식
	public ModelAndView turnOn_join_otpPage(HttpServletRequest request) throws Exception {
		mav = new ModelAndView();

		mav.addObject("mbphonenumber", request.getParameter("mbphonenumber"));
		mav.setViewName("join_otpPage");

		return mav;
	}

	// join에서 otp_intropage 팝업창 호출
	@RequestMapping(value = "/TurnOn_Join_Otp_IntroPage", method = RequestMethod.GET)
	// Client에서 넘어올 데이터가 없는 경우 , 보안이 필요없는 경우 GET 방식
	public String turnOn_join_otp_introPage() throws Exception {

		return "join_otp_intro";
	}

	// otp qrcode호출(Ajax)
	@RequestMapping(value = "/Otp_QrCode", method = RequestMethod.GET, produces = "application/text;charset=UTF-8")
	// Client에서 넘어올 데이터가 없는 경우 , 보안이 필요없는 경우 GET 방식
	public @ResponseBody String otp_qrCode(@ModelAttribute MemberBean memberBean) throws Exception {
		String result = "";
		result = (String) ajaxService.entrance(7, memberBean);
		return result;
	}

	// user code 일치여부 확인
	@RequestMapping(value = "/User_OtpCode", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	// Client에서 넘어올 데이터가 없는 경우 , 보안이 필요없는 경우 GET 방식
	public @ResponseBody String user_otpCode(@ModelAttribute OtpBean otpBean) throws Exception {
		String result = "";
		result = (String) ajaxService.entrance(8, otpBean);



		return result;
	}

	// 회원가입페이지 이동
	@RequestMapping(value = "/TurnOn_JoinPage", method = RequestMethod.GET)
	// Client에서 넘어올 데이터가 없는 경우 , 보안이 필요없는 경우 GET 방식
	public ModelAndView turnOn_joinPage() throws Exception {

		mav = new ModelAndView();

		mav.setViewName("join");
		return mav;
	}

	// 개인정보 페이지에서 연락처 수정 페이지로 이동
	@RequestMapping(value = "/TurnOn_ContactPage", method = RequestMethod.POST)
	public ModelAndView turnOn_ContactPage(@ModelAttribute MemberBean memberBean) throws Exception {
		mav = memberService.entrance(2, memberBean);

		return mav;
	}

	// 자리코드 추가
	@RequestMapping(value = "/AddSircode", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public @ResponseBody String addsircode(@ModelAttribute MemberBean memberBean) throws Exception {


		String result = "";
		result = (String) ajaxService.entrance(19, memberBean);


		return result;

	}

	//자리정보 확인
	@RequestMapping(value = "/sircodecheck", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public @ResponseBody String sircodecheck(@ModelAttribute MemberBean memberBean) throws Exception {


		String result = "";
		result = (String) ajaxService.entrance(23, memberBean);

		System.out.println(result);

		return result;

	}

	//결제금액 체크
	@RequestMapping(value = "/AddSirprice", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public @ResponseBody String addsirprice(@ModelAttribute MemberBean memberBean) throws Exception {

		String result = "";
		result = (String) ajaxService.entrance(20, memberBean);


		return result;
	}

	// 개인 정보페이지에서 닉네임 수정페이지 이동
	@RequestMapping(value = "/TurnOn_ProfilePage", method = RequestMethod.POST)
	public ModelAndView turnOn_profilePage(@ModelAttribute MemberBean memberBean) throws Exception {

		mav = memberService.entrance(3, memberBean);

		return mav;
	}

	// 개인정보 페이지에서 비밀번호 변경페이지 이동
	@RequestMapping(value = "/TurnOn_PasswordPage", method = RequestMethod.GET)
	public ModelAndView turnOn_passwordPage() {

		mav = new ModelAndView();

		mav.setViewName("mb_pw_change");

		return mav;
	}

	// 개인메일서버에서 비밀번호 변경페이지 이동
	@RequestMapping(value = "/TurnOn_PasswordPage_Email", method = RequestMethod.POST)
	public ModelAndView turnOn_passwordPage_email(@ModelAttribute MemberBean memberBean) {

		mav = new ModelAndView();


		mav.setViewName("mb_pw_change");

		return mav;
	}

	// 독서실 메인페이지에서 아이디/비밀번호찾기 페이지 이동
	@RequestMapping(value = "/TurnOn_IdPwFindPage_Member", method = RequestMethod.GET)
	public ModelAndView turnOn_idPwFindPage_member() {

		mav = new ModelAndView();

		mav.setViewName("sis_id_pw_find");

		return mav;
	}

	// 회원 정보 페이지 이동 >> RequestMapping( value = PwCheck )
	@RequestMapping(value = "/TurnOn_InfoPage", method = RequestMethod.GET)
	public ModelAndView turnOn_infoPage() throws Exception {

		mav = new ModelAndView();

		mav.setViewName("mb_info_pwcheck");

		return mav;
	}

	// 회원 결제 페이지 이동
	@RequestMapping(value = "/TurnOn_AccountPage_Member", method = RequestMethod.GET)
	public ModelAndView turnOn_accountPage_member() throws Exception {

		mav = memberService.entrance(7);
		return mav;
	}

	// 회원 입퇴실기록 페이지 이동
	@RequestMapping(value = "/TurnOn_InOutPage_Member", method = RequestMethod.POST)
	public ModelAndView turnOn_inOutPage_member() {

		return mav;
	}

	// 회원 결제내역 페이지 이동
	@RequestMapping(value = "/TurnOn_PaymentPage_Member", method = RequestMethod.GET)
	public ModelAndView turnOn_paymentPage_member(@ModelAttribute PaymentBean paymentBean) throws Exception {

		mav = memberService.entrance(24, paymentBean);

		return mav;
	}

	// 회원 목표페이지 이동
	@RequestMapping(value = "/TurnOn_GoalsPage_Member", method = RequestMethod.POST)
	public ModelAndView turnOn_goalsPage_member() {

		return mav;
	}

	// 센서 데이터 페이지 동
	@RequestMapping(value = "/TurnOn_SensorPage", method = RequestMethod.POST)
	public ModelAndView turnOn_sensorPage() {

		return mav;
	}

	// 독서실 관리 페이지로 이동 (독서실 관리자)
	@RequestMapping(value = "/TurnOn_Sis_Admin_ManagementPage", method = RequestMethod.GET)
	public ModelAndView turnOn_sis_admin_managementPage() throws Exception {

		mav = adminService.entrance(12);


		return mav;
	}

	// 독서실 회원 정보 페이지 이동 (독서실 관리자)
	@RequestMapping(value = "/TurnOn_Sis_Admin_UserInfoPage", method = RequestMethod.GET)
	public ModelAndView turnOn_sis_admin_userInfoPage() throws Exception {

		mav = adminService.entrance(16);


		return mav;
	}

	// 독서실 등록 페이지 이동
	@RequestMapping(value = "/TurnOn_Sis_Admin_RegisterPage", method = RequestMethod.GET)
	public ModelAndView turnOn_sis_admin_registerPage() throws Exception {

		mav = adminService.entrance(13);


		return mav;
	}

	// 회원들의 정보확인 (독서실 관리자)
	@RequestMapping(value = "/TurnOn_MemberInfoPage_Admin", method = RequestMethod.POST)
	public ModelAndView turnOn_memberInfoPage_admin(@ModelAttribute MemberBean memberBean) {

		return mav;
	}

	// 매출 내역 확인 (독서실 관리자)
	@RequestMapping(value = "/TurnOn_SalesPage_Admin", method = RequestMethod.GET)
	public ModelAndView turnOn_salesPage_admin() throws Exception {

		mav = adminService.entrance(5);

		return mav;
	}

	// 매출 상세내역 확인 (독서실 관리자)
	@RequestMapping(value = "/TurnOn_SalesInfoPage_Admin", method = RequestMethod.POST)
	public ModelAndView turnOn_salesInfoPage_admin() {

		return mav;
	}

	// 회원 입퇴실 기록 확인(독서실 관리자)
	@RequestMapping(value = "/TurnOn_InOutMemberPage_Admin", method = RequestMethod.POST)
	public ModelAndView turnOn_inOutMemberPage_Admin() {

		return mav;
	}

	// 독서실 메인페이지 수정페이지 이동(독서실 관리자)
	@RequestMapping(value = "/TurnOn_Sis_Admin_ChangemainPage", method = RequestMethod.GET)
	public ModelAndView turnOn_sis_admin_changemainPage() throws Exception {

		mav = adminService.entrance(14);
		return mav;
	}

	// 프렌차이즈 요청 페이지 이동
	@RequestMapping(value = "/TurnOn_RequestPage", method = RequestMethod.GET)
	public ModelAndView turnOn_requestPage(HttpServletRequest request) {
		mav = new ModelAndView();
		String page = request.getParameter("page");

		// 요청 확인 페이지
		if (page.equals("find")) {
			mav.setViewName("franchisee_request_find");

			// 요청페이지
		} else if (page.equals("request")) {
			mav.setViewName("franchisee_request");
		}

		return mav;
	}

	// 그래프 페이지 이동
	@RequestMapping(value = "/TurnOn_Graph_Page", method = RequestMethod.GET)
	public ModelAndView turnOn_graph_page(@ModelAttribute SisBean sisBean) {
		mav = new ModelAndView();

		mav.setViewName("sensorpage");

		return mav;
	}

	// 그래프 페이지 이동
	@RequestMapping(value = "/TurnOn_Graph_Page_Admin", method = RequestMethod.GET)
	public ModelAndView turnOn_graph_page_admin(@ModelAttribute SisBean sisBean) {
		mav = new ModelAndView();

		mav.setViewName("sensorpage_admin");

		return mav;
	}
	/* End View Controller */

	/* Front Controller */

	/* Service */

	// 회원가입
	@RequestMapping(value = "/Join", method = RequestMethod.POST)
	public ModelAndView join(@ModelAttribute MemberBean memberBean) throws Exception {
		session.removeAttribute("encodedKey");
		mav = memberService.entrance(10, memberBean);

		return mav;
	}

	// 로그인
	@RequestMapping(value = "/Login", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public @ResponseBody String login(@ModelAttribute MemberBean memberBean) throws Exception {

		String result = "";
		result = (String) ajaxService.entrance(5, memberBean);
		return result;
	}

	// 최종 관리자의 프렌차이즈 요청 확인(페이지 로드 Ajax)
	@RequestMapping(value = "/Admin_Franchisee_Find", method = RequestMethod.GET, produces = "application/text;charset=UTF-8")
	public @ResponseBody String admin_franchisee_find(@ModelAttribute RequestBean requestBean) throws Exception {
		String result = "";

		result = (String) ajaxService.entrance(11, requestBean);

		return result;
	}

	// 비밀번호 체크 후 회원정보페이지 이동
	@RequestMapping(value = "/PwCheck", method = RequestMethod.POST)
	public ModelAndView pwCheck(@ModelAttribute MemberBean memberBean) throws Exception {


		mav = memberService.entrance(12, memberBean);

		return mav;
	}

	// 로그아웃
	@RequestMapping(value = "/Logout", method = RequestMethod.GET)
	public ModelAndView logout(@ModelAttribute MemberBean memberBean) throws Exception {

		mav = memberService.entrance(11, memberBean);

		session.removeAttribute("mbid");
		session.removeAttribute("Admin_code");

		return mav;
	}

	// 독서실 정보 등록 후 오픈(독서실 관리자)
	@RequestMapping(value = "/Sis_Register", method = RequestMethod.POST)
	public ModelAndView sis_register(MultipartHttpServletRequest mtfRequest) throws Exception {

		mav = adminService.entrance(11, mtfRequest);

		return mav;
	}

	// 독서실 메인페이지 수정(독서실 관리자)
	@RequestMapping(value = "/SisChange_Admin", method = RequestMethod.GET)
	public ModelAndView sisChange_Admin(@ModelAttribute SisBean sisBean) {

		return mav;
	}

	// 독서실 메인페이지 수정(독서실 관리자)
	@RequestMapping(value = "/Sis_Admin_ChangeMain_Img", method = RequestMethod.POST)
	public ModelAndView sis_admin_changeMain_img(MultipartHttpServletRequest mtfRequest) throws Exception {


		mav = adminService.entrance(15, mtfRequest);

		return mav;
	}

	// 독서실 메인페이지 소개 수정(독서실 관리자)
	@RequestMapping(value = "/Sis_Admin_ChangeMain_Intro", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public @ResponseBody String sis_admin_changeMain_intro(@ModelAttribute SisBean sisBean) throws Exception {
		String result = "";

		result = (String)ajaxService.entrance(21, sisBean);

		return result;
	}

	// 독서실 메인페이지 번호 수정(독서실 관리자)
	@RequestMapping(value = "/Sis_Admin_ChangeMain_Phonenumber", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public @ResponseBody String sis_admin_changeMain_phonenumber(@ModelAttribute SisBean sisBean) throws Exception {
		String result = "";
		result = (String)ajaxService.entrance(22, sisBean);

		return result;
	}


	// 비밀번호 변경
	@RequestMapping(value = "/ChangePw", method = RequestMethod.POST)
	public ModelAndView changePw(@ModelAttribute MemberBean memberBean) throws Exception {
		memberService.entrance(13, memberBean);
		return mav;
	}

	// 주소 변경(Ajax)
	@RequestMapping(value = "/ChangeAdd", method = RequestMethod.POST)
	public ModelAndView changeAdd(@ModelAttribute MemberBean memberBean) throws Exception {
		memberService.entrance(14, memberBean);
		return mav;
	}

	// 닉네임 변경(Ajax)
	@RequestMapping(value = "/ChangeNick", method = RequestMethod.POST)
	public ModelAndView changeNick(@ModelAttribute MemberBean memberBean) throws Exception {
		memberService.entrance(15, memberBean);
		return mav;
	}

	// 휴대폰번호 변경(Ajax)
	@RequestMapping(value = "/ChangePhoneNumber", method = RequestMethod.POST)
	public ModelAndView changePhoneNumber(@ModelAttribute MemberBean memberBean) {

		return mav;
	}

	// 이메일 변경(Ajax)
	@RequestMapping(value = "/ChangeEmail", method = RequestMethod.POST)
	public @ResponseBody String changeEmail(@ModelAttribute MemberBean memberBean) throws Exception {
		String result = "";
		result = (String) ajaxService.entrance(2, memberBean);
		return result;
	}

	// 아이디 찾기
	@RequestMapping(value = "/IdFind_Member", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public @ResponseBody String idFind_member(@ModelAttribute MemberBean memberBean) throws Exception {
		String result = "";

		result = (String) ajaxService.entrance(14, memberBean);

		return result;
	}

	// 비밀번호 찾기(OTP)
	@RequestMapping(value = "/PwFind_Otp_Member", method = RequestMethod.POST)
	public @ResponseBody String pwfind_otp_member(@ModelAttribute OtpBean otpBean) throws Exception {

		String result = "";

		result = (String) otpService.entrance(3, otpBean);

		return result;
	}

	// 비밀번호 찾기(EMAIL)
	@RequestMapping(value = "/PwFind_Email_Member", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public @ResponseBody String pwFind_email_Member(@ModelAttribute MemberBean memberBean) throws Exception {

		String result = "";

		result = (String) ajaxService.entrance(15, memberBean);

		return result;
	}

	// 아이디, 휴대폰번호, 독서실코드 일치여부 확인
	@RequestMapping(value = "/IdPhoneCheck", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public @ResponseBody String idPhoneCheck(@ModelAttribute MemberBean memberBean) throws Exception {

		String result = "";

		result = (String) ajaxService.entrance(16, memberBean);

		return result;
	}

	// 독서실 결제
	@RequestMapping(value = "/Account_Member", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public @ResponseBody ModelAndView account_member(@ModelAttribute SisBean sisBean, @ModelAttribute MemberBean memberBean,
			@ModelAttribute PaymentBean paymentBean) throws Exception {
		memberService.entrance(20, paymentBean, sisBean);
		return mav;
	}

	// 회원 목표 설정
	@RequestMapping(value = "/Goals_Member", method = RequestMethod.POST)
	public ModelAndView goals_member(@ModelAttribute GoalsBean goalsBean) {

		return mav;
	}

	// 프렌차이즈 요청
	@RequestMapping(value = "/Request_Service", method = RequestMethod.POST)
	public ModelAndView request_service(@ModelAttribute RequestBean requestBean) throws Exception {

		mav = memberService.entrance(22, requestBean);

		return mav;
	}

	// 프렌차이즈 요청확인
	@RequestMapping(value = "/Request_Find", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public @ResponseBody String request_find_service(@ModelAttribute RequestBean requestBean) throws Exception {
		String result = "";


		result = (String) ajaxService.entrance(9, requestBean);

		return result;
	}

	// 그래프 테스트
	@RequestMapping(value = "/GraphTest", method = RequestMethod.GET, produces = "application/text;charset=UTF-8")
	public @ResponseBody String GraphTest(@ModelAttribute DbSensorBean dbsensorBean) throws Exception {
		String result = "sss";

		result = (String) sensorService.entrance(2, dbsensorBean);
		return result;
	}

	// id 중복체크
	@RequestMapping(value = "/Id_Sis_Check", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public @ResponseBody String Id_Sis_Check(@ModelAttribute MemberBean memberBean) throws Exception {
		String result = "";


		result = (String) ajaxService.entrance(10, memberBean);

		return result;
	}

	// 지역으로 인한 siscode 자동 호출
	@RequestMapping(value = "/SisCode_Find", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public @ResponseBody String sisCode_find(@ModelAttribute SisBean sisBean) throws Exception {
		String result = "";


		result = (String) ajaxService.entrance(12, sisBean);

		return result;
	}

	// 최종 관리자의 프렌차이즈 등록
	@RequestMapping(value = "/Sis_Setup", method = RequestMethod.POST)
	// Client에서 넘어올 데이터가 없는 경우 , 보안이 필요없는 경우 GET 방식
	public ModelAndView sis_setup(SisBean sisBean) throws Exception {


		mav = adminService.entrance(10, sisBean);

		return mav;
	}

	// url 사용시 : Sensor/센서종류/일,월기간/표현할 데이터 값(전체, 개인, 전체와 개인)
	@RequestMapping(value = "/Sensor/{kind}/{range}/{select}", method = RequestMethod.GET, produces = "application/text;charset=UTF-8")
	public @ResponseBody String select_Sensor(@PathVariable String kind, @PathVariable String range,
			@PathVariable String select, @ModelAttribute DbPaymentBean dbpaymentBean) throws Exception {
		String result = "";
		String siscode = (String) session.getAttribute("siscode");
		String sircode = (String) session.getAttribute("sircode");

		dbpaymentBean.setSiscode(siscode);



		//	try {
		if(!sircode.equals("X")) {dbpaymentBean.setSircode(sircode);
		if (kind.equals("sound")) { // 사운드 센서
			if (range.equals("day")) { // 일, 월 기간 선택
				if (select.equals("all")) { // 표현할 데이터값 전체, 개인, 전체와 개인
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(1, dbpaymentBean);

					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("personal")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(15, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("both")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(1, dbpaymentBean);
					JSONArray jsonArr2 = (JSONArray) sensorService.entrance(15, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, jsonArr2);
				}
			} else if (range.equals("month")) {
				if (select.equals("all")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(2, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("personal")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(16, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("both")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(2, dbpaymentBean);
					JSONArray jsonArr2 = (JSONArray) sensorService.entrance(16, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, jsonArr2);
				}
			}
		}

		if (kind.equals("dust")) { // 미세먼지 센서
			if (range.equals("day")) { // 일, 월 기간 선택
				if (select.equals("all")) { // 표현할 데이터값 전체, 개인, 전체와 개인
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(3, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("personal")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(17, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("both")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(3, dbpaymentBean);
					JSONArray jsonArr2 = (JSONArray) sensorService.entrance(17, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, jsonArr2);
				}
			} else if (range.equals("month")) {
				if (select.equals("all")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(4, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("personal")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(18, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("both")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(4, dbpaymentBean);
					JSONArray jsonArr2 = (JSONArray) sensorService.entrance(18, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, jsonArr2);
				}
			}
		}

		if (kind.equals("light")) { // 가변저항 센서
			if (range.equals("day")) { // 일, 월 기간 선택
				if (select.equals("all")) { // 표현할 데이터값 전체, 개인, 전체와 개인
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(5, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("personal")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(19, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("both")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(5, dbpaymentBean);
					JSONArray jsonArr2 = (JSONArray) sensorService.entrance(19, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, jsonArr2);
				}
			} else if (range.equals("month")) {
				if (select.equals("all")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(6, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("personal")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(20, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("both")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(6, dbpaymentBean);
					JSONArray jsonArr2 = (JSONArray) sensorService.entrance(20, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, jsonArr2);
				}
			}
		}

		if (kind.equals("dht")) { // 온습도 센서
			if (range.equals("day")) { // 일, 월 기간 선택
				if (select.equals("all")) { // 표현할 데이터값 전체, 개인, 전체와 개인
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(7, dbpaymentBean);
					result = sensorService.draw_graph_twodata(jsonArr1, null);
				} else if (select.equals("personal")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(21, dbpaymentBean);
					result = sensorService.draw_graph_twodata(jsonArr1, null);
				} else if (select.equals("both")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(7, dbpaymentBean);
					JSONArray jsonArr2 = (JSONArray) sensorService.entrance(21, dbpaymentBean);

					result = sensorService.draw_graph_twodata(jsonArr1, jsonArr2);
				}
			} else if (range.equals("month")) {
				if (select.equals("all")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(8, dbpaymentBean);
					result = sensorService.draw_graph_twodata(jsonArr1, null);
				} else if (select.equals("personal")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(22, dbpaymentBean);
					result = sensorService.draw_graph_twodata(jsonArr1, null);
				} else if (select.equals("both")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(8, dbpaymentBean);
					JSONArray jsonArr2 = (JSONArray) sensorService.entrance(22, dbpaymentBean);
					result = sensorService.draw_graph_twodata(jsonArr1, jsonArr2);
				}
			}
		}

		if (kind.equals("rfid")) { // RFID센서
			if (range.equals("day")) { // 일, 월 기간 선택
				if(!sensorService.entrance(29, dbpaymentBean).equals("X")) {
					if(sensorService.entrance(29, dbpaymentBean).equals("0")) {
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(9, dbpaymentBean);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
					}
					else {
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(10, dbpaymentBean);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
					}
				}
				else {
					result = "X";
				}

			} else if (range.equals("week")) {
				if(sensorService.entrance(29, dbpaymentBean).equals("0")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(23, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				}
				else {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(24, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				}
			}
		}

		if (kind.equals("ir")) { // 적외선 센서
			if (range.equals("day")) { // 일, 월 기간 선택
				if (select.equals("all")) { // 표현할 데이터값 전체, 개인, 전체와 개인
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(11, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("personal")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(25, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("both")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(11, dbpaymentBean);
					JSONArray jsonArr2 = (JSONArray) sensorService.entrance(25, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, jsonArr2);
				}
			} else if (range.equals("month")) {
				if (select.equals("all")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(12, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("personal")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(26, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("both")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(12, dbpaymentBean);
					JSONArray jsonArr2 = (JSONArray) sensorService.entrance(26, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, jsonArr2);
				}
			}
		}

		if (kind.equals("hir")) { // 인체 감지 센서
			if (range.equals("day")) { // 일, 월 기간 선택
				if (select.equals("all")) { // 표현할 데이터값 전체, 개인, 전체와 개인
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(13, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("personal")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(27, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("both")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(13, dbpaymentBean);
					JSONArray jsonArr2 = (JSONArray) sensorService.entrance(27, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, jsonArr2);
				}
			} else if (range.equals("month")) {
				if (select.equals("all")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(14, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("personal")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(28, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, null);
				} else if (select.equals("both")) {
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(14, dbpaymentBean);
					JSONArray jsonArr2 = (JSONArray) sensorService.entrance(28, dbpaymentBean);
					result = sensorService.draw_graph_onedata(jsonArr1, jsonArr2);
				}
			}
		}



		}
		else {
			System.out.println("a");
			if (kind.equals("admin")) { // 인체 감지 센서
				dbpaymentBean.setPhdate("17/11/01");
				dbpaymentBean.setPhenddate("17/11/30");
				if (range.equals("hir")) { // 일, 월 기간 선택
					if(select.equals("P0")) {
						dbpaymentBean.setSircode("P0");
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(34, dbpaymentBean);
						System.out.println(jsonArr1);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
						System.out.println(result);}
					else if(select.equals("G0")) {
						dbpaymentBean.setSircode("G0");
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(34, dbpaymentBean);
						System.out.println(jsonArr1);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
						System.out.println(result);}
					else if(select.equals("O0")) {
						dbpaymentBean.setSircode("O0");
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(34, dbpaymentBean);
						System.out.println(jsonArr1);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
						System.out.println(result);}
				} else if (range.equals("ir")) {
					if(select.equals("P0")) {
						dbpaymentBean.setSircode("P0");
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(33, dbpaymentBean);
						System.out.println(jsonArr1);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
						System.out.println(result);}
					else if(select.equals("G0")) {
						dbpaymentBean.setSircode("G0");
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(33, dbpaymentBean);
						System.out.println(jsonArr1);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
						System.out.println(result);
					}
					else if(select.equals("O0")) {
						dbpaymentBean.setSircode("O0");
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(33, dbpaymentBean);
						System.out.println(jsonArr1);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
						System.out.println(result);
					}
				}else if (range.equals("dust")) {
					System.out.println("dust");
					if(select.equals("P0")) {
						System.out.println("dustp");
						dbpaymentBean.setSircode("P0");
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(36, dbpaymentBean);
						System.out.println(jsonArr1);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
						System.out.println(result);
					}
					else if(select.equals("G0")) {
						System.out.println("dustg");
						dbpaymentBean.setSircode("G0");
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(36, dbpaymentBean);
						System.out.println(jsonArr1);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
						System.out.println(result);
					}
					else if(select.equals("O0")) {
						System.out.println("dusto");
						dbpaymentBean.setSircode("O0");
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(36, dbpaymentBean);
						System.out.println(jsonArr1);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
						System.out.println(result);
					}

				}else if (range.equals("sound")) {
					if(select.equals("P0")) {
						System.out.println("soundp");
						dbpaymentBean.setSircode("P0");
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(35, dbpaymentBean);
						System.out.println(jsonArr1);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
						System.out.println(result);
					}
					else if(select.equals("G0")) {
						System.out.println("soundg");
						dbpaymentBean.setSircode("G0");
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(35, dbpaymentBean);
						System.out.println(jsonArr1);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
						System.out.println(result);
					}
					else if(select.equals("O0")) {
						System.out.println("soundo");
						dbpaymentBean.setSircode("O0");
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(35, dbpaymentBean);
						System.out.println(jsonArr1);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
						System.out.println(result);
					}
				}else if (range.equals("light")) {
					if(select.equals("P0")) {
						dbpaymentBean.setSircode("P0");
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(37, dbpaymentBean);
						System.out.println(jsonArr1);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
						System.out.println(result);
					}
					else if(select.equals("G0")) {
						dbpaymentBean.setSircode("G0");
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(37, dbpaymentBean);
						System.out.println(jsonArr1);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
						System.out.println(result);
					}
					else if(select.equals("O0")) {
						dbpaymentBean.setSircode("O0");
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(37, dbpaymentBean);
						System.out.println(jsonArr1);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
						System.out.println(result);
					}
				}else if (range.equals("dht")) {
					if(select.equals("P0")) {
						System.out.println("dhtp");
						dbpaymentBean.setSircode("P0");
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(38, dbpaymentBean);
						System.out.println(jsonArr1);
						result = sensorService.draw_graph_twodata(jsonArr1, null);
						System.out.println(result);
					}
					else if(select.equals("G0")) {System.out.println("dhtg");
					dbpaymentBean.setSircode("G0");
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(38, dbpaymentBean);
					System.out.println(jsonArr1);
					result = sensorService.draw_graph_twodata(jsonArr1, null);
					System.out.println(result);
					}
					else if(select.equals("O0")) {System.out.println("dhto");
					dbpaymentBean.setSircode("O0");
					JSONArray jsonArr1 = (JSONArray) sensorService.entrance(38, dbpaymentBean);
					System.out.println(jsonArr1);
					result = sensorService.draw_graph_twodata(jsonArr1, null);
					System.out.println(result);
					}
				}
			}
			else {

				result = "X";}

		}
		return result;
	}
	
	/*catch(Exception e) {

			dbpaymentBean.setPhdate("17/11/01");
			dbpaymentBean.setPhenddate("17/11/30");
			if (kind.equals("sound")) { // 사운드 센서
				if (range.equals("day")) { // 일, 월 기간 선택
					if (select.equals("all")) { // 표현할 데이터값 전체, 개인, 전체와 개인

						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(32, dbpaymentBean);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
					} 

				} else if (range.equals("month")) {
					if (select.equals("all")) {
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(32, dbpaymentBean);
						result = sensorService.draw_graph_onedata(jsonArr1, null);
					}
				}
			}

			if (kind.equals("dht")) { // 온습도 센서
				if (range.equals("day")) { // 일, 월 기간 선택
					if (select.equals("all")) { // 표현할 데이터값 전체, 개인, 전체와 개인
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(31, dbpaymentBean);
						result = sensorService.draw_graph_twodata(jsonArr1, null);

					}
				} else if (range.equals("month")) {
					if (select.equals("all")) {
						JSONArray jsonArr1 = (JSONArray) sensorService.entrance(31, dbpaymentBean);
						result = sensorService.draw_graph_twodata(jsonArr1, null);
					}
				}
			}



		}*/






/* End Service */

/* End Front Controller */

}