package smart.in.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import smart.in.beans.DbMemberBean;
import smart.in.beans.DbPaymentBean;
import smart.in.beans.DbSensorBean;
import smart.in.beans.DbSisBean;
import smart.in.beans.MemberBean;
import smart.in.beans.PaymentBean;
import smart.in.beans.SensorBean;
import smart.in.beans.SisBean;
import smart.in.dao.SensorMybatis;
import smart.in.utils.Encryption;
import smart.in.utils.Session;

@Service
public class SensorService extends TransactionExe {
	// 마이바티스와 연동되는 인터페이스 사용
	@Autowired
	private SensorMybatis sensorMybatis;

	@Autowired
	private Session session;

	@Autowired
	private TransactionExe transactionExe;

	public SensorService() {
	}

	private boolean convertToBoolean(int value) {
		return (value == 1) ? true : false;
	}

	/* 진입 메서드 */
	public Object entrance(int serviceCode, Object... object) throws Exception {
		Object result = null;
		// 현재 페이지 세션등록
		if (session.getAttribute("page") != null) {
			session.removeAttribute("page");
		}
		/* session.setAttribute("test1", ((TestBean) object[0]).getTest1()); */

		switch (serviceCode) {
		case 1:
			result = sound_sensor_day((DbPaymentBean) object[0]);
			break;
		case 2:
			result = sound_sensor_month((DbPaymentBean) object[0]);
			break;
		case 3:
			result = dust_sensor_day((DbPaymentBean) object[0]);
			break;
		case 4:
			result = dust_sensor_month((DbPaymentBean) object[0]);
			break;
		case 5:
			result = light_sensor_day((DbPaymentBean) object[0]);
			break;
		case 6:
			result = light_sensor_month((DbPaymentBean) object[0]);
			break;
		case 7:
			result = dht_sensor_day((DbPaymentBean) object[0]);
			break;
		case 8:
			result = dht_sensor_month((DbPaymentBean) object[0]);
			break;
		case 9:
			result = rfid_sensor_day((DbPaymentBean) object[0]);
			break;
		case 10:
			result = rfid_sensor_day_not((DbPaymentBean) object[0]);
			break;
		case 11:
			result = ir_sensor_day((DbPaymentBean) object[0]);
			break;
		case 12:
			result = ir_sensor_month((DbPaymentBean) object[0]);
			break;
		case 13:
			result = hir_sensor_day((DbPaymentBean) object[0]);
			break;
		case 14:
			result = hir_sensor_month((DbPaymentBean) object[0]);
			break;
		case 15:
			result = sound_sensor_day_personal((DbPaymentBean) object[0]);
			break;
		case 16:
			result = sound_sensor_month_personal((DbPaymentBean) object[0]);
			break;
		case 17:
			result = dust_sensor_day_personal((DbPaymentBean) object[0]);
			break;
		case 18:
			result = dust_sensor_month_personal((DbPaymentBean) object[0]);
			break;
		case 19:
			result = light_sensor_day_personal((DbPaymentBean) object[0]);
			break;
		case 20:
			result = light_sensor_month_personal((DbPaymentBean) object[0]);
			break;
		case 21:
			result = dht_sensor_day_personal((DbPaymentBean) object[0]);
			break;
		case 22:
			result = dht_sensor_month_personal((DbPaymentBean) object[0]);
			break;
		case 23:
			result = rfid_sensor_week((DbPaymentBean) object[0]);
			break;
		case 24:
			result = rfid_sensor_week_not((DbPaymentBean) object[0]);
			break;
		case 25:
			result = ir_sensor_day_personal((DbPaymentBean) object[0]);
			break;
		case 26:
			result = ir_sensor_month_personal((DbPaymentBean) object[0]);
			break;
		case 27:
			result = hir_sensor_day_personal((DbPaymentBean) object[0]);
			break;
		case 28:
			result = hir_sensor_month_personal((DbPaymentBean) object[0]);
			break;
		case 29:
			result = rfid_sensor_log_select((DbPaymentBean) object[0]);
			break;
		case 30:
			result = select_date_range((DbPaymentBean) object[0]);
			break;
		case 31:
			result = dht_sensor_main((DbPaymentBean) object[0]);
			break;
		case 32:
			result = sound_sensor_main((DbPaymentBean) object[0]);
			break;
		case 33:
			result = ir_sensor_month_admin((DbPaymentBean) object[0]);
			break;
		case 34:
			result = hir_sensor_month_admin((DbPaymentBean) object[0]);
			break;
		case 35:
			result = sound_sensor_month_admin((DbPaymentBean) object[0]);
			break;
		case 36:
			result = dust_sensor_month_admin((DbPaymentBean) object[0]);
			break;
		case 37:
			result = light_sensor_month_admin((DbPaymentBean) object[0]);
			break;
		case 38:
			result = dht_sensor_month_admin((DbPaymentBean) object[0]);
			break;
			
			
		default:
			break;
		}

		return result;
	}

