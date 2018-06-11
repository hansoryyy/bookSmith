package com.smith.book.service;

import java.util.HashMap;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smith.book.dto.BoardDTO;
import com.smith.book.dto.CommentDTO;
import com.smith.book.dto.FreeDTO;
import com.smith.book.dto.NoticeDTO;
import com.smith.book.dto.QnaDTO;



@Service
public class BoardMapper {
   @Autowired
   private SqlSession sqlSession;
      
   public int commentUpdate(int board_code) {
      int res = 0;      
      res = sqlSession.update("commentUpdate", board_code);
      return res;         
   }
      
   public int getCount() {
      int res = sqlSession.selectOne("getCount");
         return res;      
   }
   
   public List<BoardDTO> listBoard(){
      List<BoardDTO> list = sqlSession.selectList("listBoard");
      return list;      
   }
   
   public List<BoardDTO> reviewListBoard(int book_code){
	     List<BoardDTO> list = sqlSession.selectList("reviewListBoard",book_code);
	     return list;      
	   }
   
   public BoardDTO getBoard(int board_code, String mode) {
      BoardDTO dto = null;
      if(mode.equals("content")) sqlSession.update("readCount", board_code);
      dto = (BoardDTO)sqlSession.selectOne("getBoard", board_code);      
      return dto;
   }
   
   public List<BoardDTO> searchBoard(String search, String searchString){
      List<BoardDTO> list = null;
      String sql = null;      
      java.util.HashMap<String, String> map = new java.util.HashMap();
      sql = "select * from free where "+search+" like '%"+searchString+"%' order by board_code desc";
      map.put("sql", sql);
      list = sqlSession.selectList("searchBoard", map);
      return list;
      
   }
   
   public int insertBoard(BoardDTO dto) {
      int res = sqlSession.insert("insertBoard", dto);
      float avg_rate = sqlSession.selectOne("countRate", dto.getBook_code());
      dto.setAvg_rate((int)(avg_rate));
      res = sqlSession.insert("updateRate", dto);
      return res;
   }
   
   public List<CommentDTO> listComment(int b_code){
      List<CommentDTO> list = sqlSession.selectList("listComment", b_code);
      List<String> list2 = sqlSession.selectList("listCommentTime",b_code);
      for(int i=0;i<list.size();i++) {
         list.get(i).setLeaveTime(Integer.parseInt(list2.get(i)));
      }
      return list;
   }
   
   
   public int insertComment(CommentDTO dto) {
      int res = sqlSession.insert("insertComment", dto);
      return res;
   }
   public List<BoardDTO> mainListBoard(){//������ ���� �Խ��� ����Ʈ 5��
      List<BoardDTO> list = sqlSession.selectList("mainListBoard");
      return list;
   }
   //공지사항(notice)
   public int getNoticeCount() {
      int res = sqlSession.selectOne("getNoticeCount");
      return res;      
   }
   public List<NoticeDTO> listNotice(int startRow, int endRow){
	   String sql = "null";
	   java.util.HashMap<String, String> map = new java.util.HashMap();
	   sql = "select * from notice order by notice_code desc limit "+startRow+", 10";
	   map.put("sql", sql);
	   List<NoticeDTO> list = sqlSession.selectList("listNotice", map);
	   return list;
   }
   public int insertNotice(NoticeDTO dto) {
      int res = sqlSession.insert("insertNotice", dto);      
      return res;
   }
   public NoticeDTO getNotice(int notice_code, String mode) {
      NoticeDTO dto = null;
      if(mode.equals("content")) {
         sqlSession.update("N_readCount", notice_code);
      }
      dto = (NoticeDTO)sqlSession.selectOne("getNotice", notice_code);      
      return dto;
   }
   public List<CommentDTO> listCommentNotice(int b_code) {
      List<CommentDTO> list = sqlSession.selectList("listCommentNotice", b_code);
      return list;
   }
   public List<NoticeDTO> searchNotice(String search, String searchString){
      List<NoticeDTO> list = null;
      String sql = null;      
      java.util.HashMap<String, String> map = new HashMap<String, String>();
      sql = "select * from notice where "+search+" like '%"+searchString+"%' order by notice_code desc";
      map.put("sql", sql);
      list = sqlSession.selectList("searchNotice", map);
      return list;
      
   }
   //Q&A
      public List<QnaDTO> listQna(){
         List<QnaDTO> list = sqlSession.selectList("listQna");
         return list;      
      }
      public int getQnaCount() {
         int res = sqlSession.selectOne("getQnaCount");
         return res;      
      }
      public QnaDTO getQna(int qna_code) {
         QnaDTO dto = (QnaDTO)sqlSession.selectOne("getQna", qna_code);
               
         return dto;
      }
      public int replyQna(QnaDTO dto) {
         int res = sqlSession.update("replyQna", dto);      
         return res;
      }
      
      public void updateNotice(NoticeDTO dto) {
          int res = sqlSession.update("updateNotice", dto);
       }

       public void deleteNotice(int notice_code) {
          sqlSession.delete("deleteNotice", notice_code);
       }
       
       public List<FreeDTO> mainListReview(){
    	      List<FreeDTO> list = sqlSession.selectList("mainListReview");
    	      return list;
    	}
       
 

      
       
    // 1:1 문의 검색
       public List<QnaDTO> searchQna(String search, String searchString){
          String sql = null;
          sql = "select * from qna where "+search+" like '%"+searchString+"%'";
          java.util.HashMap<String, String> map = new java.util.HashMap();
          map.put("sql", sql);
          List<QnaDTO> list = sqlSession.selectList("searchQna", map);
          return list;
       }
       
       public void deleteQna(int qna_code) {
           sqlSession.delete("deleteQna", qna_code);
       }
       
    // 리뷰 전체 개수
       public int getBookReviewCount() {
          int res = sqlSession.selectOne("getReviewCount");
          return res;
       }

       // 리뷰 목록
       public List<FreeDTO> listReview(int startRow, int endRow) {
          String sql = null;      
          sql = "select * from free order by board_code desc limit "+startRow+", 10";
          java.util.HashMap<String, String> map = new java.util.HashMap();
          map.put("sql", sql);
          List<FreeDTO> list = sqlSession.selectList("listReview", map);
          return list;
       }

       // 리뷰 검색
       public List<FreeDTO> searchReview(String search, String searchString) {
          String sql = null;
          sql = "select * from free where "+search+" like '%"+searchString+"%'";
          java.util.HashMap<String, String> map = new java.util.HashMap();
          map.put("sql", sql);
          List<FreeDTO> list = sqlSession.selectList("searchReview", map);
          return list;
       }
       
       // 리뷰 상세 보기
       public FreeDTO contentReview(int board_code) {
          FreeDTO dto = sqlSession.selectOne("contentReview", board_code);
          return dto;
       }

       // 리뷰 수정
       public void updateReview(String content, int board_code) {
          String sql = null;
          sql = "update free set content = '"+content+"' where board_code = "+board_code;
          java.util.HashMap<String, String> map = new java.util.HashMap();
          map.put("sql", sql);
          sqlSession.update("updateReview", map);
       }

       // 리뷰 삭제
       public void deleteReview(int board_code) {
          sqlSession.delete("deleteReview", board_code);
       }
      
}

