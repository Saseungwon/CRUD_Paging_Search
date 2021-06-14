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
