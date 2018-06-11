package com.smith.book.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.smith.book.dto.CartDTO;


@Repository
public class CartMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public CartDTO registeredBook(CartDTO search_cart) {
		CartDTO dto  = null;
		try{
			dto = sqlSession.selectOne("registeredBook", search_cart);
		}catch(NullPointerException e){
			dto = null;
		}
		return dto;
	}
	
	public int updateQty(CartDTO cart) {
		int res = sqlSession.update("updateQty", cart);
		return res;
	}
	
	public int totalPrice(String member_id) {
		int res = sqlSession.selectOne("totalPrice", member_id);
		return res;
	}

	
	public int addCart(CartDTO new_cart) {
		int res = sqlSession.insert("addCart", new_cart);
		return res;
	}
	
	
	public List<CartDTO> list_memberCart(String member_id) {
		List<CartDTO> list = sqlSession.selectList("list_memberCart", member_id);
		return list;
	}

	public void delete_memberCart(CartDTO dto) {
		int res = sqlSession.delete("delete_memberCart", dto);
		
	}

}
