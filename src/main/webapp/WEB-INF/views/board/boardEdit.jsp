<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 24 -->
</head>
<body>
	<!-- BoardController에서 model.attribute에 "result" 로 해줘서 여기서 el로 쓸 수 있다.  -->
<form action="boardModify.wow" method="post">
	<table border="1">
		<tr>
			<td>글번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>글내용</td>
			<td>작성일</td>
		</tr>
		
		<!-- post방식 : form태그, form action, submit버튼 -->
		<tr>
			<td>
				${board.boNo }
				<input type="hidden" value="${board.boNo }" name="boNo">
				<!-- xml에서 boNo식별할 수 있도록 하지만 사용자가 수정은 못하게 boNo Hidden으로 넣어줌 -->
			</td>
			<td>
				<input type="text" value="${board.boTitle }" name="boTitle">   <!--name속성 중요  xml에서 사용가능 -->
			</td>
						<td>
				<input type="text" value="${board.boWriter }" name="boWriter">		<!--name속성 중요  -->
			</td>
						<td>
				<input type="text" value="${board.boContent }" name="boContent">		<!--name속성 중요  -->
			</td>
			<td>${board.boRegDate }</td>
		</tr>
	</table>
	<input type="submit" value="수정">
</form>
</body>
</html>