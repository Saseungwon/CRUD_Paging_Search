<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 37 : 글작성 시작 -->
</head>
<body>
	<!-- BoardController에서 model.attribute에 "result" 로 해줘서 여기서 el로 쓸 수 있다.  -->
<form action="boardRegist.wow" method="post">
	<table border="1">
		<tr>
			<td>제목</td>
			<td>작성자</td>
			<td>글내용</td>
		</tr>
		
		<!-- post방식 : form태그, form action, submit버튼 -->
		<tr>
			<td>
				<input type="text" value="" name="boTitle">   <!--name속성 중요  xml에서 사용가능 -->
			</td>
						<td>
				<input type="text" value="" name="boWriter">		<!--name속성 중요  -->
			</td>
						<td>
				<input type="text" value="" name="boContent">		<!--name속성 중요  -->
			</td>
			<td>${board.boRegDate }</td>
		</tr>
	</table>
	<input type="submit" value="글작성">
</form>
</body>
</html>