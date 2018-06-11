package com.smith.book;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import com.smith.book.dto.BoardDTO;
import com.smith.book.dto.BookDTO;
import com.smith.book.dto.CommentDTO;
import com.smith.book.dto.FreeDTO;
import com.smith.book.dto.NoticeDTO;
import com.smith.book.dto.QnaDTO;
import com.smith.book.service.BoardMapper;
import com.smith.book.service.BookMapper;


@Controller
public class BoardController {
   @Autowired
   private BoardMapper boardMapper;
   @Autowired
   private BookMapper bookMapper;
   String now = new SimpleDateFormat("yyMMddHHmmss").format(new Date()); // 현재 시간
   

   @RequestMapping(value = "/list.board")
   public String listBoard(HttpServletRequest req) {
      int pageSize = 5;
      String num = req.getParameter("pageNum");
      if (num == null) {
         num = "1";
      }
      int currentPage = Integer.parseInt(num);
      int count = 0;
      count = boardMapper.getCount();

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
      List<BoardDTO> list = boardMapper.listBoard();
      
      req.setAttribute("num", number);
      req.setAttribute("count", count);
      req.setAttribute("startPage", startPage);
      req.setAttribute("endPage", endPage);
      req.setAttribute("pageCount", pageCount);
      req.setAttribute("pageBlock", pageBlock);
      req.setAttribute("list", list);
      return "admin/review/list";
   }

   @RequestMapping(value = "/search.board")
   public String searchBoard(HttpServletRequest req, @RequestParam String search, String searchString) {
      List<BoardDTO> list = boardMapper.searchBoard(search, searchString);
      req.setAttribute("list", list);
      return "admin/board/list";
   }

   @RequestMapping(value = "/write.board", method = RequestMethod.GET)
   public String writeForm() {
      return "admin/board/writeForm";
   }

   @RequestMapping(value = "/write.board", method = RequestMethod.POST)
   public ModelAndView writeUpdate(HttpServletRequest req, @ModelAttribute BoardDTO dto, BindingResult result) {
      MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
      MultipartFile mf = mr.getFile("filename");
      String filename = null;
      int filesize = 0;
      filename = mf.getOriginalFilename();
      HttpSession session = req.getSession();
      String upPath = session.getServletContext().getRealPath("/files");

      if (filename != null) {
         File file = new File(upPath, filename);
         // mf.transferTo(file); // ���� ����

         if (file != null) {
            filesize = (int) file.length();
         }
      }
      dto.setFilename(filename);
      dto.setFilesize(filesize);
      System.out.println("log="+req.getSession().getAttribute("log"));
      dto.setMember_id((String)req.getSession().getAttribute("log"));
      int res = boardMapper.insertBoard(dto);
      return new ModelAndView("redirect:list.board");
   }

   @RequestMapping(value = "/content.board")
   public String contentBoard(HttpServletRequest req, @RequestParam int board_code) throws ParseException {
      BoardDTO dto = boardMapper.getBoard(board_code, "content");
      
      HttpSession session = req.getSession();
      String upPath = session.getServletContext().getRealPath("/files");
      List<CommentDTO> list = boardMapper.listComment(board_code);
      req.setAttribute("dto", list);
      req.setAttribute("getBoard", dto);
      req.setAttribute("upPath", upPath);
      return "admin/board/content";
   }

   @RequestMapping(value = "/comment.board", method = RequestMethod.POST)
   public String insertComment(HttpServletRequest req, @ModelAttribute CommentDTO dto, @RequestParam int board_code, @RequestParam String id) {
      dto.setB_code(board_code);
      dto.setId(id);
      int res = boardMapper.insertComment(dto);
      boardMapper.commentUpdate(board_code);
      return "redirect:content.board?board_code="+board_code;
   }
   //공지사항
   @RequestMapping(value = "/list.notice")
   public String listNotice(HttpServletRequest req) {
	   int pageSize = 10;
		String num = req.getParameter("pageNum");
		if (num == null) {
			num = "1";
		}
		int currentPage = Integer.parseInt(num);
		int count = 0;
		count = boardMapper.getNoticeCount();

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
		List<NoticeDTO> list = boardMapper.listNotice(startRow-1, endRow);		
		req.setAttribute("num", number);
		req.setAttribute("count", count);
		req.setAttribute("startPage", startPage);
		req.setAttribute("endPage", endPage);
		req.setAttribute("pageCount", pageCount);
		req.setAttribute("pageBlock", pageBlock);
		req.setAttribute("list", list);
		return "admin/notice/list";
   }
   @RequestMapping(value = "/write.notice", method = RequestMethod.GET)
   public String writeNoticeForm() {
      return "admin/notice/writeForm";
   }

