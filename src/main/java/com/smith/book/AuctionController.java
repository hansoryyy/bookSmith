package com.smith.book;

import java.io.File;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.NestedServletException;

import com.smith.book.dto.AuctionDTO;
import com.smith.book.dto.BidderDTO;
import com.smith.book.dto.MemberDTO;
import com.smith.book.dto.MemberDTO;
import com.smith.book.service.AuctionMapper;

@Controller
public class AuctionController {
   @Autowired
   private AuctionMapper auctionMapper;
   
   
   /*-----------------고객용-------------------*/
   @RequestMapping(value="/list.auction") //경매 리스트
   public String listAuction(HttpServletRequest req) {
      List<AuctionDTO> list = auctionMapper.listAuction();
      List<Integer> list1 = auctionMapper.listTimeAuction();//寃쎈ℓ留덇컧�떆媛�
      for(int i=0;i<list.size();++i) {
         list.get(i).setLeavetime((Integer)list1.get(i));
      }
      req.setAttribute("list", list);
      return "auction/list";
   }
   @RequestMapping(value="/content.auction") //리스트 상세보기
   public String contentAuction(HttpServletRequest req, @RequestParam int a_code) {
      AuctionDTO dto = auctionMapper.getAuction(a_code);
      int leavetime = auctionMapper.getLeavetime(a_code);
      dto.setLeavetime(leavetime);
      
      String highest = "";
      if(leavetime <=0) {
         highest = auctionMapper.highest(a_code);
      }
      req.setAttribute("highest", highest);
      req.setAttribute("dto", dto);
      
      return "auction/content";
   } 
   @RequestMapping(value="/bidList.auction") //리스트에서 입찰 처리
   public ModelAndView bidListAuction(HttpServletRequest req,@RequestParam int money,
                  @RequestParam int a_code,@RequestParam int r_money) throws Exception {
	   System.out.println("돈 :"+money);
      ModelAndView mav = new ModelAndView();
      HttpSession session = req.getSession();
      MemberDTO l_dto = (MemberDTO)session.getAttribute("userLoginInfo");
      mav.setViewName("message");
      if(l_dto==null) {
         mav.addObject("msg","로그인 해주세요");
         mav.addObject("url","login.member");
         return mav;
      }
      
      if(money<=r_money) {
         mav.addObject("msg","현재 최고액보다 높은 금액으로 입찰해주세요");
         mav.addObject("url","list.auction");
         return mav;
      }
      if((money%100)>0) {
         mav.addObject("msg","100원 단위로 입찰해 주세요.");
         mav.addObject("url","list.auction");
         return mav;
      }
      AuctionDTO a_dto = auctionMapper.getAuction(a_code);
      BidderDTO dto = new BidderDTO();
      dto.setMember_id(a_dto.getMember_id());
      dto.setMoney(money);
      dto.setName(a_dto.getName());
      dto.setTime(a_dto.getTime());
      dto.setA_code(a_code);
      dto.setBid_money(money);
      dto.setId(l_dto.getId());
      int res = auctionMapper.bidCheck(dto);
      if(res==0) {
         int res1=auctionMapper.bidAuction(dto);
         if(res1>0) {
            mav.addObject("msg","정상 입찰 처리 되었습니다.");
            mav.addObject("url","list.auction");
            auctionMapper.bidding(a_code,money);
            auctionMapper.moneyBidder(a_code,money);
         }else {
            mav.addObject("msg","입찰 도중 문제가 발생하였습니다. 관리자에게 문의해주세요");
            mav.addObject("url","list.auction");
         }   
      }else {
         int res1 = auctionMapper.bidUpdate(dto);
         if(res1>0) {
            mav.addObject("msg","정상 입찰 처리 되었습니다.");
            mav.addObject("url","list.auction");
            auctionMapper.bidding(a_code,money);
         }else {
            mav.addObject("msg","입찰 도중 문제가 발생하였습니다. 관리자에게 문의해주세요");
            mav.addObject("url","list.auction");
         }
      } 
      
      
      return mav;
      
   }
   @RequestMapping(value="/myList.auction") // 내 입찰 리스트 이동
   public ModelAndView myListAuction(HttpServletRequest req) {
      ModelAndView mav = new ModelAndView();
      HttpSession session = req.getSession();
      MemberDTO dto = (MemberDTO)session.getAttribute("userLoginInfo");
      if(dto==null) {
         mav.setViewName("message");
         mav.addObject("msg","로그인을 해주세요.");
         mav.addObject("url","login.member");
         return mav;
      }
      mav.setViewName("auction/myList");
      List<BidderDTO> list = auctionMapper.myListBidder(dto.getId());
      List<Integer> list1 = auctionMapper.myListTimeBidder(dto.getId());//寃쎈ℓ留덇컧�떆媛�
      for(int i=0;i<list.size();++i) {
         list.get(i).setLeavetime((Integer)list1.get(i));
      }
      req.setAttribute("list", list);
      return mav;
   }
   @RequestMapping(value="/bidMyList.auction") // 내 입찰 리스트에서 입찰 처리
   public ModelAndView bidMyListAuction(HttpServletRequest req,@RequestParam int money,
                  @RequestParam int a_code,@RequestParam int r_money) throws Exception {
      ModelAndView mav = new ModelAndView();
      HttpSession session = req.getSession();
      MemberDTO l_dto = (MemberDTO)session.getAttribute("userLoginInfo");
      mav.setViewName("message");
      if(l_dto==null) {
         mav.addObject("msg","로그인을 해주세요.");
         mav.addObject("url","login.member");
         return mav;
      }
      
      if(money<=r_money) {
         mav.addObject("msg","현재 최고액보다 높은 금액으로 입찰해주세요.");
         mav.addObject("url","myList.auction");
         return mav;
      }
      if((money%100)>0) {
         mav.addObject("msg","100원 단위로 입찰해주세요.");
         mav.addObject("url","myList.auction");
         return mav;
      }
      AuctionDTO a_dto = auctionMapper.getAuction(a_code);
      BidderDTO dto = new BidderDTO();
      dto.setMember_id(a_dto.getMember_id());
      dto.setMoney(money);
      dto.setName(a_dto.getName());
      dto.setTime(a_dto.getTime());
      dto.setA_code(a_code);
      dto.setBid_money(money);
      dto.setId(l_dto.getId());
      int res = auctionMapper.bidCheck(dto);
      if(res==0) {
         int res1=auctionMapper.bidAuction(dto);
         if(res1>0) {
            mav.addObject("msg","정상 입찰 처리되었습니다.");
            mav.addObject("url","list.auction");
            auctionMapper.bidding(a_code,money);
            auctionMapper.moneyBidder(a_code,money);
         }else {
            mav.addObject("msg","입찰 도중 문제가 발생하였습니다. 관리자에게 문의해주세요");
            mav.addObject("url","list.auction");
         }   
      }else {
         int res1 = auctionMapper.bidUpdate(dto);
         if(res1>0) {
            mav.addObject("msg","정상 입찰 처리되었습니다.");
            mav.addObject("url","myList.auction");
            auctionMapper.bidding(a_code,money);
            auctionMapper.moneyBidder(a_code,money);
         }else {
            mav.addObject("msg","입찰 도중 문제가 발생하였습니다. 관리자에게 문의해주세요");
            mav.addObject("url","myList.auction");
         }
      } 
      
      
      return mav;
      
   }
   
