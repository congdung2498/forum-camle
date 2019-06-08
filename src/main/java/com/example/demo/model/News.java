package com.example.demo.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class News {
	private int iD;
	private String title;
	private String summary;
	private String content;
	private String author;
	private String date;
	private ArrayList<UploadFileResponse> files;
	private int type;
	private ArrayList<Comment> comments;

	public News(int id, String title, String content,String author,String date,int type,String summary, ArrayList<UploadFileResponse> files){
		this.iD = id;
		this.title = title;
		this.content = content;
		this.author = author;
		this.date = date;
		this.type = type;
		this.summary = summary;
		this.files = files;
	}
	public News(){

	}

	public ArrayList<UploadFileResponse> getFiles() {
		return files;
	}

	public void setFiles(ArrayList<UploadFileResponse> files) {
		this.files = files;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}
	public int getiD() {
		return iD;
	}

	public void setiD(int iD) {
		this.iD = iD;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public ArrayList<Comment> getComments() {
		return comments;
	}

	public void setComments(ArrayList<Comment> comments) {
		this.comments = comments;
	}
}