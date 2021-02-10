package vo;

public class Notice {
	//캡슐화
	private int noticeId;		// 공지 ID
	private String noticeTitle;	// 제목
	private String noticeContent; // 내용
	private String noticeDate; 	// 공지날짜(자바에 데이트와 마리아DB의 데이트 호환안됨)
	public int getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public String getNoticeDate() {
		return noticeDate;
	}
	public void setNoticeDate(String noticeDate) {
		this.noticeDate = noticeDate;
	}
}