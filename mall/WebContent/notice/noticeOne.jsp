<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록 확인</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
</head>
<body>
<div class="container">
<%
	// 인코딩 설정
	request.setCharacterEncoding("utf-8");

	// 공지 번호 받는 변수 생성
	int noticeId = 0;
	if(request.getParameter("noticeId") != null) {
		noticeId = Integer.parseInt(request.getParameter("noticeId"));
	}
	//System.out.println(noticeId + "<-- 공지사항 번호 받기");
	
	//결과를 담기 위한 리스트 객체 생성
	// 데이터베이스 접근을 위한 dao 객체 생성
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = new ArrayList<Notice>();
	list = noticeDao.selectNoticeOne(noticeId);
	//System.out.println(list + "<-- 받은 리스트");
%>
<div style="margin-top:30px;" align="center">	<!-- 상단 타이틀, 검색창 -->
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
				<span class="badge badge-pill badge-light">주문정보</span>
				<a href="<%=request.getContextPath()%>/orders/myOrdersList.jsp">
					<i class='fas fa-user-alt' style='font-size: 38px;margin-right: 10px;color: black'></i>
				</a>
				<span class="badge badge-pill badge-light">장바구니</span>
				<a href="#">	
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
				<li class="nav-item">
			      <a class="nav-link" href="<%=request.getContextPath()%>/member/logoutAction.jsp">로그아웃</a>
			    </li>s
			    <li class="nav-item">
			      <a class="nav-link" href="<%=request.getContextPath()%>/member/memberInfo.jsp?memberEmail=<%=session.getAttribute("loginMemberEmail")%>">회원정보</a>
			    </li>
			<%
			System.out.println(session.getAttribute("loginMemberEmail") +  "<--현재 회원 이메일");
		  		}
			%>
		   </ul>
		</nav>
	</div>
	<div class="jumbotron">
		<h4>공지사항 정보</h4>
	</div>
	<table class="table table-bordered">
		<thead>
			<tr>
				<th>notice_id</th>
				<th>notice_title</th>
				<th>notice_content</th>
				<th>notice_date</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Notice n : list) {
			%>
					<tr>
						<td><%=n.getNoticeId()%></td>
						<td><%=n.getNoticeTitle()%></td>
						<td><%=n.getNoticeContent()%></td>
						<td><%=n.getNoticeDate()%></td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
	<div class="d-flex justify-content-end">
		<a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-secondary">돌아가기</a>
	</div>
</div>
</body>
</html>