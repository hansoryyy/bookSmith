package com.smith.book.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Repository;

import com.smith.book.dto.BookDTO;
import com.smith.book.dto.GenreDTO;
import com.smith.book.dto.PublisherDTO;
import com.smith.book.dto.SearchDTO;
import com.smith.book.dto.WriterDTO;

@Repository
public class BookMapper {
	@Autowired
	private SqlSession sqlSession;

	public BookDTO getBook(int book_code) {
		BookDTO dto = sqlSession.selectOne("getBook", book_code);
		sqlSession.update("increaseReadCount", book_code);
		return dto;
	}

	public int getBookCount() {
		int res = sqlSession.selectOne("getBookCount");
		return res;
	}
	
	public List<SearchDTO> listBook(int startRow, int endRow) {
		String sql = null;
		java.util.HashMap<String, String> map = new HashMap<String, String>();
		sql = "select * from book as b inner join writer as w inner join publisher as p on(b.w_code = w.w_code and b.p_code = p.p_code) order by book_code desc limit "+startRow+", 10";
		map.put("sql", sql);
		List<SearchDTO> list = sqlSession.selectList("listBook", map);
		return list;
	}

	public int insertBook(BookDTO dto) {
		sqlSession.insert("insertBook", dto);
		return 1;
	}

	public int updateBook(SearchDTO dto) {
		sqlSession.update("updateBook", dto);
		return 1;
	}

	public int deleteBook(int book_code) {
		int res = 0;
		try {
			sqlSession.delete("deleteBook", book_code);
			res = 1;
		} catch (DataIntegrityViolationException e) {
			System.out.println("1.DataIntegrityViolationException 발생");
			res = 0;
		}
		return res;
	}

	public int max_g_code() {
		int max_g_code;
		try {
			max_g_code = sqlSession.selectOne("max_g_code");
		} catch (NullPointerException e) {
			max_g_code = 0;
		}

		return max_g_code;
	}

	public int maxS_g_code(int g_code) {
		int maxS_g_code = sqlSession.selectOne("maxS_g_code", g_code);
		return maxS_g_code;
	}

	public int insertGenre(GenreDTO dto) {
		int res = sqlSession.insert("insertGenre", dto);
		return res;
	}

	public List<GenreDTO> listBig() {
		List<GenreDTO> list = sqlSession.selectList("listBig");
		return list;
	}

	public List<GenreDTO> listLittle(int g_code) {
		List<GenreDTO> list = sqlSession.selectList("listSmall", g_code);
		return list;
	}

	public List<GenreDTO> listGenre_1() {
		List<GenreDTO> list = sqlSession.selectList("listGenre");
		return list;
	}

	public int deleteLittleGenre(int g_code) {
		int res = sqlSession.delete("deleteLittleGenre", g_code);
		return res;
	}

	public int deleteBigGenre(int g_code) {
		int res = sqlSession.delete("deleteBigGenre", g_code);
		return res;
	}
	
	public int getWriterCount() {
		int res = sqlSession.selectOne("getWriterCount");
		return res;
	}
	
	public List<WriterDTO> listWriter() {
		List<WriterDTO> list = sqlSession.selectList("listWriter");
		return list;
	}
	
	public List<WriterDTO> listWriters(int startRow, int endRow) {
		String sql = null;
		sql = "select * from writer order by w_code desc limit "+startRow+", 10";
		java.util.HashMap<String, String> map = new HashMap<String, String>();
		map.put("sql", sql);
		List<WriterDTO> list = sqlSession.selectList("listWriters", map);
		return list;
	}

	public int insertWriter(WriterDTO dto) {
		int res = sqlSession.insert("insertWriter", dto);
		return res;
	}

	public int deleteWriter(int w_code) {
		sqlSession.delete("deleteWriter", w_code);
		return 1;
	}
	
	public int getPublisherCount() {
		int res = sqlSession.selectOne("getPublisherCount");
		return res;
	}

	public List<PublisherDTO> listPublisher() {
		List<PublisherDTO> list = sqlSession.selectList("listPublisher");
		return list;
	}
	
	public List<PublisherDTO> listPublishers(int startRow, int endRow) {
		String sql = null;
		sql = "select * from publisher order by p_code desc limit "+startRow+", 10";
		java.util.HashMap<String, String> map = new HashMap<String, String>();		
		map.put("sql", sql);
		List<PublisherDTO> list = sqlSession.selectList("listPublishers", map);
		return list;
	}

