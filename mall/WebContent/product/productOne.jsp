<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세보기</title>
<!-- 부트스트랩 이용을 위한 링크 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- 부트스트랩의 아이콘을 이용하기 위한 링크 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$("#btn").click(function(){
			if($("#ordersAddr").val() == "") {
				alert("배송지를 입력하세요!");
				return;
			}
			$("#oneForm").submit();
		});
	});
</script>
</head>
<body>
<%
	// 제품 넘버 받는 변수
	int productId = 0;
	if(request.getParameter("productId") != null) {
		productId = Integer.parseInt(request.getParameter("productId"));
	}
	
	// 카테고리 넘버 받는 변수
	int categoryId = 0;
	if(request.getParameter("categoryId") != null) {
		categoryId = Integer.parseInt(request.getParameter("categoryId"));
	}
	
	System.out.println(categoryId + "<-- 상품내역 카테고리 넘버");
	// dao 객체 생성
	ProductDao productDao = new ProductDao();
	// 하나의 상품 내역을 조회하기 위한 쿼리 결과 가져오기
	Product product = productDao.selectProductOne(productId);
%>
<div class="container">
	<h1>상품 상세보기</h1>
	<form method="post" action="<%=request.getContextPath()%>/orders/addOrdersAction.jsp" id="oneForm">
		<input type="hidden" value="<%=product.getProductId()%>" name="productId">
		<input type="hidden" value="<%=product.getProductPrice()%>" name="productPrice">
		<table class="table table-bordered">
			<tr>
				<td>수량</td>
				<td>
					<select name="ordersAmount" class="form-control">
						<%
							for(int i=1; i<11; i=i+1) {
						%>		
								<option value="<%=i%>"><%=i%> 개</option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>배송주소</td>
				<td><input type="text" name="ordersAddr" class="form-control" id="ordersAddr"></td>
			</tr>
		</table>
		<div class="d-flex justify-content-end">
		<%
			// 카테고리 번호 값이 있으면 해당 카테고리 목록 화면으로 이동하기
			if(categoryId != 0) {
		%>
				<a href="<%=request.getContextPath()%>/product/ProductByCategory.jsp?categoryId=<%=categoryId%>" class="btn btn-secondary">돌아가기</a>&nbsp;
		<%
			// 카테고리 번호 값이 없으면 전체 제품 목록 화면으로 이동하기
			}else {
		%>
				<a href="<%=request.getContextPath()%>/product/allProduct.jsp" class="btn btn-secondary">돌아가기</a>&nbsp;
		<%
			}
		%>
			
			<button type="button" id="btn" class="btn btn-success">주문하기</button>
		</div>
	</form>
	<br><br>
	<table class="table table-striped table-bordered">
		<tr>
			<td>product_id</td>
			<td><%=product.getProductId()%></td>
		</tr>
		<tr>
			<td>product_pic</td>
			<td><img src="/mall-admin/image/<%=product.getProductPic()%>"></td>
		</tr>
		<tr>
			<td>product_name</td>
			<td><%=product.getProductName()%></td>
		</tr>
		<tr>
			<td>product_content</td>
			<td><%=product.getProductContent()%></td>
		</tr>
		<tr>
			<td>product_price</td>
			<td><%=product.getProductPrice()%></td>
		</tr>
		<tr>
			<td>product_soldout</td>
			<td><%=product.getProductSoldout()%></td>
		</tr>
	</table>
</div>
</body>
</html>