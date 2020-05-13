package com.jukemap.biz.user.impl;

import com.jukemap.biz.user.UserVO;

public interface UserService {
	// 회원 가입 처리
	public void insertUser(UserVO vo);
	// 회원 조회 처리
	public UserVO getUser(UserVO vo);
}
