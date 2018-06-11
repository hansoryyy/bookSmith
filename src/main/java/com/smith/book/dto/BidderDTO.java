package com.smith.book.dto;

import java.util.Date;

public class BidderDTO {
	private int bidder_code;
	private String id;
	private String member_id;// �Ǹ��� ���̵�
	private int a_code;
	private int bid_money;
	private int money;
	private String name;
	private String time;
	private int leavetime;
	private int ready;

	public int getReady() {
		return ready;
	}

	public void setReady(int ready) {
		this.ready = ready;
	}

	public int getLeavetime() {
		return leavetime;
	}

	public void setLeavetime(int leavetime) {
		this.leavetime = leavetime;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public int getMoney() {
		return money;
	}

	public void setMoney(int money) {
		this.money = money;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getBid_money() {
		return bid_money;
	}

	public void setBid_money(int bid_money) {
		this.bid_money = bid_money;
	}

	public int getBidder_code() {
		return bidder_code;
	}

	public void setBidder_code(int bidder_code) {
		this.bidder_code = bidder_code;
	}

	public int getA_code() {
		return a_code;
	}

	public void setA_code(int a_code) {
		this.a_code = a_code;
	}

}