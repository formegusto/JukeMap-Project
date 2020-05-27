package com.jukemap.biz.bookmark.impl;

import java.util.List;

import com.jukemap.biz.bookmark.BookmarkVO;

public interface BookmarkService {
	public void insertBM(BookmarkVO vo);
	public void deleteBM(BookmarkVO vo);
	public Integer getTopBM(BookmarkVO vo);
	public BookmarkVO getBM(BookmarkVO vo);
	public List<BookmarkVO> getBMList(BookmarkVO vo);
}
