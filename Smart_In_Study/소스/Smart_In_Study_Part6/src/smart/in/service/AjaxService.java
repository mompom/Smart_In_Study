package smart.in.service;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import smart.in.beans.MemberBean;
import smart.in.beans.OtpBean;
import smart.in.beans.PaymentBean;
import smart.in.beans.RequestBean;
import smart.in.beans.SisBean;
import smart.in.dao.AdminMybatis;
import smart.in.dao.MemberMybatis;
import smart.in.dao.SensorMybatis;
import smart.in.utils.Encryption;
import smart.in.utils.SendMail;
import smart.in.utils.Session;

@Service
public class AjaxService {
	@Autowired
	private MemberMybatis memberMybatis;

	@Autowired
	private SensorMybatis seonsorMybatis;

	@Autowired
	private AdminMybatis adminMybatis;

	@Autowired
	private Session session;

	@Autowired
	private Encryption encryption;

	@Autowired
	private TransactionExe transactionExe;

	@Autowired
	private OtpService otpService;

	@Autowired
	private SendMail sendMail;

	public AjaxService() {
	}

	public Object entrance(int serviceCode, Object... object) throws Exception {
		Object result = null;

		if (session.getAttribute("page") != null) {
			session.removeAttribute("page");
		}

		switch (serviceCode) {
		case 1:
			result = selectLocation((SisBean) object[0]);
			break;
		case 2:
			result = changeEmail((MemberBean) object[0]);
			break;
		case 3:
			result = selectLocationlogin();
			break;
		case 5:
			result = login((MemberBean) object[0]);
			break;
		case 6:
			result = turnOn_selectSisPages_contents((SisBean) object[0]);
			break;
		case 7:
			result = otp_qrCode((MemberBean) object[0]);
			break;
		case 8:
			result = user_otpCode((OtpBean) object[0]);
			break;
		case 9:
			result = request_find_service((RequestBean) object[0]);
			break;
		case 10:
			result = id_sis_check((MemberBean) object[0]);
			break;
		case 11:
			result = request_kind((RequestBean) object[0]);
			break;
		case 12:
			result = sisCode_find((SisBean) object[0]);
			break;
		case 13:
			result = sis_managementPage_sis();
			break;
		case 14:
			result = idFind_member((MemberBean) object[0]);
			break;
		case 15:
			result = pwFind_email_Member((MemberBean) object[0]);
			break;
		case 16:
			result = idPhoneCheck((MemberBean) object[0]);
			break;
		case 17:
			result = sis_managementPage_sir();
			break;
		case 18:
			result = sis_managementPage_mb();
			break;
		case 19:
			result = add_sircode((MemberBean) object[0]);
			break;
		case 20:
			result = add_sirprice((MemberBean) object[0]);
			break;
		case 21:
			result = sis_admin_changeMain_intro((SisBean) object[0]);
			break;
		case 22:
			result = sis_admin_changeMain_phonenumber((SisBean) object[0]);
			break;
		case 23:
			result = sis_admin_sircheck((MemberBean) object[0]);
		default:
			break;
		}

		System.out.println(result);
		return result;
	}

	private boolean convertToBoolean(int value) {
		return (value == 1) ? true : false;
	}

	// 각 지역별 독서실 호출
	private String selectLocation(SisBean sisBean) throws Exception {

		List<DbSisBean> sislists = null;

		if (sisBean.getSiscode() == null || sisBean.getSiscode().equals("All")) {
			sislists = adminMybatis.mainSisAll();

		} else {
			sislists = adminMybatis.mainSisLocation(sisBean);
		}

		Gson gson = new Gson();

		String result = gson.toJson(sislists);
		System.out.println(result);
		return result;
	}

	// 이메일 변경
	private String changeEmail(MemberBean memberBean) throws Exception {
		boolean transaction = false;
		String result = "false";
		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		System.out.println("changeEmail :: 진입");
		memberBean.setMbid((String) session.getAttribute("mbid"));
		memberBean.setSiscode((String) session.getAttribute("siscode"));
		if (convertToBoolean(memberMybatis.changeEmail(memberBean))) {
			System.out.println("이메일 변경 완료");

			transaction = true;
			result = "scuccess";
		} else {
			System.out.println("에러");
		}

		transactionExe.setTransactionResult(transaction);

		MemberBean resultBean = new MemberBean();
		resultBean.setResult(result);
		resultBean.setMbemail(memberBean.getMbemail());

		Gson gson = new Gson();

		result = gson.toJson(resultBean);

		return result;
	}

