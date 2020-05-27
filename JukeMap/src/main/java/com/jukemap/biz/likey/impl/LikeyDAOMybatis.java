package com.jukemap.biz.likey.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jukemap.biz.likey.LikeyVO;

@Repository
public class LikeyDAOMybatis {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void insertLikey(LikeyVO vo) {
		mybatis.insert("LikeyDAO.insertLikey", vo);
	}
	public void deleteLikey(LikeyVO vo) {
		mybatis.delete("LikeyDAO.deleteLikey", vo);
	}
	public Integer getTopLikey(LikeyVO vo) {
		return mybatis.selectOne("LikeyDAO.getTopLikey", vo);
	}
	public LikeyVO getLikey(LikeyVO vo) {
		return mybatis.selectOne("LikeyDAO.getLikey", vo);
	}
	public List<LikeyVO> getLikeyList(LikeyVO vo) {
		return mybatis.selectList("LikeyDAO.getLikeyList", vo);
	}
}
