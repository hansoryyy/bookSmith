package com.smith.book;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URISyntaxException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.smith.book.dto.BookDTO;
import com.smith.book.dto.FreeDTO;
import com.smith.book.dto.GenreDTO;
import com.smith.book.dto.MailDTO;
import com.smith.book.dto.MemberDTO;
import com.smith.book.dto.OrderDTO;
import com.smith.book.dto.PublisherDTO;
import com.smith.book.dto.SearchDTO;
import com.smith.book.dto.WriterDTO;
import com.smith.book.service.BoardMapper;
import com.smith.book.service.BookMapper;
import com.smith.book.service.MailMapper;
import com.smith.book.service.MemberMapper;
import com.smith.book.service.SaleMapper;



@Controller
public class AdminController {

   @Autowired
   private SaleMapper saleMapper;
   @Autowired
   private BoardMapper boardMapper;
   @Autowired
   private MemberMapper memberMapper;
   @Autowired
   private BookMapper bookMapper;
   @Autowired
   private MailMapper mailMapper;
   @Autowired
   private JavaMailSender mailSender;
   
   String now = new SimpleDateFormat("yyMMddHHmmss").format(new Date()); // 현재 시간
   
   // 로그인 폼
   @RequestMapping(value = "/login.admin", method = RequestMethod.GET)
   public String loginAdmin(HttpServletRequest req) {
      return "admin/login";
   }
   
   // 로그인 처리
   @RequestMapping(value = "/login.admin", method = RequestMethod.POST)
   public String loginAdminProcess(HttpServletRequest req, @RequestParam String id, String passwd)throws Exception {
      String url;
      HttpSession session = req.getSession();
      MemberDTO dto = memberMapper.loginMember(id, passwd);
      if(dto==null) {
         req.setAttribute("l_error", "error");
         url="admin/login";
         return url;
      }

      session.setAttribute("log", dto.getId()); // �����ҽ� ���� ����
      session.setAttribute("grade", dto.getGrade());
      url="redirect:main.admin";
      return url;
   }  
   
   // 관리자 메인
   @RequestMapping(value = "/main.admin")
   public ModelAndView main(HttpServletRequest req, RedirectAttributes rttr) {  
      ModelAndView mav = new ModelAndView();
      Boolean res = false;
      try {
         res = LoginCheck(req);
      } catch (Exception e) {
         System.err.println("LoginCheck�� �����߻�!!");
         e.printStackTrace();
      }
      if(res==false) {
         rttr.addFlashAttribute("msg", "loginError");
         mav.setViewName("redirect:login.admin");
         return mav;
      }else {
         boolean grade=false;
         try {
            grade = GradeCheck(req);
         } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
         if(grade==false) {
            rttr.addFlashAttribute("msg", "gradeError"); 
            mav.setViewName("redirect:login.admin");
            return mav;
         }
      mav.setViewName("admin/main");
      List<MemberDTO> m_list = memberMapper.mainListMember();
      mav.addObject("m_list", m_list);
      List<FreeDTO> c_list = boardMapper.mainListReview();
      mav.addObject("c_list", c_list);
      return mav;
      }
   }
   
   // 세션 체크
   public Boolean LoginCheck(HttpServletRequest req) throws Exception{ //�α��� �ߴ°�
      if(req.getSession().getAttribute("log")==null) {
         return false;
      }
      return true;
   }
   
   // 등급 체크
   public Boolean GradeCheck(HttpServletRequest req) throws Exception{
      if( (Integer)req.getSession().getAttribute("grade")<4) {
         return false;
      }
      return true;
   }
   
   // 관리자 로그아웃
   @RequestMapping(value = "/logout.admin")
   public String logoutAdmin(HttpServletRequest req) {
      HttpSession session = req.getSession();
      session.invalidate();
      return "redirect:login.admin";
   }
   

