package com.jukemap.biz.likey;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jukemap.biz.likey.impl.LikeyDAOMybatis;
import com.jukemap.biz.likey.impl.LikeyService;

@Service("likeyService")
public class LikeyServiceImpl implements LikeyService {
	@Autowired
	private LikeyDAOMybatis likeyDAO;
	
	@Override
	public void insertLikey(LikeyVO vo) {
		// TODO Auto-generated method stub
		likeyDAO.insertLikey(vo);
	}

	@Override
	public void deleteLikey(LikeyVO vo) {
		// TODO Auto-generated method stub
		likeyDAO.deleteLikey(vo);
	}

	@Override
	public Integer getTopLikey(LikeyVO vo) {
		// TODO Auto-generated method stub
		return likeyDAO.getTopLikey(vo);
	}

	@Override
	public LikeyVO getLikey(LikeyVO vo) {
		// TODO Auto-generated method stub
		return likeyDAO.getLikey(vo);
	}

	@Override
	public List<LikeyVO> getLikeyList(LikeyVO vo) {
		// TODO Auto-generated method stub
		return likeyDAO.getLikeyList(vo);
	}

}
