package com.smith.book.dto;

import java.util.Date;

public class MailDTO {
	private Integer mailcode;
	   private String subject;
	   private String content;
	   private Date regdate;
	   
	   public Integer getMailcode() {
	      return mailcode;
	   }
	   public void setMailcode(Integer mailcode) {
	      this.mailcode = mailcode;
	   }
	   public String getSubject() {
	      return subject;
	   }
	   public void setSubject(String subject) {
	      this.subject = subject;
	   }
	   public String getContent() {
	      return content;
	   }
	   public void setContent(String content) {
	      this.content = content;
	   }
	   public Date getRegdate() {
	      return regdate;
	   }
	   public void setRegdate(Date regdate) {
	      this.regdate = regdate;
	   }

}