	// 메인페이지 로그인 창의 독서실 종류 선택
	private String selectLocationlogin() throws Exception {

		List<DbSisBean> sislists = adminMybatis.mainSisAll();

		Gson gson = new Gson();

		String result = gson.toJson(sislists);
		System.out.println(result);
		return result;
	}

	// 로그인처리 > 해당 메인페이지로 이동
	private String login(MemberBean memberBean) throws Exception {
		boolean transaction = false;

		
		MemberBean result = new MemberBean();
		
		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		if (memberMybatis.locationCheck(memberBean) == 1) { // 지역 체크

			DbMemberBean pwcheck = memberMybatis.pwCheck(memberBean);

			if (encryption.matches(memberBean.getMbpw(), pwcheck.getMbpw())) {// 비밀번호 체크

				if (convertToBoolean(memberMybatis.login(memberBean))) {// 로그인

					System.out.println("로그인 완료");

					transaction = true;

					result.setPage("success:User");
					result.setMbid(memberBean.getMbid());

					// 세션등록
					DbMemberBean dbMemberBean = memberMybatis.sircode(memberBean);
					session.setAttribute("sircode", dbMemberBean.getSircode());
					session.setAttribute("mbid", memberBean.getMbid());
					session.setAttribute("siscode", memberBean.getSiscode());
					if (memberBean.getMbid().contains("Admin")) {
						System.out.println("Admin");
						session.setAttribute("mbstcode", "M0");
						memberMybatis.delsircode(memberBean);
					} else {
						System.out.println("User");
						session.setAttribute("mbstcode", "M1");
					}
				} else {// 로그인 오류

				}

			} else {// 비밀번호 오류

				System.out.println("비밀번호 틀림");
				result.setPage("error:password");
			}

		} else {// 독서실 코드 오류

			if (memberBean.getMbid().equals("SisAdmin")) {

				memberBean.setSiscode("SisAdmin");
				System.out.println(memberBean.getMbid());
				System.out.println(memberBean.getSiscode());

				DbMemberBean pwcheck = memberMybatis.pwCheck(memberBean);
				if (encryption.matches(memberBean.getMbpw(), pwcheck.getMbpw())) {// 비밀번호 체크

					System.out.println(session.getAttribute("mbid"));

					if (convertToBoolean(memberMybatis.login(memberBean))) {// 로그인

						System.out.println("로그인 완료");

						result.setPage("success:User");
						result.setMbid(memberBean.getMbid());
						session.removeAttribute("siscode");
						transaction = true;
						// 세션등록
						session.setAttribute("mbstcode", "M7");
						session.setAttribute("mbid", memberBean.getMbid());
						session.setAttribute("Admin_code", memberBean.getSiscode());

					} else {// 로그인 오류

					}

				} else {// 비밀번호 오류

					System.out.println("비밀번호 틀림");
					result.setPage("error:password");
				}

			} else {
				System.out.println("SIS코드 틀림");
				result.setPage("error:siscode");
			}

		}

		Gson gson = new Gson();

		String results = gson.toJson(result);
		System.out.println(results);

		transactionExe.setTransactionResult(transaction);
		return results;
	}

	// 독서실 메인 페이지 내용 호출
	private String turnOn_selectSisPages_contents(SisBean sisBean) throws Exception {

		List<DbSisBean> sisMainPage = memberMybatis.mainPage(sisBean);

		Gson gson = new Gson();

		String result = gson.toJson(sisMainPage);
		System.out.println(result);
		return result;
	}

	// OTP QR코드 호출
	private String otp_qrCode(MemberBean memberBean) throws Exception {
		String result = "";

		OtpBean otpBean = (OtpBean) otpService.entrance(1, memberBean);

		Gson gson = new Gson();

		result = gson.toJson(otpBean);

		return result;
	}

