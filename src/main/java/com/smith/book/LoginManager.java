package com.smith.book;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Random;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import com.smith.book.dto.LoginDTO;

public class LoginManager implements HttpSessionBindingListener {
	private static LoginManager loginManager = null;
	private static Hashtable<String,LoginDTO> loginUsers = new Hashtable<String,LoginDTO>();

	private LoginManager() {
		super();
	}

	public static synchronized LoginManager getInstance() {
		if (loginManager == null) {
			loginManager = new LoginManager();
		}
		return loginManager;
	}

	// 아이디가 맞는지 체크
	public boolean isValid(String id, String userPW) {
		return true; 
	}

	// 해당 세션에 이미 로그인 되있는지 체크
	public boolean isLogin(String sessionID) {
		boolean isLogin = false;
		Enumeration e = loginUsers.keys();
		String key = "";
		while (e.hasMoreElements()) {
			key = (String) e.nextElement();
			if (sessionID.equals(key)) {
				isLogin = true;
			}
		}
		return isLogin;
	}

	// 중복 로그인 막기 위해 아이디 사용중인지 체크
	public boolean isUsing(String id) {
		boolean isUsing = false;
		Enumeration e = loginUsers.keys();
		String key = "";
		while (e.hasMoreElements()) {
			key = (String) e.nextElement();
			if (id.equals(loginUsers.get(key).getId())) {
				isUsing = true;
			}
		}
		return isUsing;
	}

	// 세션 생성
	public void setSession(HttpSession session, String id) {
		LoginDTO dto = new LoginDTO();
		dto.setId(id);
		Random random = new Random();
		int ran = random.nextInt(100000);
		String loginCode = (String.valueOf(ran));
		Enumeration e = loginUsers.keys();
		String key = "";
		while (e.hasMoreElements()) {
			key = (String) e.nextElement();
			System.out.println(id+":"+key+":"+loginUsers.get(key).getId());
			if (id.equals(loginUsers.get(key).getId())) {
				loginUsers.remove(key);
			}
		}
		loginUsers.put(session.getId(), dto);
		session.setAttribute("login", this.getInstance());
	}

	// 세션 성립될 때
	public void valueBound(HttpSessionBindingEvent event) {
	}

	// 세션 끊길때
	public void valueUnbound(HttpSessionBindingEvent event) {
		loginUsers.remove(event.getSession().getId());
	}
	
	// 세션 ID로 로긴된 ID 구분
	public String getUserID(String sessionID) {
		return (String) loginUsers.get(sessionID).getId();
	}
	
	// 현재 접속자수
	public int getUserCount() {
		return loginUsers.size();
	}
}