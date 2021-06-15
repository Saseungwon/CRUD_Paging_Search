# CRUD_Paging_Search
### IBoardDao
```java
package com.study.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.board.vo.BoardVO;
import com.study.board.vo.SearchVO;



// 7 Mapper 를 붙이면 IBoardDao 클래스를 인스턴스화 해서 스프링에 빈 객체로 등록을 한다. 그러면 다른 곳에서 사용 가능하게 해준다. BoardServiceImpl에서 사용
@Mapper 
public interface IBoardDao {
		// 1 :  BoardList 생성
		public List<BoardVO> getBoardList(SearchVO search); //51 SearchVO추가
		//16 : BoardView 생성(글번호가 뭔지 알아야 조회하니까 int boNo)
		public BoardVO getBoard(int boNo); 
		//25 : 업데이트 생성
		public void updateBoard(BoardVO board); 
		//32 : delete
		public void deleteBoard(BoardVO board); 
		//39 : insert
		public void insertBoard(BoardVO board); 
		//53 :페이징 추가
		public int getBoardCount(SearchVO search);
}
```

### BoardServiceImpl
```java
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
```
