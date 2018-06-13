package com.smith.book;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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
import com.smith.book.dto.OrderItemDTO;
import com.smith.book.service.BookMapper;
import com.smith.book.service.CartMapper;
import com.smith.book.service.MemberMapper;

@Controller
public class CartContoller {
	@Autowired
	private BookMapper bookMapper;
	@Autowired
	private CartMapper cartMapper;
	@Autowired
	private MemberMapper memberMapper;
	
	@RequestMapping(value = "/add_direct_cart", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Object addDirectCart (HttpSession session, @RequestParam int book_code, @RequestParam int qty ) {

		BookDTO book_dto = bookMapper.getBook(book_code);
		CartDTO dto = new CartDTO(book_code, book_dto.getBookname(), book_dto.getPrice(), qty, book_dto.getImg_name());
		session.setAttribute("direct", dto);
		
		MemberDTO m_dto = (MemberDTO) session.getAttribute("userLoginInfo");
		MemberDTO member = null;
		
		Map<String, Object> json = new HashMap<String, Object>();
		if (m_dto != null) {
			 member = memberMapper.getMemberInfo(m_dto.getId());
		} else {
		}
		
		json.put("success", Boolean.TRUE);
		json.put("nextUrl", session.getServletContext().getContextPath() + "/buy_direct"); 
		return json;
	}
	@RequestMapping(value = "/buy_direct", produces = "application/json;charset=UTF-8")
	 public ModelAndView buy_direct(HttpSession session){
		CartDTO dto = (CartDTO) session.getAttribute("direct");
		
		MemberDTO m_dto = (MemberDTO) session.getAttribute("userLoginInfo");
		MemberDTO member = null;
		
		if (m_dto != null) {
			 member = memberMapper.getMemberInfo(m_dto.getId());
		}
		
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("dto", dto);
		mav.addObject("member", member);
		mav.setViewName("shop/list_cart");
		return mav;
	}
	 
	// 장바구니 물품추가
	@RequestMapping(value = "/insert_cart", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> insertCart(HttpServletRequest req, HttpSession session, @RequestParam int book_code,
			@RequestParam int qty) throws JsonProcessingException {
		
		MemberDTO m_dto = (MemberDTO) session.getAttribute("userLoginInfo");
		Map<String, Object> json = new HashMap<String, Object>();

		if (m_dto == null) { // 비회원 (or 회원인데 로그인 안했음) -> session에 저장 하겠다

			HashMap<Integer, CartDTO> map = (HashMap<Integer, CartDTO>) session.getAttribute("cart");
			if (map == null) { // 비회원이 최초로 물품을 담을때   key:"cart" value:map 으로 세션을 생성하겠다.
				map = new HashMap<Integer, CartDTO>();
				session.setAttribute("cart", map);
			}

			CartDTO cart = map.get(book_code);
			if (cart != null) { // 카트에 이미 있는 상품을 추가헀다면 수량만 증가
				cart.setQty(cart.getQty() + qty);
				
			} else { // 새로운 상품을 추가
				BookDTO bookDto = bookMapper.getBook(book_code); 
				cart = new CartDTO(book_code, bookDto.getBookname(), bookDto.getPrice(), qty, bookDto.getImg_name());
				map.put(book_code, cart);
			}
			json.put("success", Boolean.TRUE);
			return json;

		} else { // 회원인경우 DB cart Table에 저장하겠다 .
			CartDTO search_cart = new CartDTO();
			search_cart.setBook_code(book_code);
			search_cart.setMember_id(m_dto.getId());

			CartDTO cart = cartMapper.registeredBook(search_cart);

			if (cart == null) {

				BookDTO book = bookMapper.getBook(book_code);
				CartDTO new_cart = new CartDTO();
				new_cart.setMember_id(m_dto.getId());
				new_cart.setBook_code(book_code);
				new_cart.setBookname(book.getBookname());
				new_cart.setQty(qty);
				new_cart.setPrice(book.getPrice());
				int res = cartMapper.addCart(new_cart);

			} else {
				cart.setQty(cart.getQty() + qty);
				cartMapper.updateQty(cart);
				
			}
			json.put("success", Boolean.TRUE);
			return json;
		}
	}

	// 장바구니 수정
	@RequestMapping(value = "/update_cart", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> updateCartItem(HttpSession session, @RequestParam int book_code,
			@RequestParam int qty, @RequestParam int mode)
			throws JsonProcessingException {
		Map<String, Object> json = new HashMap<String, Object>();

		if(mode == 0) {
			CartDTO dto = (CartDTO) session.getAttribute("direct");
			dto.setQty(qty);
			json.put("success", Boolean.TRUE);
			json.put("qty", qty);
			json.put("price", dto.getPrice());
			json.put("each_price", dto.getQty() * dto.getPrice());
			json.put("total", dto.getQty() * dto.getPrice());
			return json;
			
		}else {
			MemberDTO m_dto = (MemberDTO) session.getAttribute("userLoginInfo");
			int each_pirce = 0;
			int total = 0;
	
			if (m_dto == null) {
				HashMap<Integer, CartDTO> map = (HashMap) session.getAttribute("cart");
				
				CartDTO cart = map.get(book_code);
				cart.setQty(qty);
				
				json.put("success", Boolean.TRUE);
				json.put("qty", qty);
				json.put("price",cart.getPrice());
				json.put("each_price", qty * cart.getPrice());
				
				for(Integer book_code1 : map.keySet()) {
					each_pirce = map.get(book_code1).getPrice()*map.get(book_code1).getQty();
					total +=each_pirce;
				}
				
				json.put("total", total);
				return json;
				
			}else {
				CartDTO search_cart = new CartDTO();
				search_cart.setBook_code(book_code);
				search_cart.setMember_id(m_dto.getId());
				CartDTO cart = cartMapper.registeredBook(search_cart);
				cart.setQty(qty);
				cartMapper.updateQty(cart);
				json.put("success", Boolean.TRUE);
				json.put("qty", qty);
				json.put("price", cart.getPrice());
				json.put("each_price", qty* cart.getPrice());
				int cart_total = cartMapper.totalPrice(m_dto.getId());
				json.put("total", cart_total);
				return json;
			}
		}

	}
	
	//장바구니 삭제
	@RequestMapping(value = "/delete_cart", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, String> deleteCartItem(HttpSession session, @RequestParam int book_code, @RequestParam int mode)
			throws JsonProcessingException {
		MemberDTO m_dto = (MemberDTO) session.getAttribute("userLoginInfo");
		Map<String, String> json = new HashMap<String, String>();
		System.out.println("BOOK_CODE : "+ book_code);
		System.out.println("MODE : " + mode);
		
		if(mode == 0) {
			System.out.println("진입성공");
			CartDTO dto = (CartDTO) session.getAttribute("direct");
			json.put("success", "return");
			return json;
		}else {
			if(m_dto == null) {
				HashMap<Integer, CartDTO> map = (HashMap) session.getAttribute("cart");
				if (map == null) {// 카트가 없음 아예없음
					json.put("success", "false");
					return json;
				} else {
					CartDTO cartItem = map.remove(book_code);
					if (cartItem == null) {
						json.put("success", "false");
						return json;
					} else {
						json.put("success", "true");
						json.put("bookname", cartItem.getBookname());
						return json;
					}
				}
			}else {
				CartDTO dto = new CartDTO();
				dto.setBook_code(book_code);
				dto.setMember_id(m_dto.getId());
				cartMapper.delete_memberCart(dto);
				json.put("success", "true");
				return json;
				
			}
			
		}
		

	}
	
	// 장바구니 리스트
	@RequestMapping(value = "/list_cart") 
	public ModelAndView list_cart(HttpSession session, HttpServletRequest req) {
		MemberDTO m_dto = (MemberDTO) session.getAttribute("userLoginInfo");
		ModelAndView mav = new ModelAndView();
		HashMap<Integer, CartDTO> map = null;
		List<CartDTO> list = null;
		MemberDTO member = null;
		String book_code = null;
		book_code = req.getParameter("book_code");
		String qty = null;
		qty = req.getParameter("qty");
		if (m_dto != null) {
			list = cartMapper.list_memberCart(m_dto.getId());
			member = memberMapper.getMemberInfo(m_dto.getId());
		} else {
			map = (HashMap) session.getAttribute("cart");
		}
		mav.addObject("map", map);
		mav.addObject("cart_list", list);
		mav.addObject("member", member);
		mav.setViewName("shop/list_cart");
		return mav;
	}
}
