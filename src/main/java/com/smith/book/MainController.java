package com.smith.book;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.smith.book.dto.BCDTO;
import com.smith.book.dto.GenreDTO;
import com.smith.book.dto.SearchDTO;
import com.smith.book.service.BookMapper;



@Controller
public class MainController {
   @Autowired 
   BookMapper bookMapper;
   
   @Autowired
   private ServletContext servletContext;
   
   private static List<GenreDTO> genreList;
   private static SearchDTO recommandBook;
   private static List<SearchDTO> bestList;
   
   private static List<SearchDTO> NewList;

   
   @RequestMapping(value="/pay_success")
      public String bookSmitpay_successh(HttpServletRequest req, HttpSession session) {
      
       session.getAttribute("bestList");
       return "shop/pay_finish";
     
      }
   
   @RequestMapping(value="/")
      public ModelAndView bookSmith(HttpServletRequest req) {
         
       req.setAttribute("bestList", bestList);
         ModelAndView mav = new ModelAndView(); 
         mav.setViewName("redirect:main.go");
         return mav;
      }
   
   @RequestMapping(value="/main.go")
      public String shopHome(HttpServletRequest req, HttpSession session) {
         if(session.getAttribute("genreList")==null) {
               genreList=bookMapper.listGenre();
               session.setAttribute("genreList",genreList);
               
            }
         
         req.setAttribute("recommand", recommandBook);
         req.setAttribute("bestList", bestList);
         req.setAttribute("newList", NewList);
          return "index";
      }
   

   @RequestMapping(value="/book_concert")
      public String book_concert() {
          
          return "bookConcert";
      }
      
      @Scheduled(cron="50 59 23 * * ?")
         public void recommandBook() {
            recommandBook=bookMapper.recommandBook();
            bestList=bookMapper.bestBooks();
            NewList=bookMapper.newBooks();
         }
      
      @PostConstruct
      public void loadDummyBook () {
         System.out.println("first rcmd book!");
          recommandBook=bookMapper.recommandBook();
          bestList=bookMapper.bestBooks();
          NewList=bookMapper.newBooks();
      }
   
      @RequestMapping(value="/admin.bookConcert", method=RequestMethod.GET)
      public String goBC(){
         
         return "admin/bookconcert/bookConcert";
      }
      
      @RequestMapping(value="/del.bookConcert")
      public String delBC(){
         servletContext.removeAttribute("book_concert");
         return "admin/bookconcert/bookConcert";
      }
      @RequestMapping(value="/regi.bookConcert")
      public String regiBC(HttpServletRequest req,@ModelAttribute BCDTO dto){
         SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
         Calendar ca1 = Calendar.getInstance();
         String today = format.format(ca1.getTime());
         Date day1 =null;
         Date day2 =null;
         
         try {
            day1=format.parse(dto.getBCdate());
            day2=format.parse(today);
         }catch(ParseException e) {
            e.printStackTrace();
         }
         
         int compare = day1.compareTo(day2);
         
         if(compare<0) {
            req.setAttribute("msg", "잘못된 날짜입니다. 확인해주세요");
         }else {
            servletContext.setAttribute("book_concert", dto);
         }
         
         return "admin/bookconcert/bookConcert";
      }
   
}