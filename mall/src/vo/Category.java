package vo;

// 결과값을 담는 클래스
public class Category {
	private int categoryId;			// 카테고리 ID
	private String categoryName;	// 카테고리 이름
	private String categoryPic;		// 카테고리 사진
	private String categoryCk;		// 카테고리  추천여부
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getCategoryPic() {
		return categoryPic;
	}
	public void setCategoryPic(String categoryPic) {
		this.categoryPic = categoryPic;
	}
	public String getCategoryCk() {
		return categoryCk;
	}
	public void setCategoryCk(String categoryCk) {
		this.categoryCk = categoryCk;
	}
	
}