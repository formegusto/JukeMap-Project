package com.jukemap.biz.juke.impl;

import java.util.List;

import com.jukemap.biz.juke.JukeVO;

public interface JukeService {
	// 마커 입력
	public void insertMarker(JukeVO vo);
	public void upLikey(JukeVO vo);
	public void downLikey(JukeVO vo);
	public JukeVO getJuke(JukeVO vo);
	public List<JukeVO> getJukeList(JukeVO vo);
	// 마커 조회
	public List<JukeVO> getMarkerList(JukeVO vo);
}
