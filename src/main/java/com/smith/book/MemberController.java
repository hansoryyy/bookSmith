package com.smith.book;

import java.io.File;
import java.io.FileNotFoundException;
import java.net.URISyntaxException;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import org.springframework.mail.javamail.JavaMailSender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.smith.book.dto.LoginDTO;
import com.smith.book.dto.MemberDTO;
import com.smith.book.dto.MyOrderDTO;
import com.smith.book.dto.OrderDTO;
import com.smith.book.dto.QnaDTO;
import com.smith.book.service.MemberMapper;

@Controller
public class MemberController {
	@Autowired
		MemberMapper memberMapper;
	@Autowired
	   private JavaMailSender mailSender;
	

	// 회원가입
	@RequestMapping(value = "/join.member", method = RequestMethod.GET)
	public String joinForm(HttpServletRequest req) {

		return "/login/join";
	}

	@ResponseBody
	@RequestMapping(value = "/duplicationCheck.member", method = RequestMethod.POST)
	public String duplicationCheck(HttpServletRequest req) {
		String id = req.getParameter("id");
		int res = memberMapper.duplicationCheck(id);
		System.out.println("아이디 체크함");
		return String.valueOf(res);
	}

	@RequestMapping(value = "/join.member", method = RequestMethod.POST)
	public ModelAndView insertMember(HttpServletRequest req, @ModelAttribute MemberDTO dto) {

		int res = memberMapper.joinMember(dto);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:main.go");
		if (res > 0) {
			
			return mav;
		}
	

		return mav;

	}

	// 로그인 폼
	@RequestMapping(value = "/login.member", method = RequestMethod.GET)
	public ModelAndView login(HttpServletRequest req, MemberDTO dto, HttpSession session) {
		Cookie[] cks = req.getCookies();
		String id = null;
		String passwd = null;
		if (cks != null && cks.length != 0) {
			for (int i = 0; i < cks.length; i++) {
				if (cks[i].getName().equals("loginIdCookie")) {
					id = cks[i].getValue();
				}
				if (cks[i].getName().equals("loginPwCookie")) {
					passwd = cks[i].getValue();
				}
			}
		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login/login");
		mav.addObject("id", id);
		mav.addObject("passwd", passwd);
		return mav;
	}

	// 로그아웃
	@RequestMapping("/logout.member")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:main.go";
	}

	// 로그인 처리
	@RequestMapping(value = "/login.member", method = RequestMethod.POST)
	public ModelAndView loginProcess(MemberDTO user, HttpSession session, HttpServletRequest req,
			HttpServletResponse resp) {
		String referrer = req.getHeader("Referer");
		req.getSession().setAttribute("url_prior_login", referrer);
		int idC = 1;
		int pwC = 1;
		String idCheck = req.getParameter("idSaveCheck");
		String pwCheck = req.getParameter("pwSaveCheck");
		LoginManager loginManager = LoginManager.getInstance();
		if (loginManager.isValid(user.getId(), user.getPasswd())) {
			if (!loginManager.isUsing(user.getId())) {

			} else {
				// throw new Exception("이미 로그인중");
			}
			loginManager.setSession(session, user.getId());
			if (idCheck == null || idCheck.equals("")) {
				idC = 0;
			}
			if (pwCheck == null || pwCheck.equals("")) {
				pwC = 0;
			}
			MemberDTO dto = memberMapper.loginMember(user.getId(), user.getPasswd());
			ModelAndView mav = new ModelAndView();
			if (dto == null) {
				mav.setViewName("redirect:login.member");
				session.setAttribute("loginError", "loginError");
				session.setAttribute("loginFirst", "1");
			} else {
				mav.setViewName("redirect:main.go");
				session.setAttribute("loginError", null);
				session.setAttribute("loginFirst", null);
				MemberDTO loginUser = new MemberDTO();
				loginUser.setId(user.getId());
				loginUser.setPasswd(user.getPasswd());
				loginUser.setGrade(dto.getGrade());
				loginUser.setMember_code(dto.getMember_code());
				if (loginUser != null) {
					session.setMaxInactiveInterval(60 * 60);
					session.setAttribute("userLoginInfo", loginUser);
				}
				if (idC == 0) {
					Cookie cookie = new Cookie("loginIdCookie", user.getId());
					cookie.setPath("/");
					cookie.setMaxAge(0);
					resp.addCookie(cookie);
				} else {
					Cookie cookie = new Cookie("loginIdCookie", user.getId());
					cookie.setPath("/");
					cookie.setMaxAge(60 * 60 * 24 * 7);
					resp.addCookie(cookie);
				}
				if (pwC == 0) {
					Cookie cookie = new Cookie("loginPwCookie", user.getPasswd());
					cookie.setPath("/");
					cookie.setMaxAge(0);
					resp.addCookie(cookie);
				} else {
					Cookie cookie = new Cookie("loginPwCookie", user.getPasswd());
					cookie.setPath("/");
					cookie.setMaxAge(60 * 60 * 24 * 7);
					resp.addCookie(cookie);
				}
			}
			return mav;
		}
		return new ModelAndView("redirect:maing.go");
	}
	

