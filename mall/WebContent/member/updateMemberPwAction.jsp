<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 인코딩 설정
	request.getParameter("utf-8");

	// 이메일 받기
	String memberEmail = "";
	if(request.getParameter("memberEmail") != null) {
		memberEmail = request.getParameter("memberEmail");
	}
	System.out.println(memberEmail + "<-- 받은 이메일");
	
	// 비밀번호 받기
	String memberPw = "";
	if(request.getParameter("memberPw") != null) {
		memberPw = request.getParameter("memberPw");
	}
	System.out.println(memberPw + "<-- 받은 비밀번호");
	
	// vo 객체 생성
	Member member = new Member();
	member.setMemberEmail(memberEmail);
	member.setMemberPassword(memberPw);
	
	// dao 객체 생성
	MemberDao memberDao = new MemberDao();
	memberDao.updateMemberPw(member);
	
	response.sendRedirect(request.getContextPath() + "/member/myPage.jsp");
%>