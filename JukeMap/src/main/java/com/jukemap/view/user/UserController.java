package com.jukemap.view.user;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jukemap.biz.juke.JukeVO;
import com.jukemap.biz.juke.impl.JukeService;
import com.jukemap.biz.user.UserVO;
import com.jukemap.biz.user.impl.UserService;

@Controller
public class UserController {
	private Map<String,UserVO> loginUser = new HashMap<String, UserVO>();
	@Autowired
	UserService userService;
	@Autowired
	JukeService jukeService;
	
	// 로그인 기능
	@RequestMapping(value="/logout.do")
	public String logout(UserVO vo, HttpSession session,
			Model model) {
		System.out.println("[Spring Service MVC Framework] 로그아웃 기능 처리");
		
		vo = (UserVO) session.getAttribute("user");
		loginUser.remove(vo.getId());
		
		session.removeAttribute("user");
		
		
		return "redirect:login.jsp";
	}
	
	// 로그인 기능
	@RequestMapping(value="/login.do")
	public String login(UserVO vo, HttpSession session,
			Model model) {
		System.out.println("[Spring Service MVC Framework] 로그인 기능 처리");
		UserVO user = userService.getUser(vo);
		if(user == null) {
			System.out.println("로그인 실패 : DB에 없는 정보");
			String msg = "아이디와 패스워드를 확인해주세요.";
			model.addAttribute("msg", msg);
			return "login.jsp";
		} else {
			if(loginUser.get(vo.getId()) != null) {
				System.out.println("로그인 실패 : 이미 로그인 되어 있는 아이디");
				String msg = "이미 접속해 있는 아이디 입니다.";
				model.addAttribute("msg", msg);
				return "login.jsp";
			}
			loginUser.put(vo.getId(), vo);
			session.setAttribute("user", user);
			return "redirect:jukeMap.do";
		}
	}
	
	// 가입 기능
	@RequestMapping(value="/register.do")
	public String register(UserVO vo, HttpSession session,
			Model model) {
		System.out.println("[Spring Service MVC Framework] 가입 기능 처리");
		
		if(vo.getId() == null || vo.getName() == null || vo.getPassword() == null) {
			String msg = "잘못된 접근 입니다.";
			model.addAttribute("msg", msg);
		} else {
			userService.insertUser(vo);
			session.setAttribute("user", vo);
		}
		
		return "login.jsp";
	}
	
	// 비밀번호 찾기 (아이디체크)
	@RequestMapping(value="/forgotCheck.do")
	public String forgotCheck(UserVO vo, HttpSession session,
			Model model) {
		System.out.println("[Spring Service MVC Framework] 아이디 찾기 기능 처리");
		String rtnAdd = "";
		
		if(vo.getId() == null) {
			String msg = "잘못된 접근 입니다.";
			model.addAttribute("msg", msg);
			rtnAdd = "login.jsp";
		} else {
			UserVO user = userService.getUserId(vo);
			if(user == null) {
				String msg = "존재하지 않는 ID 입니다.";
				model.addAttribute("msg", msg);
				rtnAdd = "login.jsp";
			} else {
				JukeVO jvo = new JukeVO();
				jvo.setId(user.getId());
				
				List<JukeVO> quizList = jukeService.getJukeListMax(jvo);
				JukeVO ans = jukeService.getJukeRandom(jvo);
				quizList.add(ans);
				Collections.shuffle(quizList);
				
				model.addAttribute("user",user);
				model.addAttribute("quizList", quizList);
				rtnAdd = "forgotQuiz.jsp";
			}
		}
		
		return rtnAdd;
	}
	
	// 비밀번호 찾기 (아이디체크)
	@RequestMapping(value="/forgotQuiz.do")
	public String forgotQuiz(UserVO vo, String ansJseq,
			HttpSession session, Model model) {
		System.out.println("[Spring Service MVC Framework] 퀴즈 매칭 기능 처리");
		String rtnAdd = "";
		
		if(ansJseq == null || vo.getId() == null) {
			String msg = "잘못된 접근 입니다.";
			model.addAttribute("msg", msg);
			rtnAdd = "login.jsp";
		} else {
			UserVO user = userService.getUserId(vo);
			
			JukeVO jvo = new JukeVO();
			System.out.println(ansJseq);
			jvo.setJseq(Integer.parseInt(ansJseq));
			jvo.setId(vo.getId());
			JukeVO juke = jukeService.getJukeIdAndSeq(jvo);
			
			if(juke != null) {
				String msg = "오답입니다!";
				model.addAttribute("msg", msg);
				rtnAdd = "login.jsp";
			} else {
				String msg = "ID는 " + user.getId() + ", PASSWORD는 " + user.getPassword() + " 입니다:)";
				model.addAttribute("msg", msg);
				rtnAdd = "login.jsp";			
			}
		}
			
		return rtnAdd;
	}
}
