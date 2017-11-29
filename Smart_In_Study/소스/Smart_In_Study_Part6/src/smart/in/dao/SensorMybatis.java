package smart.in.dao;

import java.util.List;
import java.util.Map;

import smart.in.beans.DbMemberBean;
import smart.in.beans.DbPaymentBean;
import smart.in.beans.DbSensorBean;
import smart.in.beans.MemberBean;
import smart.in.beans.SensorBean;
import smart.in.beans.SisBean;

public interface SensorMybatis {

	// 1. 센서 확인 페이지 이동
	public List<DbSensorBean> sensorPage(Map<String,String> sensorMap);

	// 2. 소음 센서 시간별 확인
	public List<DbSensorBean> sound_sensor_day(DbPaymentBean dbpaymentbean);

	// 3. 소음 센서 일별 확인
	public List<DbSensorBean> sound_sensor_month(DbPaymentBean dbpaymentbean);
	
	public List<DbSensorBean> sound_sensor_main(DbPaymentBean dbpaymentbean);

	public List<DbPaymentBean> select_room_code(DbPaymentBean dbpaymentbean);
	
	// 4. 먼지 센서 시간별 확인
	public List<DbSensorBean> dust_sensor_day(DbPaymentBean dbpaymentbean);

	// 5. 먼지 센서 일별 확인
	public List<DbSensorBean> dust_sensor_month(DbPaymentBean dbpaymentbean);

	// 6. 빛의 세기 시간별 확인
	public List<DbSensorBean> light_sensor_day(DbPaymentBean dbpaymentbean);

	// 7. 빛의 세기 일별 확인
	public List<DbSensorBean> light_sensor_month(DbPaymentBean dbpaymentbean);

	// 5. 온습도 센서 시간별 확인
	public List<DbSensorBean> dht_sensor_day(DbPaymentBean dbpaymentbean);

	// 6. 온습도 센서 일별 확인
	public List<DbSensorBean> dht_sensor_month(DbPaymentBean dbpaymentbean);
	
	public List<DbSensorBean> dht_sensor_main(DbPaymentBean dbpaymentbean);

	
	public List<DbPaymentBean> select_date_range(DbPaymentBean dbpaymentbean);
	
	// 9. 적외선 센서 시간별 확인
	public List<DbSensorBean> ir_sensor_day(DbPaymentBean dbpaymentbean);

	// 10. 적외선 센서 일별 확인
	public List<DbSensorBean> ir_sensor_month(DbPaymentBean dbpaymentbean);

	// 11. 인체감지 센서 시간별 확인
	public List<DbSensorBean> hir_sensor_day(DbPaymentBean dbpaymentbean);

	// 12. 인체감지 센서 일별 확인
	public List<DbSensorBean> hir_sensor_month(DbPaymentBean dbpaymentbean);
	
	
	// 2. 개인 소음 센서 시간별 확인
	public List<DbSensorBean> sound_sensor_day_personal(DbPaymentBean dbpaymentbean);

	// 3. 개인 소음 센서 일별 확인
	public List<DbSensorBean> sound_sensor_month_personal(DbPaymentBean dbpaymentbean);

	// 4. 개인 먼지 센서 시간별 확인
	public List<DbSensorBean> dust_sensor_day_personal(DbPaymentBean dbpaymentbean);

	// 5. 개인 먼지 센서 일별 확인
	public List<DbSensorBean> dust_sensor_month_personal(DbPaymentBean dbpaymentbean);

	// 6. 개인 빛의 세기 시간별 확인
	public List<DbSensorBean> light_sensor_day_personal(DbPaymentBean dbpaymentbean);

	// 7. 개인 빛의 세기 일별 확인
	public List<DbSensorBean> light_sensor_month_personal(DbPaymentBean dbpaymentbean);

	// 5. 개인 온습도 센서 시간별 확인
	public List<DbSensorBean> dht_sensor_day_personal(DbPaymentBean dbpaymentbean);

	// 6. 개인 온습도 센서 일별 확인
	public List<DbSensorBean> dht_sensor_month_personal(DbPaymentBean dbpaymentbean);

	
	public List<DbSensorBean> rfid_sensor_log_select(DbPaymentBean dbpaymentbean);
	
	public List<DbSensorBean> rfid_sensor_day_text(MemberBean memberBean);
	
	public List<DbSensorBean> rfid_sensor_day(DbPaymentBean dbpaymentbean);
	
	public List<DbSensorBean> rfid_sensor_day_not(DbPaymentBean dbpaymentbean);
	
	// 8. 개인 입퇴실 기록 일별 확인
	public List<DbSensorBean> rfid_sensor_week(DbPaymentBean dbpaymentbean);
	
	public List<DbSensorBean> rfid_sensor_week_not(DbPaymentBean dbpaymentbean);

	// 9. 개인 적외선 센서 시간별 확인
	public List<DbSensorBean> ir_sensor_day_personal(DbPaymentBean dbpaymentbean);

	// 10. 개인 적외선 센서 일별 확인
	public List<DbSensorBean> ir_sensor_month_personal(DbPaymentBean dbpaymentbean);

	// 11. 개인 인체감지 센서 시간별 확인
	public List<DbSensorBean> hir_sensor_day_personal(DbPaymentBean dbpaymentbean);

	public List<DbSensorBean> hir_sensor_month_personal(DbPaymentBean dbpaymentbean);
	
	// 12. 개인 인체감지 센서 일별 확인
	public List<DbSensorBean> ir_sensor_month_admin(DbPaymentBean dbpaymentbean);
	
	public List<DbSensorBean> hir_sensor_month_admin(DbPaymentBean dbpaymentbean);
	
	public List<DbSensorBean> sound_sensor_month_admin(DbPaymentBean dbpaymentbean);
	
	public List<DbSensorBean> dust_sensor_month_admin(DbPaymentBean dbpaymentbean);
	
	public List<DbSensorBean> light_sensor_month_admin(DbPaymentBean dbpaymentbean);
	
	public List<DbSensorBean> dht_sensor_month_admin(DbPaymentBean dbpaymentbean);
		
	
	
}
