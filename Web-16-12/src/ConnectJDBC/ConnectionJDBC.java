package ConnectJDBC;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionJDBC {


	public static Connection getMySQLConnection() {
		String hostName = "localhost";
		String dbName = "db_web_quiz?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull";
		String userName = "root";
		String password = "";
		try {
			try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
			} catch (InstantiationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Connection conn = DriverManager.getConnection("jdbc:mysql://"+hostName+":3306/"+dbName, userName, password);
			return conn;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	
}