	public int insertPublisher(PublisherDTO dto) {
		sqlSession.insert("insertPublisher", dto);
		return 1;
	}

	public int deletePublisher(int p_code) {
		sqlSession.delete("deletePublisher", p_code);
		return 1;
	}

	public List<WriterDTO> writerCallback(String w_name) {
		List<WriterDTO> list = sqlSession.selectList("writerCallback", w_name);
		return list;
	}

	public List<PublisherDTO> publisherCallBack(String p_name) {
		List<PublisherDTO> list = sqlSession.selectList("publisherCallback", p_name);
		return list;
	}
	
	public List<BookDTO> bookCallBack(String bookname) {
	      List<BookDTO> list = sqlSession.selectList("bookCallBack", bookname);
	      return list;
	   }

	public List<WriterDTO> writerSearch(String searchType, String value) {
		String sql = "select * from writer where " + searchType + " like " + "'%" + value + "%' order by w_code desc";
		java.util.HashMap<String, String> map = new HashMap<String, String>();
		map.put("sql", sql);
		List<WriterDTO> list = sqlSession.selectList("searchPro", map);
		return list;
	}

	public List<PublisherDTO> publisherSearch(String searchType, String value) {
		String sql = "select * from publisher where " + searchType + " like " + "'%" + value
				+ "%' order by p_code desc";
		java.util.HashMap<String, String> map = new HashMap<String, String>();
		map.put("sql", sql);
		List<PublisherDTO> list = sqlSession.selectList("searchPro", map);
		return list;
	}

	// 임시 메퍼 메소드 !
	public List<SearchDTO> listNewBigGenreBook(int g_code) {
		List<SearchDTO> list = sqlSession.selectList("listNewBigGenreBook", g_code);
		return list;
	}

	/*public List<SearchDTO> bookSearch(String search, String searchType, int currentPage, String orderby) {
	      String sql ="";
	      if(searchType.equals("bookname")) {
	            searchType="(bookname LIKE '%"+ search + "%' OR w_name LIKE '%"+search+"%' OR p_name ";
	         }
	       sql="SELECT * FROM book b INNER JOIN writer w INNER JOIN publisher p JOIN " + 
	              " (SELECT book_code FROM book bo INNER JOIN writer wr INNER JOIN publisher pu WHERE "
	             + searchType +" LIKE '%" + search +"%') AND bo.w_code = wr.w_code AND bo.p_code=pu.p_code ORDER  BY "+orderby+" LIMIT "
	             + currentPage + ",21) AS t ON t.book_code = b.book_code WHERE b.w_code = w.w_code AND b.p_code=p.p_code";
	      
	   
	      java.util.HashMap<String, String> map = new HashMap<String, String>();

	      map.put("sql", sql);

	      List<SearchDTO> list = sqlSession.selectList("bookSearch", map);
	      return list;
	   }
*/
	public List<SearchDTO> bookSearch(String search, String searchType, int currentPage) {
	      String sql ="";
	      if(searchType.equals("searchAll")) {
	         sql = "SELECT DISTINCT * FROM book b , writer w , publisher p " + 
	               "WHERE (b.bookname LIKE '%" + search + "%') AND b.w_code = w.w_code AND b.p_code=p.p_code " + 
	               "UNION " + 
	               "SELECT DISTINCT * FROM book b , writer w , publisher p " + 
	               "WHERE (w.w_name LIKE '%" + search + "%') AND b.w_code = w.w_code AND b.p_code=p.p_code " + 
	               "UNION " + 
	               "SELECT DISTINCT * FROM book b , writer w , publisher p " + 
	               "WHERE (p.p_name LIKE '%" + search + "%') AND b.w_code = w.w_code AND b.p_code=p.p_code " + 
	               "LIMIT " + currentPage + ",21"; 
	        } else {
	           if(searchType.equals("bookname")) searchType="b.bookname";
	           else if(searchType.equals("w_name")) searchType="w.w_name";
	           else if(searchType.equals("p_name")) searchType="p.p_name";
	           sql = "SELECT DISTINCT * FROM book b , writer w , publisher p " + 
	               "WHERE (" + searchType + " LIKE '%" + search + "%') AND b.w_code = w.w_code AND b.p_code=p.p_code "+ 
	               "LIMIT " + currentPage + ",21"; 
	        }
	      java.util.HashMap<String, String> map = new HashMap<String, String>();
	      map.put("sql", sql);
	      List<SearchDTO> list = sqlSession.selectList("bookSearch", map);
	      return list;
	   }
	
	
	
