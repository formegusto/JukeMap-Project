package com.jukemap.biz.message;

public class MessageVO {
	private int mseq;
	private String toid;
	private String fromid;
	private String msg;
	public int getMseq() {
		return mseq;
	}
	public void setMseq(int mseq) {
		this.mseq = mseq;
	}
	public String getToid() {
		return toid;
	}
	public void setToid(String toid) {
		this.toid = toid;
	}
	public String getFromid() {
		return fromid;
	}
	public void setFromid(String fromid) {
		this.fromid = fromid;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	@Override
	public String toString() {
		return "messageVO [mseq=" + mseq + ", toid=" + toid + ", fromid=" + fromid + ", msg=" + msg + "]";
	}
}
