package com.smith.book.dto;

public class BookDTO {

	private int book_code;
	private int g_code;
	private int w_code;
	private int p_code;
	private String bookname;
	private int price;
	private String comment;
	private String img_name;
	private int img_size;
	private String IBSN;
	private int qty;
	private String reg_date;
	private String pub_date;
	private int readCount; // 조회수
	private int saleCount; // 판매수
	private int realRank; // 판매 순위
	private String w_name;
	private String w_introduction;
	private String p_name;
	private int avg_rate;	//평점
	private int review_count;	//리뷰 갯수
	
	

	public int getReview_count() {
		return review_count;
	}

	public void setReview_count(int review_count) {
		this.review_count = review_count;
	}

	public int getAvg_rate() {
		return avg_rate;
	}

	public void setAvg_rate(int avg_rate) {
		this.avg_rate = avg_rate;
	}

	public String getW_name() {
		return w_name;
	}

	public void setW_name(String w_name) {
		this.w_name = w_name;
	}

	public String getW_introduction() {
		return w_introduction;
	}

	public void setW_introduction(String w_introduction) {
		this.w_introduction = w_introduction;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public int getSaleCount() {
		return saleCount;
	}

	public void setSaleCount(int saleCount) {
		this.saleCount = saleCount;
	}

	public int getRealRank() {
		return realRank;
	}

	public void setRealRank(int realRank) {
		this.realRank = realRank;
	}

	public int getBook_code() {
		return book_code;
	}

	public void setBook_code(int book_code) {
		this.book_code = book_code;
	}

	public int getG_code() {
		return g_code;
	}

	public void setG_code(int g_code) {
		this.g_code = g_code;
	}

	public int getW_code() {
		return w_code;
	}

	public void setW_code(int w_code) {
		this.w_code = w_code;
	}

	public int getP_code() {
		return p_code;
	}

	public void setP_code(int p_code) {
		this.p_code = p_code;
	}

	public String getBookname() {
		return bookname;
	}

	public void setBookname(String bookname) {
		this.bookname = bookname;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getImg_name() {
		return img_name;
	}

	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}

	public int getImg_size() {
		return img_size;
	}

	public void setImg_size(int img_size) {
		this.img_size = img_size;
	}

	public String getIBSN() {
		return IBSN;
	}

	public void setIBSN(String iBSN) {
		IBSN = iBSN;
	}

	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getPub_date() {
		return pub_date;
	}

	public void setPub_date(String pub_date) {
		this.pub_date = pub_date;
	}

}
