package com.jukemap.biz.user.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jukemap.biz.user.UserVO;

@Repository
public class UserDAOMybatis {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	// 회원 가입 처리
	public void insertUser(UserVO vo) {
		System.out.println("===> Mybatis로 insertUser() 가입 기능 처리");
		mybatis.insert("UserDAO.insertUser",vo);
	}
	
	// 회원 조회 처리
	public UserVO getUser(UserVO vo) {
		System.out.println("===> Mybatis로 getUser() 조회 기능 처리");
		return mybatis.selectOne("UserDAO.getUser", vo);
	}
	
}
