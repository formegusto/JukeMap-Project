package com.jukemap.biz.juke.impl;

import java.util.List;

import com.jukemap.biz.juke.JukeVO;

public interface JukeService {
	// 마커 입력
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
	// 마커 조회
	public List<JukeVO> getMarkerList(JukeVO vo);
}
