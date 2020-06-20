package com.jukemap.biz.message.impl;

import java.util.List;

import com.jukemap.biz.message.MessageVO;

public interface MessageService {
	public void insertMsg(MessageVO vo);
	public MessageVO getMsgTop(MessageVO vo);
	public List<MessageVO> getMsgList(MessageVO vo);
}