   // 회원 관리 목록
   @RequestMapping(value = "/managerList.admin")
   public String listMember(HttpServletRequest req) {
      int pageSize = 10;
      String num = req.getParameter("pageNum");
      if (num == null) {
         num = "1";
      }
      int currentPage = Integer.parseInt(num);
      int count = 0;
      count = memberMapper.getListMemberCount();

      int startRow = pageSize * currentPage - (pageSize - 1);
      int endRow = pageSize * currentPage;
      if (endRow > count)
         endRow = count;
      int number = count - (currentPage - 1) * pageSize;

      int pageBlock = 5;
      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
      int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
      int endPage = startPage + pageBlock - 1;
      if (endPage > pageCount) {
         endPage = pageCount;
      }
      List<MemberDTO> list = memberMapper.managerListMember(startRow-1, endRow);
      req.setAttribute("num", number);
      req.setAttribute("count", count);
      req.setAttribute("startPage", startPage);
      req.setAttribute("endPage", endPage);
      req.setAttribute("pageCount", pageCount);
      req.setAttribute("pageBlock", pageBlock);
      req.setAttribute("list", list);
      return "admin/member/list";
   }

   // 회원 삭제
   @RequestMapping(value="/deleteMember.admin") //ȸ�� ����
   public String deleteMember(HttpServletRequest req, @RequestParam int member_code, 
         RedirectAttributes rttr){
      int res = memberMapper.deleteMember(member_code);
      if(res>0) {
         rttr.addFlashAttribute("msg", "success");
         return "redirect:managerList.admin";
      }      
      rttr.addFlashAttribute("msg", "error");
      return "redirect:managerList.admin";
   }

   // 회원 등급 수정
   @RequestMapping(value="/updateGrade.admin") // ȸ�� ��� ����(����Ʈ����)
   public String updateMember(HttpServletRequest req,@ModelAttribute MemberDTO dto, 
         BindingResult result, RedirectAttributes rttr){
      int res = memberMapper.updateGrade(dto);
      if(res>0) {
         rttr.addFlashAttribute("msg", "updateSuccess");
         return "redirect:managerList.admin";      
      }
      rttr.addFlashAttribute("msg", "updateError");
      return "redirect:managerList.admin";
   }

   // 회원 검색
   @RequestMapping(value = "/searchMember.admin")
   public String searchMember(HttpServletRequest req, @RequestParam String search, String searchString) {
      List<MemberDTO> list = memberMapper.searchMember(search, searchString);
      req.setAttribute("list", list);
      return "admin/member/list";
   }
   
   // 회원 상세 수정 폼
   @RequestMapping(value = "/updateMember.admin")
   public String updateForm(HttpServletRequest req, @RequestParam int member_code) {
      if(member_code<0 || member_code==0) {
         return "managerList.admin";
      }else {
         MemberDTO dto = memberMapper.getMember(member_code);
         req.setAttribute("dto", dto);
         return "admin/member/updateForm";
      }
   }
   
   // 회원 상세 수정 처리
   @RequestMapping(value = "/updatePro.admin")
   public String updatePro(HttpServletRequest req,  @ModelAttribute MemberDTO dto, 
         RedirectAttributes rttr) {
      int res = memberMapper.updatePro(dto);
      if(res>0) {
         rttr.addFlashAttribute("msg", "updateSuccess");
         return "redirect:managerList.admin";
         
      }
      rttr.addFlashAttribute("msg", "updateError");
      return "redirect:managerList.admin";
   }


   // 도서 목록
   @RequestMapping(value="/list.adBook", method=RequestMethod.GET)
   public ModelAndView listADBook(HttpServletRequest req) {
      int pageSize = 10;
      String num = req.getParameter("pageNum");
      if (num == null) {
         num = "1";
      }
      int currentPage = Integer.parseInt(num);
      int count = 0;
      count = bookMapper.getBookCount();

      int startRow = pageSize * currentPage - (pageSize - 1);
      int endRow = pageSize * currentPage;
      if (endRow > count)
         endRow = count;
      int number = count - (currentPage - 1) * pageSize;

      int pageBlock = 5;
      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
      int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
      int endPage = startPage + pageBlock - 1;
      if (endPage > pageCount) {
         endPage = pageCount;
      }

      ModelAndView mav = new ModelAndView();
      List<SearchDTO> list = bookMapper.listBook(startRow-1, endRow);
      mav.addObject("list", list);
      req.setAttribute("num", number);
      req.setAttribute("count", count);
      req.setAttribute("startPage", startPage);
      req.setAttribute("endPage", endPage);
      req.setAttribute("pageCount", pageCount);
      req.setAttribute("pageBlock", pageBlock);
      req.setAttribute("list", list);
      mav.setViewName("/admin/book/book_list");
      return mav;
   }

