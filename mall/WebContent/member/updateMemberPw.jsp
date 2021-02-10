<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//세션에 회원이메일이 없다면(로그아웃이 되어 있다면) -> 로그인 페이지로 이동하기
	if(session.getAttribute("loginMemberEmail") == null) {
		response.sendRedirect(request.getContextPath() + "/member/login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
</head>
<body>
<%
	// 인코딩 설정
	request.setCharacterEncoding("utf-8");
	
	// memberEmail 받기
	String memberEmail = "";
	if(request.getParameter("memberEmail") != null) {
		memberEmail = request.getParameter("memberEmail");
		//System.out.println(memberEmail + "<--받은 이메일");
	}
	
	// 비밀번호
	int memberPw = 0;
	if(request.getParameter("memberPw") != null) {
		memberPw = Integer.parseInt(request.getParameter("memberPw"));
		//System.out.println(memberEmail + "<--받은 이메일");
	}

	MemberDao memberDao = new MemberDao();
	// 회원 정보 조회 결과 vo에 담기
	Member member = memberDao.selectMyInfo(memberEmail);
	System.out.println(member + "<--dao 실행");
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
	<div class="jumbotron">
		<h3>비밀번호 수정</h3>
	</div>
	
	<form method="post" action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp">
		<table class="table">
			<tr>
				<td>아이디</td>
				<td><input  class="form-control" type="text" readonly="readonly" value="<%=memberEmail%>" name="memberEmail"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input  class="form-control" type="password" value="<%=memberPw%>" name="memberPw"></td>
			</tr>
		</table>
		<div class="d-flex justify-content-end">
			<button type="submit" class="btn btn-primary">수정하기</button>
		</div>
	</form>
</div>
</body>
</html>