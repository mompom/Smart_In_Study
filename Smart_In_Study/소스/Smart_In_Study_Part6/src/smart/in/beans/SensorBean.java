package smart.in.beans;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("sensorBean")
public class SensorBean {

	private String siscode;
	private String sircode;
	
	public String getSiscode() {
		return siscode;
	}
	public void setSiscode(String siscode) {
		this.siscode = siscode;
	}
	public String getSircode() {
		return sircode;
	}
	public void setSircode(String sircode) {
		this.sircode = sircode;
	}
	
	
	
		
	
	
	
	
	
}
