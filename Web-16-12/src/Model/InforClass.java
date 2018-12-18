package Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import ConnectJDBC.ConnectionJDBC;

public class InforClass {
	private String ClassID;
	private String ClassName;
	private int Index;
	public String getClassID() {
		return ClassID;
	}
	public void setClassID(String classID) {
		ClassID = classID;
	}
	public String getClassName() {
		return ClassName;
	}
	public void setClassName(String className) {
		ClassName = className;
	}
	public int getIndex() {
		return Index;
	}
	public void setIndex(int index) {
		Index = index;
	}
	public static ArrayList<InforClass> getListInforClass() throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="select * from InforClass";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		ArrayList<InforClass> iclList = new ArrayList<InforClass>();
		while(rs.next())
		{
			InforClass icl = new InforClass();
			icl.setClassID(rs.getString("ClassID"));
			icl.setClassName(rs.getString("ClassName"));
			iclList.add(icl);
		}
		conn.close();
		return iclList;
	}
	
	public static String getClassName(String ClassID) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="select ClassName from InforClass where ClassID='"+ClassID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		String ClassName = null;
		ResultSet rs = ps.executeQuery();
		if(rs.next())
		{
			ClassName = rs.getString("ClassName");
		}
		return ClassName;
	}
	
	public static boolean checkClassName(String ClassName) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="select count(ClassID) as Count from InforClass where ClassName='"+ClassName+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		int count = 0;
		ResultSet rs = ps.executeQuery();
		if(rs.next())
		{
			count = rs.getInt("Count");
		}
		if(count>0)
			return false;
		return true;
	}
	
	public static void Add(InforClass cl) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sIndex = "select MAX(`Index`) as Indexs "+" from InforClass";
		
		PreparedStatement ps1 = (PreparedStatement) conn.prepareStatement(sIndex);
		
		ResultSet rs = ps1.executeQuery();
		int Index = 0;
		while(rs.next())
		{
			Index = rs.getInt("Indexs");
		}
		Index++;
		cl.ClassID = String.valueOf(Index);
		
		String sql="INSERT INTO InforClass " +
                "VALUES ('"+cl.ClassID+"', '"+cl.ClassName+"',"+Index+")";
		
		PreparedStatement ps2 = (PreparedStatement) conn.prepareStatement(sql);
		ps2.executeUpdate();
	}
	
	public static void DeleteClass(String ClassID) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();		
		String sql1="UPDATE Student set ClassID = null where ClassID='"+ClassID+"'";
		PreparedStatement ps1 = (PreparedStatement) conn.prepareStatement(sql1);
		ps1.executeUpdate();
		
		
		String sql2 ="UPDATE Exam set ClassID = null where ClassID='"+ClassID+"'";
		PreparedStatement ps2 = (PreparedStatement) conn.prepareStatement(sql2);
		ps2.executeUpdate();
		
		
		String sql = "Delete from InforClass" + " where ClassID = '"+ClassID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ps.executeUpdate();
	}
	
	public static String getStudentClassName(String StudentID) throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="select ClassName from InforClass inf , Student stu "
					+" where inf.ClassID = stu.ClassID and stu.StudentID ='"+StudentID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		String ClassName = null;
		ResultSet rs = ps.executeQuery();
		if(rs.next())
		{
			ClassName = rs.getString("ClassName");
		}
		return ClassName;
	}
	
}
