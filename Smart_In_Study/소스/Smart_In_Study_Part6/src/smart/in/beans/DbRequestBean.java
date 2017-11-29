package smart.in.beans;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("dbRequestBean")
public class DbRequestBean {

	private String rsdate;
	private String rsname;
	private String rsphonenumber;
	private String rsaddress;
	private String rscontent;
	private int rssequence;
	private String rsstname;

	
	
	
	
	
	public String getRsdate() {
		return rsdate;
	}
	public void setRsdate(String rsdate) {
		this.rsdate = rsdate;
	}
	public String getRsstname() {
		return rsstname;
	}
	public void setRsstname(String rsstname) {
		this.rsstname = rsstname;
	}
	
	public int getRssequence() {
		return rssequence;
	}
	public void setRssequence(int rssequence) {
		this.rssequence = rssequence;
	}
	public String getRsname() {
		return rsname;
	}
	public void setRsname(String rsname) {
		this.rsname = rsname;
	}
	public String getRsphonenumber() {
		return rsphonenumber;
	}
	public void setRsphonenumber(String rsphonenumber) {
		this.rsphonenumber = rsphonenumber;
	}
	public String getRsaddress() {
		return rsaddress;
	}
	public void setRsaddress(String rsaddress) {
		this.rsaddress = rsaddress;
	}
	public String getRscontent() {
		return rscontent;
	}
	public void setRscontent(String rscontent) {
		this.rscontent = rscontent;
	}
	
	
}
