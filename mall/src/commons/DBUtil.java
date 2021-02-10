package commons;
import java.sql.*;

public class DBUtil {
	public Connection getConnection() throws Exception {
		String Driver = "org.mariadb.jdbc.Driver";
		String dbaddr = "jdbc:mariadb://beliefirst.kro.kr/mall";
		String dbid = "root";
		String dbpw = "java1004";
		Class.forName(Driver);
		Connection conn = DriverManager.getConnection(dbaddr,dbid,dbpw);
		return conn;
	}
}