   @RequestMapping(value = "/write.notice", method = RequestMethod.POST)
   public ModelAndView writeNoticeUpdate(HttpServletRequest req, @ModelAttribute NoticeDTO dto, BindingResult result)
         throws Exception {
      MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
      MultipartFile mf = mr.getFile("filename");
      String filename = null;
      int filesize = 0;
      filename = mf.getOriginalFilename();
      filename = now + filename;
      HttpSession session = req.getSession();
      String upPath = session.getServletContext().getRealPath("/resources/files/notice");

      if (filename != null) {
         File file = new File(upPath, filename);
         mf.transferTo(file); // 파일 쓰기

         if (file != null) {
            filesize = (int) file.length();
         }
      }
      dto.setFilename(filename);
      dto.setFilesize(filesize);
      int res = boardMapper.insertNotice(dto);
      return new ModelAndView("redirect:list.notice");
   }
   
   @RequestMapping(value = "/content.notice")
   public String contentNotice(HttpServletRequest req, @RequestParam int notice_code) {
      NoticeDTO dto = boardMapper.getNotice(notice_code, "content");
      req.setAttribute("getBoard", dto);
      return "admin/notice/content";
   }
   @RequestMapping(value = "/search.notice")
   public String searchNotice(HttpServletRequest req, @RequestParam String search, String searchString) {
      List<NoticeDTO> list = boardMapper.searchNotice(search, searchString);
      req.setAttribute("list", list);
      return "admin/notice/list";
   }
   @RequestMapping(value="/update.notice")
   public String updateNotice(HttpServletRequest req, @ModelAttribute NoticeDTO dto) {
      boardMapper.updateNotice(dto);
      return "redirect:list.notice";
   }
   
   @RequestMapping(value = "/delete.notice")
   public String deleteNotice(HttpServletRequest req, @RequestParam int notice_code) {
      boardMapper.deleteNotice(notice_code);
      return "redirect:list.notice";
   }
   
   
   
   //Q&A 
      @RequestMapping(value = "/list.qna")
      public String listQna(HttpServletRequest req) {
         int pageSize = 5;
         String num = req.getParameter("pageNum");
         if (num == null) {
            num = "1";
         }
         int currentPage = Integer.parseInt(num);
         int count = 0;
         count = boardMapper.getQnaCount();

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
         List<QnaDTO> list = boardMapper.listQna();
         
         req.setAttribute("num", number);
         req.setAttribute("count", count);
         req.setAttribute("startPage", startPage);
         req.setAttribute("endPage", endPage);
         req.setAttribute("pageCount", pageCount);
         req.setAttribute("pageBlock", pageBlock);
         req.setAttribute("list", list);
         return "admin/qna/list";
      }
      
      @RequestMapping(value = "/content.qna")
      public String contentQna(HttpServletRequest req, @RequestParam int qna_code) {
         QnaDTO dto = boardMapper.getQna(qna_code);
         HttpSession session = req.getSession();
         String upPath = session.getServletContext().getRealPath("/files");
         req.setAttribute("getBoard", dto);
         req.setAttribute("upPath", upPath);
         return "admin/qna/content";
      }
      @RequestMapping(value = "/reply.qna", method = RequestMethod.GET)
      public String replyForm(HttpServletRequest req,@RequestParam int qna_code) {
         QnaDTO dto = boardMapper.getQna(qna_code);
         req.setAttribute("qna", dto);
         return "admin/qna/replyForm";
      }
      @RequestMapping(value = "/replyPro.qna", method = RequestMethod.POST)
      public String replyPro(HttpServletRequest req, @ModelAttribute QnaDTO dto, BindingResult result)
            throws Exception {
         MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
         ModelAndView mav = new ModelAndView();
         MultipartFile mf = mr.getFile("re_filename");
         String filename = null;
         int filesize = 0;
         filename = mf.getOriginalFilename();
         filename = now + filename;
         HttpSession session = req.getSession();
         String upPath = session.getServletContext().getRealPath("/files");
         if (filename != null) {
            File file = new File(upPath, filename);
            if (file != null) {
               filesize = (int) file.length();
            }
         }
         dto.setRe_writer("���");
         dto.setRe_filename(filename);
         dto.setRe_filesize(filesize);
         int res = boardMapper.replyQna(dto);
         
         return "redirect:content.qna?qna_code="+dto.getQna_code();
      }
      
      @RequestMapping(value = "/list.shopBoard")
      public String listShopBoard(HttpServletRequest req) {
         int pageSize = 5;
         String num = req.getParameter("pageNum");
         if (num == null) {
            num = "1";
         }
         int currentPage = Integer.parseInt(num);
         int count = 0;
         count = boardMapper.getCount();

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
         List<BoardDTO> list = boardMapper.listBoard();

         req.setAttribute("num", number);
         req.setAttribute("count", count);
         req.setAttribute("startPage", startPage);
         req.setAttribute("endPage", endPage);
         req.setAttribute("pageCount", pageCount);
         req.setAttribute("pageBlock", pageBlock);
         req.setAttribute("list", list);
         return "board/list";
      }

      @RequestMapping(value = "/content.shopBoard")
      public String contentShopBoard(HttpServletRequest req, @RequestParam int board_code) throws ParseException {
         BoardDTO dto = boardMapper.getBoard(board_code, "content");
         BookDTO bdto = bookMapper.getBook(dto.getBook_code());
         HttpSession session = req.getSession();
         String upPath = session.getServletContext().getRealPath("/files");
         List<CommentDTO> list = boardMapper.listComment(board_code);
         req.setAttribute("dto", list);
         req.setAttribute("bdto", bdto);
         req.setAttribute("getBoard", dto);
         req.setAttribute("upPath", upPath);
         return "board/content";
      }

