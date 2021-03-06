package smart.in.beans;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("dbPaymentBean")
public class DbPaymentBean {

	private String mbid;
	private String phaccountid;
	private String siscode;
	private String sircode;
	private String approvalnumber;
	private String phdate;
	private String phenddate;
	private String price;
	private String paymentdate;
	private String startdate;
	
	
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getPaymentdate() {
		return paymentdate;
	}
	public void setPaymentdate(String paymentdate) {
		this.paymentdate = paymentdate;
	}
	public String getPhaccountid() {
		return phaccountid;
	}
	public void setPhaccountid(String phaccountid) {
		this.phaccountid = phaccountid;
	}
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
	public String getApprovalnumber() {
		return approvalnumber;
	}
	public void setApprovalnumber(String approvalnumber) {
		this.approvalnumber = approvalnumber;
	}
	public String getMbid() {
		return mbid;
	}
	public void setMbid(String mbid) {
		this.mbid = mbid;
	}
	public String getPhdate() {
		return phdate;
	}
	public void setPhdate(String phdate) {
		this.phdate = phdate;
	}
	public String getPhenddate() {
		return phenddate;
	}
	public void setPhenddate(String phenddate) {
		this.phenddate = phenddate;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	
	

	
	
}
