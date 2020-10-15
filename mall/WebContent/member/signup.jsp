<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 화면</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$("#btn").click(function(){
			if($("#memberEmail").val() == "") {
				alert("이메일을 입력하세요!");
				return;
			}else if($("#memberPw").val() == "") {
				alert("비밀번호를 입력하세요!");
				return;
			}else if($("#memberName").val() == "") {
				alert("이름을 입력하세요!");
				return;
			}
			$("#signup").submit();
		});
	});
</script>
</head>
<body>
<div class="container">
	<div class="jumbotron">
		<h1>회원가입</h1>
	</div>
	<form method="post" action="<%=request.getContextPath()%>/member/signupAction.jsp" id="signup">
		<table class="table table-bordered">
			<tr>
				<td>이메일</td>
				<td><input type="text" name="memberEmail" class="form-control" id="memberEmail"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="memberPw" class="form-control" id="memberPw"></td>
			</tr>
			<tr>
				<td>사용자 이름</td>
				<td><input type="text" name="memberName" class="form-control" id="memberName"></td>
			</tr>
		</table>
		<div class="d-flex justify-content-end">
			<button type="button" id="btn" class="btn btn-success">회원가입하기</button>&nbsp;
			<a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-secondary">돌아가기</a>
		</div>
	</form>
</div>
</body>
</html>