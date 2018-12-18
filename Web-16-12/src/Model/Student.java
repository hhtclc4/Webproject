package Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import ConnectJDBC.ConnectionJDBC;

public class Student {
	private String ClassID;
	private String StudentID;

	public String getClassID() {
		return ClassID;
	}
	public void setClassID(String classID) {
		ClassID = classID;
	}
	public String getStudentID() {
		return StudentID;
	}
	public void setStudentID(String studentID) {
		StudentID = studentID;
	}
	public static String FindClassID(String StudentID) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql = "select ClassID from student where studentid ='"+StudentID+"'";
		
		
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		String ClassID = "";
		while(rs.next())
		{
			ClassID = rs.getString("ClassID");
		}
		return ClassID;
	}
	public static ArrayList<Account> getInforStudent(String ClassID) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="select acc.UserID,acc.UserName,acc.SDT,acc.Email,acc.GioiTinh from Student stu , account acc "
					+"where stu.StudentID = acc.UserID and stu.ClassID='"+ClassID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		ArrayList<Account> accList = new ArrayList<Account>();
		while(rs.next())
		{
			Account acc = new Account();
			acc.setUserID(rs.getString("UserID"));
			acc.setUserName(rs.getString("UserName"));
			acc.setSDT(rs.getString("SDT"));
			acc.setEmail(rs.getString("Email"));
			acc.setGioiTinh(rs.getString("GioiTinh"));
			accList.add(acc);
		}
		return accList;
	}
	
	public static void RemoveStudent(String StudentID) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="UPDATE Student set ClassID = (NULL) where StudentID='"+StudentID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ps.executeUpdate();
	}
	
	public static ArrayList<Student> getListStudentNoClass() throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="select * from student where ClassID is null";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		ArrayList<Student> studList = new ArrayList<Student>();
		while(rs.next())
		{
			Student student = new Student();
			student.setStudentID(rs.getString("studentID"));
			studList.add(student);
		}
		return studList;
	}
	
	public static void AddToClass(String StudentID,String ClassID) throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="UPDATE Student set ClassID='"+ClassID+"' where StudentID = '"+StudentID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ps.executeUpdate();
	}
}
