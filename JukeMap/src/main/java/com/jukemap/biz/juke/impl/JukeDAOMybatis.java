package com.jukemap.biz.juke.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jukemap.biz.juke.JukeVO;

@Repository
public class JukeDAOMybatis {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	// 마커 입력
	public void insertMarker(JukeVO vo) {
		System.out.println("===> Mybatis로 insertMarker() 마커 입력 기능 처리");
		mybatis.insert("JukeDAO.insertMarker",vo);
	}
	
	public void upLikey(JukeVO vo) {
		System.out.println("===> Mybatis로 upLikey() 기능 처리");
		mybatis.insert("JukeDAO.upLikey",vo);
	}
	
	public void downLikey(JukeVO vo) {
		System.out.println("===> Mybatis로 downLikey() 기능 처리");
		mybatis.insert("JukeDAO.downLikey",vo);
	}
	
	public JukeVO getJuke(JukeVO vo) {
		System.out.println("===> Mybatis로 getJuke() 마커 조회 기능 처리");
		return mybatis.selectOne("JukeDAO.getJuke", vo);
	}
	
	public List<JukeVO> getJukeList(JukeVO vo){
		System.out.println("===> Mybatis로 getJukeList() 마커 조회 기능 처리");
		return mybatis.selectList("JukeDAO.getJukeList", vo);
	}
	
	// 마커 조회
	public List<JukeVO> getMarkerList(JukeVO vo){
		System.out.println("===> Mybatis로 getMarkerList() 마커리스트 조회 기능 처리");
		return mybatis.selectList("JukeDAO.getMarkerList", vo);
	}
}
