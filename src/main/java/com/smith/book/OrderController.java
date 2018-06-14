package com.smith.book;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.smith.book.dto.BookDTO;
import com.smith.book.dto.CartDTO;
import com.smith.book.dto.MemberDTO;
import com.smith.book.dto.OrderDTO;
import com.smith.book.dto.OrderItemDTO;
import com.smith.book.service.BookMapper;
import com.smith.book.service.CartMapper;
import com.smith.book.service.MemberMapper;
import com.smith.book.service.OrderMapper;

@Controller
public class OrderController {
	@Autowired
	private BookMapper bookMapper;
	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private OrderMapper orderMapper;
	@Autowired
	private CartMapper cartMapper;

	

	// 오늘 날짜를 리턴
	public Date today() {
		Date date = new Date();
		/*
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String today = sdf.format(date);
		return today;
		*/
		return date;
	}
	
	//바로구매 결제 성공시 (회원 + 비회원)
	@RequestMapping(value = "/direct_buy.success", method = RequestMethod.POST)
	public String addDirectOrder(HttpSession session, @ModelAttribute OrderDTO odto, @RequestParam String message) {
		MemberDTO m_dto = (MemberDTO) session.getAttribute("userLoginInfo");
		CartDTO c_dto = (CartDTO) session.getAttribute("direct");
		BookDTO dto = bookMapper.getBook(c_dto.getBook_code());
		Date order_date = today();
		System.out.println(c_dto.getBook_code());
		
		OrderItemDTO oidto = new OrderItemDTO();
		oidto.setBook_code(c_dto.getBook_code());
		oidto.setQty(c_dto.getQty());
		oidto.setEach_price(c_dto.getPrice()*c_dto.getQty());
		oidto.setSales_date(order_date);
		odto.addItem(oidto);
		
		String tel = odto.getHp1() + odto.getHp2() + odto.getHp3();
		odto.setTel(tel);
		odto.setMessage(message);
		
		if(m_dto != null) {
			odto.setMember_id(m_dto.getId());
		}
		
		orderMapper.addDirectOrder(odto);
		session.removeAttribute("direct");
		
		return "redirect:pay_success";
	}
	
	

	// 비회원 장바구니 결제 성공시
	@RequestMapping(value = "/pay.success", method = RequestMethod.POST)
	public String addGusestOrder(HttpSession session, @ModelAttribute OrderDTO odto, @RequestParam String message) {
		HashMap<Integer, CartDTO> map = (HashMap) session.getAttribute("cart");
		Date order_date = today();
		String tel = odto.getHp1() + odto.getHp2() + odto.getHp3();

		odto.setTel(tel);
		//odto.setOrder_date(order_date);

		for (Integer book_code : map.keySet()) {
			BookDTO dto = bookMapper.getBook(book_code);
			int price = dto.getPrice();
			int qty = map.get(book_code).getQty();
			int each_price = price * qty;

			OrderItemDTO oidto = new OrderItemDTO();
			oidto.setBook_code(book_code);
			oidto.setQty(qty);
			oidto.setEach_price(each_price);
			oidto.setSales_date(order_date);
			odto.addItem(oidto);
		}
		odto.setMessage(message);
		orderMapper.addGuestOrder(odto);
		session.removeAttribute("cart");
		return "redirect:pay_success";
	}

	// 회원 장바구니 결제 성공시
	@RequestMapping(value = "/memberPay.success", method = RequestMethod.POST)
	public String addMemberOrder(HttpSession session, @ModelAttribute OrderDTO odto,  @RequestParam String message) {
		MemberDTO m_dto = (MemberDTO) session.getAttribute("userLoginInfo");
		List<CartDTO> list = cartMapper.list_memberCart(m_dto.getId());
		Date today = today();
		String tel = odto.getHp1() + odto.getHp2() + odto.getHp3();
		odto.setMember_id(m_dto.getId());
		odto.setTel(tel);
		odto.setOrder_date(today);
		odto.setMessage(message);
		for (CartDTO dto : list) {
			OrderItemDTO oidto = new OrderItemDTO();
			oidto.setBook_code(dto.getBook_code());
			oidto.setQty(dto.getQty());
			oidto.setEach_price(dto.getPrice() * dto.getQty());
			oidto.setSales_date(today);
			odto.addItem(oidto);
		}
		orderMapper.addMemberOrder(odto);
		return "redirect:pay_success";
	}

	@RequestMapping(value = "/myOrder.member", method = RequestMethod.GET)
	public ModelAndView myOrderMember(HttpSession session) {
		MemberDTO m_dto = (MemberDTO) session.getAttribute("userLoginInfo");
//		List<OrderDTO> list = orderMapper.getOrder(m_dto.getId());
		List<OrderDTO> list = new ArrayList<OrderDTO>();
		ModelAndView mav = new ModelAndView();
		mav.addObject("order", list);
		mav.setViewName("/mypage/orderList");
		return mav;
	}
	
	
	@RequestMapping(value = "/orderCheck_guest", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> orderCheckGuest(@ModelAttribute OrderDTO dto) throws JsonProcessingException {
		Map<String, Object> json = new HashMap<String, Object>();
		List<OrderDTO> list = orderMapper.getGuestOrder(dto);
		json.put("check", list);
		return json;
	}
	
	
	@RequestMapping(value = "/orderCheck_guest")
	public String orderCheckGuestForm() {
		return "/shop/orderCheck_guest";
	}
}
