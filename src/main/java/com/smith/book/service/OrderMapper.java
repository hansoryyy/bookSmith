package com.smith.book.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.smith.book.dto.CartDTO;
import com.smith.book.dto.OrderDTO;
import com.smith.book.dto.OrderItemDTO;


@Repository
public class OrderMapper {
	@Autowired
	private SqlSession sqlSession;
	@Autowired 
	private CartMapper cartMapper;
	
	public int addDirectOrder(OrderDTO odto) {
		sqlSession.insert("addOrder", odto);
		int pk = odto.getOrder_code();
		OrderItemDTO dto = odto.getItems().get(0);
		dto.setOrder_code(pk);
		addOrderItem(dto);
		sqlSession.update("updateQtySaleCount", dto);
		return 1;
	}
	
	
	
						
	public int addGuestOrder(OrderDTO odto) {
		sqlSession.insert("addOrder", odto); //odto.setOrder_code(14)
		int pk = odto.getOrder_code();
		for(OrderItemDTO item : odto.getItems()) {
			item.setOrder_code(pk);
			addOrderItem(item);
			sqlSession.update("updateQtySaleCount", item);
		}
		return 1;
	}
	
	public int addMemberOrder(OrderDTO odto) {
		sqlSession.insert("addOrder", odto);
			int pk = odto.getOrder_code();
		for(OrderItemDTO item : odto.getItems()) {
			item.setOrder_code(pk);
			addOrderItem(item);
			sqlSession.update("updateQtySaleCount", item);
			cartMapper.delete_memberCart(item.getCartItem());
		}
		return 1;
	}
	
	public int addOrderItem(OrderItemDTO oidto) {
		sqlSession.insert("addOrderItem", oidto);
		return 1;
	}
	
	
	
	public List<OrderDTO> getOrder(String id){
		List<OrderDTO> list = sqlSession.selectList("getOrder", id);
		return list;
		
	}

	public List<OrderDTO> getGuestOrder(OrderDTO dto) {
		List<OrderDTO> list = sqlSession.selectList("getGuestOrder", dto);
		return list;
	}

	
}
