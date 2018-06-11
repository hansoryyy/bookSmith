package com.smith.book.dto;

import java.util.Date;

public class SaleDTO {
   private String order_code; // 주문번호
   private String order_date; // 주문 날짜
   private String order_name; // 주문자
   private String date;
   private int qty; // 주문 개수
   private int money; // 주문 합계
   private int transfer; // 계좌 이체
   private int creditCard; // 신용카드 결제
   private int withdrawal; // 주문 취소
   private int receivable; // 미수금
   
   public String getOrder_code() {
      return order_code;
   }
   public void setOrder_code(String order_code) {
      this.order_code = order_code;
   }   
   public String getOrder_date() {
      return order_date;
   }
   public void setOrder_date(String order_date) {
      this.order_date = order_date;
   }
   public String getOrder_name() {
      return order_name;
   }
   public void setOrder_name(String order_name) {
      this.order_name = order_name;
   }
   public String getDate() {
      return date;
   }
   public void setDate(String date) {
      this.date = date;
   }
   public int getQty() {
      return qty;
   }
   public void setQty(int qty) {
      this.qty = qty;
   }
   public int getMoney() {
      return money;
   }
   public void setMoney(int money) {
      this.money = money;
   }
   public int getTransfer() {
      return transfer;
   }
   public void setTransfer(int transfer) {
      this.transfer = transfer;
   }
   public int getCreditCard() {
      return creditCard;
   }
   public void setCreditCard(int creditCard) {
      this.creditCard = creditCard;
   }
   public int getWithdrawal() {
      return withdrawal;
   }
   public void setWithdrawal(int withdrawal) {
      this.withdrawal = withdrawal;
   }
   public int getReceivable() {
      return receivable;
   }
   public void setReceivable(int receivable) {
      this.receivable = receivable;
   }
}