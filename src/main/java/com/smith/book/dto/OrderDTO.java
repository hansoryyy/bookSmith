package com.smith.book.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderDTO {
	private int order_code;
	private String member_id;
	private String name;
	private String guest_email;
	private String guest_passwd;
	private String hp1;
	private String hp2;
	private String hp3;
	private String guest_hp1;
	private String guest_hp2;
	private String guest_hp3;
	private String tel;
	private String zipcode;
	private String addr1;
	private String addr2;
	private Date order_date; 
	private String o_date;
	private String pay_date;
	private String deliveryStatus;
	private String message;
	List<OrderItemDTO> items = new ArrayList<OrderItemDTO>();
	private String payment_option;
	private String status;
	private String delivery_company;
	private String delivery_code;
	private String img_name;
	private String bookname;
	private String qty;
	private String money;
	private String date;
	private int order_item_code; // 주문 내역 번호
	private int price; // 책 가격
	private int each_price; // 주문 합계
	private int order_withdrawal = 0; // 주문 취소 금액
	
	
	
	public String getO_date() {
		return o_date;
	}
	public void setO_date(String o_date) {
		this.o_date = o_date;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public int getOrder_item_code() {
		return order_item_code;
	}
	public void setOrder_item_code(int order_item_code) {
		this.order_item_code = order_item_code;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getOrder_withdrawal() {
		return order_withdrawal;
	}
	public void setOrder_withdrawal(int order_withdrawal) {
		this.order_withdrawal = order_withdrawal;
	}
	public int getEach_price() {
		return each_price;
	}
	public void setEach_price(int each_price) {
		this.each_price = each_price;
	}
	public String getPayment_option() {
		return payment_option;
	}
	public void setPayment_option(String payment_option) {
		this.payment_option = payment_option;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDelivery_company() {
		return delivery_company;
	}
	public void setDelivery_company(String delivery_company) {
		this.delivery_company = delivery_company;
	}
	public String getDelivery_code() {
		return delivery_code;
	}
	public void setDelivery_code(String delivery_code) {
		this.delivery_code = delivery_code;
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
	public String getQty() {
		return qty;
	}
	public void setQty(String qty) {
		this.qty = qty;
	}
	public String getMoney() {
		return money;
	}
	public void setMoney(String money) {
		this.money = money;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public void setItems(List<OrderItemDTO> items) {
		this.items = items;
	}
	public int getOrder_code() {
		return order_code;
	}
	public void setOrder_code(int order_code) {
		this.order_code = order_code;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGuest_email() {
		return guest_email;
	}
	public void setGuest_email(String guest_email) {
		this.guest_email = guest_email;
	}
	public String getGuest_passwd() {
		return guest_passwd;
	}
	public void setGuest_passwd(String guest_passwd) {
		this.guest_passwd = guest_passwd;
	}
	public String getHp1() {
		return hp1;
	}
	public void setHp1(String hp1) {
		this.hp1 = hp1;
	}
	public String getHp2() {
		return hp2;
	}
	public void setHp2(String hp2) {
		this.hp2 = hp2;
	}
	public String getHp3() {
		return hp3;
	}
	public void setHp3(String hp3) {
		this.hp3 = hp3;
	}
	public String getGuest_hp1() {
		return guest_hp1;
	}
	public void setGuest_hp1(String guest_hp1) {
		this.guest_hp1 = guest_hp1;
	}
	public String getGuest_hp2() {
		return guest_hp2;
	}
	public void setGuest_hp2(String guest_hp2) {
		this.guest_hp2 = guest_hp2;
	}
	public String getGuest_hp3() {
		return guest_hp3;
	}
	public void setGuest_hp3(String guest_hp3) {
		this.guest_hp3 = guest_hp3;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	
	public String getPay_date() {
		return pay_date;
	}
	public void setPay_date(String pay_date) {
		this.pay_date = pay_date;
	}
	public String getDeliveryStatus() {
		return deliveryStatus;
	}
	public void setDeliveryStatus(String deliveryStatus) {
		this.deliveryStatus = deliveryStatus;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public void addItem(OrderItemDTO item) {
		this.items.add(item);
	}
	public List<OrderItemDTO> getItems() {
		return items;
	}
}
