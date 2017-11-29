package smart.in.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import smart.in.beans.DbMemberBean;
import smart.in.beans.DbPaymentBean;
import smart.in.beans.DbRequestBean;
import smart.in.beans.DbSisBean;
import smart.in.beans.MemberBean;
import smart.in.beans.RequestBean;
import smart.in.beans.SisBean;
import smart.in.dao.AdminMybatis;
import smart.in.dao.MemberMybatis;
import smart.in.dao.SensorMybatis;
import smart.in.utils.Encryption;
import smart.in.utils.Session;

@Service
public class AdminService extends TransactionExe {
	// 마이바티스와 연동되는 인터페이스 사용

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

	public AdminService() {
	}

	private boolean convertToBoolean(int value) {
		return (value == 1) ? true : false;
	}

	/* 진입 메서드 */
	public ModelAndView entrance(int serviceCode, Object... object) throws Exception {
		ModelAndView mav = null;

		// 현재 페이지 세션등록
		if (session.getAttribute("page") != null) {
			session.removeAttribute("page");
		}

		switch (serviceCode) {
		case 1:
			mav = MainPage();
			break;
		case 2:
			mav = MainLoginAdminPage();
			break;
		case 5:
			mav = salesPage();
			break;
		case 9:
			mav = franchisee_findPage();
			break;
		case 10:
			mav = sisSetup((SisBean) object[0]);
			break;
		case 11:
			mav = sis_register((MultipartHttpServletRequest) object[0]);
			break;
		case 12:
			mav = turnOn_sis_admin_managementPage();
			break;
		case 13:
			mav = turnOn_sis_admin_registerPage();
			break;
		case 14:
			mav = turnOn_sis_admin_changemainPage();
			break;
		case 15:
			mav = sis_admin_changeMain_img((MultipartHttpServletRequest) object[0]);
			break;
		case 16:
			mav = turnOn_sis_admin_userInfoPage();
			break;
		default:
			break;
		}

		return mav;
	}

	/* End 진입 메서드 */

	// 메인페이지 호출
	private ModelAndView MainPage() throws Exception {
		ModelAndView mav = new ModelAndView();

		StringBuffer st = new StringBuffer();

		List<DbSisBean> sisTexts = adminMybatis.mainSisAll();

		for (DbSisBean sisText : sisTexts) {
			System.out.println(sisText.getSiscode());

			st.append("<div class=\"col-sm-6 col-md-4\">\r\n" + "<div class=\"thumbnail\">\r\n");
			st.append("<a class=\"lightbox\" href=\"TurnOn_SelectSisPage?siscode=" + sisText.getSiscode() + "\">");
			if (sisText.getSisimg1().equals("comingsoon.jpg")) {
				st.append("<img src=\"images/comingsoon.jpg\" alt=\"\"></a>\n");
			} else {
				st.append("<img src=\"images/" + sisText.getSiscode() + "/" + sisText.getSisimg1()
						+ "\" alt=\"\"></a>\n");
			}
			st.append("<div class=\"caption\"><h3>" + sisText.getSisname() + "</h3>" + "</div>" + "</div></div>");
		}

		mav.addObject("sisText", st.toString());

		mav.setViewName("main");
		// google_graph_test
		return mav;

	}

	// 메인페이지 최종관리자 로그인
	private ModelAndView MainLoginAdminPage() throws Exception {
		ModelAndView mav = new ModelAndView();

		StringBuffer st = new StringBuffer();

		List<DbSisBean> sisTexts = adminMybatis.mainSisAll();

		for (DbSisBean sisText : sisTexts) {
			System.out.println(sisText.getSiscode());

			st.append("<div class=\"col-sm-6 col-md-4\">\r\n" + "<div class=\"thumbnail\">\r\n");
			st.append("<a class=\"lightbox\" href=\"TurnOn_SelectSisPage?siscode=" + sisText.getSiscode() + "\">");
			if (sisText.getSisimg1().equals("comingsoon.jpg")) {
				st.append("<img src=\"images/comingsoon.jpg\" alt=\"\"></a>\n");
			} else {
				st.append("<img src=\"images/" + sisText.getSiscode() + "/" + sisText.getSisimg1()
						+ "\" alt=\"\"></a>\n");
			}
			st.append("<div class=\"caption\"><h3>" + sisText.getSisname() + "</h3>" + "</div>" + "</div></div>");
		}

		mav.addObject("sisText", st.toString());

		mav.setViewName("main_login_admin");
		// google_graph_test
		return mav;
	}

	

	

