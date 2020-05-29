package com.jukemap.view.user;

import java.io.IOException;

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
	
	// 로그인 실패
	@RequestMapping(value="/loginFail.do")
	public String loginFail(Model model) throws IOException {
		System.out.println("[Spring Service MVC Framework] 로그인 실패 기능 처리");
		
		String msg = "잘못된 접근 입니다.";
		model.addAttribute("msg", msg);
		
		return "login.jsp";
	}
		
	// 로그인 기능
	@RequestMapping(value="/login.do")
	public String login(UserVO vo, HttpSession session,
			Model model) {
		System.out.println("[Spring Service MVC Framework] 로그인 기능 처리");
		UserVO user = userService.getUser(vo);
		if(user == null) {
			System.out.println("로그인 실패");
			String msg = "아이디와 패스워드를 확인해주세요.";
			model.addAttribute("msg", msg);
			return "login.jsp";
		} else {
			session.setAttribute("user", user);
			return "redirect:jukeMap.do";
		}
	}
	
	// 가입 기능
	@RequestMapping(value="/register.do")
	public String register(UserVO vo, HttpSession session) {
		System.out.println("[Spring Service MVC Framework] 가입 기능 처리");
		userService.insertUser(vo);
		session.setAttribute("user", vo);
		return "login.jsp";
	}
}
