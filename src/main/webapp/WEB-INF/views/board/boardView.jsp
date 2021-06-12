<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 21 -->
</head>
<body>

<form action="boardRemove.wow" method="post">	<!-- 30 delete 시작 -->
	<!-- BoardController에서 model.attribute에 "result" 로 해줘서 여기서 el로 쓸 수 있다.  -->
	<input type="hidden" value="${board.boNo }" name="boNo">
	<table border="1">
		<tr>
			<td>글번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>글내용</td>
			<td>작성일</td>
		</tr>
	
		<tr>
			<td>${board.boNo }</td>
			<td>${board.boTitle }</td>
			<td>${board.boWriter }</td>
			<td>${board.boContent }</td>
			<td>${board.boRegDate }</td>
		</tr>
	</table>

	<!-- 22 수정시작 -->
	<a href="boardEdit.wow?boNo=${board.boNo }">수정</a>
	<!-- 31 -->
	<input type="submit" value="삭제">
</form>
</body>
</html>