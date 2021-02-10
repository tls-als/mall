package vo;

/*
 * mail.orders table
 * ordersId : 
 * 
 */
public class Orders {
	private int ordersId;	// 주문 ID
	private int productId;	// 제품 ID
	private int ordersAmount;	// 주문수량
	private int ordersPrice;	// 가격
	private String memberEmail;	// 회원메일
	private String ordersAddr;	// 주소
	private String ordersState;	// 주문상태
	private String ordersDate;	// 주문일
	
	//캡슐화
	public int getOrdersId() {
		return ordersId;
	}
	public void setOrdersId(int ordersId) {
		this.ordersId = ordersId;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getOrdersAmount() {
		return ordersAmount;
	}
	public void setOrdersAmount(int ordersAmount) {
		this.ordersAmount = ordersAmount;
	}
	public int getOrdersPrice() {
		return ordersPrice;
	}
	public void setOrdersPrice(int ordersPrice) {
		this.ordersPrice = ordersPrice;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public String getOrdersAddr() {
		return ordersAddr;
	}
	public void setOrdersAddr(String ordersAddr) {
		this.ordersAddr = ordersAddr;
	}
	public String getOrdersState() {
		return ordersState;
	}
	public void setOrdersState(String ordersState) {
		this.ordersState = ordersState;
	}
	public String getOrdersDate() {
		return ordersDate;
	}
	public void setOrdersDate(String ordersDate) {
		this.ordersDate = ordersDate;
	}
	
	
}
