package com.jukemap.biz.message;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jukemap.biz.message.impl.MessageDAOMybatis;
import com.jukemap.biz.message.impl.MessageService;

@Service("messageService")
public class MessageServiceImpl implements MessageService {
	@Autowired
	private MessageDAOMybatis messageDAO;
	
	@Override
	public void insertMsg(MessageVO vo) {
		// TODO Auto-generated method stub
		messageDAO.insertMsg(vo);
	}

	@Override
	public MessageVO getMsgTop(MessageVO vo) {
		// TODO Auto-generated method stub
		return messageDAO.getMsgTop(vo);
	}

	@Override
	public List<MessageVO> getMsgList(MessageVO vo) {
		// TODO Auto-generated method stub
		return messageDAO.getMsgList(vo);
	}

}