   // 도서 등록 폼
   @RequestMapping(value="/insert.adBook", method=RequestMethod.GET)
   public ModelAndView writeADForm() {
      List<GenreDTO> glist = bookMapper.listGenre();
      List<WriterDTO> wlist = bookMapper.listWriter();
      List<PublisherDTO> plist = bookMapper.listPublisher();
      ModelAndView mav = new ModelAndView();
      mav.addObject("glist", glist);
      mav.addObject("wlist", wlist);
      mav.addObject("plist", plist);
      mav.setViewName("/admin/book/book");
      return mav;
   }

   // 도서 등록 처리
   @RequestMapping(value="/insert.adBook", method=RequestMethod.POST)
   public ModelAndView writePro(HttpServletRequest req, @ModelAttribute BookDTO dto) throws Exception{
      MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
      MultipartFile mf = mr.getFile("img");
      String filename = mf.getOriginalFilename();
      filename = now + filename;
      if (!(filename==null || filename.trim().equals(""))) { 
         HttpSession session = req.getSession();
         String upPath = session.getServletContext().getRealPath("/resources/files/book");
         File file = new File(upPath, filename);
         mf.transferTo(file);
         dto.setImg_name(filename);
         dto.setImg_size((int)file.length());
      }else {
         dto.setImg_name("");
         dto.setImg_size(0);
      }
      int res = bookMapper.insertBook(dto);
      return new ModelAndView("redirect:list.adBook");
   }
   
   // 도서 수정
   @RequestMapping(value="/updateBook.adBook", method=RequestMethod.POST)
   public String updateBook(@RequestParam int qty, @RequestParam int price, @RequestParam int book_code) {
      SearchDTO dto = new SearchDTO();
      dto.setBook_code(book_code);
      dto.setQty(qty);
      dto.setPrice(price);
      int res = bookMapper.updateBook(dto);
      return "redirect:list.adBook";
   }
   
   // 도서 삭제
   @RequestMapping(value="/deleteBook.adBook")
   public String deleteBook(@RequestParam int book_code, RedirectAttributes rttr) {
      int res = bookMapper.deleteBook(book_code);
      System.out.println("2.AdminController res�� :" +  res );
      if(res == 0) {
         System.out.println("3.if(res==0) �� ����");
         rttr.addFlashAttribute("msg", "sale");
         return "redirect:list.adBook";
      }
      return "redirect:list.adBook";
   }
   
   // 도서 검색
   @RequestMapping(value = "/searchBook.adBook")
   public String searchBook(HttpServletRequest req, @RequestParam String search, @RequestParam String searchString) {
      List<BookDTO> list = bookMapper.searchBook(search, searchString);
         req.setAttribute("list", list);
         return "admin/book/book_list";
   }
   