   @RequestMapping(value="/bring.auction",method = RequestMethod.GET)
   public ModelAndView bringForm(HttpServletRequest req) {//경매신청서 폼
      HttpSession session = req.getSession();
      ModelAndView mav= new ModelAndView();
      
      MemberDTO dto = (MemberDTO) session.getAttribute("userLoginInfo");
      if(dto==null || dto.getId()=="") {
         mav.setViewName("message");
         mav.addObject("msg","로그인을 해주세요.");
         mav.addObject("url","login.member");
         return mav;
      }
      mav.setViewName("auction/bringForm");
      return mav;
   }
   @RequestMapping(value="/bring.auction",method = RequestMethod.POST) //경매 신청서 등록 처리
   public ModelAndView bringPro(HttpServletRequest req,@ModelAttribute AuctionDTO dto,BindingResult result) throws Exception{
      MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
      MultipartFile mf = mr.getFile("filename");
      ModelAndView mav = new ModelAndView();
      mav.setViewName("message");
      String filename=null;
      int filesize = 0;
      HttpSession session = req.getSession();
      filename = mf.getOriginalFilename();
      if (!(filename==null || filename.trim().equals(""))) {
         String upPath = session.getServletContext().getRealPath("/resources/files/auction"); 
         File file = new File(upPath, filename);
         mf.transferTo(file);
         filesize = (int) file.length();
      }
      MemberDTO m_dto = (MemberDTO) session.getAttribute("userLoginInfo");
      String time = req.getParameter("date")+" "+req.getParameter("time")+":00:00";
      dto.setTime(time);
      dto.setMember_id(m_dto.getId());
      dto.setFilename(filename);
      dto.setFilesize(filesize);
      auctionMapper.bringAuction(dto);
      mav.addObject("msg","경매품 신청 성공!!");
      mav.addObject("url","list.auction");
      return mav;
   }
   
