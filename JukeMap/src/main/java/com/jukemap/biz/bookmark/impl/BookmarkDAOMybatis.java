package com.jukemap.biz.bookmark.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jukemap.biz.bookmark.BookmarkVO;

@Repository
public class BookmarkDAOMybatis {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void insertBM(BookmarkVO vo) {
		mybatis.insert("BookmarkDAO.insertBM", vo);
	}
	public void deleteBM(BookmarkVO vo) {
		mybatis.delete("BookmarkDAO.deleteBM", vo);
	}
	public Integer getTopBM(BookmarkVO vo) {
		return mybatis.selectOne("BookmarkDAO.getTopBM", vo);
	}
	public BookmarkVO getBM(BookmarkVO vo) {
		return mybatis.selectOne("BookmarkDAO.getBM", vo);
	}
	public List<BookmarkVO> getBMList(BookmarkVO vo) {
		return mybatis.selectList("BookmarkDAO.getBMList", vo);
	}
}
