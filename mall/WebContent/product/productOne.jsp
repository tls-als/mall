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
</head>
<body>
<%
	int productId = Integer.parseInt(request.getParameter("productId"));
	ProductDao productDao = new ProductDao();
	Product product = productDao.selectProductOne(productId);
%>
<div class="container">
	<h1>상품 상세보기</h1>
	<form method="post" action="<%=request.getContextPath()%>/orders/addOrdersAction.jsp">
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
				<td><input type="text" name="ordersAddr" class="form-control"></td>
			</tr>
		</table>
		<div class="d-flex justify-content-end">
			<button type="submit" class="btn btn-success">주문하기</button>
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
			<td><img src="<%=request.getContextPath()%>/images/<%=product.getProductPic()%>"></td>
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