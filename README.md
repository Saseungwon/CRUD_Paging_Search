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

### PagingVO
```java
package com.study.common.vo;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;


//50 : 페이징 시작
@SuppressWarnings("serial")
public class PagingVO implements Serializable {
	//입력받는 데이터
	private int curPage = 1;          // 현재 페이지 번호
	private int rowSizePerPage = 10;  // 한 페이지당 레코드 수      기본5
	private int pageSize = 5;         // 페이지 리스트에서 보여줄 페이지 갯수  이거는 보통 10 or 5 안 변함 
	private int totalRowCount ;       // 총 레코드 건수
	
	
	//입력받는 데이터를 통해 계산되는 값
	private int firstRow ;           // 시작 레코드 번호   
	private int lastRow;             // 마지막 레코드 번호 
	private int totalPageCount;      // 총 페이지 건수
	private int firstPage; 	         // 페이지 리스트에서 시작  페이지 번호 
	private int lastPage;            // 페이지 리스트에서 마지막 페이지 번호 
	
	//page계산
	public void pageSetting() {
		firstRow=(curPage-1)*rowSizePerPage+1;
		lastRow=firstRow+rowSizePerPage-1;
		totalPageCount=(totalRowCount-1)/rowSizePerPage+1; 
		firstPage=((curPage-1)/pageSize)*pageSize+1;
		lastPage=firstPage+pageSize-1;
		if(lastPage>totalPageCount) {
			lastPage=totalPageCount;
		}
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getRowSizePerPage() {
		return rowSizePerPage;
	}

	public void setRowSizePerPage(int rowSizePerPage) {
		this.rowSizePerPage = rowSizePerPage;
	}

	public int getFirstRow() {
		return firstRow;
	}

	public void setFirstRow(int firstRow) {
		this.firstRow = firstRow;
	}

	public int getLastRow() {
		return lastRow;
	}

	public void setLastRow(int lastRow) {
		this.lastRow = lastRow;
	}

	public int getTotalRowCount() {
		return totalRowCount;
	}

	public void setTotalRowCount(int totalRowCount) {
		this.totalRowCount = totalRowCount;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getFirstPage() {
		return firstPage;
	}

	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

}
```

### src/main/resources/mybatis/mapper/board.xml
```java
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<!-- 3 : 네임스페이스는 Dao 주소  -->
<mapper namespace="com.study.board.dao.IBoardDao">

<!-- 54 -->
<select id="getBoardCount" resultType="int" parameterType="com.study.board.vo.SearchVO">
	select count(*)
	from free_board
	where bo_del_yn = 'N'
	<if test="searchWord != null"> <!-- 검색어에 따라 리스트 나오게 설정 -->
		<choose>
			<when test='searchType=="T"'>
				and bo_title like '%' || #{searchWord} || '%'
			</when>
			<when test='searchType=="W"'>
				and bo_writer like '%' || #{searchWord} || '%'
			</when>
			<when test='searchType=="C"'>
				and bo_content like '%' || #{searchWord} || '%'
			</when>
		</choose>
	</if>
</select>




<!-- 4 : sql에서 테이블을 셀렉트로 끌고와서 넣어주기  -->
<select id="getBoardList" resultType="com.study.board.vo.BoardVO" parameterType="com.study.board.vo.SearchVO"><!-- 52 : SearchVO 추가 -->

<!-- 페이징 하기 위해 쿼리 수정 -->
	select *
from
(select a.*, rownum as rnum 
from(
SELECT bo_no
       , bo_title
       , bo_category
       , bo_writer
       , bo_pass
       , bo_content
       , bo_ip
       , bo_hit
       , bo_reg_date
       , bo_mod_date
       , bo_del_yn
	FROM free_board
	where bo_del_yn = 'N'
	<if test="searchWord != null"> <!-- 검색어에 따라 리스트 나오게 설정 -->
		<choose>
			<when test='searchType=="T"'>
				and bo_title like '%' || #{searchWord} || '%'
			</when>
			<when test='searchType=="W"'>
				and bo_writer like '%' || #{searchWord} || '%'
			</when>
			<when test='searchType=="C"'>
				and bo_content like '%' || #{searchWord} || '%'
			</when>
		</choose>
	</if>
	order by bo_no desc) a)b
    where rnum between #{firstRow} and #{lastRow} 	

</select>

<!-- 17 : Dao에서 넣어놨던 파라미터 값을 무조건 parameterType에 써주기   -->
<select id="getBoard" resultType="com.study.board.vo.BoardVO" parameterType="int">

	SELECT bo_no
       , bo_title
       , bo_category
       , bo_writer
       , bo_pass
       , bo_content
       , bo_ip
       , bo_hit
       , bo_reg_date
       , bo_mod_date
       , bo_del_yn
	FROM free_board
	where bo_no = #{boNo}<!-- #{boNo} 이건 파라미터값 -->

</select>

<!-- 26 업데이트 : Dao에서 넣어놨던 파라미터 값을 무조건 parameterType에 써주기  -->
<update id="updateBoard" parameterType="com.study.board.vo.BoardVO">
	update free_board set
	bo_title = #{boTitle}, <!-- boardEdit.jsp에서 name으로 지정해준 값을 사용할 수 있다. -->
	bo_writer = #{boWriter}, 
	bo_content = #{boContent}
	where bo_no = #{boNo} 
</update>

<!-- 33 delete xml -->
<update id="deleteBoard" parameterType="com.study.board.vo.BoardVO">
	update free_board set
	bo_del_yn = 'Y'
	where bo_no = #{boNo}
</update>

<!-- 40  -->
<insert id="insertBoard" parameterType="com.study.board.vo.BoardVO" >
		INSERT INTO free_board (
	    bo_no
	    , bo_title
	    , bo_category
	    , bo_writer
	    , bo_pass
	    , bo_content
	    , bo_ip
	    , bo_hit
	    , bo_reg_date
	    , bo_mod_date
	    , bo_del_yn
	) VALUES (
	
	(select max(bo_no) + 1 from free_board)
	    , #{boTitle}
	    , 'BC01'
	    , #{boWriter}
	    , '1004'
	    , #{boContent}
	    , '0'
	    , 0
	    , sysdate
	    , null
	    , 'N'
	)

</insert>
</mapper>
```

