package com.jukemap.biz.likey;

public class LikeyVO {
	private int lseq;
	private String id;
	private int jseq;
	
	public int getLseq() {
		return lseq;
	}
	public void setLseq(int lseq) {
		this.lseq = lseq;
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
		return "LikeyVO [lseq=" + lseq + ", id=" + id + ", jseq=" + jseq + "]";
	}
	
}
