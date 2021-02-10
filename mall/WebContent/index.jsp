<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>index</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
	<style>
		.carousel-inner img {
		  width: 100%;
		  height: 100%;
		}
		.notice h4,
		.notice button {
			display: inline;
		}
	</style>
</head>
<!-- mall에서 할 것.
	1. 전체 카테고리 버튼 클릭 -> 모든 카테고리 항목의 제품을 List로 출력
	2. 각 항목 카테고리 버튼 클릭 -> 해당 카테고리 포함된 제품만 List로 출력 
	3. 추천 카테고리 4개 클릭시 -> 해당 카테고리 포함된 제품 List 출력
	4. 추천 상품 버튼 클릭시 -> 해당 카테고리 별 추천 상품 카드형태로 출력
	5. 각 List 별로 페이징 기능 구현해보기.
	6. 아이콘 클릭시 내 주문 확인
	7. 구디 클릭시 홈페이지 이동
	mall-admin에서 할 것.
	1. 회원 관리 페이지(조회기능,탈퇴기능 단,PW는 노출 안 할 것)
	2. 페이징 하기
 -->
<%
	request.setCharacterEncoding("utf-8");
	CategoryDao categoryDao = new CategoryDao();
	//카테고리 전체 리스트 이름 목록
	ArrayList<Category> categoryList1 = categoryDao.selectCategoryList();
	//추천 카테고리 목록 4개
	ArrayList<Category> categoryList2 = categoryDao.selectCategoryCkList();
%>