	//아이디찾기
	@RequestMapping(value="idFind.do", method=RequestMethod.GET)
	   public String idFind() {
	      return "login/idFind";
	   }
	
	@RequestMapping(value="idFind.do", method=RequestMethod.POST)
	   public ModelAndView idFind(HttpServletRequest req, 
	         @RequestParam String name, String email) throws FileNotFoundException, URISyntaxException{
	      String from = "sthox18@gmail.com";
	      ModelAndView mav = new ModelAndView();
	      MemberDTO dto = new MemberDTO();
	      dto.setName(name);
	      dto.setEmail(email);
	      MemberDTO dto1 = memberMapper.idFind(dto);
	      if(dto1 == null) {
	         mav.setViewName("message");
	         mav.addObject("msg","일치하는 이름 또는 이메일이 없습니다.");
	         mav.addObject("url","idFind.do");
	         return mav;
	      }
	      String subject = "[BookSmith] 아이디 찾기 ";
	      String text = "가입하신 아이디는 ["+dto1.getId()+"]입니다.";
	      try {
	         MimeMessage message = mailSender.createMimeMessage();
	         message.setFrom(new InternetAddress(from, "북스미스관리자")); 
	         message.addRecipient(RecipientType.TO, new InternetAddress(dto1.getEmail()));
	         message.setSubject(subject);
	         message.setText(text, "utf-8", "html");
	         mailSender.send(message);
	      }catch(Exception e) {
	         e.printStackTrace();
	      }
	      mav.setViewName("message");
	      mav.addObject("msg","아이디가 이메일로 전송되었습니다.");
	      mav.addObject("url","login.member");
	      return mav;
	   }

	@RequestMapping(value="pwdFind.do", method=RequestMethod.GET)
	   public String pwdFind() {
	      return "login/pwdFind";
	   }
	
	
	   
	   @RequestMapping(value="pwdFind.do", method=RequestMethod.POST)
	   public ModelAndView pwdFind(@RequestParam String id, String email) throws FileNotFoundException, URISyntaxException {
	      String from = "sthox18@gmail.com";
	      ModelAndView mav = new ModelAndView();
	      MemberDTO dto = new MemberDTO();
	      dto.setId(id);
	      dto.setEmail(email);
	      String passwd ="";
	      MemberDTO dto1 = memberMapper.pwdFind(dto);
	      if(dto1 == null) {
	         mav.setViewName("message");
	         mav.addObject("msg","일치하는 아이디 또는 이메일이 없습니다.");
	         mav.addObject("url","pwdFind.do");
	         return mav;
	      }
	      for(int i = 0; i < 8; i++){
	         char lowerStr = (char)(Math.random() * 26 + 97);
	         if(i % 2 == 0){
	            passwd += (int)(Math.random() * 10);
	         }else{
	            passwd += lowerStr;
	         }
	      }
	      dto.setPasswd(passwd);
	      memberMapper.pwdChange(dto);      
	      String subject = "[BookSmith] 비밀번호 찾기 ";
	      String text = "임시 비밀번호는 ["+passwd+"]입니다.<br>패스워드를 꼭 변경 해주세요!!";
	      try {
	         MimeMessage message = mailSender.createMimeMessage();
	         message.setFrom(new InternetAddress(from, "북스미스관리자")); 
	         message.addRecipient(RecipientType.TO, new InternetAddress(dto1.getEmail()));
	         message.setSubject(subject);
	         message.setText(text, "utf-8", "html");
	         mailSender.send(message);
	      }catch(Exception e) {
	         e.printStackTrace();
	      }
	      mav.setViewName("message");
	      mav.addObject("msg","임시 비밀번호가 이메일로 전송되었습니다.");
	      mav.addObject("url","login.member");
	      return mav;
	   }
	   
	   
	// ------------------------ my page ---------------------
		// myPage main
		@RequestMapping(value = "/mypage.mypage", method = RequestMethod.GET)
		public ModelAndView mypage(HttpServletRequest req, HttpSession session) {
			MemberDTO dto = (MemberDTO) session.getAttribute("userLoginInfo");
			List<MyOrderDTO> olist = memberMapper.mypage_mainO(dto.getId());
			List<QnaDTO> qlist = memberMapper.mypage_mainQ(dto.getMember_code());
			ModelAndView mav = new ModelAndView();
			mav.setViewName("mypage/mypage");
			mav.addObject("olist", olist);
			mav.addObject("qlist", qlist);
			return mav;
		}

