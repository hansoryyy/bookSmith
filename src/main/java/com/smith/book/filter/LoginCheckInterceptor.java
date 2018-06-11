package com.smith.book.filter;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter{

	String serviceLoginUri = "/login.member";
	List<String> loginCheckUrls = Arrays.asList(
			"/mypage_orderList.mypage",
			"/list_memberCart"
	);
	
	String adminLoginUri = "/login.admin";
	List<String> adminUrls = Arrays.asList(
			"/managerList.admin" ,
			"/mailList.admin",
			"/list.notice",
			"/list.board"
	);
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler)
			throws Exception {
		String uri = stripUri(req);
//		System.out.println("[LOGIN CHECK] uri : " + uri);
		
		if ( adminUrls.contains(uri) ) {
			if ( ! isAdmin ( req )) {
				res.sendRedirect(req.getContextPath() + adminLoginUri);
				return false;
			}
		}
		
		
		if ( loginCheckUrls.contains(uri) ) {
			if ( ! hasLogin ( req ) ) {
//				System.out.println("              NO LOGIN INFO");
				res.sendRedirect(req.getContextPath() + serviceLoginUri);
				return false;
			}
		}
		return true;
		// return super.preHandle(req, res, handler);
	}
	
	boolean isAdmin(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		if ( session == null) {
			return false;
		}
		
		/*
		session.setAttribute("log", dto.getId()); // 성공할시 세션 생성
		session.setAttribute("grade", dto.getGrade());
		 */
		String adminId = (String) session.getAttribute("log");
		Integer grade = (Integer) session.getAttribute("grade");
		if ( adminId != null && grade != null && grade >= 5 ) {
			return true;
		} else {
			return false;			
		}
		
	}
	boolean hasLogin(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		if ( session == null) {
			return false;
		}
		
		if ( session.getAttribute("userLoginInfo") == null ) {
			return false;
		}
		
		return true;
	}
	private String stripUri(HttpServletRequest req) {
		String ctxpath = req.getContextPath();
		String fullUri = req.getRequestURI();
		return fullUri.substring(ctxpath.length());
	}
	
}