   @RequestMapping(value="/deleteBidder.auction")//입찰 신청 취하
   public String deleteBidder(@RequestParam int bidder_code) {
      auctionMapper.deleteBidder(bidder_code);
      return "redirect:myList.auction";      
   }
   @RequestMapping(value="/bid.auction") //상세보기에서 입찰 처리
   public ModelAndView bidAuction(HttpServletRequest req,@RequestParam int money,
                  @RequestParam int a_code,@RequestParam int r_money) throws Exception {
      ModelAndView mav = new ModelAndView();
      HttpSession session = req.getSession();
      MemberDTO l_dto = (MemberDTO)session.getAttribute("userLoginInfo");
      mav.setViewName("message");
      if(l_dto==null) {
         mav.addObject("msg","로그인을 해주세요.");
         mav.addObject("url","login.member");
         return mav;
      }
      AuctionDTO a_dto = auctionMapper.getAuction(a_code);
      BidderDTO dto = new BidderDTO();
      dto.setMember_id(a_dto.getMember_id());
      dto.setMoney(money);
      dto.setName(a_dto.getName());
      dto.setTime(a_dto.getTime());
      dto.setA_code(a_code);
      dto.setBid_money(money);
      dto.setId(l_dto.getId());
      int res = auctionMapper.bidCheck(dto);
      if(res==0) {
         int res1=auctionMapper.bidAuction(dto);
         if(res1>0) {
            mav.addObject("msg","정상 입찰 처리 되었습니다.");
            mav.addObject("url","list.auction");
            auctionMapper.bidding(a_code,money);
            auctionMapper.moneyBidder(a_code,money);
         }else {
            mav.addObject("msg","입찰 도중 문제가 발생하였습니다. 관리자에게 문의해주세요");
            mav.addObject("url","list.auction");
         }   
      }else {
         int res1 = auctionMapper.bidUpdate(dto);
         if(res1>0) {
            mav.addObject("msg","정상 입찰 처리 되었습니다.");
            mav.addObject("url","list.auction");
            auctionMapper.bidding(a_code,money);
         }else {
            mav.addObject("msg","입찰 도중 문제가 발생하였습니다. 관리자에게 문의해주세요");
            mav.addObject("url","list.auction");
         }
      } 
      
      
      return mav;
      
   }
   
