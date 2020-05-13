package com.jukemap.view.juke;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.jukemap.biz.juke.JukeVO;
import com.jukemap.biz.juke.impl.JukeService;

@Controller
public class JukeController {
	@Autowired
	JukeService jukeService;
	
	@RequestMapping(value="/jukeMarkerAdd_proc.do")
	public String jukeMarkerAdd(JukeVO vo, 
			@RequestParam MultipartFile musicFile,
			HttpSession session) throws IllegalStateException, IOException {
		System.out.println(vo);
		vo.setId("admin");
		vo.setLikey(0);
		jukeService.insertMarker(vo);
		String filePath = session.getServletContext().getRealPath("/music");
		String fileName = "1.mp3";
		
		File file = new File(filePath + "/" + fileName);
		System.out.println(file.getPath());
		
		musicFile.transferTo(file);
		
		return "redirect:jukeMap.do";
	}
	
	@RequestMapping(value="/jukeMap.do")
	public String jukeMap(JukeVO vo, Model model) {
		
		model.addAttribute("jukeList", jukeService.getMarkerList(vo));
		
		return "jukeMap.jsp";
	}
}