		// mypage 주문 리스트
		@RequestMapping(value = "/mypage_orderList.mypage", method = RequestMethod.GET)
		public ModelAndView mypage_orderList(HttpServletRequest req, HttpSession session) {
			String search = req.getParameter("search");
			MemberDTO dto = (MemberDTO) session.getAttribute("userLoginInfo");
			List<MyOrderDTO> list = memberMapper.mypage_orderList(dto.getId(), search);
			ModelAndView mav = new ModelAndView();
			mav.setViewName("mypage/orderList");
			mav.addObject("list", list);
			return mav;
		}

		// mypage 주문 상세정보
		@RequestMapping(value = "/mypage_orderDetail.mypage", method = RequestMethod.GET)
		public ModelAndView mypage_orderDetail(HttpServletRequest req, HttpSession session) {
			String order_code = req.getParameter("order_code");
			MemberDTO dto = (MemberDTO) session.getAttribute("userLoginInfo");
			List<MyOrderDTO> list = memberMapper.mypage_orderDetail(dto.getId(), order_code);
			ModelAndView mav = new ModelAndView();
			mav.setViewName("mypage/orderDetail");
			mav.addObject("list", list);
			return mav;
		}

		// mypage 주문 상세정보 수정
		@RequestMapping(value = "/mypage_orderDetailUpdate.mypage", method = RequestMethod.POST)
		public ModelAndView mypage_orderDetailUpdate(HttpServletRequest req, @ModelAttribute OrderDTO dto, BindingResult result)
				throws Exception {
			int res = memberMapper.mypage_orderDetailUpdate(dto);
			ModelAndView mav = new ModelAndView();
			mav.setViewName("redirect:mypage.mypage");
			return mav;
		}
		
		// mypage 주문 상세정보 취소
			@RequestMapping(value = "/mypage_orderDetailCancel.mypage")
			public ModelAndView mypage_orderDetailCancel(HttpServletRequest req) {
				String order_code = req.getParameter("order_code");
				int res = memberMapper.mypage_orderDetailCancel(order_code);
				ModelAndView mav = new ModelAndView();
				mav.setViewName("redirect:mypage.mypage");
				return mav;
			}
		
		
		// mypage Q&A
		@RequestMapping(value = "/mypage_qna.mypage", method = RequestMethod.GET)
		public String mypage_qna(HttpServletRequest req) {
			return "mypage/qna";
		}

		// mypage Q&A list
		@RequestMapping(value = "/mypage_qnaList.mypage", method = RequestMethod.GET)
		public ModelAndView mypage_qnaList(HttpServletRequest req, HttpSession session) {
			MemberDTO dto = (MemberDTO) session.getAttribute("userLoginInfo");
			List<QnaDTO> list = memberMapper.myPage_qnaList(dto.getMember_code());
			ModelAndView mav = new ModelAndView();
			mav.setViewName("mypage/qnaList");
			mav.addObject("list", list);
			return mav;
		}