	// OTP 일치여부 확인
	private String user_otpCode(OtpBean otpBean) throws Exception {
		String result = "";
		boolean transaction = false;
		OtpBean otpBeans = (OtpBean) otpService.entrance(2, otpBean);

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		if (otpBean.getPage() != null) {
			if (otpBean.getPage().equals("mb_contact_change")) {
				MemberBean memberBean = new MemberBean();

				memberBean.setMbphonenumber(otpBean.getMbphonenumber());
				memberBean.setMbid((String) session.getAttribute("mbid"));
				memberBean.setSiscode((String) session.getAttribute("siscode"));

				if (convertToBoolean(memberMybatis.changePhoneNumber(memberBean))) {
					// 휴대폰번호 변경 성공
					otpBeans.setMbphonenumber(otpBean.getMbphonenumber());
					transaction = true;
				} else {
					// 변경 실패
				}
			}
		}

		Gson gson = new Gson();

		result = gson.toJson(otpBeans);

		System.out.println(result);
		transactionExe.setTransactionResult(transaction);
		return result;
	}

	// 내 요청 요청확인
	private String request_find_service(RequestBean requestBean) throws Exception {
		String result = "";

		List<DbRequestBean> requestList = memberMybatis.request_find_service(requestBean);

		Gson gson = new Gson();

		result = gson.toJson(requestList);

		System.out.println(result);

		return result;
	}

	// 아이디 중복 체크
	private String id_sis_check(MemberBean memberBean) throws Exception {

		MemberBean result = new MemberBean();
		
		
		System.out.println(memberBean.getMbid());
		if (memberMybatis.locationCheck(memberBean) == 1) {
			System.out.println("중복된 아이디");
			result.setPage("error:id");
		} else if(memberBean.getMbid().equalsIgnoreCase("admin")){
			result.setPage("error:admincode");
			System.out.println("어드민코드");	
		}else {
			System.out.println("가입가능");
			result.setPage("success");
		}

		Gson gson = new Gson();

		String results = gson.toJson(result);
		System.out.println(results);
		return results;
	}

	// 최종관리자의 독서실 요청 종류 선택
	private String request_kind(RequestBean requestBean) throws Exception {
		String result = "";
		System.out.println(requestBean.getRsstcode());
		String stcode = "";

		if (requestBean.getRsstcode().equals("오픈예정")) {
			System.out.println(requestBean.getRsstcode() + "AA");
			stcode = "R1";

		} else if (requestBean.getRsstcode().equals("오픈")) {
			stcode = "R2";

		} else {
			stcode = "R0";

		}
		requestBean.setRsstcode(stcode);
		List<DbRequestBean> requestList = adminMybatis.request_kind(requestBean);

		Gson gson = new Gson();

		result = gson.toJson(requestList);

		System.out.println(result);

		return result;
	}

	// 최종 관리자 : 독서실 등록 시 지역이름을 통한 siscode 자동 호출
	private String sisCode_find(SisBean sisBean) throws Exception {
		String result = "";
		String resultNumber1 = "";
		String resultNumber2 = "";

		System.out.println(sisBean.getSiscode());
		String siscode = adminMybatis.sisCode_find(sisBean);
		if (siscode == null) {
			resultNumber1 = "0000001";
		} else {
			String number = (Integer.parseInt(siscode.substring(4)) + 1) + "";
			String zero = "";
			for (int i = 0; i < 7 - number.length(); i++) {
				zero += "0";
			}
			resultNumber1 = zero + number;
		}
		resultNumber2 = sisBean.getSiscode() + resultNumber1;

		SisBean resultBean = new SisBean();
		resultBean.setSiscode(resultNumber2);
		Gson gson = new Gson();

		result = gson.toJson(resultBean);

		return result;
	}

	// 독서실 관리자 : 해당 독서실 정보 호출
	private String sis_managementPage_sis() throws Exception {
		String result = "";
		System.out.println("독서실정보호출 진입");
		SisBean sisBean = new SisBean();
		sisBean.setSiscode((String) session.getAttribute("siscode"));
		System.out.println(sisBean.getSiscode());
		List<DbSisBean> dbSisList = memberMybatis.mainPage(sisBean);

		Gson gson = new Gson();

		result = gson.toJson(dbSisList);

		return result;
	}

