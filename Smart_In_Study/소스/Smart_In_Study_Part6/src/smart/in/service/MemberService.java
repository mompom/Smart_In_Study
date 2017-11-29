package smart.in.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import smart.in.beans.DbMemberBean;
import smart.in.beans.DbPaymentBean;
import smart.in.beans.DbRequestBean;
import smart.in.beans.DbSensorBean;
import smart.in.beans.DbSisBean;
import smart.in.beans.GoalsBean;
import smart.in.beans.MemberBean;
import smart.in.beans.PaymentBean;
import smart.in.beans.RequestBean;
import smart.in.beans.SisBean;
import smart.in.dao.AdminMybatis;
import smart.in.dao.MemberMybatis;
import smart.in.dao.SensorMybatis;
import smart.in.utils.Encryption;
import smart.in.utils.Session;

@Service
public class MemberService {
	// 마이바티스와 연동되는 인터페이스 사용
	@Autowired
	private MemberMybatis memberMybatis;

	@Autowired
	private SensorMybatis sensorMybatis;

	@Autowired
	private AdminMybatis adminMybatis;
	
	@Autowired
	private Session session;

	@Autowired
	private Encryption encryption;

	@Autowired
	private TransactionExe transactionExe;

	public MemberService() {
	}

	private boolean convertToBoolean(int value) {
		return (value == 1) ? true : false;
	}

	/* 진입 메서드 */
	public ModelAndView entrance(int serviceCode, Object... object) throws Exception {
		ModelAndView mav = null;
		Object result = null;
		// 현재 페이지 세션등록
		if (session.getAttribute("page") != null) {
			session.removeAttribute("page");
		}

		switch (serviceCode) {
		case 1:
			mav = infoPage();
			break;
		case 2:
			mav = contactPage((MemberBean) object[0]);
			break;
		case 3:
			mav = profilePage((MemberBean) object[0]);
			break;
		case 4:
			mav = passwordPage();
			break;
		case 5:
			mav = sis_mainPage((SisBean) object[0]);
			break;
		case 6:
			mav = inOutPage();
			break;
		case 7:
			mav = paymentPage();
			break;
		case 8:
			mav = goalsPage();
			break;
		case 10:
			mav = join((MemberBean) object[0]);
			break;
		case 11:
			mav = logout((MemberBean) object[0]);
			break;
		case 12:
			mav = pwCheck((MemberBean) object[0]);
			break;
		case 13:
			mav = changePw((MemberBean) object[0]);
			break;
		case 14:
			mav = changeAdd((MemberBean) object[0]);
			break;
		case 15:
			mav = changeNick((MemberBean) object[0]);
			break;
		case 16:
			mav = changePhoneNumber((MemberBean) object[0]);
			break;
		case 17:
			result = changeEmail((MemberBean) object[0]);
			break;
		case 18:
			mav = idFind((MemberBean) object[0]);
			break;
		case 19:
			mav = pwFind((MemberBean) object[0]);
			break;
		case 20:
			mav = account((PaymentBean) object[0], (SisBean) object[1]);
			break;
		case 21:
			mav = goals((GoalsBean) object[0]);
			break;
		case 22:
			mav = request_service((RequestBean) object[0]);
			break;
		case 23:
			mav = request_service((RequestBean) object[0]);
			break;
		case 24:
			mav = paymentpage_member((PaymentBean) object[0]);
			break;
		
		default:
			break;
		}

		return mav;
	}

	/* End 진입 메서드 */

