package com.jukemap.view.juke;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.jukemap.biz.bookmark.BookmarkVO;
import com.jukemap.biz.bookmark.impl.BookmarkService;
import com.jukemap.biz.juke.JukeVO;
import com.jukemap.biz.juke.impl.JukeService;
import com.jukemap.biz.likey.LikeyVO;
import com.jukemap.biz.likey.impl.LikeyService;
import com.jukemap.biz.user.UserVO;

@Controller
public class JukeController {
	@Autowired
	JukeService jukeService;
	@Autowired
	BookmarkService bookmarkService;
	@Autowired
	LikeyService likeyService;
	
	@RequestMapping(value="/jukeMarkerAdd_proc.do")
	public String jukeMarkerAdd(JukeVO vo, 
			@RequestParam MultipartFile musicFile,
			HttpSession session) throws IllegalStateException, IOException {
		System.out.println(vo);
		jukeService.insertMarker(vo);
		
	
		String filePath = session.getServletContext().getRealPath("/music");
		String fileName = jukeService.getJukeTopnum() + ".mp3";
		
		File file = new File(filePath + "/" + fileName);
		System.out.println(file.getPath());
		
		musicFile.transferTo(file);
		
		return "redirect:jukeMap.do";
	}
	
	@RequestMapping(value="/jukeMap.do")
	public String jukeMap(JukeVO vo, HttpSession session,
			Model model) {
		UserVO user = (UserVO)session.getAttribute("user");
		
		System.out.println(user.getId());
		
		JukeVO jvo = new JukeVO();
		jvo.setId(user.getId());
		
		BookmarkVO bvo = new BookmarkVO();
		bvo.setId(user.getId());
		
		LikeyVO lvo = new LikeyVO();
		lvo.setId(user.getId());
		
		List<BookmarkVO> bmList = bookmarkService.getBMList(bvo);
		List<JukeVO> jbmList = new ArrayList<JukeVO>();
		for(BookmarkVO bm : bmList) {
			JukeVO juke = new JukeVO();
			juke.setJseq(bm.getJseq());
			jbmList.add(jukeService.getJuke(juke));
		}
		
		model.addAttribute("ujukeList", jukeService.getJukeList(jvo));
		model.addAttribute("likeyList", likeyService.getLikeyList(lvo));
		model.addAttribute("jukeList", jukeService.getMarkerList(vo));
		model.addAttribute("bmList", bmList);
		model.addAttribute("jbmList", jbmList);
		
		return "jukeMap.jsp";
	}
}
