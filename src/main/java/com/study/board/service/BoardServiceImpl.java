package com.study.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.study.board.dao.IBoardDao;
import com.study.board.vo.BoardVO;
import com.study.board.vo.SearchVO;

//5 메서드 생성    	//11 : Service 붙여주기
@Service
public class BoardServiceImpl implements IBoardService {

	//56
	@Override
	public int getBoardCount(SearchVO search) {
		return boardDao.getBoardCount(search); 
	}
	
	//8
	@Inject
	private IBoardDao boardDao ; 
	
	// 6 : ctrl space 누르면 재정의 해준다. 
	@Override
	public List<BoardVO> getBoardList(SearchVO search) { // 52 : SearchVO 추가
		//55
		int totalRowCount = boardDao.getBoardCount(search);
		search.setTotalRowCount(totalRowCount);
		search.pageSetting();
		//9
		return boardDao.getBoardList(search); 
	}
	
	//19 : dao service serviceimpl 다 똑같이 쓴다. 
	@Override
	public BoardVO getBoard(int boNo) {
		return boardDao.getBoard(boNo); 
	}
		
	//28
	@Override
		public void modifyBoard(BoardVO board) {
		//update만 실행시키고 끝내면 되니까 return이 필요없음
			boardDao.updateBoard(board); 
		}
	
	//35
	@Override
	public void removeBoard(BoardVO board) {
		boardDao.deleteBoard(board); 
	}
	
	//42
	@Override
	public void registBoard(BoardVO board) {
		boardDao.insertBoard(board); 
			
		}
	

}
