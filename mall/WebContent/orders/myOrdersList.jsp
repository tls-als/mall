<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	/*
	* 주문 상세보기를 위한 페이지
	* 1. 로그인이 되어 있지 않으면 로그인 화면으로 이동하기
	* 2. 회원 이메일 값으로 구분하여 주문 목록을 출력하기
	*/
	
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
	<title>나의 주문</title>
	<!-- 부트스트랩 이용을 위한 링크 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- 부트스트랩의 아이콘을 이용하기 위한 링크 -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
</head>
<body>
<%
	// 인코딩 설정
	request.setCharacterEncoding("utf-8");

	// 회원 이메일 받아오기
	String memberEmail = (String)session.getAttribute("loginMemberEmail");
	
	// 페이징 데이터를 담는 Pasing 객체 생성
	Paging paging = new Paging();
	// 현재 페이지 담기
	int currentPage = paging.getCurrentPage();
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		paging.setCurrentPage(currentPage);
	}
	// 마지막 페이지를 담을 변수
	int lastPage = 0;
	lastPage = paging.getLastPageByOrders(memberEmail);
	// 네이게이션 페이지 정보 담기
	Map<String, Integer> map = paging.getNavPaging(currentPage, lastPage);
	int navStartPage = map.get("navStartPage");
	int navEndPage = map.get("navEndPage");
	
	// 주문 상세 목록 결과를 가져오기 위한   dao 객체 생성
	OrdersDao ordersDao = new OrdersDao();
	// 결과값 list에 담기
	ArrayList<Orders> list = ordersDao.selectOrdersListByEmail(memberEmail);
	System.out.println(list + "<- 가져온 주문상세");
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
		<h1>주문 상세목록</h1>
	</div>
	<form action="<%=request.getContextPath()%>/index.jsp">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>product_id</th>
					<th>orders_amount</th>
					<th>orders_price</th>
					<th>member_email</th>
					<th>orders_addr</th>
					<th>orders_state</th>
					<th>orders_date</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Orders o : list) {
				%>
						<tr>
							<td><%=o.getProductId()%></td>
							<td><%=o.getOrdersAmount()%></td>
							<td><%=o.getOrdersPrice()%></td>
							<td><%=o.getMemberEmail()%></td>
							<td><%=o.getOrdersAddr()%></td>
							<td><%=o.getOrdersState()%></td>
							<td><%=o.getOrdersDate()%></td>
						</tr>
				<%
					System.out.println(o.getProductId() + "<- 제품번호");
					System.out.println(o.getOrdersAmount() + "<- 주문개수");
					System.out.println(o.getOrdersPrice() + "<- 주문가격");
					System.out.println(o.getMemberEmail() + "<- 회원메일");
					System.out.println(o.getOrdersAddr() + "<- 주문지");
					System.out.println(o.getOrdersDate() + "<- 날짜");
					}
				%>
			</tbody>
		</table>
		<!-- 페이징 네비게이션 -->
		<div align="center">
			<%
				if(lastPage == 1 || lastPage == 0) {
			%>
					<ul class="pagination pagination-sm pagination justify-content-center">
						<li class="page-item disabled"><a class="page-link">처음으로</a></li>
						<li class="page-item disabled"><a class="page-link">이전</a></li>
						<li class="page-item active">
							<span class="page-link">1</span>
						</li>
						<li class="page-item disabled"><a class="page-link" href="">다음</a></li>
						<li class="page-item disabled"><a class="page-link" href="">마지막으로</a></li>
					</ul>
			<%
				}
				if(currentPage == 1 && lastPage != 1) {
			%>	
					<ul class="pagination pagination-sm pagination justify-content-center">
						<li class="page-item disabled"><a class="page-link">처음으로</a></li>
						<li class="page-item disabled"><a class="page-link">이전</a></li>
					<%
						for(int i=navStartPage; i<=navEndPage; i++) {
							if(currentPage == i) {
					%>
							<li class="page-item active"><a class="page-link"><%=i%></a></li>
					<%		
							}else {
					%>
							<li class="page-item"><a class="page-link" href="/mall/orders/myOrdersList.jsp?currentPage=<%=i%>"><%=i%></a></li>
					<%
							}
						}
					%>
						<li class="page-item"><a class="page-link" href="/mall/orders/myOrdersList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
						<li class="page-item"><a class="page-link" href="/mall/orders/myOrdersList.jsp?currentPage=<%=lastPage%>">마지막으로</a></li>
					</ul>
			<%
				}
				if(currentPage != 1 && currentPage != lastPage) {
			%>	
					<ul class="pagination pagination-sm pagination justify-content-center">
						<li class="page-item"><a class="page-link" href="/mall/orders/myOrdersList.jsp?currentPage=1">처음으로</a></li>
						<li class="page-item"><a class="page-link" href="/mall/orders/myOrdersList.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
					<%
						for(int i=navStartPage; i<=navEndPage; i++) {
							if(currentPage == i) {
					%>
							<li class="page-item active"><a class="page-link"><%=i%></a></li>
					<%		
							}else {
					%>
							<li class="page-item"><a class="page-link" href="/mall/orders/myOrdersList.jsp?currentPage=<%=i%>"><%=i%></a></li>
					<%
							}
						}
					%>
						<li class="page-item"><a class="page-link" href="/mall/orders/myOrdersList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
						<li class="page-item"><a class="page-link" href="/mall/orders/myOrdersList.jsp?currentPage=<%=lastPage%>">마지막으로</a></li>
					</ul>
			<%	
				}
				if(currentPage == lastPage && lastPage != 1) {
			%>	
					<ul class="pagination pagination-sm pagination justify-content-center">
						<li class="page-item"><a class="page-link" href="/mall/orders/myOrdersList.jsp?currentPage=1">처음으로</a></li>
						<li class="page-item"><a class="page-link" href="/mall/orders/myOrdersList.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
					<%
						for(int i=navStartPage; i<=navEndPage; i++) {
							if(currentPage == i) {
					%>
							<li class="page-item active"><a class="page-link"><%=i%></a></li>
					<%		
							}else {
					%>
							<li class="page-item"><a class="page-link" href="/mall/orders/myOrdersList.jsp?currentPage=<%=i%>"><%=i%></a></li>
					<%
							}
						}
					%>
						<li class="page-item disabled"><a class="page-link">다음</a></li>
						<li class="page-item disabled"><a class="page-link">마지막으로</a></li>
					</ul>
			<%	
				}
			%>
		</div>
		<!-- 인덱스 페이지로 돌아가는 버튼 -->
		<div class="d-flex justify-content-end">
			<button type="submit" class="btn btn-secondary">돌아가기</button>
		</div>
		<!-- 안내문구 -->
		<h6><span>주문을 취소하시려면 배송준비 전까지 admin@gd.com으로 메일을 주세요.</span></h6>
	</form>
</div>
</body>
</html>