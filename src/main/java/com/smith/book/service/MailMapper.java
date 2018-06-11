package com.smith.book.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.smith.book.dto.MailDTO;
import com.smith.book.dto.MemberDTO;

@Repository
public class MailMapper {
	@Autowired
	   private SqlSession sqlSession;
	   
		public int getTotalPage() {
			int res = sqlSession.selectOne("getTotalPage");
			return res;
		}

		public List<MailDTO> mailUserList(int startRow, int endRow) {
			String sql = null;
			java.util.HashMap<String, String> map = new java.util.HashMap<String, String>();
			sql = "select * from mail order by mailcode desc limit "+startRow+", 10";
			map.put("sql", sql);
			List<MailDTO> list = sqlSession.selectList("mailUserList", map);
			return list;
		}
	   
	   public int createMail(MailDTO dto) {
	      int res = sqlSession.insert("createMail", dto);
	      return res;
	   }
	   
	   public int deleteMail(int mailcode) {
	      int res = sqlSession.delete("deleteMail", mailcode);
	      return res;
	   }
	   
	   public MailDTO getList(int mailcode) {
	      MailDTO dto = sqlSession.selectOne("getList", mailcode);
	      return dto;
	   }
	   
	   public int updateMail(MailDTO dto) {
	      int res = sqlSession.update("updateMail", dto);
	      return res;
	   }
	   
	   public List<MemberDTO> mailReceive(String mode) {
	      List<MemberDTO> list = sqlSession.selectList("mailReceive", mode);
	      return list;
	   }

}
