package com.study.board.vo;

import com.study.common.vo.PagingVO;

public class SearchVO  extends PagingVO{
	// 60 : 검색 시작    제목 작성자 내용
	private String searchType; 
	private String searchWord;
	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	} 
	
	
}
