<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 세션에 회원이메일이 없다면(로그아웃이 되어 있다면) -> 로그인 페이지로 이동하기
	if(session.getAttribute("loginMemberEmail") == null) {
		response.sendRedirect(request.getContextPath() + "/member/login.jsp");
		return;
	}
 %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>myPage</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- 부트스트랩의 아이콘을 이용하기 위한 링크 -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
</head>
<body>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 세션으로부터 이메일값 받아오기
	String memberEmail = (String)session.getAttribute("loginMemberEmail");
	// 쿼리 결과 받아오기
	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMyInfo(memberEmail);
%>
<div class="container">
	<!-- 상단 타이틀, 검색창, 주문조회 및 장바구니 -->
	<div style="margin-top:30px;" align="center">	
		<div class="row">
			<div class="col">
				<span><h1><a href="<%=request.getContextPath()%>/index.jsp" style='color: black'>Goodee Shop</a></h1></span>
			</div>
			<div class="col">
				<form>
					<div class="input-group mb-3">
						<input type="text" class="form-control" style="width:200px;" placeholder="검색할 키워드를 입력해 주세요.">
						<div class="input-group-append">
							<button type="submit" class="btn btn-secondary">검색</button>	
						</div>				
					</div>
				</form>
			</div>
			<div class="col">
				<span class="badge badge-pill badge-light">마이페이지</span>
				<a href="<%=request.getContextPath()%>/member/myPage.jsp">
					<i class='fas fa-user-alt' style='font-size: 38px;margin-right: 10px;color: black'></i>
				</a>
				<span class="badge badge-pill badge-light">주문정보</span>
				<a href="<%=request.getContextPath()%>/orders/myOrdersList.jsp">	
					<i class='fas fa-shopping-cart' style='font-size:38px;color: black'></i>
				</a>
			</div>
		</div>
	</div>
	
	<!-- 로그인,회원가입 메뉴바 -->
	<div>	
		<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		  <ul class="navbar-nav mr-auto"></ul>
		  	<ul class="navbar-nav">
		  	<%
		  		if(session.getAttribute("loginMemberEmail") == null) {
		  	%>
			<!-- 로그아웃 상태 -->
			    <li class="nav-item">
			      <a class="nav-link" href="<%=request.getContextPath()%>/member/login.jsp"">로그인</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="<%=request.getContextPath()%>/member/signup.jsp">회원가입</a>
			    </li>
		   <%
		  		}else {
		   %>
			<!-- 로그인 상태 -->
				<li class="nav-item text-white" style="align-self: center;">
					<strong><%=session.getAttribute("loginMemberEmail")%></strong>님&nbsp;
			    </li>
				<li class="nav-item">
			      	<a class="nav-link" href="<%=request.getContextPath()%>/member/logoutAction.jsp">로그아웃</a>
			    </li>
			<%
		  		}
			%>
		   </ul>
		</nav>
	</div>
	<!-- 타이틀 -->
	<div class="jumbotron">
		<h1>마이페이지</h1>
	</div>
	
	<!-- 테이블 출력 -->
	<form method="post" action="<%=request.getContextPath()%>/member/updateMemberPw.jsp">
		<table class="table">
			<tr>
				<th>이메일</th>
				<td>
					<input class="form-control" type="text" name="memberEmail" value="<%=member.getMemberEmail()%>" readonly="readonly">
					<input type="hidden" name="memberPw" value="<%=member.getMemberPassword()%>">
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input class="form-control" type="text" name="memberName" value="<%=member.getMemberName()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>가입날짜</th>
				<td><%=member.getMemberDate()%></td>
			</tr>
		</table>
		<!-- 비빌번호 변경 페이지 이동 -->
		<div class="d-flex justify-content-end">
			<button type="submit" class="btn btn-info">비밀번호 변경</button>
		</div>
	</form>
</div>
</body>
</html>