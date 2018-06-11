package com.smith.book.service;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smith.book.dto.MemberDTO;
import com.smith.book.dto.MyOrderDTO;
import com.smith.book.dto.OrderDTO;
import com.smith.book.dto.QnaDTO;

@Service
public class MemberMapper {

	@Autowired
	private SqlSession sqlSession;

	public int joinMember(MemberDTO dto) {
		int res = 0;
		res = sqlSession.insert("joinMember", dto);
		return res;
	}

	public int duplicationCheck(String id) {
		int res = sqlSession.selectOne("duplicationCheck", id);
		return res;
	}

	public MemberDTO loginMember(String id, String passwd) {
		MemberDTO dto = new MemberDTO();// 보내는 용
		MemberDTO dto1 = new MemberDTO();// 받는 용
		dto.setId(id);
		dto.setPasswd(passwd);
		dto1 = sqlSession.selectOne("loginMember", dto);
		return dto1;
	}

	public List<MemberDTO> mainListMember() { // 관리자 메인 회원 리스트 5개
		List<MemberDTO> list = sqlSession.selectList("mainListMember");
		return list;
	}

	public int getListMemberCount() { // 회원 전체 개수
		int res = sqlSession.selectOne("getListMemberCount");
		return res;
	}
	
	public List<MemberDTO> managerListMember(int startRow, int endRow) { // 회원 전체 목록
		String sql = "null";
		java.util.HashMap<String, String> map = new java.util.HashMap();
		sql = "select * from member order by member_code desc limit "+startRow+", 10";
		map.put("sql", sql);
		List<MemberDTO> list = sqlSession.selectList("managerListMember", map);
		return list;
	}

	public int deleteMember(int member_code) { // 회원삭제
		int res = sqlSession.delete("deleteMember", member_code);
		return res;
	}

	public int updateGrade(MemberDTO dto) { // 회원 등급 수정(리스트에서)
		int res = sqlSession.update("updateGrade", dto);
		return res;
	}

	public List<MemberDTO> searchMember(String search, String searchString) { // 회원 검색
	      List<MemberDTO> list = null;
	      String sql = null;
	      java.util.HashMap<String, String> map = new HashMap<String, String>();
	      sql = "select * from member where "+search+" like '%"+searchString+"%'";
	      map.put("sql", sql);
	      list = sqlSession.selectList("searchMember", map);
	      return list;
	   }

	public MemberDTO getMember(int member_code) { // 회원 한명의 정보
		MemberDTO dto = sqlSession.selectOne("getMember", member_code);
		return dto;
	}

	public int updatePro(MemberDTO dto) {// 회원 상세 수정 처리
		int res = 0;
		res = sqlSession.update("updatePro", dto);
		return res;
	}

	public MemberDTO getMemberInfo(String id) { // 회원 한명의 정보
		MemberDTO dto = sqlSession.selectOne("getMemberInfo", id);
		return dto;
	}
	
	
	//아이디찾기
	public MemberDTO idFind(MemberDTO dto) {
	      MemberDTO dto1 = sqlSession.selectOne("idFind", dto);
	      return dto1;
	   }
	   
	 public MemberDTO pwdFind(MemberDTO dto) {
	      MemberDTO dto1 = sqlSession.selectOne("pwdFind", dto);
	      return dto1;
	   }
	   
	 public void pwdChange(MemberDTO dto) {
	      sqlSession.update("pwdChange", dto);
	   }
	 
	 
	// -------------mypage-------------
		
		public List<MyOrderDTO> mypage_mainO(String member_id) {
			List<MyOrderDTO> list=null;
			list = sqlSession.selectList("mypage_mainO", member_id);
			return list;
		}
		public List<QnaDTO> mypage_mainQ(int m_code) {
			List<QnaDTO> list=null;
			list = sqlSession.selectList("mypage_mainQ", m_code);
			return list;
		}
		
		public List<MyOrderDTO> mypage_orderDetail(String member_id,String order_code) {
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("member_id", member_id);
			params.put("order_code",order_code);
			List<MyOrderDTO> list=null;
			list = sqlSession.selectList("mypage_orderDetail", params);
			return list;
		}
		
		public List<MyOrderDTO> mypage_orderList(String member_id,String search) {
			List<MyOrderDTO> list=null;
			if("3month".equals(search)) {
				list = sqlSession.selectList("mypage_orderList2", member_id);
			}else if("all".equals(search)) {
				list = sqlSession.selectList("mypage_orderList3", member_id);
			}else {
				list = sqlSession.selectList("mypage_orderList1", member_id);
			}
			return list;
		}
		
		public int mypage_orderDetailUpdate(OrderDTO dto) {
			int res = 0;
			res = sqlSession.update("mypage_orderDetailUpdate", dto);
			return res;
		}
		
		public int mypage_orderDetailCancel(String order_code) {
			int res = 0;
			res = sqlSession.update("mypage_orderDetailCancel", order_code);
			return res;
		}
		
		public List<QnaDTO> myPage_qnaList(int member_code) {
			List<QnaDTO> list;
			list = sqlSession.selectList("myPage_qnaList", member_code);
			return list;
		}
		
		public QnaDTO mypage_qnaDetail(int qna_code) {
			QnaDTO dto;
			dto = sqlSession.selectOne("mypage_qnaDetail", qna_code);
			return dto;
		}
		
		public int myPage_registQna(QnaDTO dto) {
			int res = 0;
			res = sqlSession.update("myPage_registQna", dto);
			return res;
		}
		
		public MemberDTO myPage_modifyInfoGet(String id) {
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = sqlSession.selectOne("myPage_modifyInfoGet", dto);
			return dto;
		}

		public int myPage_modifyInfo(MemberDTO dto) {
			int res = 0;
			res = sqlSession.update("myPage_modifyInfo", dto);
			return res;
		}

		public int myPage_modifyPw(MemberDTO dto) {
			int res = 0;
			res = sqlSession.update("myPage_modifyPw", dto);
			return res;
		}

		public int myPage_deleteMember(MemberDTO dto) {
			int res = 0;
			res = sqlSession.delete("myPage_deleteMember", dto);
			return res;
		}
	   

}
