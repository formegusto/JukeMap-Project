package com.jukemap.biz.user.impl;

import com.jukemap.biz.user.UserVO;

public interface UserService {
	// ȸ�� ���� ó��
	public void insertUser(UserVO vo);
	// ȸ�� ��ȸ ó��
	public UserVO getUser(UserVO vo);
}
