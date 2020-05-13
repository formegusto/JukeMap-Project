package com.jukemap.biz.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jukemap.biz.user.impl.UserDAOMybatis;
import com.jukemap.biz.user.impl.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDAOMybatis userDAO;
	
	@Override
	public void insertUser(UserVO vo) {
		// TODO Auto-generated method stub
		userDAO.insertUser(vo);
	}

	@Override
	public UserVO getUser(UserVO vo) {
		// TODO Auto-generated method stub
		return userDAO.getUser(vo);
	}

}
