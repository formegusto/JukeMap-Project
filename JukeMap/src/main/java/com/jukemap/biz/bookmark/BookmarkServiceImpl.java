package com.jukemap.biz.bookmark;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jukemap.biz.bookmark.impl.BookmarkDAOMybatis;
import com.jukemap.biz.bookmark.impl.BookmarkService;

@Service("bookmarkService")
public class BookmarkServiceImpl implements BookmarkService {
	@Autowired
	private BookmarkDAOMybatis bookmarkDAO;
	
	@Override
	public void insertBM(BookmarkVO vo) {
		// TODO Auto-generated method stub
		bookmarkDAO.insertBM(vo);
	}
	
	@Override
	public void deleteBM(BookmarkVO vo) {
		// TODO Auto-generated method stub
		bookmarkDAO.deleteBM(vo);
	}
	
	@Override
	public Integer getTopBM(BookmarkVO vo) {
		// TODO Auto-generated method stub
		return bookmarkDAO.getTopBM(vo);
	}

	@Override
	public BookmarkVO getBM(BookmarkVO vo) {
		// TODO Auto-generated method stub
		return bookmarkDAO.getBM(vo);
	}

	@Override
	public List<BookmarkVO> getBMList(BookmarkVO vo) {
		// TODO Auto-generated method stub
		return bookmarkDAO.getBMList(vo);
	}

}