      @RequestMapping(value = "/search.shopBoard")
      public String searchShopBoard(HttpServletRequest req, @RequestParam String search, String searchString) {
         List<BoardDTO> list = boardMapper.searchBoard(search, searchString);
         req.setAttribute("list", list);
         return "board/list";
      }

      @RequestMapping(value = "/write.shopBoard", method = RequestMethod.GET)
      public String writeBoardForm() {
         return "board/writeForm";
      }

      @RequestMapping(value = "/write.shopBoard", method = RequestMethod.POST)
      public ModelAndView writeBoardUpdate(HttpServletRequest req, @ModelAttribute BoardDTO dto, BindingResult result) throws IllegalStateException, IOException {
         MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
         MultipartFile mf = mr.getFile("filename");
         String filename = null;
         int filesize = 0;
         filename = mf.getOriginalFilename();
         if (mf != null) {
            HttpSession session = req.getSession();
            String upPath = session.getServletContext().getRealPath("/resources/img");
            File file = new File(upPath, filename);
            if (filename == null || filename.equals("")) {
            } else {
               mf.transferTo(file);
            }
            filesize = (int) file.length();
         }  
           
         dto.setFilename(filename);
         dto.setFilesize(filesize);
         dto.setMember_id((String) req.getSession().getAttribute("log"));
         int res = boardMapper.insertBoard(dto);
         String referer = req.getHeader("Referer");
         return new ModelAndView("redirect:"+ referer);
      }

      @RequestMapping(value = "/bookCallBack.shopBoard")
      public ModelAndView writerCallBack(@RequestParam String bookname, HttpServletRequest req) {
         List<BookDTO> list = null;
         list = bookMapper.bookCallBack(bookname);
         ModelAndView mav = new ModelAndView();
         mav.setViewName("/board/bookCallBack");
         mav.addObject("list", list);
         return mav;
      }

      @RequestMapping(value = "/comment.shopBoard", method = RequestMethod.POST)
      public String insertshopBoardComment(HttpServletRequest req, @ModelAttribute CommentDTO dto,
            @RequestParam int board_code, @RequestParam String id) {
         dto.setB_code(board_code);
         dto.setId(id);
         int res = boardMapper.insertComment(dto);
         boardMapper.commentUpdate(board_code);
         return "redirect:content.shopBoard?board_code=" + board_code;
      }
      
   // 리뷰 목록
      @RequestMapping(value="/list.review")
      public String listBookLog(HttpServletRequest req) {
         int pageSize = 10;
         String num = req.getParameter("pageNum");
         if (num == null) {
            num = "1";
         }
         int currentPage = Integer.parseInt(num);
         int count = 0;
         count = boardMapper.getBookReviewCount();

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

         List<FreeDTO> list = boardMapper.listReview(startRow-1, endRow);
         req.setAttribute("num", number);
         req.setAttribute("count", count);
         req.setAttribute("startPage", startPage);
         req.setAttribute("endPage", endPage);
         req.setAttribute("pageCount", pageCount);
         req.setAttribute("pageBlock", pageBlock);
         req.setAttribute("list", list);
         return "admin/review/list";
      }

      // 리뷰 검색
      @RequestMapping(value = "/search.review")
      public String searchReview(HttpServletRequest req, @RequestParam String search, String searchString) {
         List<FreeDTO> list = boardMapper.searchReview(search, searchString);
         req.setAttribute("list", list);
         return "admin/review/list";
      }
      
      // 리뷰 보기
      @RequestMapping(value = "/content.review")
      public String contentReview(HttpServletRequest req, @RequestParam int board_code) {
         FreeDTO dto = boardMapper.contentReview(board_code);
         req.setAttribute("dto", dto);
         return "admin/review/content";
      }

      // 리뷰 수정
      @RequestMapping(value = "/update.review", method = RequestMethod.POST)
      public String updateReview(HttpServletRequest req, @RequestParam String content, int board_code) {
         boardMapper.updateReview(content, board_code);      
         return "redirect:list.review";
      }

      // 리뷰 삭제
      @RequestMapping(value = "/delete.review")
      public String deleteReview(HttpServletRequest req, @RequestParam int board_code) {
         boardMapper.deleteReview(board_code);
         return "redirect:list.review";
      }
      
   // 1:1 문의 검색
      @RequestMapping(value="/search.qna")
      public String searchQna(HttpServletRequest req, @RequestParam String search, String searchString) {
         List<QnaDTO> list = boardMapper.searchQna(search, searchString);
         req.setAttribute("list", list);
         return "admin/qna/list";
      }
      
   // 1:1 문의 삭제
      @RequestMapping(value="/delete.qna")
      public String deleteQna(@RequestParam int qna_code) {
         boardMapper.deleteQna(qna_code);
         return "redirect:list.qna";
      }
      
      
      
      
}