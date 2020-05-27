package com.jukemap.view.community;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.web.socket.server.standard.SpringConfigurator;;

@ServerEndpoint(value="/community.do", configurator=SpringConfigurator.class)
public class WebSocketCommunity {
	private static List<Session> clientList = new ArrayList<Session>();
	
	public WebSocketCommunity() {
		System.out.println("[昆家南(辑滚)] 目孤聪萍 家南 积己");
	}
	
	@OnOpen
	public void onOpen(Session session) {
		clientList.add(session);
	}
	
	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		System.out.println(message);
		
		for(Session client : clientList)
			if(client.equals(session)) {
				client.getBasicRemote().sendText(message);
				break;
			}
	}
	
	@OnClose
	public void onClose(Session session) {
		clientList.remove(session);
	}
}
