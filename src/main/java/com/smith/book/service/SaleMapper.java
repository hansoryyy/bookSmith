package com.smith.book.service;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.smith.book.dto.BookDTO;
import com.smith.book.dto.OrderDTO;

@Repository
public class SaleMapper {
	@Autowired
	private SqlSession sqlSession;
	
		public int orderTotalPage() {
			int res = sqlSession.selectOne("orderTotalPage");
			return res;
		}
		
		// 주문 내역
		public List<OrderDTO> orderList(int startRow, int endRow){
			String sql = null;
			java.util.HashMap<String, String> map = new java.util.HashMap<String, String>();
			sql = "select a.order_code, a.name, a.tel, (SELECT sum(b.each_price) from  order_item Group BY b.order_code) AS each_price, a.`status`, a.payment_option, \r\n" + 
					"		a.member_id, count(b.qty) AS qty, a.delivery_code, a.delivery_company, a.order_date from \r\n" + 
					"		moon.order a inner join order_item b on a.order_code = b.order_code group by a.order_code \r\n" + 
					"		order by a.order_code desc limit "+startRow+", 10";
			map.put("sql", sql);
			List<OrderDTO> list = sqlSession.selectList("orderList", map);
			return list;
		}
	   
	   // 주문 내역 검색
		public List<OrderDTO> orderSearch(String search, String searchString) {
			List<OrderDTO> list = null;
			String sql = null;
			java.util.HashMap<String, String> map = new java.util.HashMap<String, String>();
			sql = "select a.order_code, a.name, a.tel, (SELECT sum(b.each_price) from  order_item Group BY b.order_code) AS each_price, a.`status`, a.member_id, count(b.qty) AS qty, a.delivery_code, a.delivery_company, a.order_date from moon.order a inner join order_item b on a.order_code = b.order_code where a."+search+" like '%"+searchString+"%' group by a.order_code order by a.order_code desc";
			map.put("sql", sql);
			list = sqlSession.selectList("orderSearch", map);
			return list;
		}
	   
	   // 주문 내역 수정
	   public OrderDTO orderStatus(int order_code){
	      OrderDTO dto = sqlSession.selectOne("orderStatus", order_code);
	      return dto;
	   }
	   
	   // 주문 상품 목록
	   public List<OrderDTO> orderProduct(int order_code){
	      List<OrderDTO> list = sqlSession.selectList("orderProduct", order_code);
	      return list;
	   }
	   
	   // 주문 상품 목록 수정(상태<취소, 환불 제외>, 수량)
	   public void orderProductModify(int order_code, int order_item_code, String status, int price, int qty) {
	      String sql = null;
	      int each_price = price * qty;
	      java.util.HashMap<String, String> map = new java.util.HashMap();
	      sql = "update order_item set status='"+status+"', qty="+qty+", each_price="+each_price+" where order_code="+order_code+
	            " and order_item_code="+order_item_code;
	      map.put("sql", sql);
	      sqlSession.selectList("orderProductModify", map);
	   }
	   
	   // 주문 상품 목록 수정(취소, 환불)
	   public void orderProductDeduction(int order_code, int order_item_code, String status, int price, int qty) {
	      String sql = null;
	      int each_price = price * qty;
	      java.util.HashMap<String, String> map = new java.util.HashMap();
	      sql = "update order_item set status='"+status+"', qty=0, each_price=0 where order_code="+order_code+" and order_item_code="+order_item_code;
	      map.put("sql", sql);
	      sqlSession.update("orderProductDeduction", map);
	   }
	   
	   // 결제 상세 정보 수정
	   public int paymentStatusModify(OrderDTO dto) {
	      int res = sqlSession.update("paymentStatusModify", dto);
	      return res;
	   }

	   // 주문자 배송지 수정
	   public void orderAddrModify(OrderDTO dto) {
	      sqlSession.update("orderAddrModify", dto);      
	   }

	   // 일일 매출 현황
		public List<OrderDTO> saleToday(String date) {
			List<OrderDTO> list = sqlSession.selectList("saleToday", date);
			return list;
		}

		// 일간 매출 현황
		public List<OrderDTO> saleDate(String fr_date, String to_date) {
			List<OrderDTO> list = null;
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("fr_date", fr_date);
			params.put("to_date", to_date);
			list = sqlSession.selectList("saleDate", params);
			return list;
		}

		// 월간 매출 현황
		public List<OrderDTO> saleMonth(String fr_month, String to_month) {
			List<OrderDTO> list = null;
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("fr_month", fr_month);
			params.put("to_month", to_month);
			list = sqlSession.selectList("saleMonth", params);
			return list;
		}

		// 연간 매출 현황
		public List<OrderDTO> saleYear(String fr_year, String to_year) {
			List<OrderDTO> list = null;
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("fr_year", fr_year);
			params.put("to_year", to_year);
			list = sqlSession.selectList("saleYear", params);
			return list;
		}

		// 상품 판매 순위 검색
		public List<BookDTO> itemRankFind(String type, String g_code, String fr_date, String to_date) {
			List<BookDTO> list = null;
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("type", type);
			params.put("fr_date", fr_date);
			params.put("to_date", to_date);
			if(g_code.equals("0")) {
				list = sqlSession.selectList("itemRankFindAll", params); 
			}else{
				params.put("g_code", g_code); 
				list = sqlSession.selectList("itemRankFind", params);
			}
			
			
			return list;
		}

		

}