	// 맴버정보 페이지
	private ModelAndView infoPage() throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);


		return mav;
	}

	// 맴버 연락처 페이지
	private ModelAndView contactPage(MemberBean memberBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		memberBean.setMbid((String)session.getAttribute("mbid"));
		memberBean.setSiscode((String)session.getAttribute("siscode"));
		List<DbMemberBean> contactPage = memberMybatis.contactPage(memberBean);

		for (DbMemberBean contactPa : contactPage) {
			mav.addObject("mbemail", contactPa.getMbemail());
			mav.addObject("mbaddress", contactPa.getMbaddress());
			mav.addObject("mbphonenumber", contactPa.getMbphonenumber());
		}

		mav.setViewName("mb_contact_change");
		return mav;
	}

	// 맴버 프로필 페이지
	private ModelAndView profilePage(MemberBean memberBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		memberBean.setMbid((String)session.getAttribute("mbid"));
		memberBean.setSiscode((String)session.getAttribute("siscode"));
		List<DbMemberBean> profilePage = memberMybatis.profilePage(memberBean);

		for (DbMemberBean profilePa : profilePage) {
			mav.addObject("mbnick", profilePa.getMbnick());
		}
		mav.setViewName("mb_profile_change");
		return mav;

	}

	// 맴버 비밀번호변경 페이지
	private ModelAndView passwordPage() throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		
		return mav;
	}

	// sis 메인 호출
	private ModelAndView sis_mainPage(SisBean sisBean) throws Exception {
		ModelAndView mav = new ModelAndView();

		// 세션등록
		if (sisBean.getSiscode() != null) {
			session.setAttribute("siscode", sisBean.getSiscode());
		}else {
			System.out.println("AAA");
		}
		mav.setViewName("sis_main");
		return mav;
	}
	
	
	
	// 로그기록 페이지
	private ModelAndView inOutPage() throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		return mav;
	}

	// 결제 페이지 이동
	private ModelAndView paymentPage() throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		MemberBean memberBean = new MemberBean();
		
		memberBean.setMbid((String) session.getAttribute("mbid"));
		memberBean.setSiscode((String) session.getAttribute("siscode"));
		
		System.out.println((String) session.getAttribute("siscode"));
		System.out.println((String) session.getAttribute("mbid"));
		System.out.println(memberBean.getMbid());
		
		DbMemberBean mbinfo = memberMybatis.mbinfo_payment(memberBean);
		SisBean sisBean = new SisBean();
		sisBean.setSiscode((String)session.getAttribute("siscode"));
		sisBean.setSircode("O");
		List<DbSisBean> sisOneSirList = adminMybatis.sis_managementPage_sir(sisBean);
		sisBean.setSircode("P");
		List<DbSisBean> sisOpenSirList = adminMybatis.sis_managementPage_sir(sisBean);
		sisBean.setSircode("G");
		List<DbSisBean> sisGroupSirList = adminMybatis.sis_managementPage_sir(sisBean);
		
		Gson gson = new Gson();
		
		mav.addObject("memberinfo", gson.toJson(mbinfo));
		mav.addObject("sisOneSirList", gson.toJson(sisOneSirList));
		mav.addObject("sisOpenSirList", gson.toJson(sisOpenSirList));
		mav.addObject("sisGroupSirList", gson.toJson(sisGroupSirList));
		mav.setViewName("pay_test");
		return mav;
	}

	// 목표 설정 페이지 이동
	private ModelAndView goalsPage() throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		return mav;
	}

	// 사용자 회원가입
	private ModelAndView join(MemberBean memberBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		// 비밀번호 암호화
		memberBean.setMbpw(encryption.encode(memberBean.getMbpw()));

		memberBean.setSiscode((String) session.getAttribute("siscode"));
		// 회원가입INSERT
		if (convertToBoolean(memberMybatis.join(memberBean))) {
			System.out.println("조인 완료");
			
			if (convertToBoolean(memberMybatis.login(memberBean))) {// 로그인 
				
				System.out.println("로그인 완료");

				transaction = true;

				// 세션등록
				
				session.setAttribute("mbid", memberBean.getMbid());
				session.setAttribute("siscode", memberBean.getSiscode());
				session.removeAttribute("sircode");
			} else {// 로그인 오류

			}
		} else {//회원가입 실패

		}
		transactionExe.setTransactionResult(transaction);
		mav.setViewName("sis_login_main");
		return mav;
	}

	// 사용자 로그아웃
	private ModelAndView logout(MemberBean memberBean) throws Exception {
		ModelAndView mav = new ModelAndView();

		String page = "error";

		boolean transaction = false;
		System.out.println("로그아웃진입");

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		System.out.println(session.getAttribute("mbid"));
		System.out.println(session.getAttribute("siscode"));
		System.out.println(session.getAttribute("Admin_code"));

		memberBean.setMbid((String) session.getAttribute("mbid"));

		if (session.getAttribute("Admin_code") == null || session.getAttribute("siscode") != null) {
			memberBean.setSiscode((String) session.getAttribute("siscode"));
		} else {
			memberBean.setSiscode((String) session.getAttribute("Admin_code"));
		}

		if (convertToBoolean(memberMybatis.logout(memberBean))) {

			System.out.println("로그아웃 완료");

			// 세션관리
			session.setAttribute("page", memberBean.getPage());

			transaction = true;
			page = (String) session.getAttribute("page");

		} else {// 로그아웃 실패
			// 에러페이지 이동
		}

		mav.setViewName(page);
		transactionExe.setTransactionResult(transaction);
		return mav;
	}

	// 비밀번호 체크
	private ModelAndView pwCheck(MemberBean memberBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();

		boolean transaction = false;
		memberBean.setMbid((String) session.getAttribute("mbid"));
		memberBean.setSiscode((String) session.getAttribute("siscode"));
		System.out.println(memberBean.getMbid());
		DbMemberBean pwcheck = memberMybatis.pwCheck(memberBean);
		System.out.println(pwcheck.getMbpw());

		if (encryption.matches(memberBean.getMbpw(), pwcheck.getMbpw())) {
			System.out.println("hello~");
			mav = History(memberBean);
			memberBean.setMbid((String) session.getAttribute("mbid"));
			System.out.println((String) session.getAttribute("mbid"));
			List<DbMemberBean> infoPage = memberMybatis.infoPage(memberBean);

			for (DbMemberBean infoPa : infoPage) {
				System.out.println(infoPa.getMbname());
				mav.addObject("mbid", infoPa.getMbid());
				mav.addObject("mbnick", infoPa.getMbnick());
				mav.addObject("mbpw", infoPa.getMbpw());
				mav.addObject("mbname", infoPa.getMbname());
				mav.addObject("mbgender", infoPa.getMbgender());
				mav.addObject("mbbirthday", infoPa.getMbbirthday());
				mav.addObject("mbaddress", infoPa.getMbaddress());
				mav.addObject("mbemail", infoPa.getMbemail());
				mav.addObject("mbphonenumber", infoPa.getMbphonenumber());
			}

			mav.setViewName("mb_info");
		} else {
			System.out.println("비밀번호틀림");
			mav.setViewName("mb_info_pwcheck");
		}

		System.out.println(mav.getViewName());
		return mav;
	}

	// 비밀번호 변경
	private ModelAndView changePw(MemberBean memberBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);
		System.out.println(memberBean.getMbid());
		memberBean.setMbid((String)session.getAttribute("mbid"));
		System.out.println(memberBean.getMbid());
		memberBean.setMbpw(encryption.encode(memberBean.getMbpw()));
		System.out.println(encryption.encode(memberBean.getMbpw()));
		
		memberBean.setSiscode((String)session.getAttribute("siscode"));	
		if (convertToBoolean(memberMybatis.changePw(memberBean))) {
			System.out.println("비밀번호 변경 완료");
			transaction = true;
		} else {

		}
		transactionExe.setTransactionResult(transaction);
		mav.setViewName("mb_info");
		return mav;
	}

	// 주소 변경
	private ModelAndView changeAdd(MemberBean memberBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);
		System.out.println("주소진입");
		memberBean.setSiscode((String)session.getAttribute("siscode"));
		if (convertToBoolean(memberMybatis.changeAdd(memberBean))) {
			System.out.println("주소 변경 완료");
			
			transaction = true;

		} else {
			System.out.println("에러");
		}
		transactionExe.setTransactionResult(transaction);
		return mav;
	}

	// 닉네임 변경
	private ModelAndView changeNick(MemberBean memberBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		System.out.println(memberBean.getMbid());
		System.out.println(memberBean.getMbnick());

		memberBean.setSiscode((String)session.getAttribute("siscode"));
		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		if (convertToBoolean(memberMybatis.changeNick(memberBean))) {
			System.out.println("닉네임 변경 완료");

			transaction = true;

		} else {

		}
		transactionExe.setTransactionResult(transaction);
		mav.setViewName("change_nick");
		return mav;
	}

	// 전화번호 변경
	private ModelAndView changePhoneNumber(MemberBean memberBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		return mav;
	}

	// 이메일 변경
		private String changeEmail(MemberBean memberBean) throws Exception {
			StringBuffer st = new StringBuffer();
			boolean transaction = false;

			transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
					TransactionDefinition.ISOLATION_READ_COMMITTED, false);
			System.out.println("changeEmail :: 진입");
			memberBean.setSiscode((String)session.getAttribute("siscode"));
			if (convertToBoolean(memberMybatis.changeEmail(memberBean))) {
				System.out.println("이메일 변경 완료");
				
				transaction = true;

			} else {
				System.out.println("에러");
			}
			transactionExe.setTransactionResult(transaction);
			
			String result = memberBean.getMbemail();
			System.out.println(result);

			return result;
		}

	// 아이디 찾기
	private ModelAndView idFind(MemberBean memberBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);
		memberMybatis.join(memberBean);
		return mav;
	}

	// 비밀번호 찾기
	private ModelAndView pwFind(MemberBean memberBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		return mav;
	}

	// 결제
	private ModelAndView account(PaymentBean paymentBean , SisBean sisBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);
		paymentBean.setSiscode((String)session.getAttribute("siscode"));
		System.out.println((String)session.getAttribute("siscode"));
		System.out.println(paymentBean.getSiscode());
		System.out.println(paymentBean.getPaymentdate());
		paymentBean.setSircode((String) session.getAttribute("sircode"));
		paymentBean.setMbid((String) session.getAttribute("mbid"));
		String from = paymentBean.getStartdate();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date to = transFormat.parse(from);
		paymentBean.setPhdate(to);
		
		if(convertToBoolean(memberMybatis.set_sir(paymentBean))) {
			System.out.println("자리등록완료");
			transaction = true;
			if(convertToBoolean(memberMybatis.account(paymentBean))) {
				System.out.println("결제완료");
				transaction = true;
			}
		}
		transactionExe.setTransactionResult(transaction);
		return mav;
	}

	// 목표 설정
	private ModelAndView goals(GoalsBean goalsBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		return mav;
	}

	// 독서실 진입
	private ModelAndView request_service(RequestBean requestBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		boolean transaction = false;
		String page = "error";
		String message = "";
		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);
		
		DbRequestBean dbrequestBean = memberMybatis.request_Sequnce_find(requestBean);
		
		
		if (dbrequestBean == null) {
			System.out.println("null");
			requestBean.setRssequnce(1);
		} else {
			System.out.println(dbrequestBean.getRssequence());
			requestBean.setRssequnce(dbrequestBean.getRssequence() + 1);
		}

		if (convertToBoolean(memberMybatis.request_service(requestBean))) {
			// insert 성공

			transaction = true;

			// 세션등록
			session.setAttribute("page", requestBean.getPage());
			page = (String) session.getAttribute("page");
			message = "신청 완료되었습니다.";
		} else {
			// insert 실패
		}
		mav.addObject("message", message);
		mav.setViewName(page);
		transactionExe.setTransactionResult(transaction);

		return mav;
	}

	// 독서실 진입
	private ModelAndView turnOnMainPage(SisBean sisBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);
		List<DbSisBean> mainPage = memberMybatis.mainPage(sisBean);

		return mav;
	}

	
	
	//회원 정보창에 삽입할 기록
	private ModelAndView History(MemberBean memberBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer ih = new StringBuffer();
		StringBuffer ht = new StringBuffer();
		System.out.println(session.getAttribute("sircode"));
		memberBean.setSircode((String) session.getAttribute("sircode"));
		memberBean.setSiscode((String) session.getAttribute("siscode"));
		List<DbSensorBean> sensordata = sensorMybatis.rfid_sensor_day_text(memberBean);
		List<DbMemberBean> history = memberMybatis.loginHistory(memberBean);
		
		if(convertToBoolean(memberMybatis.accountCheck(memberBean))) {
			
			
		ih.append("<table class=\"container\">");
		ih.append("<thead><tr><th><h1>일시</h1></th><th><h1>상태</h1></th></tr></thead>");
		ih.append("<tbody>");

		for (DbSensorBean inouthistory : sensordata) {
			ih.append("<tr>");
			ih.append("<td>" + inouthistory.getSedate() + "</td>");
			ih.append("<td>" + ((inouthistory.getSelog().equals("1")) ? "입실" : "퇴실") + "</td>");
			ih.append("</tr>");

		}
		}else {
			ih.append("<tr>");
			ih.append("등록된 자리가 없습니다.");
			ih.append("<tr>");
		}
		ih.append("</tbody></table>");
		
		ht.append("<table class=\"container\">");
		ht.append("<thead><tr><th><h1>일시</h1></th><th><h1>상태</h1></th></tr></thead>");
		ht.append("<tbody>");

		for (DbMemberBean loginhistory : history) {
			ht.append("<tr>");
			ht.append("<td>" + loginhistory.getHidate() + "</td>");
			ht.append("<td>" + ((loginhistory.getHistcode().equals("L1")) ? "로그인" : "로그아웃") + "</td>");
			ht.append("</tr>");

		}
		ht.append("</tbody></table>");
		mav.addObject("historylog", ht);
		mav.addObject("inouthistory", ih);
		return mav;
		
	}
	
	// 결제완료 페이지 이동
	private ModelAndView paymentpage_member(PaymentBean paymentBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);
		paymentBean.setMbid((String) session.getAttribute("mbid"));
		paymentBean.setSiscode((String) session.getAttribute("siscode"));
		paymentBean.setSircode((String) session.getAttribute("sircode"));
		System.out.println(session.getAttribute("mbid"));
		System.out.println(session.getAttribute("siscode"));
		System.out.println(session.getAttribute("sircode"));
		List<DbPaymentBean> paymentPage = memberMybatis.paymentPage(paymentBean);
			
		for (DbPaymentBean paymentPa : paymentPage) {
			mav.addObject("phaccountid", paymentPa.getPhaccountid());
			mav.addObject("siscode", paymentPa.getSiscode());
			mav.addObject("sircode", paymentPa.getSircode());
			mav.addObject("mbid", paymentPa.getMbid());
			mav.addObject("phdate", paymentPa.getPhdate());
			mav.addObject("phenddate", paymentPa.getPhenddate());
			mav.addObject("price", paymentPa.getPrice());
			
		}

		mav.setViewName("paymentpage_member");
		return mav;
	}
	
	
}