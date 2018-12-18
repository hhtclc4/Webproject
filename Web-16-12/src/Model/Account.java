package Model;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

import ConnectJDBC.ConnectionJDBC;

public class Account {
	
	private String UserID;
	private String UserName;
	private String Password;
	private String UserType;
	
	private String SDT;
	private String Email;
	private String GioiTinh;
	
	
	public String  Student = "STU";
	public String  QuestionM = "QUM";
	public String  ExamM = "EXM";
	public String  ClassM = "CLM";
	
	
	
	public String getSDT() {
		return SDT;
	}
	public void setSDT(String sDT) {
		SDT = sDT;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	
	public String getGioiTinh() {
		return GioiTinh;
	}
	public void setGioiTinh(String gioiTinh) {
		GioiTinh = gioiTinh;
	}
	public String getUserType() {
		return UserType;
	}
	public void setUserType(String userType) {
		UserType = userType;
	}
	public String getPassword() {
		return Password;
	}
	public void setPassword(String password) {
		Password = password;
	}
	public String getUserID() {
		return UserID;
	}
	public void setUserID(String userID) {
		UserID = userID;
	}
	public String getUserName() {
		return UserName;
	}
	public void setUserName(String userName) {
		UserName = userName;
	}


	public static boolean CheckLogin(Account account) throws ClassNotFoundException, SQLException
	{
		
		Connection conn = (Connection) ConnectionJDBC.getMySQLConnection();
		String sql= "select * from Account where UserID = '"+ account.UserID +"'";
		String username="";
		String password="";
		String usertype ="";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			username = rs.getString("UserName");
			password = rs.getString("password");
			usertype = rs.getString("usertype");
		}
		
		if(password.equals(account.getPassword()) && usertype.equals(account.getUserType()))
		{
			account.setUserName(username);
			System.out.println(account.getUserName());
			return true;
		}
		return false;
	}
	
	public static Account getAccountDetail(String UserID) throws SQLException, ClassNotFoundException
	{
		String sql = "select * from Account where UserID='"+UserID+"'";
		Connection conn = (Connection) ConnectionJDBC.getMySQLConnection();
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		Account user = new Account();
		while(rs.next())
		{
			user.setUserID(UserID);
			user.setUserName(rs.getString("UserName"));
			user.setEmail(rs.getString("Email"));
			user.setSDT(rs.getString("SDT"));
			user.setGioiTinh(rs.getString("GioiTinh"));
		}
		return user;
	}
	
	public static void Update(Account user) throws ClassNotFoundException, SQLException
	{
		System.out.println("username " + user.UserName);
		Connection conn = (Connection) ConnectionJDBC.getMySQLConnection();
		String sql="UPDATE Account "
					+" set UserName = '"+user.UserName+"' , SDT='"+user.SDT+"', Email='"+user.Email+"', GioiTinh='" + user.GioiTinh+"'"
					+" where UserID='"+user.UserID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ps.executeUpdate();
	}
}
