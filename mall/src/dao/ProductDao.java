package dao;

import java.util.*;

import commons.DBUtil;
import vo.Paging;
import vo.Product;
import java.sql.*;

public class ProductDao {
	// 검색에 따른 상품리스트 카운트를 구하는 메서드
	public int selectCountByProductName(String productName) throws Exception {
		int count = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) FROM product WHERE product_name LIKE ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+productName+"%");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("COUNT(*)");
		}
		return count;
	}
	
	// 카테고리 별, 상품 리스트의 전체 목록 개수를 구하기 위한 쿼리 메서드
	public int selectCountByCategoryId(int categoryId) throws Exception {
		int count = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) FROM product where category_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("COUNT(*)");
		}
		return count;
	}
	
	// 상품 리스트의 전체 목록 개수를 구하기 위한 쿼리 메서드
	public int selectCount() throws Exception {
		int count = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) FROM product";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		System.out.println(rs + "<--전체 상품 개수 쿼리");
		if(rs.next()) {
			count = rs.getInt("COUNT(*)");
		}
		return count;
	}
	
	// 카테고리 상품 전체 조회
	public ArrayList<Product> selectAllProductListByCategoryId(int categoryId, Paging paging) throws Exception {
		// 데이터를 담을 리스트 변수 생성
		ArrayList<Product> list = new ArrayList<Product>();
		// 데이터베이스 연결을 위한 객체 생성
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		// 전체 카테고리의 모든 상품을 조회하기 위한 쿼리
		String sql = "select product_id, product_name,product_price, product_content, product_soldout, product_pic from product where category_id = ? order by product_id asc limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryId);
		stmt.setInt(2, (paging.getCurrentPage()-1)*paging.getRowPerPage());
		System.out.println((paging.getCurrentPage() + "<-- 시작 페이지-----"));
		stmt.setInt(3, paging.getRowPerPage());
		ResultSet rs = stmt.executeQuery();
		//System.out.println(categoryId + "<-- 카테고리");
		System.out.println(paging.getRowPerPage() + "<-- 행의 수");
		System.out.println(rs + "<-- 쿼리 실행문");
		while(rs.next()) {
			Product product = new Product();
			product.setProductId(rs.getInt("product_id"));
			product.setProductName(rs.getString("product_name"));
			product.setProductPrice(rs.getInt("product_price"));
			product.setProductContent(rs.getString("product_content"));
			product.setProductSoldout(rs.getString("product_soldout"));
			product.setProductPic(rs.getString("product_pic"));
			list.add(product);
		}
		conn.close();
		return list;
	}
	
	// 전체 제품 조회
	public ArrayList<Product> selectAllProductList(Paging paging) throws Exception {
		// 데이터를 담을 리스트 변수 생성
		ArrayList<Product> list = new ArrayList<Product>();
		// 데이터베이스 연결을 위한 객체 생성
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		// 전체 카테고리의 모든 상품을 조회하기 위한 쿼리
		String sql = "select product_id, product_name,product_price, product_content, product_soldout, product_pic from product order by product_id asc limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, (paging.getCurrentPage()-1)*paging.getRowPerPage());
		System.out.println((paging.getCurrentPage()-1)*paging.getRowPerPage() + "<-- 시작 페이지11");
		stmt.setInt(2, paging.getRowPerPage());
		ResultSet rs = stmt.executeQuery();
		//System.out.println(rs + "<-- 쿼리 실행문");
		while(rs.next()) {
			Product product = new Product();
			product.setProductId(rs.getInt("product_id"));
			product.setProductName(rs.getString("product_name"));
			product.setProductPrice(rs.getInt("product_price"));
			product.setProductContent(rs.getString("product_content"));
			product.setProductSoldout(rs.getString("product_soldout"));
			product.setProductPic(rs.getString("product_pic"));
			list.add(product);
		}
		conn.close();
		return list;
	}
	
	//제품 한개를 출력
	public Product selectProductOne(int productId) throws Exception {
		Product product = null;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "select product_id,product_name,product_content,product_pic,product_price,product_soldout from product where product_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			product = new Product();
			product.setProductId(rs.getInt("product_id"));
			product.setProductName(rs.getString("product_name"));
			product.setProductContent(rs.getString("product_content"));
			product.setProductPic(rs.getString("product_pic"));
			product.setProductPrice(rs.getInt("product_price"));
			product.setProductSoldout(rs.getString("product_soldout"));
		}
		conn.close();
		return product;
	}
	
	//상품 리스트 출력(추천별 6개 출력)
	public ArrayList<Product> selectProductList() throws Exception{
		ArrayList<Product> list = new ArrayList<Product>();
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "select product_id,product_pic,product_name,product_price from product limit 0,6";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Product p = new Product();
//			p.productId = rs.getInt("product_id");
//			p.productPic = rs.getString("product_pic");
//			p.productName = rs.getString("product_name");
//			p.productPrice = rs.getInt("product_price");
			p.setProductId(rs.getInt("product_id"));
			p.setProductPic(rs.getString("product_pic"));
			p.setProductName(rs.getString("product_name"));
			p.setProductPrice(rs.getInt("product_price"));
			list.add(p);
		}
		conn.close();
		return list;
	}
	// 검색 조건에 따른 상품 리스트 출력
	public ArrayList<Product> selectProductListBySearch(String productName, Paging paging) throws Exception {
		ArrayList<Product> list = new ArrayList<Product>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "select product_id, product_name, product_price, product_content, product_soldout, product_pic from product WHERE product_name LIKE ? order by product_id ASC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + productName + "%");
		stmt.setInt(2, (paging.getCurrentPage()-1)*paging.getRowPerPage());
		stmt.setInt(3, paging.getRowPerPage());
		ResultSet rs = stmt.executeQuery();
		System.out.println(rs + ": 검색 쿼리");
		while(rs.next()) {
			Product product = new Product();
			product.setProductId(rs.getInt("product_id"));
			product.setProductName(rs.getString("product_name"));
			product.setProductPrice(rs.getInt("product_price"));
			product.setProductContent(rs.getString("product_content"));
			product.setProductSoldout(rs.getString("product_soldout"));
			product.setProductPic(rs.getString("product_pic"));
			list.add(product);
		}
		return list;
	}
}