package com.jukemap.biz.juke.impl;

import java.util.List;

import com.jukemap.biz.juke.JukeVO;

public interface JukeService {
	// ��Ŀ �Է�
	public void insertMarker(JukeVO vo);
	
	// ��Ŀ ��ȸ
	public List<JukeVO> getMarkerList(JukeVO vo);
}
