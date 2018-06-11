package com.smith.book.dto;

import java.util.Date;

public class NoticeDTO {
   private int notice_code;
   private String writer;
   private String subject;
   private String content;
   private String filename;
   private int filesize;
   private int readcount;
   private Date reg_date;
   private int c_count;
   public int getNotice_code() {
      return notice_code;
   }
   public void setNotice_code(int notice_code) {
      this.notice_code = notice_code;
   }
   public String getWriter() {
      return writer;
   }
   public void setWriter(String writer) {
      this.writer = writer;
   }
   public String getSubject() {
      return subject;
   }
   public void setSubject(String subject) {
      this.subject = subject;
   }
   public String getContent() {
      return content;
   }
   public void setContent(String content) {
      this.content = content;
   }
   public String getFilename() {
      return filename;
   }
   public void setFilename(String filename) {
      this.filename = filename;
   }
   public int getFilesize() {
      return filesize;
   }
   public void setFilesize(int filesize) {
      this.filesize = filesize;
   }
   public int getReadcount() {
      return readcount;
   }
   public void setReadcount(int readcount) {
      this.readcount = readcount;
   }
   public Date getReg_date() {
      return reg_date;
   }
   public void setReg_date(Date reg_date) {
      this.reg_date = reg_date;
   }
   public int getC_count() {
      return c_count;
   }
   public void setC_count(int c_count) {
      this.c_count = c_count;
   }
   
   
   
}