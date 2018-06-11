package com.smith.book.dto;

public class LoginDTO {
	private String id;
	private String passwd;
	private String loginGrade;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getLoginGrade() {
		return loginGrade;
	}
	public void setLoginGrade(String loginGrade) {
		this.loginGrade = loginGrade;
	}
	
}