	private List<DbPaymentBean> select_date_range(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> sensordata = sensorMybatis.select_date_range(dbpaymentbean);
		return sensordata;
	}

	public List<DbPaymentBean> select_room_code(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> sensordata = sensorMybatis.select_room_code(dbpaymentbean);
		return sensordata;
	}
	
	private JSONArray sound_sensor_day(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.sound_sensor_day(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray sound_sensor_month(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.sound_sensor_month(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}
	
	private JSONArray sound_sensor_main(DbPaymentBean dbpaymentbean) throws Exception {

		List<DbSensorBean> sensordata = sensorMybatis.sound_sensor_main(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray dust_sensor_day(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.dust_sensor_day(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray dust_sensor_month(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.dust_sensor_month(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray light_sensor_day(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.light_sensor_day(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray light_sensor_month(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.light_sensor_month(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray dht_sensor_day(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.dht_sensor_day(dbpaymentbean);
		return draw_graph_insert_twodata(sensordata);
	}

	private JSONArray dht_sensor_month(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());
		List<DbSensorBean> sensordata = sensorMybatis.dht_sensor_month(dbpaymentbean);
		return draw_graph_insert_twodata(sensordata);
	}
	
	private JSONArray dht_sensor_main(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbSensorBean> sensordata = sensorMybatis.dht_sensor_main(dbpaymentbean);
		return draw_graph_insert_twodata(sensordata);
	}

	private JSONArray rfid_sensor_day(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.rfid_sensor_day(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray rfid_sensor_day_not(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.rfid_sensor_day_not(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray ir_sensor_day(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.ir_sensor_day(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray ir_sensor_month(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.ir_sensor_month(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray hir_sensor_day(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.hir_sensor_day(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray hir_sensor_month(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.hir_sensor_month(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray sound_sensor_day_personal(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.sound_sensor_day_personal(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray sound_sensor_month_personal(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.sound_sensor_month_personal(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray dust_sensor_day_personal(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.dust_sensor_day_personal(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray dust_sensor_month_personal(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.dust_sensor_month_personal(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray light_sensor_day_personal(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.light_sensor_day_personal(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray light_sensor_month_personal(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.light_sensor_month_personal(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray dht_sensor_day_personal(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.dht_sensor_day_personal(dbpaymentbean);
		return draw_graph_insert_twodata(sensordata);
	}

	private JSONArray dht_sensor_month_personal(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());
		List<DbSensorBean> sensordata = sensorMybatis.dht_sensor_month_personal(dbpaymentbean);
		return draw_graph_insert_twodata(sensordata);
	}

	private JSONArray rfid_sensor_week(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.rfid_sensor_week(dbpaymentbean);
		System.out.println(sensordata.get(0));
		return draw_graph_insert_onedata(sensordata);
	}

	private String rfid_sensor_log_select(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.rfid_sensor_log_select(dbpaymentbean);
		try {
			return (String) (sensordata.get(0).getSelog());
		} catch (Exception e) {
			String a = "X";
			return a;
		}

	}

	private JSONArray rfid_sensor_week_not(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.rfid_sensor_week_not(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray ir_sensor_day_personal(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.ir_sensor_day_personal(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}
	private JSONArray ir_sensor_month_personal(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.ir_sensor_month_personal(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray hir_sensor_day_personal(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.hir_sensor_day_personal(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}

	private JSONArray hir_sensor_month_personal(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_date_range(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.hir_sensor_month_personal(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}
	
	private JSONArray ir_sensor_month_admin(DbPaymentBean dbpaymentbean) throws Exception {
		List<DbPaymentBean> paymentdata = select_room_code(dbpaymentbean);
		dbpaymentbean.setPhdate(paymentdata.get(0).getPhdate());
		dbpaymentbean.setPhenddate(paymentdata.get(0).getPhenddate());

		List<DbSensorBean> sensordata = sensorMybatis.ir_sensor_month_admin(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}
	
	
	
	private JSONArray hir_sensor_month_admin(DbPaymentBean dbpaymentbean) throws Exception {
		
		List<DbSensorBean> sensordata = sensorMybatis.hir_sensor_month_admin(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}
	
	private JSONArray sound_sensor_month_admin(DbPaymentBean dbpaymentbean) throws Exception {

		List<DbSensorBean> sensordata = sensorMybatis.sound_sensor_month_admin(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}
	
	private JSONArray dust_sensor_month_admin(DbPaymentBean dbpaymentbean) throws Exception {
		
		List<DbSensorBean> sensordata = sensorMybatis.dust_sensor_month_admin(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}
	
	private JSONArray light_sensor_month_admin(DbPaymentBean dbpaymentbean) throws Exception {
	
		List<DbSensorBean> sensordata = sensorMybatis.light_sensor_month_admin(dbpaymentbean);
		return draw_graph_insert_onedata(sensordata);
	}
	
	private JSONArray dht_sensor_month_admin(DbPaymentBean dbpaymentbean) throws Exception {
		
		List<DbSensorBean> sensordata = sensorMybatis.dht_sensor_month_admin(dbpaymentbean);
		return draw_graph_insert_twodata(sensordata);
	}

	public String draw_graph_onedata(JSONArray row1, JSONArray row2) throws Exception {

		Gson gson = new Gson();
		JSONObject data = new JSONObject();
		JSONObject cols1 = new JSONObject();
		JSONObject cols2 = new JSONObject();
		JSONObject cols3 = new JSONObject();
		JSONObject cols4 = new JSONObject();
		JSONArray ArrCols = new JSONArray();
		JSONArray ArrRows = new JSONArray();

		if (row2 == null) {
			cols1.put("id", "");
			cols1.put("label", "날짜");
			cols1.put("patten", "");
			cols1.put("type", "string");

			cols2.put("id", "");
			cols2.put("label", "데이터");
			cols2.put("patten", "");
			cols2.put("type", "number");

			ArrCols.add(cols1);
			ArrCols.add(cols2);

			data.put("cols", ArrCols);
			data.put("rows", row1);
		} else {
			cols1.put("id", "");
			cols1.put("label", "날짜");
			cols1.put("patten", "");
			cols1.put("type", "string");

			cols2.put("id", "");
			cols2.put("label", "전체 데이터");
			cols2.put("patten", "");
			cols2.put("type", "number");
			
			cols3.put("id", "");
			cols3.put("label", "개인 데이터");
			cols3.put("patten", "");
			cols3.put("type", "number");

			ArrCols.add(cols1);
			ArrCols.add(cols2);
			ArrCols.add(cols3);
			

			data.put("cols", ArrCols);
			row1.addAll(row2);
			data.put("rows", row1);

		}

		String a = gson.toJson(data);
		TreeMap<String, Object> map = gson.fromJson(a, TreeMap.class);
		String convertJson = gson.toJson(map);

		return convertJson;
	}

	public String draw_graph_twodata(JSONArray row1, JSONArray row2) throws Exception {

		Gson gson = new Gson();
		JSONObject data = new JSONObject();
		JSONObject cols1 = new JSONObject();
		JSONObject cols2 = new JSONObject();
		JSONObject cols3 = new JSONObject();
		JSONObject cols4 = new JSONObject();
		JSONObject cols5 = new JSONObject();
		JSONObject cols6 = new JSONObject();
		JSONArray ArrCols = new JSONArray();
		JSONArray ArrRows = new JSONArray();

		if (row2 == null) {
			cols1.put("id", "");
			cols1.put("label", "날짜");
			cols1.put("patten", "");
			cols1.put("type", "string");

			cols2.put("id", "");
			cols2.put("label", "습도");
			cols2.put("patten", "");
			cols2.put("type", "number");

			cols3.put("id", "");
			cols3.put("label", "온도");
			cols3.put("patten", "");
			cols3.put("type", "number");

			ArrCols.add(cols1);
			ArrCols.add(cols2);
			ArrCols.add(cols3);

			data.put("cols", ArrCols);
			data.put("rows", row1);
		} else {
			cols1.put("id", "");
			cols1.put("label", "날짜");
			cols1.put("patten", "");
			cols1.put("type", "string");

			cols2.put("id", "");
			cols2.put("label", "전체 습도");
			cols2.put("patten", "");
			cols2.put("type", "number");
									
			cols3.put("id", "");
			cols3.put("label", "전체 온도");
			cols3.put("patten", "");
			cols3.put("type", "number");

			cols4.put("id", "");
			cols4.put("label", "개인 습도");
			cols4.put("patten", "");
			cols4.put("type", "number");

			cols5.put("id", "");
			cols5.put("label", "개인 온도");
			cols5.put("patten", "");
			cols5.put("type", "number");

			ArrCols.add(cols1);
			ArrCols.add(cols2);
			ArrCols.add(cols3);
			ArrCols.add(cols4);
			ArrCols.add(cols5);
			

			data.put("cols", ArrCols);
			row1.addAll(row2);
			
			data.put("rows", row1);
		}
		String a = gson.toJson(data);
		TreeMap<String, Object> map = gson.fromJson(a, TreeMap.class);
		String convertJson = gson.toJson(map);

		return convertJson;
	}

	private JSONArray draw_graph_insert_onedata(List<DbSensorBean> sensordata) throws Exception {
		JSONArray ArrRows = new JSONArray();
		for (int i = 0; i < sensordata.size(); i++) {
			JSONObject rows1 = new JSONObject();
			rows1.put("v", sensordata.get(i).getSedate());
			rows1.put("f", null);

			JSONObject rows2 = new JSONObject();
			rows2.put("v", sensordata.get(i).getSedata());
			rows2.put("f", null);

			JSONArray cValueArr = new JSONArray();
			cValueArr.add(rows1);
			cValueArr.add(rows2);

			JSONObject cValueObj = new JSONObject();
			cValueObj.put("c", cValueArr);

			ArrRows.add(cValueObj);
		}
		;

		return ArrRows;

	}

	private JSONArray draw_graph_insert_twodata(List<DbSensorBean> sensordata) throws Exception {
		JSONArray ArrRows = new JSONArray();

		for (int i = 0; i < sensordata.size(); i++) {

			JSONObject rows1 = new JSONObject();
			rows1.put("v", sensordata.get(i).getSedate());
			rows1.put("f", null);

			JSONObject rows2 = new JSONObject();
			rows2.put("v", sensordata.get(i).getSedata());
			rows2.put("f", null);

			JSONObject rows3 = new JSONObject();
			rows3.put("v", sensordata.get(i).getSedata2());
			rows3.put("f", null);

			JSONArray cValueArr = new JSONArray();
			cValueArr.add(rows1);
			cValueArr.add(rows2);
			cValueArr.add(rows3);

			JSONObject cValueObj = new JSONObject();
			cValueObj.put("c", cValueArr);

			ArrRows.add(cValueObj);
		};

		return ArrRows;
	}
	
	private JSONArray draw_graph_insert_threedata(List<DbSensorBean> sensordata1,List<DbSensorBean> sensordata2) throws Exception {
		JSONArray ArrRows = new JSONArray();

		for (int i = 0; i < sensordata1.size(); i++) {

			JSONObject rows1 = new JSONObject();
			rows1.put("v", sensordata1.get(i).getSedate());
			rows1.put("f", null);

			JSONObject rows2 = new JSONObject();
			rows2.put("v", sensordata1.get(i).getSedata());
			rows2.put("f", null);

			JSONObject rows3 = new JSONObject();
			rows3.put("v", sensordata2.get(i).getSedata2());
			rows3.put("f", null);
			
			
			JSONArray cValueArr = new JSONArray();
			cValueArr.add(rows1);
			cValueArr.add(rows2);
			cValueArr.add(rows3);

			JSONObject cValueObj = new JSONObject();
			cValueObj.put("c", cValueArr);

			ArrRows.add(cValueObj);
		};

		return ArrRows;
	}
	
	private JSONArray draw_graph_insert_fourdata(List<DbSensorBean> sensordata1,List<DbSensorBean> sensordata2) throws Exception {
		JSONArray ArrRows = new JSONArray();

		for (int i = 0; i < sensordata1.size(); i++) {

			JSONObject rows1 = new JSONObject();
			rows1.put("v", sensordata1.get(i).getSedate());
			rows1.put("f", null);

			JSONObject rows2 = new JSONObject();
			rows2.put("v", sensordata1.get(i).getSedata());
			rows2.put("f", null);

			JSONObject rows3 = new JSONObject();
			rows3.put("v", sensordata1.get(i).getSedata2());
			rows3.put("f", null);
			
			JSONObject rows4 = new JSONObject();
			rows4.put("v", sensordata2.get(i).getSedata());
			rows4.put("f", null);
			
			JSONObject rows5 = new JSONObject();
			rows5.put("v", sensordata2.get(i).getSedata2());
			rows5.put("f", null);

			JSONArray cValueArr = new JSONArray();
			cValueArr.add(rows1);
			cValueArr.add(rows2);
			cValueArr.add(rows3);
			cValueArr.add(rows4);
			cValueArr.add(rows5);

			JSONObject cValueObj = new JSONObject();
			cValueObj.put("c", cValueArr);

			ArrRows.add(cValueObj);
		};

		return ArrRows;
	}
}