		// mypage Q&A list
		@RequestMapping(value = "/mypage_qnaDetail.mypage", method = RequestMethod.GET)
		public ModelAndView mypage_qnaDetail(HttpServletRequest req, @RequestParam String qna_code) {
			HttpSession session = req.getSession();
			String upPath = session.getServletContext().getRealPath("/resources/img");
			QnaDTO dto = memberMapper.mypage_qnaDetail(Integer.parseInt(qna_code));
			ModelAndView mav = new ModelAndView();
			mav.setViewName("mypage/qnaDetail");
			mav.addObject("dto", dto);
			mav.addObject("upPath", upPath);
			return mav;
		}

		// mypage Q&A 등록
		@RequestMapping(value = "/mypage_qna.mypage", method = RequestMethod.POST)
		public ModelAndView myPage_registQna(HttpServletRequest req, @ModelAttribute QnaDTO dto, BindingResult result)
				throws Exception {
			MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
			String filename = null;
			MultipartFile mf = mr.getFile("filename");
			filename = mf.getOriginalFilename();
			if (mf != null) {
				HttpSession session = req.getSession();
				String upPath = session.getServletContext().getRealPath("/resources/img");
				File file = new File(upPath, filename);
				if (filename == null || filename.equals("")) {
				} else {
					mf.transferTo(file);
				}
			}
			dto.setFilename(filename);
			int res = memberMapper.myPage_registQna(dto);
			ModelAndView mav = new ModelAndView();
			mav.setViewName("redirect:mypage.mypage");
			return mav;
		}

		// myPage 회원정보수정 창
		@RequestMapping("/myPage_modifyInfoForm.mypage")
		public ModelAndView myPage_modifyInfoForm(HttpSession session) {
			MemberDTO sid = (MemberDTO) session.getAttribute("userLoginInfo");
			MemberDTO dto = memberMapper.myPage_modifyInfoGet(sid.getId());
			ModelAndView mav = new ModelAndView();
			mav.setViewName("mypage/myPage_modifyInfoForm");
			mav.addObject("loginUser", dto);
			return mav;
		}

		// myPage 회원정보수정
		@RequestMapping(value = "/myPage_modifyInfo.mypage", method = RequestMethod.POST)
		public ModelAndView myPage_modifyInfo(HttpServletRequest req, @ModelAttribute MemberDTO dto) {
			memberMapper.myPage_modifyInfo(dto);
			return new ModelAndView("redirect:mypage.mypage");
		}

		// myPage 비밀번호수정 창
		@RequestMapping("/myPage_modifyPwForm.mypage")
		public ModelAndView myPage_modifyPwForm(HttpSession session) {
			MemberDTO sid = (MemberDTO) session.getAttribute("userLoginInfo");
			MemberDTO dto = memberMapper.myPage_modifyInfoGet(sid.getId());
			ModelAndView mav = new ModelAndView();
			mav.setViewName("mypage/myPage_modifyPwForm");
			mav.addObject("loginUser", dto);
			return mav;
		}

		// myPage 비밀번호수정
		@RequestMapping(value = "/myPage_modifyPw.mypage", method = RequestMethod.POST)
		public ModelAndView myPage_modifyPw(HttpServletRequest req, @ModelAttribute MemberDTO dto) {
			memberMapper.myPage_modifyPw(dto);
			return new ModelAndView("redirect:mypage.mypage");
		}

		// myPage 회원탈퇴창
		@RequestMapping("/myPage_deleteMemberForm.mypage")
		public ModelAndView myPage_deleteMemberForm(HttpSession session) {
			MemberDTO sid = (MemberDTO) session.getAttribute("userLoginInfo");
			MemberDTO dto = memberMapper.myPage_modifyInfoGet(sid.getId());
			ModelAndView mav = new ModelAndView();
			mav.setViewName("mypage/myPage_deleteMemberForm");
			mav.addObject("loginUser", dto);
			return mav;
		}

		// myPage 회원탈퇴
		@RequestMapping(value = "/myPage_deleteMember.mypage", method = RequestMethod.POST)
		public ModelAndView myPage_deleteMember(HttpServletRequest req, HttpSession session, @ModelAttribute MemberDTO dto) {
			memberMapper.myPage_deleteMember(dto);
			session.invalidate();
			return new ModelAndView("redirect:main.go");
			
		}

		// ------------------------ my page ---------------------end

}
