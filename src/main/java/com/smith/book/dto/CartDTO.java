package com.smith.book.dto;

public class CartDTO {
	
	private int cart_code;
	private String member_id; // member
	private int book_code;
	private String bookname;
	private String img_name;
	
	private int price;
	private int qty;
	
	public CartDTO(){}
	public CartDTO(int book_code, String bookname, int price, int qty, String img_name){
		this.book_code = book_code;
		this.bookname = bookname;
		this.price = price;
		this.qty = qty;
		this.img_name = img_name;
	}
	
	public String getImg_name() {
		return img_name;
	}
	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}
	
	public String getBookname() {
		return bookname;
	}
	public void setBookname(String bookname) {
		this.bookname = bookname;
	}
	public int getCart_code() {
		return cart_code;
	}
	public void setCart_code(int cart_code) {
		this.cart_code = cart_code;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getBook_code() {
		return book_code;
	}
	public void setBook_code(int book_code) {
		this.book_code = book_code;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	

}
