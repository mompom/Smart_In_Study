package smart.in.beans;

import org.apache.ibatis.type.Alias;

@Alias("memberBean")
public class MemberBean {

	private String mbid;
	private String mbpw;
	private String mbnick;
	private String mbname;
	private String mbgender;
	private String mbbirthday;
	private String mbaddress;
	private String mbemail;
	private String mbphonenumber;
	private String siscode;
	private String sircode;
	private String page;
	private String result;
	private String stcode;
	private String sirprice;
	
	
	public String getSirprice() {
		return sirprice;
	}
	public void setSirprice(String sirprice) {
		this.sirprice = sirprice;
	}
	public String getStcode() {
		return stcode;
	}
	public void setStcode(String stcode) {
		this.stcode = stcode;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getMbpw() {
		return mbpw;
	}
	public void setMbpw(String mbpw) {
		this.mbpw = mbpw;
	}
	public String getMbphonenumber() {
		return mbphonenumber;
	}
	public void setMbphonenumber(String mbphonenumber) {
		this.mbphonenumber = mbphonenumber;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getMbid() {
		return mbid;
	}
	public void setMbid(String mbid) {
		this.mbid = mbid;
	}
	public String getMbnick() {
		return mbnick;
	}
	public void setMbnick(String mbnick) {
		this.mbnick = mbnick;
	}
	public String getMbname() {
		return mbname;
	}
	public void setMbname(String mbname) {
		this.mbname = mbname;
	}
	public String getMbgender() {
		return mbgender;
	}
	public void setMbgender(String mbgender) {
		this.mbgender = mbgender;
	}
	public String getMbbirthday() {
		return mbbirthday;
	}
	public void setMbbirthday(String mbbirthday) {
		this.mbbirthday = mbbirthday;
	}
	public String getMbaddress() {
		return mbaddress;
	}
	public void setMbaddress(String mbaddress) {
		this.mbaddress = mbaddress;
	}
	public String getMbemail() {
		return mbemail;
	}
	public void setMbemail(String mbemail) {
		this.mbemail = mbemail;
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
	
	
	
	
	
}