	// 독서실 관리자 : 해당 독서실 자리정보 호출
	private String sis_managementPage_sir() throws Exception {
		String result = "";
		System.out.println("자리정보호출 진입");
		SisBean sisBean = new SisBean();
		sisBean.setSiscode((String) session.getAttribute("siscode"));

		System.out.println(sisBean.getSiscode());
		List<DbSisBean> dbmemberList = adminMybatis.sis_managementPage_sir(sisBean);

		Gson gson = new Gson();

		result = gson.toJson(dbmemberList);

		return result;
	}

	// 독서실 관리자 : 해당 독서실 회원정보
	private String sis_managementPage_mb() throws Exception {
		String result = "";
		System.out.println("회원정보호출 진입");
		SisBean sisBean = new SisBean();
		sisBean.setSiscode((String) session.getAttribute("siscode"));
		System.out.println(sisBean.getSiscode());
		List<DbMemberBean> dbSisList = adminMybatis.sis_managementPage_mb(sisBean);

		Gson gson = new Gson();

		result = gson.toJson(dbSisList);

		return result;
	}

	// 회원의 아이디찾기
	private String idFind_member(MemberBean memberBean) throws Exception {
		String result = "";
		StringBuffer st = new StringBuffer();
		memberBean.setSiscode((String) session.getAttribute("siscode"));
		MemberBean resultBean = new MemberBean();
		List<DbMemberBean> dbMemberList = memberMybatis.idFind(memberBean);
		int count = 1;
		try {
			st.append("<html>");
			st.append("<head>");
			st.append("<meta charset=\"utf-8\">");
			st.append("<style>");
			st.append("table {\r\n" + "    border-collapse: collapse;\r\n" + "    width: 100%;\r\n" + "}\r\n" + "\r\n"
					+ "th, td {\r\n" + "    text-align: left;\r\n" + "    padding: 8px;\r\n" + "}\r\n" + "\r\n"
					+ "tr:nth-child(even){background-color: #f2f2f2}\r\n" + "\r\n" + "th {\r\n"
					+ "    background-color: #4CAF50;\r\n" + "    color: white;\r\n" + "}");
			st.append("</style>");
			st.append("</head>");
			st.append("<body>");
			st.append("<div class=\"container\" style=\"	max-width: 41em;\r\n" + "	padding: 1em 3em 2em 3em;\r\n"
					+ "	margin: 0em auto;\r\n" + "	background-color: #fff;\r\n" + "	border-radius: 4.2px;\r\n"
					+ "	box-shadow: 0px 3px 10px -2px rgba(0, 0, 0, 0.2);\">");
			st.append(dbMemberList.get(0).getSisname() + "가입된 회원님의 아이디 목록");
			st.append("<table>");
			for (DbMemberBean dbmemberBean : dbMemberList) {
				st.append("<tr>");
				st.append("<td" + count + "</td><td>" + dbmemberBean.getMbid() + "</td>");
				st.append("</tr>");
				count++;
			}
			st.append("</table>");
			st.append("</div>");
			st.append("</body>");
			st.append("</html>");

			sendMail.sendmailInit(memberBean.getMbemail(), dbMemberList.get(0).getSisname(), st.toString());
			resultBean.setResult("전송완료");
		} catch (Exception e) {
			resultBean.setResult("확인된 아이디가 없습니다. 다시한번 확인해주세요.");
		}
		Gson gson = new Gson();

		result = gson.toJson(resultBean);

		return result;
	}

