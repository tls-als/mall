<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>productSearch</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
</head>
<body>
<%
	//인코딩 설정
	request.setCharacterEncoding("utf-8");
	// 검색어 정보 받기
	String search = "";
	if(request.getParameter("search") != null) {
		search = request.getParameter("search");
	}
	System.out.println(search + ": 전달받은 검색어");
	
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
	lastPage = paging.getLastPageBySearch(search);
	// 네이게이션 페이지 정보 담기
	Map<String, Integer> map = paging.getNavPaging(currentPage, lastPage);
	int navStartPage = map.get("navStartPage");
	int navEndPage = map.get("navEndPage");
	System.out.println("navStartPage: " + navStartPage);
	System.out.println("navEndPage: " + navEndPage);

	// ProductDao 객체 생성
	ProductDao productDao = new ProductDao();
	ArrayList<Product> list = productDao.selectProductListBySearch(search, paging);
	System.out.println("리스트 결과: " + list);
%>
<div class="container">
	<!-- 상단 타이틀, 검색창, 주문조회 및 장바구니 -->
	<div style="margin-top:30px;" align="center">	
		<div class="row">
			<div class="col">
				<span><h1><a href="<%=request.getContextPath()%>/index.jsp" style='color: black'>Goodee Shop</a></h1></span>
			</div>
			<div class="col">
				<form method="get" action="<%=request.getContextPath()%>/product/productSearch.jsp">
					<div class="input-group mb-3">
						<input type="text" class="form-control" style="width:200px;" name="search" value="<%=search%>" placeholder="검색할 키워드를 입력해 주세요.">
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
		<h3>검색 상품</h3>
	</div>
	
	<!-- 리스트 형태로 제품 출력하기 -->
	<table class="table table-bordered table-hover">
		<thead>
			<tr>
				<th>product_id</th>
				<th>product_name</th>
				<th>product_pic</th>
				<th>product_price</th>
				<th>product_content</th>
				<th>product_soldout</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Product p : list) {
			%>
					<tr>
						<td><a href="<%=request.getContextPath()%>/product/productOne.jsp?productId=<%=p.getProductId()%>" class="btn btn-info"><%=p.getProductId()%></a></td>
						<td><%=p.getProductName()%></td>
						<td><img src="<%=request.getContextPath()%>/images/<%=p.getProductPic()%>" width="180px" height="150px"></td>
						<td><%=p.getProductPrice()%></td>
						<td><%=p.getProductContent()%></td>
						<td><%=p.getProductSoldout()%></td>
					</tr>	
			<%		
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
						<li class="page-item"><a class="page-link" href="/mall/product/productSearch.jsp?currentPage=<%=i%>"><%=i%></a></li>
				<%
						}
					}
				%>
					<li class="page-item"><a class="page-link" href="/mall/product/productSearch.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
					<li class="page-item"><a class="page-link" href="/mall/product/productSearch.jsp?currentPage=<%=lastPage%>">마지막으로</a></li>
				</ul>
		<%
			}
			if(currentPage != 1 && currentPage != lastPage) {
		%>	
				<ul class="pagination pagination-sm pagination justify-content-center">
					<li class="page-item"><a class="page-link" href="/mall/product/productSearch.jsp?currentPage=1">처음으로</a></li>
					<li class="page-item"><a class="page-link" href="/mall/product/productSearch.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
				<%
					for(int i=navStartPage; i<=navEndPage; i++) {
						if(currentPage == i) {
				%>
						<li class="page-item active"><a class="page-link"><%=i%></a></li>
				<%		
						}else {
				%>
						<li class="page-item"><a class="page-link" href="/mall/product/productSearch.jsp?currentPage=<%=i%>"><%=i%></a></li>
				<%
						}
					}
				%>
					<li class="page-item"><a class="page-link" href="/mall/product/productSearch.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
					<li class="page-item"><a class="page-link" href="/mall/product/productSearch.jsp?currentPage=<%=lastPage%>">마지막으로</a></li>
				</ul>
		<%	
			}
			if(currentPage == lastPage && lastPage != 1) {
		%>	
				<ul class="pagination pagination-sm pagination justify-content-center">
					<li class="page-item"><a class="page-link" href="/mall/product/productSearch.jsp?currentPage=1">처음으로</a></li>
					<li class="page-item"><a class="page-link" href="/mall/product/productSearch.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
				<%
					for(int i=navStartPage; i<=navEndPage; i++) {
						if(currentPage == i) {
				%>
						<li class="page-item active"><a class="page-link"><%=i%></a></li>
				<%		
						}else {
				%>
						<li class="page-item"><a class="page-link" href="/mall/product/productSearch.jsp?currentPage=<%=i%>"><%=i%></a></li>
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
</div>
</body>
</html>