<%@page import="dao.*"%>
<%@page import="vo.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/*
	* 주문 상품을 추가하기 위한 액션페이지 
	*/
	
	// 인코딩 설정
	request.setCharacterEncoding("utf-8");

	// 현재 로그인 상태가 아니면 로그인 페이지 이동
	if(session.getAttribute("loginMemberEmail") == null) {
		response.sendRedirect(request.getContextPath() + "/member/login.jsp");
		return;
	}
	
	// 상품 넘버 받는 변수 생성
	int productId = Integer.parseInt(request.getParameter("productId"));
	System.out.print(productId + "<- 제품번호 값");	// 디버깅
	// 주문 개수를 받는 변수 생성
	int ordersAmount = Integer.parseInt(request.getParameter("ordersAmount"));
	// 제품 가격을 받는 변수 생성
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	// 회원 이메일을 받는 변수 생성
	String memberEmail = (String)(session.getAttribute("loginMemberEmail"));
	// 주문 배송지를 받는 변수 생성
	String ordersAddr = request.getParameter("ordersAddr");
	
	// request로부터 받아온 값을 vo에 저장하기 위한 객체 생성
	Orders orders = new Orders();
	// vo에 상품 넘버 저장
	orders.setProductId(productId);
	// vo에 주문 갯수를 저장
	orders.setOrdersAmount(ordersAmount);
	// vo에 주문 가격을 저장
	orders.setOrdersPrice(productPrice);
	// vo에 회원 이메일을 저장
	orders.setMemberEmail(memberEmail);
	// vo에 주문 배송지를 저장
	orders.setOrdersAddr(ordersAddr);
	
	// vo에 저장된 값을 가지고 Dao로 넘기기 위한 객체 생성
	OrdersDao ordersDao = new OrdersDao();
	// 외래키의 데이터 값이 일치하면 삽입 가능 
	// vo값을 담아 dao 쿼리문 실행하여 결과 받아오기
	ordersDao.insertOrders(orders);
	
	// 나의 주문 목록 페이지로 이동
	response.sendRedirect(request.getContextPath() + "/orders/myOrdersList.jsp");
%>