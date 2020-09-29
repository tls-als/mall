<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고별 상품 리스트</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
</head>
<body>
<%
	// 인코딩 설정
	request.setCharacterEncoding("utf-8");
	
	// 페이징 데이터를 담는 Pasing 객체 생성
	Paging paging = new Paging();
	// 현재 페이지 담기
	if(request.getParameter("currentPage") != null) {
		//paging.currentPage = Integer.parseInt(request.getParameter("currentPage"));
		paging.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		//System.out.println(request.getParameter("currentPage") + "   담는 커런트 페이지");
	}
	
	// request로부터 보내온 카테고리 ID 받기
	int categoryId = 0;
	if(request.getParameter("categoryId") != null) {
		categoryId = Integer.parseInt(request.getParameter("categoryId"));
	}
	System.out.println(categoryId + "<-- 카테고리 넘버");
	
	// doa 객체 생성
	ProductDao productDao = new ProductDao();	

	// 리스트 객체 생성. 쿼리 결과 담기
	ArrayList<Product> list = new ArrayList<Product>();
	list = productDao.selectAllProductListByCategoryId(categoryId, paging);
	//System.out.println(list + "<-- 리스트");
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
			      <a class="nav-link" href="#">회원정보</a>
			    </li>
			<%
		  		}
			%>
		   </ul>
		</nav>
	</div>
	
	<div class="jumbotron">
		<h3>카테고리별 상품</h3>
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
						<td><a href="<%=request.getContextPath()%>/product/productOne.jsp?productId=<%=p.getProductId()%>&categoryId=<%=p.getCategoryId()%>" class="btn btn-info"><%=p.getProductId()%></a></td>
						<td><%=p.getProductName()%></td>
						<td><img src="/mall-admin/image/<%=p.getProductPic()%>" width="180px" height="150px"></td>
						<td><%=p.getProductPrice()%></td>
						<td><%=p.getProductContent()%></td>
						<td><%=p.getProductSoldout()%></td>
					</tr>	
			<%	
			System.out.println(p.getCategoryId() + "<--보내는 상품내역 카테고리번호");
				}
			%>
		</tbody>
	</table>
	
	<!-- 페이징 네비게이션 -->
	<div align="center">
		<%
			// 마지막 페이지를 담을 변수
			int lastPage = 0;
			// 현재 페이지를 담는 변수
			int currentPage = paging.getCurrentPage();
			System.out.println(currentPage+"<--커런트페이지");
			// 다음페이지를 받는 변수
			int next = currentPage+1;
			// 이전페이지를 받는 변수
			int pre = currentPage-1;
			
			lastPage = paging.getLastPageByCategory(categoryId);
			if(currentPage < 2 && lastPage != 1) {
		%>	
				<ul class="pagination pagination-sm pagination justify-content-center">
					<li class="page-item disabled"><a class="page-link">처음으로</a></li>
					<li class="page-item disabled"><a class="page-link">이전</a></li>
					<li class="page-item">
						<span class="page-link"><%=currentPage%></span>
					</li>
					<li class="page-item"><a class="page-link" href="/mall/product/ProductByCategory.jsp?currentPage=<%=next%>&categoryId=<%=categoryId%>">다음</a></li>
					<li class="page-item"><a class="page-link" href="/mall/product/ProductByCategory.jsp?currentPage=<%=lastPage%>&categoryId=<%=categoryId%>">마지막으로</a></li>
				</ul>
		<%
			}
			if(currentPage > 1 && lastPage > currentPage) {
		%>		<ul class="pagination pagination-sm pagination justify-content-center">
					<li class="page-item"><a class="page-link" href="/mall/product/ProductByCategory.jsp?currentPage=1&categoryId=<%=categoryId%>">처음으로</a></li>
					<li class="page-item"><a class="page-link" href="/mall/product/ProductByCategory.jsp?currentPage=<%=pre%>&categoryId=<%=categoryId%>">이전</a></li>
					<li class="page-item">
						<span class="page-link"><%=currentPage%></span>
					</li>						
					<li class="page-item"><a class="page-link" href="/mall/product/ProductByCategory.jsp?currentPage=<%=next%>&categoryId=<%=categoryId%>">다음</a></li>
					<li class="page-item"><a class="page-link" href="/mall/product/ProductByCategory.jsp?currentPage=<%=lastPage%>&categoryId=<%=categoryId%>">마지막으로</a></li>
				</ul>
		<%
			}
			if(currentPage > 1 && currentPage == lastPage) {
		%>
				<ul class="pagination pagination-sm pagination justify-content-center">
					<li class="page-item"><a class="page-link" href="/mall/product/ProductByCategory.jsp?currentPage=1&categoryId=<%=categoryId%>">처음으로</a></li>
					<li class="page-item"><a class="page-link" href="/mall/product/ProductByCategory.jsp?currentPage=<%=pre%>&categoryId=<%=categoryId%>">이전</a></li>
					<li class="page-item">
						<span class="page-link"><%=currentPage%></span>
					</li>
					<li class="page-item disabled"><a class="page-link" href="/mall/product/ProductByCategory.jsp?currentPage=<%=next%>">다음</a></li>
					<li class="page-item disabled"><a class="page-link" href="/mall/product/ProductByCategory.jsp?currentPage=<%=lastPage%>">마지막으로</a></li>
				</ul>		
		<%
			}
		%>
	</div>
</div>
</body>
</html>