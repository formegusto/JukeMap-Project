package com.jukemap.biz.likey.impl;

import java.util.List;

import com.jukemap.biz.likey.LikeyVO;

public interface LikeyService {
	public void insertLikey(LikeyVO vo);
	public void deleteLikey(LikeyVO vo);
	public Integer getTopLikey(LikeyVO vo);
	public LikeyVO getLikey(LikeyVO vo);
	public List<LikeyVO> getLikeyList(LikeyVO vo);
}
