package com.jukemap.biz.message.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jukemap.biz.message.MessageVO;

@Repository
public class MessageDAOMybatis {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void insertMsg(MessageVO vo) {
		mybatis.insert("MessageDAO.insertMsg", vo);
	}
	public MessageVO getMsgTop(MessageVO vo) {
		return mybatis.selectOne("MessageDAO.getMsgTop", vo);
	}
	public List<MessageVO> getMsgList(MessageVO vo) {
		return mybatis.selectList("MessageDAO.getMsgList", vo);
	}
}
