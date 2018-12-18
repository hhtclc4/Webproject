package Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import ConnectJDBC.ConnectionJDBC;

public class Subject {
	private String SubjectID;
	private String SubjectName;
private int Index;
	
	


	public int getIndex() {
		return Index;
	}

	public void setIndex(int index) {
		Index = index;
	}
	public String getSubjectID() {
		return SubjectID;
	}
	public void setSubjectID(String subjectID) {
		SubjectID = subjectID;
	}
	public String getSubjectName() {
		return SubjectName;
	}
	public void setSubjectName(String subjectName) {
		SubjectName = subjectName;
	} 
	
	public static ArrayList<Subject> getSubject() throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql = "select * from Subject";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		ArrayList<Subject> qList = new ArrayList<>();
		while(rs.next())
		{
			Subject sb = new Subject();
			sb.SubjectID = rs.getString("SubjectID");
			sb.SubjectName = rs.getString("SubjectName");
			qList.add(sb);
		}
		conn.close();
		return qList;
	}
	
	public static String findSubjectName(String SubjectID) throws ClassNotFoundException, SQLException
	{

		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql ="select SubjectName from Subject where SubjectID ='"+SubjectID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		String SubjectName="";
		while(rs.next())
			SubjectName = rs.getString("SubjectName");
		System.out.println("now : " + SubjectName);
		return SubjectName;
	}
	
	
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		
		for(Subject e: Subject.getSubject())
		{
			System.out.println(e.SubjectID+" "+e.SubjectName);
		}
	
	}
	public static int CountQuestion(String SubjectID) throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql ="select Level,count(QuestionID) as Count from QuestionBank "
					+"where SubjectID ='"+SubjectID+"'"
					+"group by Level";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		int De = 0;
		int TB = 0;
		int Kho = 0;
		int count = 0;
		while(rs.next())
		{
			switch (rs.getInt("Level"))
			{
				case 1: De = rs.getInt("Count");				
					break;
				case 2: TB = rs.getInt("Count");	
					break;
				case 3: Kho = rs.getInt("Count");	
			}
		}
		
		count  = De*1000000 + TB * 1000 + Kho;
		
		return count;
	}
	
}
