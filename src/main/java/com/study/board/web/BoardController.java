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
