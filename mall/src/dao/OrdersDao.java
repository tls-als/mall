package dao;
import java.sql.*;
import java.util.ArrayList;

import commons.DBUtil;
import vo.*;

public class OrdersDao {
	// 주문상세 목록의 카운트를 구하는 메서드
	public int selectCountOrdersByMemberEmail(String memberEmail) throws Exception{
		int count = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) FROM orders WHERE member_email = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberEmail);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("COUNT(*)");
		}
		return count;
	}
	
	// 주문 상세 목록을 조회하기 위한 메서드(회원 이메일로 구분)
	public ArrayList<Orders> selectOrdersListByEmail(String memberEmail) throws Exception {
		// 결과를 담기 위한 list 객체 생성
		ArrayList<Orders> list = new ArrayList<Orders>();
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "select product_id, orders_amount, orders_price, member_email, orders_addr, orders_state, orders_date from orders where member_email = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberEmail);
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		System.out.println(stmt + "<- 쿼리 실행");
		while(rs.next()) {
			Orders orders = new Orders();
			orders.setProductId(rs.getInt("product_id"));
			orders.setOrdersAmount(rs.getInt("orders_amount"));
			orders.setOrdersPrice(rs.getInt("orders_price"));
			orders.setMemberEmail(rs.getString("member_email"));
			orders.setOrdersAddr(rs.getString("orders_addr"));
			orders.setOrdersState(rs.getString("orders_state"));
			orders.setOrdersDate(rs.getString("orders_date"));
			list.add(orders);
			//디버깅
			System.out.println(rs.getInt("product_id") + " 제품 번호");
			System.out.println(rs.getInt("orders_amount") + " 주문 개수");
			System.out.println(rs.getInt("orders_price") + " 주문 가격");
			System.out.println(rs.getString("member_email") + " 회원 메일");
			System.out.println(rs.getString("orders_addr") + " 주문 배송지");
			System.out.println(rs.getString("orders_date") + " 주문 날짜");
		}
		conn.close();
		return list;
	}
	
	// 상품 주문을 등록하기 위한 메서드
	public void insertOrders(Orders orders) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "insert into orders(product_id, orders_amount, orders_price, member_email, orders_addr, orders_state, orders_date) values(?,?,?,?,?,'결제완료',now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orders.getProductId());
		stmt.setInt(2, orders.getOrdersAmount());
		stmt.setInt(3, orders.getOrdersPrice());
		stmt.setString(4, orders.getMemberEmail());
		stmt.setString(5, orders.getOrdersAddr());
		System.out.println(stmt);
		stmt.executeUpdate();
		conn.close();
	}
}