   @RequestMapping(value="/my.auction") // 내 경매품 리스트 이동
   public ModelAndView myAuction(HttpServletRequest req)throws Exception {
      ModelAndView mav = new ModelAndView();
      HttpSession session = req.getSession();
      MemberDTO dto = (MemberDTO)session.getAttribute("userLoginInfo");
      if(dto==null) {
         mav.setViewName("message");
         mav.addObject("msg","로그인을 해주세요.");
         mav.addObject("url","login.member");
         return mav;
      }
      mav.setViewName("auction/my");
      List<AuctionDTO> list = null;
      list = auctionMapper.myListAuction(dto.getId());
      if(list==null) {
         return mav;
      }
      List<Integer> list1 = auctionMapper.myListTimeAuction(dto.getId());//寃쎈ℓ留덇컧�떆媛�
      for(int i=0;i<list.size();++i) {
         list.get(i).setLeavetime((Integer)list1.get(i));
      }
      req.setAttribute("list", list);
      return mav;
   }
   @RequestMapping(value="/delete.auction")//내 경매품 취하하기
   public ModelAndView deleteAuction(@RequestParam int a_code) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("auction/my");
      try {
         auctionMapper.deleteAuction(a_code);
      }catch(Exception e) {
         mav.setViewName("message");
         mav.addObject("msg","정상 삭제 처리 되었습니다.");
         mav.addObject("url","my.auction");
         return mav;
      }
      return mav;
   }
   
   
   
   
   
   /*------------------------관리자 경매------------------------*/
   @RequestMapping(value="/readyContent.auction") //신청서 상세보기
   public String readyContentAuction(HttpServletRequest req,@RequestParam int a_code) {
      AuctionDTO dto = auctionMapper.getAuction(a_code);
      int leavetime = auctionMapper.getLeavetime(a_code);
      dto.setLeavetime(leavetime);
      req.setAttribute("dto", dto);
      return "admin/auction/readyContent";
   }
   @RequestMapping(value="/readyList.auction") // 신청서 리스트 보기
   public String readyListAuction(HttpServletRequest req) {
      List<AuctionDTO> list = auctionMapper.readyListAuction();
      req.setAttribute("list", list);
      return "admin/auction/readyList";
   }
   @RequestMapping(value="/success.auction") // 신청서 등록 처리
   public String successAuction(@RequestParam int a_code) {
      auctionMapper.successAuction(a_code);
      return "redirect:readyList.auction";
   }
   @RequestMapping(value="/fail.auction") //  신청서 취하 처리
   public String failAuction(@RequestParam int a_code) {
      auctionMapper.failAuction(a_code);
      return "redirect:readyList.auction";
   }
   @RequestMapping(value="/finish.auction")//시간 끝난 경매품 리스트
   public String finishAuction(HttpServletRequest req) {
      List<AuctionDTO> list = auctionMapper.finishAuction();
      req.setAttribute("list", list);
      return "admin/auction/finish";
   }
   @RequestMapping(value="/close.auction")//경매 마감처리
   public String closeAuction(@RequestParam int a_code) {
      auctionMapper.closeAuction(a_code);
      auctionMapper.closeBidder(a_code);
      return "redirect:finish.auction";
   }
   @RequestMapping(value="/closeList.auction")
   public String closeList(HttpServletRequest req) {//마감된 경매품 리스트
      List<AuctionDTO> list = auctionMapper.closeList();
      req.setAttribute("list", list);
      return "admin/auction/close";
   }
   
   @RequestMapping(value="/content.adAuction") //리스트 상세보기
   public String contentAdAuction(HttpServletRequest req, @RequestParam int a_code) {
      AuctionDTO dto = auctionMapper.getAuction(a_code);
      int leavetime = auctionMapper.getLeavetime(a_code);
      dto.setLeavetime(leavetime);
      String highest = "";
      if(leavetime <=0) {
         highest = auctionMapper.highest(a_code);
      }
      req.setAttribute("highest", highest);
      req.setAttribute("dto", dto);
      
      return "admin/auction/content";
   } 
   
   /*======================검색======================*/
   @RequestMapping(value="/search.auction")
   public String searchAuction(HttpServletRequest req, @RequestParam String search,
                     @RequestParam String searchString,@RequestParam String juso) {//寃��깋
      List<AuctionDTO> list = auctionMapper.searchAuction(search,searchString);
      List<Integer> list1 = auctionMapper.searchTimeAuction(search,searchString);//寃쎈ℓ留덇컧�떆媛�
      for(int i=0;i<list.size();++i) {
         list.get(i).setLeavetime((Integer)list1.get(i));
      }
      req.setAttribute("list", list);
      return juso;
   }
}
