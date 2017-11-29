package smart.in.dao;

import java.util.List;

import java.util.Map;

import smart.in.beans.DbMemberBean;
import smart.in.beans.DbPaymentBean;
import smart.in.beans.DbRequestBean;
import smart.in.beans.DbSensorBean;
import smart.in.beans.DbSisBean;
import smart.in.beans.MemberBean;
import smart.in.beans.RequestBean;
import smart.in.beans.SisBean;

public interface AdminMybatis {
	
	// 메인페이지 호출
	public List<DbSisBean> mainSisAll();
	
	// 메인페이지 지역 호출
	public List<DbSisBean> mainSisLocation(SisBean sisBean);
	
	// 1. 메인페이지 수정
	public int sisChange(SisBean sisBean);

	// 2. 회원 정보 확인
	public List<DbMemberBean> memberInfoPage();

	// 3. 매출 정보 확인
	public List<DbPaymentBean> salesPage();

	// 4. 매출 상세정보 확인
	public List<DbPaymentBean> salesInfoPage(MemberBean memberBean);

	// 5. 사용자 로그기록 확인
	public List<DbMemberBean> inOutMemberPage();
	
	// 6. 메인 수정 페이지 이동
	public List<DbSisBean> sisChangePage(Map<String,String> adminMap);
	
	// 7. 최종관리자의 프렌차이즈 호출 
	public List<DbRequestBean> request_kind(RequestBean requestBean);
	
	// 8. 지역에 해당하는 다음 siscode 자동 호출
	public String sisCode_find(SisBean sisBean);
	
	// 9. 등록된 요청 상태코드 및 주소 업데이트
	public int request_update(Map<String,String> requestMap);
	public int request_address_update(Map<String,String> requestMap);
	
	// 10. 독서실 등록
	public int sisSetup(Map<String,String> sisMap);
	
	// 11. 방 등록
	public int sisRoomSetup(Map<String,String> sisMap);
	
	// 12. 자리 등록
	public int sisSeetSetup(Map<String,String> sisMap);
	
	// 13. 관리자 등록
	public int sisjoin(MemberBean memberBean);
	
	// 14. 독서실 관리자의 독서실 오픈 // 업데이트
	public int sis_register(SisBean sisBean);
	// 14-1. 독서실 자리 가격 업데이트
	public int sis_sir_register(SisBean sisBean);
	// 14-2. 독서실 요청 가격 업데이트
	public int sis_rs_register(SisBean sisBean);
	
	// 15. 독서실 자리정보 호출
	public List<DbSisBean> sis_managementPage_sir(SisBean sisBean);
	
	// 16. 독서실 회원정보 호출
	public List<DbMemberBean> sis_managementPage_mb(SisBean sisBean);
	
	// 16. 독서실 정보 호출
	public DbSisBean sis_managementPage_sis(SisBean sisBean);
	
	// 17. 관리자 독서실 이미지 변경
	public int sis_admin_changeMain_img1(SisBean sisBean);
	public int sis_admin_changeMain_img2(SisBean sisBean);
	public int sis_admin_changeMain_img3(SisBean sisBean);
	public int sis_admin_changeMain_img4(SisBean sisBean);
	
	// 18. 관리자 독서실 소개 변경
	public int sis_admin_changeMain_intro(SisBean sisBean);
		
	// 18. 관리자 독서실 담당자 번호 변경
	public int sis_admin_changeMain_phonenumber(SisBean sisBean);
	
	// 19. 매출 내역
	public List<DbPaymentBean> sales(MemberBean memberBean);
	
	// 20. 자리 정보
	public DbPaymentBean sis_admin_sircheck(MemberBean memberBean);
	
	// 21. 자리정보 2
	public DbSensorBean inoutcheck(MemberBean memberBean);
}
