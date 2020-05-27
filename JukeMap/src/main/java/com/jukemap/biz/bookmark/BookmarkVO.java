package com.jukemap.biz.bookmark;

public class BookmarkVO {
	private int bmseq;
	private String id;
	private int jseq;
	
	public int getBmseq() {
		return bmseq;
	}
	public void setBmseq(int bmseq) {
		this.bmseq = bmseq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getJseq() {
		return jseq;
	}
	public void setJseq(int jseq) {
		this.jseq = jseq;
	}
	
	@Override
	public String toString() {
		return "BookmarkVO [bmseq=" + bmseq + ", id=" + id + ", jseq=" + jseq + "]";
	}
}
