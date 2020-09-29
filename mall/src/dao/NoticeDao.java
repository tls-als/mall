package dao;
import java.util.*;

import commons.DBUtil;
import java.sql.*;
import vo.*;

public class NoticeDao {
	// 공지 사항 목록을 조회하는 메서드
	public ArrayList<Notice> selectNoticeList() throws Exception{
		// 데이터를 담을 리스트 객체 생성
		ArrayList<Notice> list = new ArrayList<Notice>();
		// 마리아데이터베이스 연결하기 위한 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 전체 공지 리스트를 출력하는 쿼리
		String sql = "select notice_id, notice_title from notice order by notice_date desc limit 0, 2";
		// 쿼리문 실행하기
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		// 결과 값을 Notice vo에 담기
		while(rs.next()) {
			Notice n = new Notice();
			//n.noticeId = rs.getInt("notice_id");
			n.setNoticeId(rs.getInt("notice_id"));
			//n.noticeTitle = rs.getNString("notice_title");
			n.setNoticeTitle(rs.getNString("notice_title"));
			// 리스트에 추가하기
			list.add(n);
		}
		// 커넥션 종료
		conn.close();
		// 리스트를 리턴
		return list;
	}
	
	// 선택한 공지사항을 조회하는 메서드
	public ArrayList<Notice> selectNoticeOne(int noticeId) throws Exception{
		// 데이터를 담을 리스트 객체 생성
		ArrayList<Notice> list = new ArrayList<Notice>();
		// DB연결을 위한 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 선택한 공지 번호에 따른 조건부 리스트 조회
		String sql = "select notice_id, notice_title, notice_content, notice_date from notice where notice_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		// 매개변수로 넘어온 공지번호를 파라메터에 설정
		stmt.setInt(1, noticeId);
		// 쿼리 실행하기
		ResultSet rs = stmt.executeQuery();
		System.out.println(rs + "<- 쿼리 실행문");
		// 쿼리 결과를 가져와서 vo변수에 담기
		if(rs.next()) {
			Notice notice = new Notice();
			notice.setNoticeId(rs.getInt("notice_id"));
			notice.setNoticeTitle(rs.getString("notice_title"));
			notice.setNoticeContent(rs.getString("notice_content"));
			notice.setNoticeDate(rs.getString("notice_date"));
			list.add(notice);
		}
		conn.close();
		return list;
	}
}
