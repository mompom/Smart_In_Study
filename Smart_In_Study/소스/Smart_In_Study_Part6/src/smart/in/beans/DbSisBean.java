package smart.in.beans;

import org.apache.ibatis.type.Alias;

@Alias("dbSisBean")
public class DbSisBean {


	private String siscode;
	private String sisname;
	private String sisintro;
	private String sisaddress;
	private String sisimg1;
	private String sisimg2;
	private String sisimg3;
	private String sisimg4;
	private String sircode;
	private String sirprice;
	private String sisnumber;
	private String sisphonenumber;
	private String sisstcode;
	
	
	public String getSisstcode() {
		return sisstcode;
	}
	public void setSisstcode(String sisstcode) {
		this.sisstcode = sisstcode;
	}
	public String getSiscode() {
		return siscode;
	}
	public void setSiscode(String siscode) {
		this.siscode = siscode;
	}
	public String getSisname() {
		return sisname;
	}
	public void setSisname(String sisname) {
		this.sisname = sisname;
	}
	public String getSisintro() {
		return sisintro;
	}
	public void setSisintro(String sisintro) {
		this.sisintro = sisintro;
	}
	public String getSisaddress() {
		return sisaddress;
	}
	public void setSisaddress(String sisaddress) {
		this.sisaddress = sisaddress;
	}
	public String getSisimg1() {
		return sisimg1;
	}
	public void setSisimg1(String sisimg1) {
		this.sisimg1 = sisimg1;
	}
	public String getSisimg2() {
		return sisimg2;
	}
	public void setSisimg2(String sisimg2) {
		this.sisimg2 = sisimg2;
	}
	public String getSisimg3() {
		return sisimg3;
	}
	public void setSisimg3(String sisimg3) {
		this.sisimg3 = sisimg3;
	}
	public String getSisimg4() {
		return sisimg4;
	}
	public void setSisimg4(String sisimg4) {
		this.sisimg4 = sisimg4;
	}
	public String getSircode() {
		return sircode;
	}
	public void setSircode(String sircode) {
		this.sircode = sircode;
	}
	

	public String getSirprice() {
		return sirprice;
	}
	public void setSirprice(String sirprice) {
		this.sirprice = sirprice;
	}
	public String getSisnumber() {
		return sisnumber;
	}
	public void setSisnumber(String sisnumber) {
		this.sisnumber = sisnumber;
	}
	public String getSisphonenumber() {
		return sisphonenumber;
	}
	public void setSisphonenumber(String sisphonenumber) {
		this.sisphonenumber = sisphonenumber;
	}
	
}