	public List<SearchDTO> bookSearchByGenre(int g_code, String mode, int currentPage, String orderby) {

	      String sql = "SELECT * FROM book b INNER JOIN writer w INNER JOIN publisher p JOIN "
	            + "(SELECT book_code FROM book bo INNER JOIN writer wr INNER JOIN publisher pu WHERE ";

	      if (mode.equals("big")) {
	         sql = sql + "g_code-(g_code % 1000) = " + (g_code - (g_code % 1000))
	               + " AND bo.w_code = wr.w_code AND bo.p_code=pu.p_code ORDER  BY "+orderby+" LIMIT  " + currentPage
	               + ", 21) AS t ON t.book_code = b.book_code WHERE b.w_code = w.w_code AND b.p_code=p.p_code";
	      } else {
	         sql = sql + "g_code = " + g_code
	               + " AND bo.w_code = wr.w_code AND bo.p_code=pu.p_code ORDER  BY "+orderby+" LIMIT  " + currentPage
	               + ", 21) AS t ON t.book_code = b.book_code WHERE b.w_code = w.w_code AND b.p_code=p.p_code";
	      }
	      java.util.HashMap<String, String> map = new HashMap<String, String>();
	      map.put("sql", sql);

	      List<SearchDTO> list = sqlSession.selectList("bookSearch", map);
	      return list;
	   }
	
	
	

	public List<GenreDTO> listGenre() {
		List<GenreDTO> list = null;
		list = sqlSession.selectList("genreList");
		return list;
	}

	public void updateSaleCount(BookDTO updto) {
		sqlSession.update("updateSaleCount", updto);
	}

	public SearchDTO recommandBook() {
	      SearchDTO dto = null;
	      dto = sqlSession.selectOne("recommand");
	      return dto; 
	}
	
	/*-------------------검색--------------------*/
	public List<PublisherDTO> searchPublisher(String search, String searchString){
	      List<PublisherDTO> list ;
	      String sql = null;
	      java.util.HashMap<String, String> map = new java.util.HashMap<String, String>();
	      sql = "select * from publisher where "+search+" like '%"+searchString+"%'";
	      map.put("sql",sql);
	      list = sqlSession.selectList("searchPublisher",map);
	      return list;
	   }
	
	 public List<WriterDTO> searchWriter(String search, String searchString){
	      List<WriterDTO> list ;
	      String sql = "";
	      java.util.HashMap<String, String> map = new java.util.HashMap<String, String>();
	      if(search=="w_code" || search.equals("w_code")) {
	         sql = "select * from writer where w_code = "+searchString;
	         map.put("sql", sql);
	      }else {
	         sql = "select * from writer where w_name like '%"+searchString+"%' order by w_code desc";
	         map.put("sql",sql); 
	      }
	      list = sqlSession.selectList("searchWriter",map);
	      
	      return list;
	   }
	 	
	 public List<BookDTO> searchBook(String search, String searchString){
	      List<BookDTO> list ;
	      String sql = "";
	      java.util.HashMap<String, String> map = new java.util.HashMap<String, String>();
	      if(search=="w_name" || search.equals("w_name")) {
	         sql = "select book_code,bookname,w_name,price,qty,img_name from writer a inner join book b on a.w_code=b.w_code where w_name like '%"+searchString+"%' order by b.book_code desc";
	         map.put("sql", sql);
	      }else if(search == "book_code" || search.equals("book_code")){
	         sql = "select book_code,bookname,w_name,price,qty, img_name from book a inner join writer b on a.w_code = b.w_code where book_code ="+ searchString;
	         map.put("sql",sql);
	      }else {
	         sql = "select book_code,bookname,w_name,price,qty, img_name from book a inner join writer b on a.w_code = b.w_code where "+search+" like '%"+searchString+"%' order by book_code desc";
	         map.put("sql",sql);
	      }
	      list = sqlSession.selectList("searchBook",map);
	      
	      return list;
	   }
	 
	 public List<SearchDTO> bestBooks() {
         List<SearchDTO> list = null;
         list = sqlSession.selectList("bestBooks");
         return list; 
      }
	 
	 public List<SearchDTO> newBooks() {
         List<SearchDTO> list = null;
         list = sqlSession.selectList("newBooks");
         return list; 
      }



	

}
