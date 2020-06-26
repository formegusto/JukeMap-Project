package com.jukemap.view.community;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.server.standard.SpringConfigurator;

import com.jukemap.biz.bookmark.BookmarkVO;
import com.jukemap.biz.bookmark.impl.BookmarkService;
import com.jukemap.biz.juke.JukeVO;
import com.jukemap.biz.juke.impl.JukeService;
import com.jukemap.biz.likey.LikeyVO;
import com.jukemap.biz.likey.impl.LikeyService;
import com.jukemap.biz.message.MessageVO;
import com.jukemap.biz.message.impl.MessageService;;

@ServerEndpoint(value="/community.do", configurator=SpringConfigurator.class)
public class WebSocketCommunity {
	@Autowired
	private BookmarkService bookmarkService;
	@Autowired
	private LikeyService likeyService;
	@Autowired
	private JukeService jukeService;
	@Autowired
	private MessageService messageService;
	private static List<Session> clientList = new ArrayList<Session>();
	private static Map<String,Session> clientMap = new HashMap<String, Session>();
	
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
		String messageType = message.split("\\|")[0];
		
		if(messageType.contains("msg")) {
			if(messageType.equals("inmsg")) {
				String id = message.split("\\|")[1];
				clientMap.put(id, session);
				System.out.println(id+"|inmsgOkay");
			}else if(messageType.equals("outmsg")) {
				String id = message.split("\\|")[1];
				clientMap.remove(id);
				System.out.println(id+"|outmsgOkay");
			}else if(messageType.equals("sendmsg")) {
				String to = message.split("\\|")[1];
				String from = message.split("\\|")[2];
				String msg = message.split("\\|")[3];
				
				Session sendSession = clientMap.get(to);
				MessageVO vo = new MessageVO();
				vo.setToid(to);
				vo.setFromid(from);
				vo.setMsg(msg);
				messageService.insertMsg(vo);
				
				MessageVO topMsg = messageService.getMsgTop(vo);
				
				message = "sendmsg|" + topMsg.getMseq() + "|" + from + "|" + msg;
				if(sendSession != null) {
					sendSession.getBasicRemote().sendText(message);
				}
			}
		}
		else {
			for(Session client : clientList)
				if(client.equals(session)) {
					if(messageType.equals("onbookmark")) {
						String seq = message.split("\\|")[1];
						String id = message.split("\\|")[2];
						BookmarkVO vo = new BookmarkVO();
						vo.setId(id);
						vo.setJseq(Integer.parseInt(seq));
						bookmarkService.insertBM(vo);
						System.out.println("[Server] insertBM");
						
						JukeVO jvo = new JukeVO();
						jvo.setJseq(Integer.parseInt(seq));
						JukeVO juke = jukeService.getJuke(jvo);
						
						message = messageType + "|" + seq + "|" + bookmarkService.getTopBM(vo) + "|" + 
								juke.getTitle() + "|" + juke.getId() + "|" + juke.getContent() + "|" + 
								juke.getLikey() + "|" + juke.getLat() + "|" + juke.getLon();
					} else if(messageType.equals("offbookmark")) {
						String bmseq = message.split("\\|")[1];
						BookmarkVO vo = new BookmarkVO();
						vo.setBmseq(Integer.parseInt(bmseq));
						int jseq = bookmarkService.getBM(vo).getJseq();
						int bseq = bookmarkService.getBM(vo).getBmseq();
						bookmarkService.deleteBM(vo);
						System.out.println("[Server] deleteBM");
						message = messageType + "|" + jseq + "|" + bseq;
					} else if(messageType.equals("onlikey")) {
						String seq = message.split("\\|")[1];
						String id = message.split("\\|")[2];
						LikeyVO vo = new LikeyVO();
						vo.setId(id);
						vo.setJseq(Integer.parseInt(seq));
						likeyService.insertLikey(vo);
						
						JukeVO jvo = new JukeVO();
						jvo.setJseq(Integer.parseInt(seq));
						jukeService.upLikey(jvo);
						
						System.out.println("[Server] insertLikey");
						message = messageType + "|" + seq + "|" + likeyService.getTopLikey(vo);
					} else if(messageType.equals("offlikey")) {
						String lseq = message.split("\\|")[1];
						LikeyVO vo = new LikeyVO();
						vo.setLseq(Integer.parseInt(lseq));
						int seq = likeyService.getLikey(vo).getJseq();
						likeyService.deleteLikey(vo);
						
						JukeVO jvo = new JukeVO();
						jvo.setJseq(seq);
						jukeService.downLikey(jvo);
						
						System.out.println("[Server] deleteLikey");
						message = messageType + "|" + seq;
					}
					
					client.getBasicRemote().sendText(message);
					break;
				}
		}
	}
	
	@OnClose
	public void onClose(Session session) {
		clientList.remove(session);
		System.out.println("摧躯唱夸?");
	}
}
