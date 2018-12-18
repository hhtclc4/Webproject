package Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import ConnectJDBC.ConnectionJDBC;

public class Class_Subject {

	private String ClassID;
	private String SubjectID;
	public String getClassID() {
		return ClassID;
	}
	public void setClassID(String classID) {
		ClassID = classID;
	}
	public String getSubjectID() {
		return SubjectID;
	}
	public void setSubjectID(String subjectID) {
		SubjectID = subjectID;
	}
	
	
	public static ArrayList<Subject> getListOFClass_SubjectName(String ClassID) throws SQLException, ClassNotFoundException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql = "select sb.SubjectID,sb.SubjectName from class_subject clsb , subject sb "
					+" where clsb.ClassID='"+ClassID+"' and clsb.SubjectID=sb.SubjectID";
		
		
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		ArrayList<Subject> sbList = new ArrayList<Subject>();
		while(rs.next())
		{
			Subject sb = new Subject();
			sb.setSubjectID(rs.getString("SubjectID"));
			sb.setSubjectName(rs.getString("SubjectName"));
			sbList.add(sb);
		}
		return sbList;
	}
	
}
