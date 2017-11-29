package smart.in.service;

import java.io.IOException;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Date;
import java.util.Random;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base32;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import smart.in.beans.MemberBean;
import smart.in.beans.OtpBean;
import smart.in.beans.SisBean;
import smart.in.dao.MemberMybatis;
import smart.in.utils.Session;
 
@Service
public class OtpService{
	

	@Autowired
	private Session session;

	@Autowired
	private MemberMybatis memberMybatis;
	
	public OtpService() {}
	
	
	private boolean convertToBoolean(int value) {
		return (value == 1) ? true : false;
	}
	
	public Object entrance(int serviceCode, Object... object) throws Exception {
		Object result = "";

		switch (serviceCode) {
		case 1:
			result = otpservice((MemberBean) object[0]);
			break;
		case 2:
			result = otpservice2((OtpBean)object[0]);
			break;
		case 3:
			result = otpservice3((OtpBean)object[0]);
			break;
		default:
			break;
		}

		return result;
	}
	
	//OTP QR코드 생성
    public OtpBean otpservice(MemberBean memberBean) throws Exception {
         
         
         // 생성된 Key!
        String encodedKey = createOtpkey(memberBean);
         
        System.out.println(encodedKey);
        System.out.println("encodedKey : " + encodedKey);
         
        // String url = getQRBarcodeURL(userName, hostName, secretKeyStr);
        // userName과 hostName은 변수로 받아서 넣어야 하지만, 여기선 테스트를 위해 하드코딩 해줬다.
        String url = getQRBarcodeURL(memberBean.getMbphonenumber(), "SmartInStudy.com", encodedKey); // 생성된 바코드 주소!
        System.out.println("URL : " + url);
         
        OtpBean otpBean = new OtpBean();
        
        otpBean.setEncodedKey(encodedKey);
        
        otpBean.setUrl(url);
        session.setAttribute("encodedKey", encodedKey);
        
       

     /*   req.setAttribute("encodedKey", encodedKey);
        req.setAttribute("url", url);
         
        req.getRequestDispatcher(view).forward(req, res);*/
         return otpBean;
    }
     
    private String createOtpkey(MemberBean memberBean) throws Exception {
		String phone = memberBean.getMbphonenumber();
		String codeSet[] = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","X","Y","Z"};
		String createdCode = "";
		System.out.println(phone);
		if(phone.charAt(10)%2==0) {
			for(int i = 0; i<phone.length(); ++i) {
				int indexNum = phone.charAt(i)-48;
				createdCode=createdCode+codeSet[indexNum];	
			}
			return createdCode;
		}
		else 
		{
			for(int i = 0; i<phone.length(); ++i) {
				int indexNum = phone.charAt(i)-39;
				createdCode=createdCode+codeSet[indexNum];
			}
			return createdCode;

		}
	}
    
    public static String getQRBarcodeURL(String user, String host, String secret) {
        String format = "http://chart.apis.google.com/chart?cht=qr&amp;chs=300x300&amp;chl=otpauth://totp/%s@%s%%3Fsecret%%3D%s&amp;chld=H|0";
         
        return String.format(format, user, host, secret);
    }
     
    //회원가입시 코드와 일치여부 확인
    public OtpBean otpservice2(OtpBean otpBean) throws Exception {
    	OtpBean otpBeans = new OtpBean();
    	String result ="";
    	  String user_codeStr = otpBean.getUser_code();
          long user_code = Integer.parseInt(user_codeStr);
          String encodedKey = (String)session.getAttribute("encodedKey");
          
          long l = new Date().getTime();
          long ll =  l / 30000;
           
          boolean check_code = false;
          try {
              // 키, 코드, 시간으로 일회용 비밀번호가 맞는지 일치 여부 확인.
              check_code = check_code(encodedKey, user_code, ll);
          } catch (InvalidKeyException e) {
              e.printStackTrace();
          } catch (NoSuchAlgorithmException e) {
              e.printStackTrace();
          }
          
          // 일치한다면 true.
          System.out.println("check_code : " + check_code);
          
          otpBeans.setResult(check_code);
          
         
          
    	return otpBeans;
   }
    
    private static boolean check_code(String secret, long code, long t) throws NoSuchAlgorithmException, InvalidKeyException {
        Base32 codec = new Base32();
        byte[] decodedKey = codec.decode(secret);
 
        // Window is used to check codes generated in the near past.
        // You can use this value to tune how far you're willing to go.
        int window = 3;
        for (int i = -window; i <= window; ++i) {
            long hash = verify_code(decodedKey, t + i);
 
            if (hash == code) {
                return true;
            }
        }
 
        // The validation code is invalid.
        return false;
    }
    
    private static int verify_code(byte[] key, long t)
            throws NoSuchAlgorithmException, InvalidKeyException {
        byte[] data = new byte[8];
        long value = t;
        for (int i = 8; i-- > 0; value >>>= 8) {
            data[i] = (byte) value;
        }
 
        SecretKeySpec signKey = new SecretKeySpec(key, "HmacSHA1");
        Mac mac = Mac.getInstance("HmacSHA1");
        mac.init(signKey);
        byte[] hash = mac.doFinal(data);
 
        int offset = hash[20 - 1] & 0xF;
 
        // We're using a long because Java hasn't got unsigned int.
        long truncatedHash = 0;
        for (int i = 0; i < 4; ++i) {
            truncatedHash <<= 8;
            // We are dealing with signed bytes:
            // we just keep the first byte.
            truncatedHash |= (hash[offset + i] & 0xFF);
        }
 
        truncatedHash &= 0x7FFFFFFF;
        truncatedHash %= 1000000;
 
        return (int) truncatedHash;
    }
 
    
    
    //비밀번호 찾기시 OTPservice
    public String otpservice3(OtpBean otpBean) throws Exception {
    	OtpBean otpBeans = new OtpBean();
    	String result ="";
    	  MemberBean memberBean = new MemberBean();
    	  memberBean.setMbphonenumber((String)session.getAttribute("mbphonenumber"));
    	  String user_codeStr = otpBean.getUser_code();
          long user_code = Integer.parseInt(user_codeStr);
          
          String encodedKey = createOtpkey(memberBean);
          
          long l = new Date().getTime();
          long ll =  l / 30000;
           
          boolean check_code = false;
          try {
              // 키, 코드, 시간으로 일회용 비밀번호가 맞는지 일치 여부 확인.
              check_code = check_code(encodedKey, user_code, ll);
          } catch (InvalidKeyException e) {
              e.printStackTrace();
          } catch (NoSuchAlgorithmException e) {
              e.printStackTrace();
          }
          
          // 일치한다면 true.
          System.out.println("check_code : " + check_code);
          
          otpBeans.setResult(check_code);
          
          Gson gson = new Gson();
          
          result = gson.toJson(otpBeans);
          
    	return result;
   }
    
    
}