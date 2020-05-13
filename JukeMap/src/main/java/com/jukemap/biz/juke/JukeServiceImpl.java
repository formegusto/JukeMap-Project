package com.jukemap.biz.juke;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jukemap.biz.juke.impl.JukeDAOMybatis;
import com.jukemap.biz.juke.impl.JukeService;

@Service("jukeService")
public class JukeServiceImpl implements JukeService {
	@Autowired
	private JukeDAOMybatis jukeDAO;
	
	@Override
	public void insertMarker(JukeVO vo) {
		// TODO Auto-generated method stub
		jukeDAO.insertMarker(vo);
	}

	@Override
	public List<JukeVO> getMarkerList(JukeVO vo) {
		// TODO Auto-generated method stub
		return jukeDAO.getMarkerList(vo);
	}

}