	// 결제 내역 페이지
	private ModelAndView salesPage() throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		MemberBean memberBean = new MemberBean();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);
		System.out.println(session.getAttribute("siscode"));
		memberBean.setSiscode((String) session.getAttribute("siscode"));
		
		List<DbPaymentBean> sales = adminMybatis.sales(memberBean);
		st.append("<div id=\"resultTable\">");
		st.append("<div class=\"component\">");
		st.append("<table>");
		st.append("<thead><tr><th>자리</th><th>회원아이디</th><th>시작 날짜</th><th>종료 날짜"
				+ "</th><th>가격</th></tr></thead>");
		st.append("<tbody>");
		
		for (DbPaymentBean sale : sales) {
			st.append("<tr>");
			st.append("<td>" + sale.getSircode() + "</td>");
			st.append("<td>" + sale.getMbid() + "</td>");
			st.append("<td>" + sale.getPhdate() + "</td>");
			st.append("<td>" + sale.getPhenddate() + "</td>");
			st.append("<td>" + sale.getPrice() + "</td>");
			st.append("</tr>");
		}
		st.append("</tbody></table>");
		mav.addObject("sales", st);
		mav.setViewName("salespage");
		return mav;
	}



	// 프렌차이즈 요청 확인 페이지 호출
	private ModelAndView franchisee_findPage() throws Exception {
		ModelAndView mav = new ModelAndView();

		StringBuffer st = new StringBuffer();
		RequestBean requestBean = new RequestBean();

		requestBean.setRsstcode("R0");
		List<DbRequestBean> requestTexts = adminMybatis.request_kind(requestBean);
		int count = 0;

		st.append("<div id=\"resultTable\">");
		st.append("<div class=\"component\">");
		st.append("<table>");
		st.append("<thead><tr>");
		st.append("<th>번호</th>");
		st.append("<th>이름</th>");
		st.append("<th>휴대폰 번호</th>");
		st.append("<th>현황</th>");
		st.append("</tr></thead><tobdy>");

		for (DbRequestBean requestText : requestTexts) {
			System.out.println(requestText.getRsdate());
			st.append("<tr onClick=\"request_sequence('" + count + "')\" >");
			st.append("<td>" + (count + 1) + "</td>");
			st.append("<td>" + requestText.getRsname() + "</td>");
			st.append("<td>" + requestText.getRsphonenumber() + "</td>");
			st.append("<td>" + requestText.getRsstname() + "</td>");
			st.append("</tr>");
			st.append("<tr id=\"sequence" + count + "\" style=\"display:none\" >");
			st.append("<td colspan=\"4\">주소 : " + requestText.getRsaddress() + "<br>");
			st.append("요청사항  <br>" + requestText.getRscontent());
			st.append("<br> <input type=\"button\" onClick=\"turnOn_admin_franchisee_setupPage('"
					+ requestText.getRsaddress() + "','" + requestText.getRsphonenumber() + "','"
					+ requestText.getRsdate() + "')\" value=\"등록\" />");
			st.append("</td>");
			st.append("</tr>");

			count++;
		}
		st.append("</tbody></table>");

		mav.addObject("requestTexts", st.toString());

		mav.setViewName("admin_request_find");
		// google_graph_test

		return mav;
	}

	// 프렌차이즈 요청 확인 페이지 호출
	private ModelAndView sisSetup(SisBean sisBean) throws Exception {
		ModelAndView mav = new ModelAndView();
		boolean transaction = false;
		StringBuffer st = new StringBuffer();
		Map<String, String> sisMap = new HashMap<String, String>();
		Map<String, String> requestMap = new HashMap<String, String>();

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		System.out.println(sisBean.getSiscode());
		System.out.println(sisBean.getSisaddress());
		System.out.println(sisBean.getSisphonenumber());
		System.out.println(sisBean.getSisroomType());
		System.out.println((String) session.getAttribute("rsaddress"));

		String[] roomType = sisBean.getSisroomType().split(",");
		int oneCount = 0;
		int openCount = 0;
		int groupCount = 0;

		// 독서실 등록 및 자리등록
		sisMap.put("siscode", sisBean.getSiscode());
		sisMap.put("sisaddress", sisBean.getSisaddress());
		sisMap.put("sisphonenumber", sisBean.getSisphonenumber());
		String[] sisname = sisBean.getSisaddress().split(" ");
		sisMap.put("sisname", sisname[1] + " " + sisname[2] + "점");

		// 요청 수정
		requestMap.put("rsaddress", (String) session.getAttribute("rsaddress"));
		requestMap.put("rsaddress2", sisBean.getSisaddress());
		requestMap.put("rsphonenumber", sisBean.getSisphonenumber());

		// 독서실 관리자 등록
		MemberBean memberBean = new MemberBean();
		String mbid = sisBean.getSiscode().substring(0, 3) + Integer.parseInt(sisBean.getSiscode().substring(4))
				+ "Admin";
		memberBean.setMbid(mbid);
		memberBean.setSiscode(sisBean.getSiscode());
		memberBean.setMbpw(encryption.encode("1q2w3e4r"));
		memberBean.setMbphonenumber(sisBean.getSisphonenumber());
		memberBean.setMbaddress(sisBean.getSisaddress());

		if (convertToBoolean(adminMybatis.sisSetup(sisMap))) {
			// 독서실 등록 성공

			if (convertToBoolean(adminMybatis.request_update(requestMap))) {// 요청 수정성공
				sisMap.put("siscode", sisBean.getSiscode());
				sisMap.put("roomType", "X");

				// 관리자 가입 성공

				if (convertToBoolean(adminMybatis.sisRoomSetup(sisMap))) { // X 등록성공
					if (convertToBoolean(adminMybatis.sisjoin(memberBean))) {

						for (int i = 0; i < roomType.length; i++) { // 방 및 자리등록

							if (roomType[i].equals("1인실")) {
								sisMap.put("roomType", "O" + oneCount);

								if (convertToBoolean(adminMybatis.sisRoomSetup(sisMap))) {
									// 방 등록 성공

									for (int j = 1; j <= Integer.parseInt(roomType[i + 1]); j++) {
										sisMap.put("seetType", "O" + oneCount + j);

										if (convertToBoolean(adminMybatis.sisSeetSetup(sisMap))) {
											// 자리등록 성공

											transaction = true;

										} else {
											// 자리등록 실패
											System.out.println("자리등록 실패");
											break;
										}

									} // End For
									oneCount++;
								} else {// 방 등록 실패

								}

							} else if (roomType[i].equals("오픈형열람실")) {

								sisMap.put("roomType", "P" + openCount);

								if (convertToBoolean(adminMybatis.sisRoomSetup(sisMap))) {
									// 방 등록 성공
									for (int j = 1; j <= Integer.parseInt(roomType[i + 1]); j++) {
										sisMap.put("seetType", "P" + openCount + j);

										if (convertToBoolean(adminMybatis.sisSeetSetup(sisMap))) {
											// 자리등록 성공
											transaction = true;

										} else {
											// 자리등록 실패
											System.out.println("자리등록 실패");
											break;
										}

									} // End For
									openCount++;
								} else {// 방 등록 실패

								}

							} else if (roomType[i].equals("그룹스터디룸")) {

								sisMap.put("roomType", "G" + groupCount);

								if (convertToBoolean(adminMybatis.sisRoomSetup(sisMap))) {
									// 방 등록 성공
									for (int j = 1; j <= Integer.parseInt(roomType[i + 1]); j++) {
										sisMap.put("seetType", "G" + groupCount + j);

										if (convertToBoolean(adminMybatis.sisSeetSetup(sisMap))) {
											// 자리등록 성공
											transaction = true;

										} else {
											// 자리등록 실패
											System.out.println("자리등록 실패");
											break;
										}

									} // End For
									groupCount++;
								} else {// 방 등록 실패
									System.out.println("방 등록 실패");
								}
							} // End 그룹스터디룸
						} // End For
					} else {
						// 관리자 가입 실패
						System.out.println("관리자 가입 실패");
					}
				} else {
					// X 자리 등록 실패
					System.out.println("X 자리 등록 실패");
				}

			} else {
				// 요청 수정 실패
				System.out.println("요청 수정 실패");
			}

		} else {
			// 독서실 등록 실패
			System.out.println("독서실 등록 실패");
		}

		transactionExe.setTransactionResult(transaction);
		mav = franchisee_findPage();
		// google_graph_test

		return mav;
	}

	// 독서실 관리자의 메인페이지 오픈
	private ModelAndView sis_register(MultipartHttpServletRequest mtfRequest) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;

		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		SisBean sisBean = new SisBean();

		List<MultipartFile> mainList = mtfRequest.getFiles("sisimg1");
		List<MultipartFile> oneList = mtfRequest.getFiles("sisimg2");
		List<MultipartFile> openList = mtfRequest.getFiles("sisimg3");
		List<MultipartFile> groupList = mtfRequest.getFiles("sisimg4");

		String sisimg1 = "";
		String sisimg2 = "";
		String sisimg3 = "";
		String sisimg4 = "";
		String safeFile1 = "";
		String safeFile2 = "";
		String safeFile3 = "";
		String safeFile4 = "";
		String path = "E:\\cha\\Smart_In_Study_Part6\\WebContent\\views\\images\\"
				+ (String) session.getAttribute("siscode") + "\\";
		try {
			File targetDir = new File(path);
			if (!targetDir.exists()) {// 파일이 존재하지 않으면 생성
				targetDir.mkdirs();
			} /*
				 * else { targetDir.delete(); targetDir.mkdirs(); }
				 */

			for (MultipartFile mf : mainList) {
				sisimg1 = mf.getOriginalFilename(); // 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈
				safeFile1 = path + sisimg1;
				System.out.println("main이미지 파일 크기 : " + fileSize);
			}
			for (MultipartFile mf : oneList) {
				sisimg2 = mf.getOriginalFilename(); // 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈
				safeFile2 = path + sisimg2;
				System.out.println("one 이미지 파일 크기 : " + fileSize);
			}
			for (MultipartFile mf : openList) {
				sisimg3 = mf.getOriginalFilename(); // 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈
				safeFile3 = path + sisimg3;
				System.out.println("open 이미지 파일 크기 : " + fileSize);
			}
			for (MultipartFile mf : groupList) {
				sisimg4 = mf.getOriginalFilename(); // 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈
				safeFile4 = path + sisimg4;
				System.out.println("group 이미지 파일 크기 : " + fileSize);
			}

			sisBean.setSiscode((String) session.getAttribute("siscode"));
			sisBean.setSisname(mtfRequest.getParameter("sisname"));
			sisBean.setSisintro(mtfRequest.getParameter("sisintro"));
			sisBean.setSisnumber(mtfRequest.getParameter("sisnumber"));
			sisBean.setSisphonenumber(mtfRequest.getParameter("sisphonenumber"));
			sisBean.setSisaddress(mtfRequest.getParameter("sisaddress"));
			sisBean.setSisimg1(sisimg1);
			sisBean.setSisimg2(sisimg2);
			sisBean.setSisimg3(sisimg3);
			sisBean.setSisimg4(sisimg4);
			System.out.println(sisBean.getSiscode());
			System.out.println(sisBean.getSisphonenumber());
			System.out.println(sisBean.getSisaddress());
			
			if (convertToBoolean(adminMybatis.sis_register(sisBean))) {
				// 독서실 업데이트 성공
				if (convertToBoolean(adminMybatis.sis_rs_register(sisBean))) {
					// 독서실 요청 업데이트 성공
					sisBean.setSirprice(Integer.parseInt(mtfRequest.getParameter("oneSirPrice")));
					sisBean.setSircode("O");
					System.out.println(sisBean.getSiscode());
					System.out.println(sisBean.getSircode());
					System.out.println(sisBean.getSirprice());
					adminMybatis.sis_sir_register(sisBean);// 독립형 1인실 자리 가격 업데이트

					sisBean.setSirprice(Integer.parseInt(mtfRequest.getParameter("openSirPrice")));
					sisBean.setSircode("P");
					adminMybatis.sis_sir_register(sisBean);// 오픈형열람실 가격 업데이트

					sisBean.setSirprice(Integer.parseInt(mtfRequest.getParameter("groupSirPrice")));
					sisBean.setSircode("G");
					adminMybatis.sis_sir_register(sisBean); // 그룹스터디룸 가격 업데이트 성공

					transaction = true;
					// 파일 업로드
					for (MultipartFile mf : mainList) {
						mf.transferTo(new File(safeFile1));
					}
					for (MultipartFile mf : oneList) {
						mf.transferTo(new File(safeFile2));
					}
					for (MultipartFile mf : openList) {
						mf.transferTo(new File(safeFile3));
					}
					for (MultipartFile mf : groupList) {
						mf.transferTo(new File(safeFile4));
					}
				}else {
					//독서실 요청 업데이트 실패
					System.out.println("AAA");
				}
			} else {
				System.out.println("DDD");
				// 독서실 업데이트 실패
			}
		} catch (Exception e) {
			e.printStackTrace();
			transaction = false;
		}

		transactionExe.setTransactionResult(transaction);
		mav.setViewName("sis_login_main");
		return mav;
	}

	// 독서실 관리자의 독서실 관리 페이지 이동
	private ModelAndView turnOn_sis_admin_managementPage() throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();

		SisBean sisBean = new SisBean();

		sisBean.setSiscode((String) session.getAttribute("siscode"));

		DbSisBean dbSisBean = adminMybatis.sis_managementPage_sis(sisBean);

		List<DbMemberBean> sisMemberList = adminMybatis.sis_managementPage_mb(sisBean);

		sisBean.setSircode("O");
		List<DbSisBean> sisOneSirList = adminMybatis.sis_managementPage_sir(sisBean);
		sisBean.setSircode("P");
		List<DbSisBean> sisOpenSirList = adminMybatis.sis_managementPage_sir(sisBean);
		sisBean.setSircode("G");
		List<DbSisBean> sisGroupSirList = adminMybatis.sis_managementPage_sir(sisBean);

		Gson gson = new Gson();

		mav.addObject("dbSisBean", gson.toJson(dbSisBean));
		mav.addObject("sisMemberList", gson.toJson(sisMemberList));
		mav.addObject("sisOneSirList", gson.toJson(sisOneSirList));
		mav.addObject("sisOpenSirList", gson.toJson(sisOpenSirList));
		mav.addObject("sisGroupSirList", gson.toJson(sisGroupSirList));

		mav.setViewName("sis_admin_management");
		return mav;
	}

	// 독서실 관리자의 독서실 등록페이지 이동
	private ModelAndView turnOn_sis_admin_registerPage() throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();

		SisBean sisBean = new SisBean();

		sisBean.setSiscode((String) session.getAttribute("siscode"));

		DbSisBean dbSisBean = adminMybatis.sis_managementPage_sis(sisBean);

		Gson gson = new Gson();

		mav.addObject("dbSisBean", gson.toJson(dbSisBean));

		mav.setViewName("sis_admin_register");
		return mav;
	}

	// 독서실 관리자의 독서실 메인페이지 관리페이지 이동
	private ModelAndView turnOn_sis_admin_changemainPage() throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();

		SisBean sisBean = new SisBean();

		sisBean.setSiscode((String) session.getAttribute("siscode"));

		List<DbSisBean> dbSisBean = memberMybatis.mainPage(sisBean);

		Gson gson = new Gson();

		mav.addObject("dbSisBean", gson.toJson(dbSisBean));

		mav.setViewName("sis_admin_changemain");
		return mav;
	}

	// 독서실 관리자의 독서실 메인페이지 관리페이지 이동
	private ModelAndView sis_admin_changeMain_img(MultipartHttpServletRequest mtfRequest) throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();
		boolean transaction = false;
		String message = "";
		transactionExe.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		String path = "E:\\cha\\Smart_In_Study_Part6\\WebContent\\views\\images\\"
				+ (String) session.getAttribute("siscode") + "\\";

		String imgname = mtfRequest.getParameter("page");

		List<MultipartFile> imgList = mtfRequest.getFiles(imgname);
		String sisimg = "";
		String safeFile = "";
		try {
			File targetDir = new File(path);
			if (!targetDir.exists()) {// 파일이 존재하지 않으면 생성
				targetDir.mkdirs();
			} /*
				 * else { targetDir.delete(); targetDir.mkdirs(); }
				 */

			for (MultipartFile mf : imgList) {
				sisimg = mf.getOriginalFilename(); // 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈
				safeFile = path + sisimg;
				System.out.println("main이미지 파일 크기 : " + fileSize);
			}
			SisBean sisBean = new SisBean();
			sisBean.setSiscode((String) session.getAttribute("siscode"));
			sisBean.setSisimg1(sisimg);

			if (imgname.equals("sisimg1")) {
				if (convertToBoolean(adminMybatis.sis_admin_changeMain_img1(sisBean))) {
					// 이미지1 업데이트 성공
					transaction = true;
					message = "<p id=\"notice\">알림 : 메인 사진 업로드 성공</p>";
					// 파일 업로드
					for (MultipartFile mf : imgList) {
						mf.transferTo(new File(safeFile));
					}
				} else {
					// 이미지 업데이트 실패
				}
			} else if (imgname.equals("sisimg2")) {
				if (convertToBoolean(adminMybatis.sis_admin_changeMain_img2(sisBean))) {
					// 이미지2 업데이트 성공
					transaction = true;
					message = "<p id=\"notice\">알림 : 독립형 1인실 사진 업로드 성공</p>";
					// 파일 업로드
					for (MultipartFile mf : imgList) {
						mf.transferTo(new File(safeFile));
					}
				} else {
					// 이미지 업데이트 실패
				}
			} else if (imgname.equals("sisimg3")) {
				if (convertToBoolean(adminMybatis.sis_admin_changeMain_img3(sisBean))) {
					// 이미지3 업데이트 성공
					transaction = true;
					message = "<p id=\"notice\">알림 : 오픈형 열람실 사진 업로드 성공</p>";
					// 파일 업로드
					for (MultipartFile mf : imgList) {
						mf.transferTo(new File(safeFile));
					}
				} else {
					// 이미지 업데이트 실패
				}
			} else if (imgname.equals("sisimg4")) {
				if (convertToBoolean(adminMybatis.sis_admin_changeMain_img4(sisBean))) {
					// 이미지4 업데이트 성공
					transaction = true;
					message = "<p id=\"notice\">알림 : 그룹스터디룸 사진 업로드 성공</p>";
					// 파일 업로드
					for (MultipartFile mf : imgList) {
						mf.transferTo(new File(safeFile));
					}
				} else {
					// 이미지 업데이트 실패
				}
			}

		} catch (Exception e) {
			e.printStackTrace();

		}
		transactionExe.setTransactionResult(transaction);
		mav = turnOn_sis_admin_changemainPage();
		mav.addObject("message", message);

		return mav;
	}

	// 독서실 관리자의 독서실 메인페이지 관리페이지 이동
	private ModelAndView turnOn_sis_admin_userInfoPage() throws Exception {
		ModelAndView mav = new ModelAndView();
		StringBuffer st = new StringBuffer();

		SisBean sisBean = new SisBean();

		sisBean.setSiscode((String) session.getAttribute("siscode"));

		List<DbMemberBean> dbMemberBean = adminMybatis.sis_managementPage_mb(sisBean);

		Gson gson = new Gson();

		mav.addObject("dbMemberBean", gson.toJson(dbMemberBean));
		mav.setViewName("sis_admin_userinfo");
		return mav;
	}

}