package com.jukemap.biz.juke.impl;

import java.util.List;

import com.jukemap.biz.juke.JukeVO;

public interface JukeService {
	// ��Ŀ �Է�
	public void insertMarker(JukeVO vo);
	public void upLikey(JukeVO vo);
	public void downLikey(JukeVO vo);
	public Integer getJukeTopnum();
	public JukeVO getJuke(JukeVO vo);
	public JukeVO getJukeIdAndSeq(JukeVO vo);
	public List<JukeVO> getJukeList(JukeVO vo);
	public JukeVO getJukeRandom(JukeVO vo);
	public List<JukeVO> getJukeListMax(JukeVO vo);
	public List<JukeVO> getJukeListDis(JukeVO vo);
	// ��Ŀ ��ȸ
	public List<JukeVO> getMarkerList(JukeVO vo);
}
