package smart.in.beans;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("dbSensorBean")
public class DbSensorBean {

	private String sesircode;
	private String sesirsiscode;
	private String secode;
	private String sedate;
	private String sedata;
	private String sedata2;
	private String selog;
	
	

	public String getSesircode() {
		return sesircode;
	}
	public void setSesircode(String sesircode) {
		this.sesircode = sesircode;
	}
	public String getSesirsiscode() {
		return sesirsiscode;
	}
	public void setSesirsiscode(String sesirsiscode) {
		this.sesirsiscode = sesirsiscode;
	}
	public String getSecode() {
		return secode;
	}
	public void setSecode(String secode) {
		this.secode = secode;
	}
	public String getSedate() {
		return sedate;
	}
	public void setSedate(String sedate) {
		this.sedate = sedate;
	}
	public String getSedata() {
		return sedata;
	}
	public void setSedata(String sedata) {
		this.sedata = sedata;
	}
	public String getSedata2() {
		return sedata2;
	}
	public void setSedata2(String sedata2) {
		this.sedata2 = sedata2;
	}
	public String getSelog() {
		return selog;
	}
	public void setSelog(String selog) {
		this.selog = selog;
	}
	
	
	
	
	
	
	
	
}
