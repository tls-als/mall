package vo;

public class Member {
	private String memberEmail;		// 회원 메일
	private String memberPassword;	// 회원 비밀번호
	private String memberName;		// 회원 이름
	private String memberDate;		// 가입일
	// Member() {
	//  memberEmail = null;
	//	memberPassword = null;... 
	// }
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public String getMemberPassword() {
		return memberPassword;
	}
	public void setMemberPassword(String memberPassword) {
		this.memberPassword = memberPassword;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberDate() {
		return memberDate;
	}
	public void setMemberDate(String memberDate) {
		this.memberDate = memberDate;
	}
}