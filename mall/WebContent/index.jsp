<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %> 
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>Index.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
</head>
<!-- 
	*mall 프로젝트 진행 중 아쉬웠던 점
	1. 데이터베이스의 결과 값을 가져오기 위해 Dao 클래스를 만들어 이용해 보았고 데이터를 담는 클래스가 vo.
	      메서드에 대한 이해도가 아직 부족한 것 같음 
	      -> 메서드의 파라메터 값은 두 가지 이상도 보낼 수 있다. ex) 값을 가진 변수, 페이징을 위한 vo객체도 한 메서드 안에서 같이 보낼 수 있다
	      -> 메서드의 리턴값과 매개변수에 대한 이해도
	2. 주석과 디버깅에 대한 습관이 많이 부족하다. -> 디버깅을 중간마다 체크하면서 코딩을 진행해야 오류를 쉽게 찾을 수 있을텐데 디버깅을 안 하고 진행하다 보니 오류를
	      찾는데에 다소 시간이 많이 소요됨을 느낌
	3. 아직 페이징 숫자를 구현하지 못한 아쉬움 -> 현재 페이지에서 해당 범위까지 이동할 수 있는 번호가 있는 페이징을 구현해보고 싶었으나 아직까지 방법을 찾고 있음
	4. 코딩은 순차적으로 진행됨. -> 코드의 순서에 따라 값을 받을 수도 못받을 수도 있으니 주의.(생각하면서 코딩!)
	5. 파일 업로드 다시 복습하기
	6. 상품 리스트 페이지 상세보기에서 뒤로갔을 때 해당 페이지로 다시 돌아가는 구현이 아쉬움.
 -->
<%
	//인코딩 설정
	request.setCharacterEncoding("utf-8");

	//카테고리 아이디 받기
	int categoryId = -1;
	if(request.getParameter("categoryId") != null) {
		categoryId = Integer.parseInt(request.getParameter("categoryId"));
	}
	
	//dao 객체 생성
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
		  <div class="col-sm-9">

		  	<!-- request.getContextPath() : 프로젝트명을 리턴한다 -->
		  	<img src="<%=request.getContextPath()%>/images/main.jpg" width="700px" height="400px">
		  </div>
		</div>
	</div>

	<!-- 추천 카테고리 이미지 리스트 -->
	<div align="center" style="margin-top: 100px;">
	<div align="left" style="margin-bottom: 50px;"><h4>추천 카테고리</h4></div>
		<%
			for(Category c : categoryList2) {
		%>		
				<a href="<%=request.getContextPath()%>/product/ProductByCategory.jsp?categoryId=<%=c.getCategoryId()%>" style="margin-right: 20px;">
					<img src="<%=request.getContextPath()%>/images/<%=c.getCategoryPic()%>" class="rounded-circle" width="200px" height="200px">
					<span class="badge badge-pill badge-info"><%=c.getCategoryName()%></span>
				</a>
		<%		
			}
		%>
	</div>
	<%
		//날짜 구하기
		Calendar today = Calendar.getInstance();	// new Calendar();
	%>

	<!-- 카테고리 별 추천상품 버튼 -->
	<div style="margin-top: 100px;">
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
			<a href="<%=request.getContextPath()%>/index.jsp?categoryId=-1" class="btn btn-secondary" style="margin-right: 20px;">전체</a>
			<%
		  		for(Category c : categoryList1) {
		  	%>
		  			<a href="<%=request.getContextPath()%>/index.jsp?categoryId=<%=c.getCategoryId()%>" class="btn btn-secondary" style="margin-right: 20px;"><%=c.getCategoryName()%></a>
		  	<%
		  		}
		  	%>
		  	<a href="<%=request.getContextPath()%>/product/allProduct.jsp" class="btn btn-info" style="margin-right: 20px;">더보기</a>
		</div>
	</div>
	<%
		//상품리스트 가져오는 객체 생성
		ProductDao productDao = new ProductDao();
		//전체 상품 리스트
		ArrayList<Product> productList1 = productDao.selectProductList();
		//카테고리별 상품리스트
		ArrayList<Product> productList2 = productDao.selectProductListByCategoryId(categoryId);
		
	%>
	<!-- 상품 목록 6개 목록 보이기-->
	<div align="center" style="margin-top: 20px;">
		<table>
			<tr>
				<%
					int i = 0;
					System.out.println(categoryId + "받을 카테고리 아이디");
					if(categoryId == -1) {
						for(Product p : productList1) {
							i=i+1;
				%>
				<td>	
					<div class="card" style="width: 250px;margin-right: 20px;margin-bottom: 20px;">
					  <img class="card-img-top" src="/mall-admin/image/<%=p.getProductPic()%>">
					  <div class="card-body">
					    <h4 class="card-title">
					    	<a href="<%=request.getContextPath()%>/product/productOne.jsp?productId=<%=p.getProductId()%>">
					    		<%=p.getProductName()%>
					    	</a>
					    </h4>
					    <p class="card-text"><%=p.getProductPrice() %></p>
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
					}
					else {
						for(Product p : productList2) {
							i=i+1;
				%>
				<td>	
					<div class="card" style="width: 250px;margin-right: 20px;margin-bottom: 20px;">
					  <img class="card-img-top" src="<%=request.getContextPath()%>/images/<%=p.getProductPic()%>">
					  <div class="card-body">
					    <h4 class="card-title">
					    	<a href="<%=request.getContextPath()%>/product/productOne.jsp?productId=<%=p.getProductId()%>">
					    		<%=p.getProductName()%>
					    	</a>
					    </h4>
					    <p class="card-text"><%=p.getProductPrice() %></p>
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
		<div align="left" style="margin-top: 50px;"><h4>최근 공지사항</h4></div>
		<table class="table">
			<thead>
				<tr>
					<td>notice_id</td>
					<td>notice_title</td>
					<td>상세보기</td>
				</tr>
			</thead>
			<tbody>
				<%
					for(Notice n : list) {
				%>
						<tr>
							<td><%=n.getNoticeId()%></td>
							<td><%=n.getNoticeTitle()%></td>
							<td><a class="btn btn-info" href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeId=<%=n.getNoticeId()%>">상세보기</a></td>			
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