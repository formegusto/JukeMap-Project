package com.jukemap.view.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jukemap.biz.user.UserVO;
import com.jukemap.biz.user.impl.UserService;

@Controller
public class UserController {
	@Autowired
	UserService userService;
	
	// �α��� ���
	@RequestMapping(value="/login.do")
	public String login(UserVO vo, HttpSession session) {
		System.out.println("[Spring Service MVC Framework] �α��� ��� ó��");
		UserVO user = userService.getUser(vo);
		if(user == null) {
			System.out.println("�α��� ����");
			return "login.jsp";
		} else {
			session.setAttribute("user", user);
			return "redirect:jukeMap.do";
		}
	}
	
	// ���� ���
	@RequestMapping(value="/register.do")
	public String register(UserVO vo, HttpSession session) {
		System.out.println("[Spring Service MVC Framework] ���� ��� ó��");
		userService.insertUser(vo);
		session.setAttribute("user", vo);
		return "login.jsp";
	}
}
