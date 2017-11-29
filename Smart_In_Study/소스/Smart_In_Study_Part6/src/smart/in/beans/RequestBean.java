package smart.in.beans;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("requestBean")
public class RequestBean {

	private String rsname;
	private String rsphonenumber;
	private String rsaddress;
	private String rscontent;
	private int rssequnce;
	private String rsstcode;
	private String rsdate;
	private String page;
	
	
	

	public String getRsdate() {
		return rsdate;
	}
	public void setRsdate(String rsdate) {
		this.rsdate = rsdate;
	}
	public String getRsstcode() {
		return rsstcode;
	}
	public void setRsstcode(String rsstcode) {
		this.rsstcode = rsstcode;
	}
	public int getRssequnce() {
		return rssequnce;
	}
	public void setRssequnce(int rssequnce) {
		this.rssequnce = rssequnce;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
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
