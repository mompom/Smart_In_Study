package smart.in.utils;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Component;


@Component
public class SendMail {
	public SendMail(){}
	
	public void sendmailInit(String sendmail, String sisname, String idpw) throws MessagingException {
		
		sendmail(sendmail, sisname, idpw);
		
	}
	
 private void sendmail(String sendmail, String sisname, String idpw) throws MessagingException {
  //보내는 사람
  String smtpServer = "smtp.gmail.com";
  final String sendld = "smartinstudy";
  final String sendPass = "1q2w3e4r!!";
  String sendEmailAddress = "smartinstudy@gmail.com";
  int smtpPort = 465;
  //받는 사람
  String recieveEmailAddress = sendmail;
  String subject = sisname+"에서 보낸 메일입니다.";
  
  String content = idpw;
 
  Properties props = System.getProperties();
  
  props.put("mail.smtp.host", smtpServer);
  props.put("mail.smtp.port", smtpPort);
  props.put("mail.smtp.auth", "true");
  props.put("mail.smtp.ssl.enable", "true");
  props.put("mail.smtp.ssl.trust", smtpServer);
  
  
  Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator(){
   protected PasswordAuthentication getPasswordAuthentication(){
    return new PasswordAuthentication(sendld, sendPass);
   }
  });
  session.setDebug(true); //for debug
  
  Message mimeMessage = new MimeMessage(session);
  mimeMessage.setFrom(new InternetAddress(sendEmailAddress));
  mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recieveEmailAddress));
  mimeMessage.setSubject(subject);
  mimeMessage.setContent(content, "text/html; charset=euc-kr");
  Transport.send(mimeMessage);
  
 
 }
}
