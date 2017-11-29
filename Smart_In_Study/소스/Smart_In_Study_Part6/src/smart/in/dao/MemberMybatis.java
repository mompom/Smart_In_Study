package smart.in.dao;



import java.util.List;
import java.util.Map;

import org.apache.ibatis.type.Alias;

import smart.in.beans.DbMemberBean;
import smart.in.beans.DbPaymentBean;
import smart.in.beans.DbRequestBean;
import smart.in.beans.DbSensorBean;
import smart.in.beans.DbSisBean;
import smart.in.beans.GoalsBean;
import smart.in.beans.MemberBean;
import smart.in.beans.PaymentBean;
import smart.in.beans.RequestBean;
import smart.in.beans.SensorBean;
import smart.in.beans.SisBean;

@Alias ("dbMemberBean")

public interface MemberMybatis {
	// 1. 아이디 체크
	public int idCheck(MemberBean memberBean);

	// 2. 패스워드 체크
	public DbMemberBean pwCheck(MemberBean memberBean);

	// 3. 회원가입
	public int join(MemberBean memberBean);

	// 4. 로그아웃
	public int logout(MemberBean memberBean);

	// 5. 비밀번호 변경
	public int changePw(MemberBean memberBean);

	// 6. 주소 변경
	public int changeAdd(MemberBean memberBean);

	// 7. 닉네임 변경
	public int changeNick(MemberBean memberBean);

	// 8. 전화번호 변경
	public int changePhoneNumber(MemberBean memberBean);

	// 9. 이메일 변경
	public int changeEmail(MemberBean memberBean);

	// 10. 아이디 찾기
	public List<DbMemberBean> idFind(MemberBean memberBean);

	// 11. 비밀번호 찾기
	public DbMemberBean pwFind(MemberBean memberBean);

	// 12. 결제하기
	public int account(PaymentBean paymentBean);

	// 13. 목표 설정
	public int goals(Map<String, String> memberMap);

	// 14. 회원 정보페이지 이동
	public List<DbMemberBean> infoPage(MemberBean memberBean);

	// 15. 연락처변경페이지 이동
	public List<DbMemberBean> contactPage(MemberBean memberBean);

	// 16. 프로필변경페이지 이동
	public List<DbMemberBean> profilePage(MemberBean memberBean);

	// 17. 비밀번호변경페이지 이동
	public MemberBean passwordPage(MemberBean memberBean);

	// 18. 메인페이지 이동
	public List<DbSisBean> mainPage(SisBean sisBean);

	// 19. 회원 로그기록 페이지 이동
	public List<DbMemberBean> inOutPage(MemberBean memberBean);

	// 20. 결제페이지 이동
	public List<DbPaymentBean> paymentPage(PaymentBean paymentBean);

	// 21. 목표설정 페이지 이동
	public List<GoalsBean> goalsPage(MemberBean memberBean);

	// 22. 메인페이지 이동
	public List<DbSisBean> selectLocation(SisBean sisBean);

	// 23. 멤버 입&퇴실 기록
	public List<DbSensorBean> inOutHistory (SensorBean sensorBean);
	
	// 24. 멤버 로그인 기록
	public List<DbMemberBean> loginHistory (MemberBean memberBean);
	
	// 25. 로그인
	public int login(MemberBean memberBean);
	
	// 26. 지역 체크
	public int locationCheck(MemberBean memberBean);
		
	// 27. 프렌차이즈 요청
	public int request_service(RequestBean requestBean);
	
	// 28. 프렌차이즈 시퀀스 번호 확인
	public DbRequestBean request_Sequnce_find(RequestBean requestBean);
	
	// 29. 내 프렌차이즈 요청 확인
	public List<DbRequestBean> request_find_service(RequestBean requestBean);
	
	// 30. 자리 등록
	public int set_sir(PaymentBean paymentBean);
	
	// 31. 비밀번호찾기(아이디, 핸드폰번호, 독서실코드 일치여부 확인)
	public int idPhoneCheck(MemberBean memberBean);
	
	// 32. 비밀번호찾기(아이디, 이메일, 독서실코드 일치여부 확인)
	public int idEmailCheck(MemberBean memberBean);
	
	// 33. siscode와 일치한 이름 출력
	public String sisCodeToName(Map<String,String> sisMap);
	
	// 32. 비밀번호찾기(이름, 아이디, 이메일, 독서실코드 일치여부 확인)
	public int nameIdEmailCheck(MemberBean memberBean);
	
	// 33. 결제에 필요한 회원정보 출력
	public DbMemberBean mbinfo_payment(MemberBean memberBean);
	
	// 35. 자리 가격 체크
	public DbMemberBean sirpriceCheck(MemberBean memberBean);
	
	// 36. 자리 중복 체크
	public int sircodeCheck(MemberBean memberBean);
	
	// 37. 결제 중복 체크
	public int paymentCheck(MemberBean memberBean);
	
	// 38. 자리 등록 체크
	public int accountCheck(MemberBean memberBean);
	
	// 39. 자리 등록
	public DbMemberBean sircode(MemberBean memberBean);
	
	// 40. 자리 삭제
	public int delsircode(MemberBean memberBean);
	
	
}
