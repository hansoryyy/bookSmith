package com.smith.book.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.NestedServletException;

import com.smith.book.dto.AuctionDTO;
import com.smith.book.dto.BidderDTO;

@Service
public class AuctionMapper {
   @Autowired
   private SqlSession sqlSession;
   
   
   /*============고객용===========*/
   public List<AuctionDTO> listAuction(){ //경매 리스트
      List<AuctionDTO> list = sqlSession.selectList("listAuction");
      return list;
   }
   public int bidAuction(BidderDTO dto) { //입찰하기
      int res = sqlSession.insert("bidderInsert",dto);
      return res;
   }
   public void bringAuction(AuctionDTO dto) { //신청서  등록
      sqlSession.insert("bringAuction",dto);
   }
   public List<Integer> listTimeAuction(){ //경매 리스트 마감시간 계산
      List<Integer> list = sqlSession.selectList("listTimeAuction");
      return list;
   }
   public void bidding(int a_code,int money) { //누군가 입찰시 현재 입찰금액 변경(table=auction)
      AuctionDTO dto = new AuctionDTO();
      dto.setA_code(a_code);
      dto.setMoney(money);
      sqlSession.update("bidding",dto);
   }
   public AuctionDTO getAuction(int a_code) { //경매물품정보 가져오기 
      AuctionDTO dto = sqlSession.selectOne("getAuction",a_code);
      return dto;
   }
   public int getLeavetime(int a_code) { //하나의 경매품 마감시간 계산
      int leavetime = sqlSession.selectOne("getLeavetime",a_code);
      return leavetime;
   }
   public String highest(int a_code) {//최종 낙찰자
      String id= sqlSession.selectOne("highest",a_code);
      return id;
   }
   public List<BidderDTO> myListBidder(String member_id){ //내 입찰리스트 갖고오기
      List<BidderDTO> list = sqlSession.selectList("myListBidder",member_id);
      return list;
   }
   public int bidCheck(BidderDTO dto) { //내가 입찰했던 물품인지 검색
      int res=0;
      try{
         res = sqlSession.selectOne("bidCheck", dto);
      }catch(Exception e) {
      }
      return res; 
   }
   public int bidUpdate(BidderDTO dto) { //같은 물품 다른금액으로 입찰
      int res = sqlSession.update("bidUpdate",dto);
      return res;
   }
   public void moneyBidder(int a_code,int money) { //다른사람이 입찰시에 현재 입찰금액 변경(table=bidder)
      BidderDTO dto = new BidderDTO();
      dto.setA_code(a_code);
      dto.setMoney(money);
      sqlSession.update("moneyBidder",dto);   
   }
   public List<Integer> myListTimeBidder(String id) { //내 입찰 리스트 마감시간 계산
      List<Integer> list = sqlSession.selectList("myListTime",id);
      return list;
   } 
   public void deleteBidder(int bidder_code) { //내가 입찰중인 경매 취하
      sqlSession.delete("deleteBidder",bidder_code);
   }
   public List<AuctionDTO> myListAuction(String id){//내 경매품 리스트
      List<AuctionDTO> list = null;
      try {
         list = sqlSession.selectList("myListAuction",id);
      }catch(Exception e) {}
      return list;
   }
   public List<Integer> myListTimeAuction(String id) { //내 경매품 리스트 마감시간 계산
      List<Integer> list = null;
      try {
         list = sqlSession.selectList("myListTimeAuction",id);
      }catch(Exception e) {}
      return list;
   }
   public void deleteAuction(int a_code){ //내 경매품 취하
      try {
         sqlSession.delete("deleteAuction",a_code);
      }catch(Exception e) {}
   }
   /*============관리자용============*/
   public void successAuction(int a_code) { //경매 신청서 통과처리
      sqlSession.update("successAuction",a_code);
   }
   public void failAuction(int a_code) { //경매 신청서 불통과 처리
      sqlSession.delete("failAuction",a_code);
   }
   public List<AuctionDTO> readyListAuction(){ //경매 신청서 리스트
      List<AuctionDTO> list = sqlSession.selectList("readyListAuction");
      return list;
   }
   public List<AuctionDTO> finishAuction(){//시간 끝난 경매품 리스트
      List<AuctionDTO> list = sqlSession.selectList("finishAuction");
      return list;
   }
   public void closeAuction(int a_code) {//경매 마감처리
      sqlSession.update("closeAuction",a_code);
   }
   public void closeBidder(int a_code) {// 입찰 정보 마감처리
		sqlSession.update("closeBidder", a_code);
	}
   public List<AuctionDTO> closeList(){ //마감된 경매품 리스트
      List<AuctionDTO> list = sqlSession.selectList("closeList");
      return list;
   }
   /*===========검색==========*/
   public List<AuctionDTO> searchAuction(String search,String searchString){
      String sql = "select * from auction where "+search+" like '%"+searchString+"%' order by a_code desc";
      java.util.HashMap<String, String> map = new java.util.HashMap();
      map.put("sql", sql);
      List<AuctionDTO> list = sqlSession.selectList("searchAuction",map);
      return list;
   }
   public List<Integer> searchTimeAuction(String search,String searchString){ //검색된 경매 리스트 마감시간 계산
      String sql = "select TIMESTAMPDIFF(second,now(),time) from auction where "+search+" like '%"+searchString+"%' order by a_code desc";
      java.util.HashMap<String, String> map = new java.util.HashMap();
      map.put("sql", sql);
      List<Integer> list = sqlSession.selectList("searchTimeAuction",map);
      return list;
   }
}