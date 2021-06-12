package com.study.board.service;

import java.util.List;

import com.study.board.vo.BoardVO;
import com.study.board.vo.SearchVO;

// 4 
public interface IBoardService {
	//5
	public List<BoardVO> getBoardList(SearchVO search); // 52 : SearchVO 추가
	// 18 : IBoardDao에 있는 메서드 복붙
	public BoardVO getBoard(int boNo); 
	
	//27 
	public void modifyBoard(BoardVO board); 
	
	//34
	public void removeBoard(BoardVO board); 
	
	//41
	public void registBoard(BoardVO board); 
	
	//55
	public int getBoardCount(SearchVO search);
}
