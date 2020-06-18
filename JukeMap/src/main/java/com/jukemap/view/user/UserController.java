package com.jukemap.view.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jukemap.biz.user.UserVO;
import com.jukemap.biz.user.impl.UserService;

@Controller
public class UserController {
	@Autowired
	UserService userService;
	
	// �α��� ���
	@RequestMapping(value="/logout.do")
	public String logout(UserVO vo, HttpSession session,
			Model model) {
		System.out.println("[Spring Service MVC Framework] �α׾ƿ� ��� ó��");
		
		session.removeAttribute("user");
		return "redirect:login.jsp";
	}
	
	// �α��� ���
	@RequestMapping(value="/login.do")
	public String login(UserVO vo, HttpSession session,
			Model model) {
		System.out.println("[Spring Service MVC Framework] �α��� ��� ó��");
		UserVO user = userService.getUser(vo);
		if(user == null) {
			System.out.println("�α��� ����");
			String msg = "���̵�� �н����带 Ȯ�����ּ���.";
			model.addAttribute("msg", msg);
			return "login.jsp";
		} else {
			session.setAttribute("user", user);
			return "redirect:jukeMap.do";
		}
	}
	
	// ���� ���
	@RequestMapping(value="/register.do")
	public String register(UserVO vo, HttpSession session,
			Model model) {
		System.out.println("[Spring Service MVC Framework] ���� ��� ó��");
		
		if(vo.getId() == null || vo.getName() == null || vo.getPassword() == null) {
			String msg = "�߸��� ���� �Դϴ�.";
			model.addAttribute("msg", msg);
		} else {
			userService.insertUser(vo);
			session.setAttribute("user", vo);
		}
		
		return "login.jsp";
	}
}
