package com.jukemap.biz.user.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jukemap.biz.user.UserVO;

@Repository
public class UserDAOMybatis {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	// ȸ�� ���� ó��
	public void insertUser(UserVO vo) {
		System.out.println("===> Mybatis�� insertUser() ���� ��� ó��");
		mybatis.insert("UserDAO.insertUser",vo);
	}
	
	// ȸ�� ��ȸ ó��
	public UserVO getUser(UserVO vo) {
		System.out.println("===> Mybatis�� getUser() ��ȸ ��� ó��");
		return mybatis.selectOne("UserDAO.getUser", vo);
	}
	
}
