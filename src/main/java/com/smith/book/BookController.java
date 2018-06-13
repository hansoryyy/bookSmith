package com.smith.book;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.smith.book.dto.BoardDTO;
import com.smith.book.dto.BookDTO;
import com.smith.book.dto.SearchDTO;
import com.smith.book.service.BoardMapper;
import com.smith.book.service.BookMapper;


@Controller
public class BookController {

   @Autowired BookMapper bookMapper;
   @Autowired BoardMapper boardMapper;
   
   @RequestMapping(value = "/book.search")
   public String searchBook(HttpServletRequest req,@RequestParam int currentPage,@RequestParam String search,@RequestParam String searchType, @RequestParam String orderBy) {
      
      if(search==null||searchType==null)return"index";
      
      List<SearchDTO> list = bookMapper.bookSearch(search, searchType, ((currentPage-1)/5) * 20);
      
      //다음|이전 페이지를 위한 파라미터값들 
      req.setAttribute("searchList", list);
      req.setAttribute("value_rm", "book.search");
      req.setAttribute("currentPage", currentPage);
      req.setAttribute("search", search);
      req.setAttribute("searchType", searchType);
      req.setAttribute("bali", req.getParameter("bali"));
      req.setAttribute("orderBy", orderBy);
      
      //개수 조절
      
      return "search/result";
   }
   @RequestMapping(value = "/bookBygenre.search")
   public String searchGenre(HttpServletRequest req,@RequestParam int currentPage, @RequestParam int g_code, @RequestParam String mode, @RequestParam String orderBy) {
      
      if(g_code==0)return"index";
      List<SearchDTO> list = bookMapper.bookSearchByGenre(g_code, mode, ((currentPage-1)/5) * 20, orderBy);
      
      req.setAttribute("value_rm", "bookBygenre.search");
      req.setAttribute("currentPage", currentPage);
      req.setAttribute("g_code", g_code);
      req.setAttribute("mode", mode);
      req.setAttribute("bali", req.getParameter("bali"));
      req.setAttribute("orderBy", orderBy);
      
      req.setAttribute("searchList", list);
      return "search/result";
   }
   
   @RequestMapping(value="/view.product")
   public String viewProduct(HttpServletRequest req, @ModelAttribute SearchDTO product , @RequestParam int book_code) {
      BookDTO dto = bookMapper.getBook(book_code);
      List<BoardDTO> list = boardMapper.reviewListBoard(book_code);
      req.setAttribute("dto", dto);
      req.setAttribute("product", product);
      req.setAttribute("reviewList", list);
   
      return "shop/productContent";
   }
}