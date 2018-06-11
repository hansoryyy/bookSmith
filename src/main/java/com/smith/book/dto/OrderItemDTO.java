package com.smith.book.dto;

import java.util.Date;

public class OrderItemDTO {
	private int order_item_code;
	private String order_id;
	private int book_code;
	private int qty;
	private int each_price;
	private Date sales_date;
	private int order_code ;
	private String bookname;
	private String img_name;
	
	 
	
	
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
	public int getOrder_item_code() {
		return order_item_code;
	}
	public void setOrder_item_code(int order_item_code) {
		this.order_item_code = order_item_code;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public int getOrder_code() {
		return order_code;
	}
	public void setOrder_code(int order_code) {
		this.order_code = order_code;
	}
	public int getBook_code() {
		return book_code;
	}
	public void setBook_code(int book_code) {
		this.book_code = book_code;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public int getEach_price() {
		return each_price;
	}
	public void setEach_price(int each_price) {
		this.each_price = each_price;
	}
	public Date getSales_date() {
		return sales_date;
	}
	public void setSales_date(Date sales_date) {
		this.sales_date = sales_date;
	}
	public CartDTO getCartItem() {
		CartDTO cart = new CartDTO(this.book_code, null, this.each_price/this.qty, this.qty, this.img_name);
		cart.setMember_id(order_id);
		return cart;
	}
	
}