### /src/main/resources/spring/appconfig.properties
```java
# appconfig.properties
# file encoding is UTF-8

# JDBC information
jdbc.driverClassName=oracle.jdbc.driver.OracleDriver
jdbc.url=jdbc:oracle:thin:@localhost:1521:xe
jdbc.username=jsp
jdbc.password=oracle
jdbc.defaultAutoCommit=false
jdbc.maxTotal=4
jdbc.minIdle=4
jdbc.validationQuery=SELECT 1 FROM dual

# File Upload (developer) 
file.upload.path=/home/pc42-pc/upload/ygy
```

### CRUD_Paging_Search/src/main/resources/spring/context-datasource.xml
```java 
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:aop="http://www.springframework.org/schema/aop"
	xmlns:cache="http://www.springframework.org/schema/cache"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:mybatis-spring="http://mybatis.org/schema/mybatis-spring"
	xmlns:util="http://www.springframework.org/schema/util"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xsi:schemaLocation="http://www.springframework.org/schema/cache http://www.springframework.org/schema/cache/spring-cache-4.3.xsd
		http://mybatis.org/schema/mybatis-spring http://mybatis.org/schema/mybatis-spring-1.2.xsd
		http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc-4.3.xsd
		http://www.springframework.org/schema/beans https://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-4.3.xsd
		http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop-4.3.xsd
		http://www.springframework.org/schema/util http://www.springframework.org/schema/util/spring-util-4.3.xsd">

	<!-- DB관련 -->
	<util:properties id="app" location="classpath:/spring/appconfig.properties"/>
	<bean id="dataSource" class="org.apache.commons.dbcp2.BasicDataSource" destroy-method="close">
		<property name="driverClassName" value="#{app['jdbc.driverClassName']}"/>
		<property name="url" value="#{app['jdbc.url']}"/>
		<property name="username" value="#{app['jdbc.username']}"/>
		<property name="password" value="#{app['jdbc.password']}"/>
		<property name="defaultAutoCommit" value="#{app['jdbc.defaultAutoCommit']}"/>
		<property name="maxTotal" value="#{app['jdbc.maxTotal']}"/>
		<property name="minIdle" value="#{app['jdbc.minIdle']}"/>
		<property name="validationQuery" value="#{app['jdbc.validationQuery']}"/>
	</bean>
	
	<!-- SqlSession setup for MyBatis Database Layer -->
	<bean id="sqlSession" class="org.mybatis.spring.SqlSessionFactoryBean">
		<property name="dataSource" ref="dataSource" />
		<property name="configLocation" value="classpath:mybatis/mybatis-config.xml" />
		<property name="mapperLocations" value="classpath:mybatis/mapper/*.xml" />
	</bean>
	
	<!-- 
		mybatis는 base-package의 모든 인터페이스를 찾아 구현체 생성
		이는 문제의 소지가 있으므로 @Mapper만 찾아서 구현체를 생성
	 -->
	<mybatis-spring:scan base-package="com.study" annotation="org.apache.ibatis.annotations.Mapper"/>

</beans>
```
