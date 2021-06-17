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

### BoardVO
```java
package com.study.board.vo;

public class BoardVO {
	
	// 2 : 오라클에서 vo 생성쿼리로 테이블 가져온다. 게터세터 만들어준다. 
	private int boNo;                       /*글 번호*/
	private String boTitle;                 /*글 제목*/
	private String boCategory;              /*글 분류 코드*/
	private String boWriter;                /*작성자명*/
	private String boPass;                  /*비밀번호*/
	private String boContent;               /*글 내용*/
	private String boIp;                    /*등록자 IP*/
	private int boHit;                      /*조회수*/
	private String boRegDate;               /*등록 일자*/
	private String boModDate;               /*수정 일자*/
	private String boDelYn;                 /*삭제 여부*/
	public int getBoNo() {
		return boNo;
	}
	public void setBoNo(int boNo) {
		this.boNo = boNo;
	}
	public String getBoTitle() {
		return boTitle;
	}
	public void setBoTitle(String boTitle) {
		this.boTitle = boTitle;
	}
	public String getBoCategory() {
		return boCategory;
	}
	public void setBoCategory(String boCategory) {
		this.boCategory = boCategory;
	}
	public String getBoWriter() {
		return boWriter;
	}
	public void setBoWriter(String boWriter) {
		this.boWriter = boWriter;
	}
	public String getBoPass() {
		return boPass;
	}
	public void setBoPass(String boPass) {
		this.boPass = boPass;
	}
	public String getBoContent() {
		return boContent;
	}
	public void setBoContent(String boContent) {
		this.boContent = boContent;
	}
	public String getBoIp() {
		return boIp;
	}
	public void setBoIp(String boIp) {
		this.boIp = boIp;
	}
	public int getBoHit() {
		return boHit;
	}
	public void setBoHit(int boHit) {
		this.boHit = boHit;
	}
	public String getBoRegDate() {
		return boRegDate;
	}
	public void setBoRegDate(String boRegDate) {
		this.boRegDate = boRegDate;
	}
	public String getBoModDate() {
		return boModDate;
	}
	public void setBoModDate(String boModDate) {
		this.boModDate = boModDate;
	}
	public String getBoDelYn() {
		return boDelYn;
	}
	public void setBoDelYn(String boDelYn) {
		this.boDelYn = boDelYn;
	}
}
```

### SearchVO
```java
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
```

### BoardController
```java
package com.study.board.web;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.board.service.IBoardService;
import com.study.board.vo.BoardVO;
import com.study.board.vo.SearchVO;

//10 컨트롤러 생성	//13 @Controller 붙여주기 
@Controller
public class BoardController {
	
	//12 BoardServiceImpl에서 Service해준 거 @Inject 해주기  
	@Inject
	private IBoardService boardService; 
	
	//11 : @RequestMapping 으로 매핑 
	@RequestMapping("/board/boardList.wow")
	public String boardList(Model model, SearchVO search) {	// 52 : SearchVO 추가
		// 14 Model 에 담아주고 model.addAttribute 해주기 
		List<BoardVO> list = boardService.getBoardList(search); //List<BoardVO>
		model.addAttribute("result",list);  // 여기서 "result"는 BoardVO에 있는 객체를 사용할 수 있게 만들어준다. 
		model.addAttribute("search",search); 
		return "board/boardList"; 
	}
	
	//20
	@RequestMapping("/board/boardView.wow")
	public String boardView(Model model, @RequestParam("boNo") int num) { //@RequestParam은 주소창에서 boNo 뒤에 있는 숫자를 가져오는 기능
		BoardVO board = boardService.getBoard(num); 
		model.addAttribute("board",board); 
		return "board/boardView";
		
	}

	//23
	@RequestMapping("/board/boardEdit.wow")
	public String boarEdit(Model model, @RequestParam("boNo") int boNo) { //@RequestParam은 주소창에서 boNo 뒤에 있는 숫자를 가져오는 기능(파라미터 안에 들어가는 값은 상관 없음)
		BoardVO board = boardService.getBoard(boNo); 
		model.addAttribute("board",board); 
		return "board/boardEdit";
		
	}
	
	//29
	//@RequestMapping(value="/board/boardModify.wow", method = RequestMethod.POST)
	@PostMapping("/board/boardModify.wow")
	public String boardModify(BoardVO board) {
		boardService.modifyBoard(board);
		return "redirect:/board/boardView.wow?boNo=" + board.getBoNo(); //수정한 걸로 가기위해  redirect 하고 무슨 글인지 알기 위해 getBoNo
	}
	
	//36
	@PostMapping("/board/boardRemove.wow")
	public String boardRemove(BoardVO board) {
		boardService.removeBoard(board);
		return "redirect:/board/boardList.wow"; 
	}
	
	//38 글작성 폼
	@RequestMapping("/board/boardForm.wow")
	public String boardForm() {
		return "board/boardForm"; 
	}
	
	//43
	@PostMapping("/board/boardRegist.wow")
	public String boardRegist(BoardVO board) {
		boardService.registBoard(board);
		return "redirect:/board/boardList.wow"; 
	}	
}
```
