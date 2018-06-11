package com.smith.book.dto;

import java.util.Date;

public class QnaDTO {

	private int qna_code;
	private String writer;
	private String subject;
	private String content;
	private String filename;
	private int filesize;
	private Date reg_date;
	private int m_code;
	private String re_writer;
	private String re_content;
	private String re_filename;
	private int re_filesize;
	private Date re_reg_date;

	public int getQna_code() {
		return qna_code;
	}

	public void setQna_code(int qna_code) {
		this.qna_code = qna_code;
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

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public int getM_code() {
		return m_code;
	}

	public void setM_code(int m_code) {
		this.m_code = m_code;
	}

	public String getRe_writer() {
		return re_writer;
	}

	public void setRe_writer(String re_writer) {
		this.re_writer = re_writer;
	}

	public String getRe_content() {
		return re_content;
	}

	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}

	public String getRe_filename() {
		return re_filename;
	}

	public void setRe_filename(String re_filename) {
		this.re_filename = re_filename;
	}

	public int getRe_filesize() {
		return re_filesize;
	}

	public void setRe_filesize(int re_filesize) {
		this.re_filesize = re_filesize;
	}

	public Date getRe_reg_date() {
		return re_reg_date;
	}

	public void setRe_reg_date(Date re_reg_date) {
		this.re_reg_date = re_reg_date;
	}

}
