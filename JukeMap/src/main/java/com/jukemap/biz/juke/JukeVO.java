package com.jukemap.biz.juke;

import java.sql.Date;

public class JukeVO {
	private int jseq;
	private double lat;
	private double lon;
	private String id;
	private String title;
	private String content;
	private int likey;
	private Date regdate;
	private double dis;

	public int getJseq() {
		return jseq;
	}
	public void setJseq(int jseq) {
		this.jseq = jseq;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLon() {
		return lon;
	}
	public void setLon(double lon) {
		this.lon = lon;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public int getLikey() {
		return likey;
	}
	public void setLikey(int likey) {
		this.likey = likey;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public double getDis() {
		return dis;
	}
	public void setDis(double dis) {
		this.dis = dis;
	}
	
	@Override
	public String toString() {
		return "JukeVO [jseq=" + jseq + ", lat=" + lat + ", lon=" + lon + ", id=" + id + ", title=" + title
				+ ", content=" + content + ", likey=" + likey + ", regdate=" + regdate + ", dis=" + dis + "]";
	}
}
