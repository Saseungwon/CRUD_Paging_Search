<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 15 -->
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<body>
${search }
<form action="boardList.wow?curPage=1" method="post"> <!-- 폼 액션 서브밋 -->
	<!-- 38 글작성 버튼생성 -->
	<a href="boardForm.wow">글등록</a>
	<!-- BoardController에서 model.attribute에 "result" 로 해줘서 여기서 el로 쓸 수 있다.  -->
	<table border="1">
		<tr>
			<td>글번호</td>
			<td>제목</td>
			<td>작성자</td>
		</tr>
	
		<c:forEach items="${result }" var="board"><!-- BoardVO에 담긴 데이터를 ${result }에 담겨 있으니까 var로 사용가능 -->
			<tr>
				<td>${board.boNo }</td>
				<td><a href="boardView.wow?boNo=${board.boNo }">${board.boTitle }</a></td><!-- get방식 -->
				<td>${board.boWriter }</td>
			</tr>
		</c:forEach>
	</table>
	<!-- search 시작 -->
	<select name="searchType">
		<!-- T 제목 W 작성자 C 내용 -->
		<option value="T" ${search.searchType eq 'T' ? "selected='selected'" : "" }>제목</option>
		<option value="W" ${search.searchType eq 'W' ? "selected='selected'" : "" }>작성자</option>
		<option value="C" ${search.searchType eq 'C' ? "selected='selected'" : "" }>내용</option>
	</select>
	<input type="text" value="${search.searchWord }" name="searchWord" placeholder="검색어를 입력하세요"">
	<input type="submit" value="검색"> <br>
	
	<!-- 페이징 시작 -->
				<!-- pagingVO에 있는 객체들을 search에 담고 넣어줌 -->
		<!-- << 버튼 만들기 -->
		<c:if test="${search.firstPage ne 1}">
			<a data-page="1" href="#" onclick="f_ck(this)">&lt;&lt;</a>
		</c:if>
		
		<!-- < 버튼 만들기 -->
		<c:if test="${search.firstPage ne 1}">
			<a data-page="${search.firstPage - search.pageSize }" href="#" onclick="f_ck(this)">&lt;</a>
		</c:if>
		
		<c:forEach begin="${search.firstPage }" end="${search.lastPage }" var="i">
			<a data-page="${i }" href="#" onclick="f_ck(this)">${i }</a>
		</c:forEach>
	
		<!-- > 버튼 만들기 -->
		<c:if test="${search.lastPage ne search.totalPageCount}">
			<a data-page="${search.firstPage + search.pageSize }" href="#" onclick="f_ck(this)">&gt;</a>
		</c:if>
	
		<!-- >> 버튼 만들기 -->
		<c:if test="${search.curPage ne search.totalPageCount}">
			<a data-page="${search.totalPageCount }" href="#" onclick="f_ck(this)">&gt;&gt;</a>
		</c:if>
	<!-- 페이징 끝 -->
	
</form>

<script type="text/javascript">
	function f_ck(tag) {
		//a링크의 이벱트 막기, 검색할 때 페이징 넘기면 초기화 되는 거 때문에 onclick="f_ck(this)" 줌 
		event.preventDefault(); 
		document.forms[0].action = "boardList.wow?curPage=" + $(tag).attr('data-page'); 
		document.forms[0].submit();
		//console.log(tag);
	}
</script>
	

</body>
</html>