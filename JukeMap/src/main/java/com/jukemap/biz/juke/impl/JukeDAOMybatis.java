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
	
	// ��Ŀ �Է�
	public void insertMarker(JukeVO vo) {
		System.out.println("===> Mybatis�� insertMarker() ��Ŀ �Է� ��� ó��");
		mybatis.insert("JukeDAO.insertMarker",vo);
	}
	
	public void upLikey(JukeVO vo) {
		System.out.println("===> Mybatis�� upLikey() ��� ó��");
		mybatis.insert("JukeDAO.upLikey",vo);
	}
	
	public void downLikey(JukeVO vo) {
		System.out.println("===> Mybatis�� downLikey() ��� ó��");
		mybatis.insert("JukeDAO.downLikey",vo);
	}
	
	public JukeVO getJuke(JukeVO vo) {
		System.out.println("===> Mybatis�� getJuke() ��Ŀ ��ȸ ��� ó��");
		return mybatis.selectOne("JukeDAO.getJuke", vo);
	}
	
	public List<JukeVO> getJukeList(JukeVO vo){
		System.out.println("===> Mybatis�� getJukeList() ��Ŀ ��ȸ ��� ó��");
		return mybatis.selectList("JukeDAO.getJukeList", vo);
	}
	
	// ��Ŀ ��ȸ
	public List<JukeVO> getMarkerList(JukeVO vo){
		System.out.println("===> Mybatis�� getMarkerList() ��Ŀ����Ʈ ��ȸ ��� ó��");
		return mybatis.selectList("JukeDAO.getMarkerList", vo);
	}
}
