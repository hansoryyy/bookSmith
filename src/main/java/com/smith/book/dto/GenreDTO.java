package com.smith.book.dto;

import java.io.Serializable;

public class GenreDTO implements Serializable {
	
	private int g_code;
	private String name;
	
	public int getG_code() {
		return g_code;
	}
	public void setG_code(int g_code) {
		this.g_code = g_code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

}
