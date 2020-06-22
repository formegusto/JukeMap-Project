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
	
	// �α��� ���
	@RequestMapping(value="/logout.do")
	public String logout(UserVO vo, HttpSession session,
			Model model) {
		System.out.println("[Spring Service MVC Framework] �α׾ƿ� ��� ó��");
		
		vo = (UserVO) session.getAttribute("user");
		loginUser.remove(vo.getId());
		
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
			System.out.println("�α��� ���� : DB�� ���� ����");
			String msg = "���̵�� �н����带 Ȯ�����ּ���.";
			model.addAttribute("msg", msg);
			return "login.jsp";
		} else {
			if(loginUser.get(vo.getId()) != null) {
				System.out.println("�α��� ���� : �̹� �α��� �Ǿ� �ִ� ���̵�");
				String msg = "�̹� ������ �ִ� ���̵� �Դϴ�.";
				model.addAttribute("msg", msg);
				return "login.jsp";
			}
			loginUser.put(vo.getId(), vo);
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
	
	// ��й�ȣ ã�� (���̵�üũ)
	@RequestMapping(value="/forgotCheck.do")
	public String forgotCheck(UserVO vo, HttpSession session,
			Model model) {
		System.out.println("[Spring Service MVC Framework] ���̵� ã�� ��� ó��");
		String rtnAdd = "";
		
		if(vo.getId() == null) {
			String msg = "�߸��� ���� �Դϴ�.";
			model.addAttribute("msg", msg);
			rtnAdd = "login.jsp";
		} else {
			UserVO user = userService.getUserId(vo);
			if(user == null) {
				String msg = "�������� �ʴ� ID �Դϴ�.";
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
	
	// ��й�ȣ ã�� (���̵�üũ)
	@RequestMapping(value="/forgotQuiz.do")
	public String forgotQuiz(UserVO vo, String ansJseq,
			HttpSession session, Model model) {
		System.out.println("[Spring Service MVC Framework] ���� ��Ī ��� ó��");
		String rtnAdd = "";
		
		if(ansJseq == null || vo.getId() == null) {
			String msg = "�߸��� ���� �Դϴ�.";
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
				String msg = "�����Դϴ�!";
				model.addAttribute("msg", msg);
				rtnAdd = "login.jsp";
			} else {
				String msg = "ID�� " + user.getId() + ", PASSWORD�� " + user.getPassword() + " �Դϴ�:)";
				model.addAttribute("msg", msg);
				rtnAdd = "login.jsp";			
			}
		}
			
		return rtnAdd;
	}
}