   // 분류 선택
   @RequestMapping(value = "/selectGenre.adGenre", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
   @ResponseBody
   public String selectGenre(HttpServletRequest req, @RequestParam int bg_code)
         throws JsonProcessingException {
      System.out.println("bg_code="+bg_code);
      Map<String, Object> json = new HashMap<String, Object>();
      ObjectMapper mapper = new ObjectMapper();
      List<GenreDTO> list = bookMapper.listLittle(bg_code);
      json.put("s_glist", list);
      String str = mapper.writeValueAsString(json);
      return str;      
   }       

   // 분류 목록
   @RequestMapping(value="/list.adGenre")
   public ModelAndView listGenre() {
      List<GenreDTO> blist = bookMapper.listBig();

      ModelAndView mav = new ModelAndView();
      mav.addObject("b_list", blist);
      mav.setViewName("/admin/book/genre_list");
      return mav;
   }
   // 소분류 목록
   @RequestMapping(value="/littleList.adGenre")
   public ModelAndView listtleListGenre(HttpServletRequest req,@RequestParam int g_code) {
      List<GenreDTO> slist = bookMapper.listLittle(g_code);
      List<GenreDTO> blist = bookMapper.listBig();
      ModelAndView mav = new ModelAndView();
      mav.addObject("b_list",blist);
      mav.addObject("s_list", slist);
      req.setAttribute("g_code", g_code);
      mav.setViewName("/admin/book/genre_list");
      return mav;
   }

   // 대분류 등록
   @RequestMapping(value="/insert.adBig", method=RequestMethod.POST)
   public ModelAndView insertBigGenre(@RequestParam String name) throws IOException {
      int max_g_code = bookMapper.max_g_code();
      int new_g_code = max_g_code - (max_g_code%1000) + 1000;
      GenreDTO dto = new GenreDTO();
      dto.setG_code(new_g_code);
      dto.setName(name);
      int res =  bookMapper.insertGenre(dto);
      ModelAndView mav = new ModelAndView();
      mav.setViewName("redirect:list.adGenre");
      return mav;
   }

   // 소분류 등록
   @RequestMapping(value="/insert.adSmall", method=RequestMethod.POST)
   public ModelAndView insertSmallGenre(@RequestParam int g_code, @RequestParam String name) throws IOException {
      System.out.println("g_code="+g_code);
      int maxS_g_code = bookMapper.maxS_g_code(g_code);
      int newS_g_code = maxS_g_code + 1;
      GenreDTO dto = new GenreDTO();
      dto.setG_code(newS_g_code);
      dto.setName(name);
      int res =  bookMapper.insertGenre(dto);
      ModelAndView mav = new ModelAndView();
      mav.setViewName("redirect:littleList.adGenre?g_code="+g_code);
      return mav;
   }

   // 소분류 삭제
   @RequestMapping(value="/deleteLittle.adGenre", method=RequestMethod.GET)
   public String deleteGenre(@RequestParam int g_code, RedirectAttributes rttr) {
      int code = g_code/1000*1000;
      try {
         int res = bookMapper.deleteLittleGenre(g_code);
      }catch(Exception e) {
         rttr.addFlashAttribute("msg", "genre"); // �帣�� �Ҽӵ� å�� �־� ���� �� ���� �����ϴ�.
         return "redirect:list.adGenre";         
      }
      return "redirect:list.adGenre";
   }
   
   // 대분류 삭제
   @RequestMapping(value="/deleteBig.adGenre")
   public String deleteBigGenre(@RequestParam int g_code, RedirectAttributes rttr) {
      try {
         int res = bookMapper.deleteBigGenre(g_code);
      }catch(Exception e) {
         rttr.addFlashAttribute("msg", "genre"); // 
         return "redirect:list.adGenre";         
      }
      return "redirect:list.adGenre";
   }


   // 작가 목록
   @RequestMapping(value="/list.adWriter", method=RequestMethod.GET)
   public ModelAndView listWriter(HttpServletRequest req) {
      ModelAndView mav = new ModelAndView();
      int pageSize = 10;
      String num = req.getParameter("pageNum");
      if (num == null) {
         num = "1";
      }
      int currentPage = Integer.parseInt(num);
      int count = 0;
      count = bookMapper.getWriterCount();

      int startRow = pageSize * currentPage - (pageSize - 1);
      int endRow = pageSize * currentPage;
      if (endRow > count)
         endRow = count;
      int number = count - (currentPage - 1) * pageSize;

      int pageBlock = 5;
      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
      int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
      int endPage = startPage + pageBlock - 1;
      if (endPage > pageCount) {
         endPage = pageCount;
      }

      List<WriterDTO> list = bookMapper.listWriters(startRow-1, endRow);
      mav.addObject("wlist", list);
      req.setAttribute("num", number);
      req.setAttribute("count", count);
      req.setAttribute("startPage", startPage);
      req.setAttribute("endPage", endPage);
      req.setAttribute("pageCount", pageCount);
      req.setAttribute("pageBlock", pageBlock);
      req.setAttribute("list", list);
      mav.setViewName("/admin/book/write_list");
      return mav;
   }
   
   // 작가 등록 폼
   @RequestMapping(value="/insertForm.adWriter")
   public String insertFormWriter() {
      return "/admin/book/writer";
   }
   
   // 작가 등록
   @RequestMapping(value="/insert.adWriter", method=RequestMethod.POST)
   public String insertWriter(HttpServletRequest req, WriterDTO dto) throws IOException {
      int res =  bookMapper.insertWriter(dto);
      ModelAndView mav = new ModelAndView();
      return "redirect:list.adWriter";
   }      

   // 작가 삭제
   @RequestMapping(value="/deleteWriter.adWriter", method=RequestMethod.GET)
   public String deleteWriter(@RequestParam int w_code) {
      int res = bookMapper.deleteWriter(w_code);
      return "redirect:list.adWriter";
   }

   // 출판사 목록
   @RequestMapping(value="/list.adPublisher", method=RequestMethod.GET)
   public ModelAndView listPublisher(HttpServletRequest req) {
      ModelAndView mav = new ModelAndView();
      int pageSize = 10;
      String num = req.getParameter("pageNum");
      if (num == null) {
         num = "1";
      }
      int currentPage = Integer.parseInt(num);
      int count = 0;
      count = bookMapper.getPublisherCount();

      int startRow = pageSize * currentPage - (pageSize - 1);
      int endRow = pageSize * currentPage;
      if (endRow > count)
         endRow = count;
      int number = count - (currentPage - 1) * pageSize;

      int pageBlock = 5;
      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
      int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
      int endPage = startPage + pageBlock - 1;
      if (endPage > pageCount) {
         endPage = pageCount;
      }

      List<PublisherDTO> list =bookMapper.listPublishers(startRow-1, endRow);
      mav.addObject("plist", list);
      req.setAttribute("num", number);
      req.setAttribute("count", count);
      req.setAttribute("startPage", startPage);
      req.setAttribute("endPage", endPage);
      req.setAttribute("pageCount", pageCount);
      req.setAttribute("pageBlock", pageBlock);
      req.setAttribute("list", list);
      mav.setViewName("/admin/book/publisher_list");
      return mav;
   }
   
   // 출판사 등록 폼
   @RequestMapping(value="/insertForm.adPublisher", method=RequestMethod.GET)
   public String insertFormPublisher() {
      return "/admin/book/publisher";
   }
   
   // 출판사 등록
   @RequestMapping(value="/insert.adPublisher", method=RequestMethod.POST)
   public ModelAndView insertPublisher(HttpServletRequest req, PublisherDTO dto) throws IOException {
      int res =  bookMapper.insertPublisher(dto);
      ModelAndView mav = new ModelAndView();
      mav.setViewName("redirect:list.adPublisher");
      return mav;
   }

   // 출판사 삭제
   @RequestMapping(value="/deletePublisher.adPublisher", method=RequestMethod.GET)
   public String deletePublisher(@RequestParam int p_code) {
      int res = bookMapper.deletePublisher(p_code);
      return "redirect:list.adPublisher";
   }

   // 도서 등록(작가 선택)
   @RequestMapping(value = "/writerCallBack.adWriter")
   public ModelAndView writerCallBack(@RequestParam String w_name, HttpServletRequest req) {
      List<WriterDTO> list = null;
      System.out.println(w_name);
      list = bookMapper.writerCallback(w_name);
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/admin/book/writerCallBack");
      mav.addObject("wlist", list);
      return mav;
   }
   
   // 도서 등록(출판사 선택)
   @RequestMapping(value = "/publisherCallBack.adPublisher")
   public ModelAndView publisherCallBack(@RequestParam String p_name, HttpServletRequest req) {
      List<PublisherDTO> list = null;
      System.out.println(p_name);
      list = bookMapper.publisherCallBack(p_name);
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/admin/book/publisherCallBack");
      mav.addObject("plist", list);
      return mav;
   }

   // 작가 검색
   @RequestMapping(value="/searchWriter")
   public ModelAndView searchWriter(@RequestParam String searchType, 
         @RequestParam String value) {
      ModelAndView mav = new ModelAndView();
      if(searchType==null||value==null) {
         mav.setViewName("redirect:list.adWriter");
         return mav;
      }else {
         List<WriterDTO> list = bookMapper.writerSearch(searchType, value);
         mav.addObject("wlist", list);
         mav.setViewName("/admin/book/write_list");
         return mav;
      }
   }
   
   // 출판사 검색
   @RequestMapping(value="/searchPublisher")
   public ModelAndView searchPublisher(@RequestParam String searchType, 
         @RequestParam String value) {
      ModelAndView mav = new ModelAndView();
      if(searchType==null||value==null) {
         mav.setViewName("redirect:list.adPublisher");
         return mav;
      }else {
         List<PublisherDTO> list = bookMapper.publisherSearch(searchType, value);
         mav.addObject("plist", list);
         mav.setViewName("/admin/book/publisher_list");
         return mav;
      }
   }

   // 대분류 목록
   @RequestMapping(value="/listBig.go", method=RequestMethod.GET)
   public String listBigGenreBook(HttpServletRequest req, @RequestParam int g_code) {
      List<SearchDTO> n_list = bookMapper.listNewBigGenreBook(g_code);
      req.setAttribute("new_list", n_list);
      return "/shop/list";
   }

   // �ֹ� ����
   @RequestMapping(value="/orderList.admin")
   public String orderList(HttpServletRequest req) {
      int pageSize = 10;
      String num = req.getParameter("pageNum");
      if (num == null) {
         num = "1";
      }
      int currentPage = Integer.parseInt(num);
      int count = 0;
      count = saleMapper.orderTotalPage();

      int startRow = pageSize * currentPage - (pageSize - 1);
      int endRow = pageSize * currentPage;
      if (endRow > count)
         endRow = count;
      int number = count - (currentPage - 1) * pageSize;

      int pageBlock = 3;
      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
      int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
      int endPage = startPage + pageBlock - 1;
      if (endPage > pageCount) {
         endPage = pageCount;
      }
      List<OrderDTO> list = saleMapper.orderList(startRow-1, endRow);
      req.setAttribute("num", number);
      req.setAttribute("count", count);
      req.setAttribute("startPage", startPage);
      req.setAttribute("endPage", endPage);
      req.setAttribute("pageCount", pageCount);
      req.setAttribute("pageBlock", pageBlock);
      req.setAttribute("list", list);
      return "admin/shop/orderList";
   }

   // �ֹ� ���� �˻�
   @RequestMapping(value="/orderSearch.admin")
   public ModelAndView orderSearch(HttpServletRequest req, @RequestParam String search, 
         String searchString) throws Exception {
      List<OrderDTO> list = saleMapper.orderSearch(search, searchString);
      ModelAndView mav = new ModelAndView();
      mav.setViewName("admin/shop/orderList");
      mav.addObject("list", list);
      return mav;
   }

   // �ֹ� ���� ����
   @RequestMapping(value="/orderStatus.admin")
   public ModelAndView orderStatus(HttpServletRequest req, @RequestParam int order_code) {
      OrderDTO dto = saleMapper.orderStatus(order_code);
      List<OrderDTO> list = saleMapper.orderProduct(order_code);
      ModelAndView mav = new ModelAndView();
      mav.setViewName("admin/shop/orderStatus");
      mav.addObject("dto", dto);
      mav.addObject("list", list);
      return mav;
   }

   // �ֹ� ���� ����(�ֹ� ��ǰ ��� ����)
   @RequestMapping(value="/orderProductModify.admin")
   public ModelAndView orderProductModify(HttpServletRequest req, @RequestParam int order_code, int order_item_code, 
         String status, int price, int qty) {      
      if(status == "���" || status == "��ǰ" ) {
         saleMapper.orderProductDeduction(order_code, order_item_code, status, price, qty);
      }
      saleMapper.orderProductModify(order_code, order_item_code, status, price, qty);
      ModelAndView mav = new ModelAndView();
      mav.setViewName("redirect:orderStatus.admin?order_code="+order_code);
      return mav;
   }

   // ���� �� ���� ����
   @RequestMapping(value="/paymentStatusModify.admin", method=RequestMethod.POST)
   public @ResponseBody int paymentStatusModify(@ModelAttribute OrderDTO dto) {
      int res = saleMapper.paymentStatusModify(dto);
      return res;
   }

   // �ֹ� ����� ����
   @RequestMapping(value="/orderAddrModify.admin", method=RequestMethod.POST)
   public @ResponseBody int orderAddrModify(@ModelAttribute OrderDTO dto) {
      saleMapper.orderAddrModify(dto);
      return 0;
   }   

   
   	/*메일관련*/
   @RequestMapping(value="mailList.admin")
   public String mailList(HttpServletRequest req) throws Exception{
      int pageSize = 10;
      String num = req.getParameter("pageNum");
      if (num == null) {
         num = "1";
      }
      int currentPage = Integer.parseInt(num);
      int count = 0;
      count = mailMapper.getTotalPage();

      int startRow = pageSize * currentPage - (pageSize - 1);
      int endRow = pageSize * currentPage;
      if (endRow > count)
         endRow = count;
      int number = count - (currentPage - 1) * pageSize;

      int pageBlock = 5;
      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
      int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
      int endPage = startPage + pageBlock - 1;
      if (endPage > pageCount) {
         endPage = pageCount;
      }
      List<MailDTO> list = mailMapper.mailUserList(startRow-1, endRow);
      req.setAttribute("num", number);
      req.setAttribute("count", count);
      req.setAttribute("startPage", startPage);
      req.setAttribute("endPage", endPage);
      req.setAttribute("pageCount", pageCount);
      req.setAttribute("pageBlock", pageBlock);
      req.setAttribute("list", list);
      return "admin/member/mailList";      
   }
   
   @RequestMapping(value="/deleteMail.admin")
   public String deleteMail(HttpServletRequest req, @RequestParam int mailcode) {
      int res = mailMapper.deleteMail(mailcode);
      return "redirect:mailList.admin";
   }
   
   @RequestMapping(value="/createMail.admin", method = RequestMethod.GET)
   public String createMail() {
      return "admin/member/mailForm";
   }
   
   @RequestMapping(value="/createMail.admin", method = RequestMethod.POST)
   public String insertMail(HttpServletRequest req, @ModelAttribute MailDTO dto){
      int res = mailMapper.createMail(dto);
      return "redirect:mailList.admin";
   }
   
   @RequestMapping(value="/updateMail.admin", method = RequestMethod.GET)
   public String updateMailForm(HttpServletRequest req, @RequestParam int mailcode) {
      MailDTO dto = mailMapper.getList(mailcode);
      req.setAttribute("dto", dto);
      return "admin/member/mailUpdate";
   }
   
   @RequestMapping(value="/updateMail.admin", method = RequestMethod.POST)
   public String updateMail(HttpServletRequest req, @ModelAttribute MailDTO dto){
      int res = mailMapper.updateMail(dto);
      return "redirect:mailList.admin";
   }   
   
   @RequestMapping(value="/mailSend.admin", method = RequestMethod.POST)
   public String sendMailControll(@RequestParam int mailcode) throws FileNotFoundException, URISyntaxException {      
       try{
          String mode = "y";
          List<MemberDTO> list = mailMapper.mailReceive(mode);
          MailDTO dto = mailMapper.getList(mailcode);
          for(int i=0; i<list.size(); i++) {          
             String from = "sthox18@gmail.com";
             MimeMessage message = mailSender.createMimeMessage();
             message.setFrom(new InternetAddress(from, "MoonGo 관리자")); // InternetAddress(메일 주소, 보낸이)
             message.addRecipient(RecipientType.TO, new InternetAddress(list.get(i).getEmail())); // 메일 받는 사람들의 주소
             message.setSubject(dto.getSubject(), "UTF-8"); // 메일 제목
             message.setText(dto.getContent(), "UTF-8", "html"); // 메일 내용
             mailSender.send(message); // 메일 보내기
          }
       }catch(Exception e){
        e.printStackTrace();
        return "redirect:mailList.admin";
       }
       return "redirect:mailList.admin";
   }
   
// 매출 현황
   @RequestMapping(value = "/saleList.admin")
   public String sale(HttpServletRequest req) throws Exception {
      return "admin/shop/sale";
   }

   // 일일 매출
   @RequestMapping(value = "/saleToday.admin")
   public ModelAndView saleToday(HttpServletRequest req, @RequestParam String date) {
      List<OrderDTO> list = saleMapper.saleToday(date);
      ModelAndView mav = new ModelAndView();
      mav.setViewName("admin/shop/saleToday");
      mav.addObject("date", date);
      mav.addObject("list", list);
      return mav;
   }

   // 일간 매출
   @RequestMapping(value = "/saleDate.admin")
   public ModelAndView saleDate(HttpServletRequest req, @RequestParam String fr_date, String to_date) {
      List<OrderDTO> list = saleMapper.saleDate(fr_date, to_date);
      ModelAndView mav = new ModelAndView();
      mav.setViewName("admin/shop/saleDate");
      mav.addObject("fr_date", fr_date);
      mav.addObject("fr_date", to_date);
      mav.addObject("list", list);
      return mav;
   }

   // 월간 매출
   @RequestMapping(value = "/saleMonth.admin")
   public ModelAndView saleMonth(HttpServletRequest req, @RequestParam String fr_month, String to_month) {
      List<OrderDTO> list = saleMapper.saleMonth(fr_month, to_month);
      ModelAndView mav = new ModelAndView();
      mav.setViewName("admin/shop/saleMonth");
      mav.addObject("fr_date", fr_month);
      mav.addObject("fr_date", to_month);
      mav.addObject("list", list);
      return mav;
   }

   // 연간 매출
   @RequestMapping(value = "/saleYear.admin")
   public ModelAndView saleYear(HttpServletRequest req, @RequestParam String fr_year, String to_year) {
      List<OrderDTO> list = saleMapper.saleYear(fr_year, to_year);
      ModelAndView mav = new ModelAndView();
      mav.setViewName("admin/shop/saleYear");
      mav.addObject("fr_year", fr_year);
      mav.addObject("fr_year", to_year);
      mav.addObject("list", list);
      return mav;
   }
 
   // 상품 판매 순위
   @RequestMapping(value = "/itemSellRank.admin")
   public ModelAndView itemSellRank() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("admin/shop/itemSellRank");
      List<GenreDTO> gb = bookMapper.listBig();
      mav.addObject("gb", gb);
      return mav;
   }

   // 상품 판매 순위 검색
   @RequestMapping(value = "/itemRankFind.admin")
   public ModelAndView itemRankFind(HttpServletRequest req, @RequestParam String g_code, String fr_date, String to_date) {
      String type = req.getParameter("type");
      
      ModelAndView mav = new ModelAndView();
      mav.setViewName("admin/shop/itemSellRank");
      List<GenreDTO> gb = bookMapper.listBig();
      mav.addObject("gb", gb);
      List<BookDTO> list=null;
      list = saleMapper.itemRankFind(type,g_code, fr_date, to_date);
      
      mav.addObject("list", list);
      return mav;
   }
   
   
  
}