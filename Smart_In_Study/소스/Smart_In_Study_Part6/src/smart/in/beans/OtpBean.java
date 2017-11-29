package smart.in.beans;

public class OtpBean {

	
	private String user_code;
	private String encodedKey;
	private String url;
	private boolean result;
	private String page;
	private String mbphonenumber;
	
	
	
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
	public boolean isResult() {
		return result;
	}
	public void setResult(boolean result) {
		this.result = result;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getUser_code() {
		return user_code;
	}
	public void setUser_code(String user_code) {
		this.user_code = user_code;
	}
	public String getEncodedKey() {
		return encodedKey;
	}
	public void setEncodedKey(String encodedKey) {
		this.encodedKey = encodedKey;
	}
	
	
}