	// 회원의 비밀번호 찾기(EMAIL)
	private String pwFind_email_Member(MemberBean memberBean) throws Exception {
		String result = "";
		StringBuffer st = new StringBuffer();
		memberBean.setSiscode((String) session.getAttribute("siscode"));
		MemberBean resultBean = new MemberBean();
		Map<String, String> sisMap = new HashMap<String, String>();

		try {
			if (convertToBoolean(memberMybatis.nameIdEmailCheck(memberBean))) {
				sisMap.put("siscode", (String) session.getAttribute("siscode"));
				String sisname = memberMybatis.sisCodeToName(sisMap);

				st.append("<html>");
				st.append("<body>");
				st.append("<h1>안녕하세요 " + memberBean.getMbname() + " 님, </h1>");
				st.append("<p><strong>비밀번호를 변경하시려면 이 링크를 눌러주세요. 이 링크는 24시간 동안 유효합니다.</strong></p><br><br>");
				st.append("<form action=\"http://localhost/Smart_In_Study/TurnOn_PasswordPage_Email\" ");
				st.append("method=\"post\" >");
				st.append("<input type=\"hidden\" name=\"siscode\" value=\"" + memberBean.getSiscode() + "\" />");
				st.append("<input type=\"hidden\" name=\"mbid\" value=\"" + memberBean.getMbid() + "\" />");
				st.append("<div style=\"text-align: center;\">");
				st.append("<input type=\"submit\" value=\"비밀번호 변경 페이지로 이동\" style=\" background-color: #f05f40;\r\n"
						+ "      border-top: 10px solid #f05f40;\r\n" + "      border-right: 18px solid #f05f40;\r\n"
						+ "      border-bottom: 10px solid #f05f40;\r\n"
						+ "      border-left: 18px solid #f05f40;  display: inline-block;\r\n"
						+ "      color: #FFF;\r\n" + "      text-decoration: none;\r\n"
						+ "      border-radius: 3px;\r\n" + "      box-shadow: 0 2px 3px rgba(0, 0, 0, 0.16);\r\n"
						+ "      -webkit-text-size-adjust: none;\"></input>");
				st.append("</div>");
				/* st.append("<input type=\"submit\" value=\"비밀번호 변경페이지로 이동\" />"); */
				st.append("</form>");
				st.append("</body>");
				st.append("</html>");

				sendMail.sendmailInit(memberBean.getMbemail(), sisname, st.toString());
				resultBean.setResult("전송완료");

			} else {
				resultBean.setResult("확인된 아이디가 없습니다. 다시한번 확인해주세요.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultBean.setResult("확인된 아이디가 없습니다. 다시한번 확인해주세요.");
		}
		Gson gson = new Gson();

		result = gson.toJson(resultBean);

		return result;
	}

	// 회원의 아이디, 비밀번호, email 일치여부 확인
	private String idPhoneCheck(MemberBean memberBean) throws Exception {
		String result = "";
		StringBuffer st = new StringBuffer();
		memberBean.setSiscode((String) session.getAttribute("siscode"));
		MemberBean resultBean = new MemberBean();

		if (convertToBoolean(memberMybatis.idPhoneCheck(memberBean))) {
			resultBean.setResult("일치");
			// 세션등록
			session.setAttribute("mbid", memberBean.getMbid());
			session.setAttribute("mbphonenumber", memberBean.getMbphonenumber());
		} else {
			resultBean.setResult("불일치");
		}
		
		Gson gson = new Gson();

		result = gson.toJson(resultBean);

		return result;
	}

	// 결제시 자리코드 추가
	private String add_sircode(MemberBean memberBean) throws Exception {
		String result = "";

		memberBean.setMbid((String) session.getAttribute("mbid"));
		memberBean.setSiscode((String) session.getAttribute("siscode"));
		DbMemberBean dbmemberBean = new DbMemberBean();
		MemberBean resultBean = new MemberBean();
		if(convertToBoolean(memberMybatis.sircodeCheck(memberBean))) {
			resultBean.setPage("이미 사용중인 자리입니다.");
		}else {
			if (session.getAttribute("sircode") == null) {
				session.setAttribute("sircode", memberBean.getSircode());
				resultBean.setResult("자리선택 완료  자리 " + memberBean.getSircode());
				dbmemberBean = memberMybatis.sirpriceCheck(memberBean);
				session.setAttribute("sirprice", dbmemberBean.getSirprice());
				System.out.println(dbmemberBean.getSirprice());
				System.out.println(resultBean.getPage());
			} else if (session.getAttribute("sircode") != null) {
				resultBean.setResult(("자리선택 재완료  변경 후 자리 : " + memberBean.getSircode() + " 변경 전 자리 : "
						+ session.getAttribute("sircode")));
				session.removeAttribute("sircode");
				session.setAttribute("sircode", memberBean.getSircode());

				dbmemberBean = memberMybatis.sirpriceCheck(memberBean);
				session.setAttribute("sirprice", dbmemberBean.getSirprice());
				System.out.println(dbmemberBean.getSirprice());
			}
		}
		System.out.println(session.getAttribute("sircode"));
		System.out.println(session.getAttribute("sirprice"));

		Gson gson = new Gson();

		result = gson.toJson(resultBean);

		return result;
	}
	
	
	// 결제시 가격 계산
	private String add_sirprice(MemberBean memberBean) throws Exception {
		String result = "";

		memberBean.setMbid((String) session.getAttribute("mbid"));
		memberBean.setSiscode((String) session.getAttribute("siscode"));
		memberBean.setSircode((String) session.getAttribute("sircode"));
		DbMemberBean dbmemberBean = new DbMemberBean();
		MemberBean resultBean = new MemberBean();
		if(convertToBoolean(memberMybatis.paymentCheck(memberBean))) {
			dbmemberBean = memberMybatis.sirpriceCheck(memberBean);
			resultBean.setResult(dbmemberBean.getSirprice());
		}else {
		resultBean.setPage("이미 사용중이신 자리가 있습니다.");
		System.out.println(resultBean.getPage());
		}
		Gson gson = new Gson();

		result = gson.toJson(resultBean);
		
		return result;
	}
	
	private String sis_admin_sircheck(MemberBean memberBean) throws Exception {
		String result = "";
		
		
		memberBean.setMbid((String) session.getAttribute("mbid"));
		memberBean.setSiscode((String) session.getAttribute("siscode"));
		DbPaymentBean dbPaymentBean = new DbPaymentBean();
		PaymentBean resultBean = new PaymentBean();
		DbSensorBean dbsensorBean = new DbSensorBean();
		if(!convertToBoolean(memberMybatis.sircodeCheck(memberBean))) {
			resultBean.setPage("사용중인 회원이 없습니다.");
		}else {
			dbPaymentBean = adminMybatis.sis_admin_sircheck(memberBean);
			resultBean.setMbid(dbPaymentBean.getMbid());
			resultBean.setStartdate(dbPaymentBean.getStartdate());
			resultBean.setPhenddate(dbPaymentBean.getPhenddate());
			dbsensorBean = adminMybatis.inoutcheck(memberBean);
			try {
				resultBean.setResult((dbsensorBean.getSelog().equals("1")) ? "입실상태" : "퇴실상태");
			}catch(Exception ex) {
				resultBean.setResult("퇴실상태");
			}
			
		}
		
		Gson gson = new Gson();

		result = gson.toJson(resultBean);

		return result;
	}
	
	// 독서실 소개 수정
	private String sis_admin_changeMain_intro(SisBean sisBean) throws Exception {
		String result = "";
		boolean transaction = false;
		sisBean.setSiscode((String) session.getAttribute("siscode"));
		SisBean resultBean = new SisBean();

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		if (convertToBoolean(adminMybatis.sis_admin_changeMain_intro(sisBean))) {
			// 관리자 내용 소개 수정
			transaction = true;
			resultBean.setSisintro(sisBean.getSisintro());
			resultBean.setResult("<p id=\"notice\">알림 : 독서실 소개 수정 완료</p>");
		} else {
			// 내용 소개 수정 실패
			resultBean.setResult("<p id=\"notice\">알림 : 독서실 소개 수정 실패</p>");
		}

		transactionExe.setTransactionResult(transaction);

		Gson gson = new Gson();

		result = gson.toJson(resultBean);

		return result;
	}

	// 독서실 번호 수정
	private String sis_admin_changeMain_phonenumber(SisBean sisBean) throws Exception {
		String result = "";
		boolean transaction = false;
		sisBean.setSiscode((String) session.getAttribute("siscode"));
		SisBean resultBean = new SisBean();

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		if (convertToBoolean(adminMybatis.sis_admin_changeMain_phonenumber(sisBean))) {
			// 관리자 번호 수정
			transaction = true;
			resultBean.setSisphonenumber(sisBean.getSisphonenumber());
			resultBean.setResult("<p id=\"notice\">알림 : 독서실 담당자 번호 수정 완료</p>");
		} else {
			// 내용 번호 수정 실패
			resultBean.setResult("<p id=\"notice\">알림 : 독서실 담당자 번호 수정 실패</p>");
		}

		transactionExe.setTransactionResult(transaction);

		Gson gson = new Gson();

		result = gson.toJson(resultBean);

		return result;
	}

}
