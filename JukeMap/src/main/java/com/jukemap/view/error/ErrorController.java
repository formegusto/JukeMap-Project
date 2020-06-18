package com.jukemap.view.error;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorController {
	@RequestMapping(value="/badRs.do")
	public String loginFail(Model model) throws IOException {
		System.out.println("[Spring Service MVC Framework] �α��� ���� ��� ó��");
		
		String msg = "�߸��� ���� �Դϴ�.";
		model.addAttribute("msg", msg);
		
		return "login.jsp";
	}
}