<body>
<div class="container">
	<div style="margin-top:30px;" align="center">	<!-- 상단 타이틀, 검색창 -->
		<div class="row">
			<div class="col">
				<span><h1><a href="<%=request.getContextPath()%>/index.jsp" style='color: black'>Goodee Shop</a></h1></span>
			</div>
			<div class="col">
				<form method="get" action="<%=request.getContextPath()%>/product/productSearch.jsp">
					<div class="input-group mb-3">
						<input type="text" class="form-control" style="width:200px;" name="search" placeholder="검색할 키워드를 입력해 주세요.">
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
	<div style="margin-top: 20px;">
		<!-- 전체 카테고리, 이미지 배너 -->
		<div class="row">
			<div class="col-sm-3">
				<div class="btn-group-vertical">
					<a href="<%=request.getContextPath()%>/product/allProduct.jsp" class="btn btn-secondary">전체 카테고리</a>
				<%
					for(Category c : categoryList1) {
				%>
						<a href="<%=request.getContextPath()%>/product/ProductByCategory.jsp?categoryId=<%=c.getCategoryId()%>" class="btn btn-secondary"><%=c.getCategoryName()%></a>
				<%
					//System.out.println(c.getCategoryId() + "<--카테고리 아이디");
					}
				%>
				</div>
			</div>			
			<div id="demo" class="carousel slide col-sm-7" data-ride="carousel">
				<ul class="carousel-indicators">
					<li data-target="#demo" data-slide-to="0" class="active"></li>
					<li data-target="#demo" data-slide-to="1"></li>
					<li data-target="#demo" data-slide-to="2"></li>
				</ul>
				<div class="carousel-inner">
					<div class="carousel-item active">
						<!-- request.getContextPath() : 프로젝트명을 리턴한다 -->
						<img src="<%=request.getContextPath()%>/images/banner1.jpg" width="700" height="500">
					</div>
					<div class="carousel-item">
						<img src="<%=request.getContextPath()%>/images/banner2.jpg" width="700" height="500">
					</div>
					<div class="carousel-item">
						<img src="<%=request.getContextPath()%>/images/banner3.jpg" width="700" height="500">
					</div>
				</div>
				<a class="carousel-control-prev" href="#demo" data-slide="prev">
					<span class="carousel-control-prev-icon"></span>
				</a>
				<a class="carousel-control-next" href="#demo" data-slide="next">
					<span class="carousel-control-next-icon"></span>
				</a>
			</div>
		</div>
	</div>

	<!-- 추천 카테고리 이미지 리스트 -->
	<div align="center" style="margin-top: 50px;">
		<table>
			<tr>
			<%
				for(Category c : categoryList2) {
			%>	
				<td style="padding: 20px 40px 20px 40px">
					<a href="<%=request.getContextPath()%>/product/ProductByCategory.jsp?categoryId=<%=c.getCategoryId()%>">
						<img src="<%=request.getContextPath()%>/images/<%=c.getCategoryPic()%>" class="rounded-circle" width="200px" height="200px">
						<div align="center"><strong><%=c.getCategoryName()%></strong></div>
					</a>
				</td>				
			<%		
				}
			%>					
			</tr>
		</table>
	</div>
	<%
		//날짜 구하기
		Calendar today = Calendar.getInstance();	// new Calendar();
	%>

	<!-- 카테고리 별 추천상품 버튼 -->
	<div style="margin-top: 50px;">
		<table>
			<tr>
				<td><h4>오늘의 추천상품</h4></td>
				<td>
					<span class="badge badge-primary group-append">
						<%=today.get(Calendar.YEAR)%>.<%=today.get(Calendar.MONTH)+1%>.<%=today.get(Calendar.DAY_OF_MONTH)%>
					</span>
				</td>
			</tr>
		</table>	
		<div align="center" style="margin-top: 20px;">
			<a href="<%=request.getContextPath()%>/product/allProduct.jsp" class="btn btn-secondary" style="margin-right: 20px;">전체</a>
			<%
		  		for(Category c : categoryList1) {
		  	%>
		  			<a href="<%=request.getContextPath()%>/product/ProductByCategory.jsp?categoryId=<%=c.getCategoryId()%>" class="btn btn-secondary" style="margin-right: 20px;"><%=c.getCategoryName()%></a>
		  	<%
		  		}
		  	%>
		</div>
	</div>
	<%
		ProductDao productDao = new ProductDao();
		ArrayList<Product> productList = productDao.selectProductList();
	%>
	<!-- 상품 목록 6개 목록 보이기-->
	<div align="center" style="margin-top: 20px; margin-bottom: 30px;">
		<table>
			<tr>
				<%
					int i = 0;
					for(Product p : productList) {
						i=i+1;
				%>
				<td>
					<div class="card" style="width: 250px;margin-right: 20px;margin-bottom: 20px;">
						<a href="<%=request.getContextPath()%>/product/productOne.jsp?productId=<%=p.getProductId()%>">
					 		<img class="card-img-top" src="<%=request.getContextPath()%>/images/<%=p.getProductPic()%>" width="200px" height="250px">
					  	</a>
					  <div class="card-body">
					    <h4 class="card-title">
					    	<a href="<%=request.getContextPath()%>/product/productOne.jsp?productId=<%=p.getProductId()%>">
					    		<%=p.getProductName()%>
					    	</a>
					    </h4>
					    <p class="card-text"><%=p.getProductPrice() %>원</p>
					  </div>
					</div>
				</td>
				<%
						if(i%3==0) {
				%>			
							</tr><tr>		
				<%
						}
					}
				%>
			</tr>
		</table>
	</div>
	
	<!-- 최근 공지 2개 -->
	<%
		NoticeDao noticeDao = new NoticeDao();
		ArrayList<Notice> list = noticeDao.selectNoticeList();
	%>	
	<div>
		<div class="notice mb-2">
			<h4>공지사항</h4>
			<a class="btn btn-info btn-sm" href="<%=request.getContextPath()%>/notice/noticeList.jsp">더보기</a>
		</div>
		<table class="table">
			<thead>
				<tr>
					<td>notice_id</td>
					<td>notice_title</td>
				</tr>
			</thead>
			<tbody>
				<%
					for(Notice n : list) {
				%>
						<tr>
							<td><%=n.getNoticeId()%></td>
							<td>
								<a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeId=<%=n.getNoticeId()%>">
									<%=n.getNoticeTitle()%>	
								</a>
							</td>				
						</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
</div>
</body>
</html>