<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 해당페이지는 로그인 폼 페이지입니다 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<%
	if(session.getAttribute("loginMemberEmail") != null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>
<div class="container">
	<div class="jumbotron">
		<h1>로그인</h1>
	</div>
	<form method="post" action="<%=request.getContextPath()%>/member/loginAction.jsp">
	<table	class="table table-bordered">
		<tr>
			<td>이메일</td>
			<td><input type="text" name="memberEmail" class="form-control" value="shin@naver.com"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="memberPw" class="form-control" value="1234"></td>
		</tr>
	</table>
	<div class="d-flex justify-content-end">
		<button type="submit" class="btn btn-success">로그인</button>&nbsp;
		<a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-secondary">돌아가기</a>
	</div>
	</form>
</div>
</body>
</html>