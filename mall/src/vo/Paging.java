package vo;
import java.util.HashMap;
import java.util.Map;

import dao.*;

public class Paging {
	// 현재 페이지를 담는 변수 생성(초기값: 1)
	private int currentPage = 1;
	// 한 페이지에 출력되는 행의 수(초기값: 10행 출력)
	private int rowPerPage = 10;
	
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getRowPerPage() {
		return rowPerPage;
	}
	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}
	
	// 상품리스트의 전체 행 개수를 구하는 메서드
	public int getLastPage() throws Exception {
		//전체 페이지를 담는 변수
		int totalPage = 0;
		//Dao객체 접근
		ProductDao productDao = new ProductDao();
		//마지막 페이지
		totalPage = productDao.selectCount();
		int lastPage = totalPage/rowPerPage;		
		if(totalPage%rowPerPage != 0) {
			lastPage += 1;
		}		
		return lastPage;
	}
	// 카테고리 별 전체 행을 구하는 메서드
	public int getLastPageByCategory(int categoryId) throws Exception {
		//전체 페이지를 담는 변수
		int totalPage = 0;
		//Dao객체 접근
		ProductDao productDao = new ProductDao();
		//마지막 페이지
		totalPage = productDao.selectCountByCategoryId(categoryId);
		int lastPage = totalPage/rowPerPage;	// <-- 전체 행 수/현재 행의 수
		if(totalPage%rowPerPage != 0) {
			lastPage += 1;
		}		
		System.out.println(categoryId + "<-- 넘어온 카테고리 넘버");
		// System.out.println(totalPage + "<-- 카테고리 전체 행의 수");
		System.out.println(lastPage + "<-- 카테고리 라스트 페이지");
		return lastPage;
	}
	// 검색에 따른 lastPage를 구하는 메서드
	public int getLastPageBySearch(String productName) throws Exception {
		int totalPage = 0;
		// Dao객체
		ProductDao productDao = new ProductDao();
		totalPage = productDao.selectCountByProductName(productName);
		int lastPage = totalPage/rowPerPage;
		if(totalPage%rowPerPage != 0) {
			lastPage += 1;
		}
		return lastPage;
	}
	// 공지사항 lastPage를 구하는 메서드
	public int getLastPageByNotice() throws Exception {
		int totalPage = 0;
		NoticeDao noticeDao = new NoticeDao();
		totalPage = noticeDao.selectCountNotice();
		int lastPage = totalPage/rowPerPage;
		if(totalPage%rowPerPage != 0) {
			lastPage += 1;
		}
		return lastPage;
	}
	// 주문 상품 목록의 lastPage를 구하는 메서드
	public int getLastPageByOrders(String memberEmail) throws Exception {
		int totalPage = 0;
		OrdersDao ordersDao = new OrdersDao();
		totalPage = ordersDao.selectCountOrdersByMemberEmail(memberEmail);
		int lastPage = totalPage/rowPerPage;
		if(totalPage%rowPerPage != 0) {
			lastPage += 1;
		}
		return lastPage;
	}
	// 네비게이션 페이징을 구하는 메서드
	public Map<String, Integer> getNavPaging(int currentPage, int lastPage) throws Exception {
		// 네비게이션 전체 ROW
		int navPerPage = 10;
		// 네비게이션 시작 ROW
		int navStartPage = currentPage-(currentPage%navPerPage)+1;
		// 네비게이션 끝 ROW
		int navEndPage = navStartPage+(navPerPage-1);
		// 현재페이지가 네이게이션 끝 ROW에 위치할 때
		if(currentPage%navPerPage == 0) {
			navStartPage= navStartPage-navPerPage;
			navEndPage = navEndPage-navPerPage;
		}
		// lastPage가 navEndPage보다 작을 때
		if(lastPage < navEndPage) {
			navEndPage = lastPage;
		}
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("navStartPage", navStartPage);
		map.put("navEndPage", navEndPage);
		return map;
	}
}