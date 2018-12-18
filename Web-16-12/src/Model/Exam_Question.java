package Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import ConnectJDBC.ConnectionJDBC;

public class Exam_Question {
	
	private String ExamID;
	private String QuestionID;
	public String getExamID() {
		return ExamID;
	}
	public void setExamID(String examID) {
		ExamID = examID;
	}
	public String getQuestionID() {
		return QuestionID;
	}
	public void setQuestionID(String questionID) {
		QuestionID = questionID;
	}
	
	public static ArrayList<Exam_Question> getListOFExam_Question(String ExamID) throws ClassNotFoundException, SQLException
	{

		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql =  "select QuestionID"
					+" from exam_question exq"
					+ " where exq.ExamID ='"+ExamID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		ArrayList<Exam_Question> exqList = new ArrayList<Exam_Question>();
		while(rs.next())
		{
			Exam_Question exq = new Exam_Question();
			exq.setQuestionID(rs.getString("QuestionID"));
			exqList.add(exq);
		}
		return exqList;
	}
	
	
	
	public static void CreateRanDomExam(String SubjectID,String Level,String SoLuong,String ExamID) throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		
		String sql =  "select QuestionID"
						+" from questionbank"
						+" where level = "+Integer.parseInt(Level)+" and SubjectID = '"+SubjectID+"'"
						+" ORDER by RAND()"
						+" limit "+Integer.parseInt(SoLuong)+";";
		
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			Exam_Question exq = new Exam_Question();
			exq.setExamID(ExamID);
			exq.setQuestionID(rs.getString("QuestionID"));
			
			String sql_insertExam_Question = "INSERT INTO exam_question "
								+" VALUES ('"+ExamID+"', '"+rs.getString("QuestionID")+"')";
			
			PreparedStatement ps_insertExam_Question = (PreparedStatement) conn.prepareStatement(sql_insertExam_Question);
			ps_insertExam_Question.executeUpdate();
		}
	}
	
	public static void RemoveQuestion_EXQ (String ExamID,String QuestionID) throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		
		String sql="DELETE FROM Exam_Question " +
                "WHERE ExamID='"+ExamID+"' and QuestionID = '"+QuestionID+"'";
		
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ps.executeUpdate();
	}
	
	public static void AddQuestion(String ExamID,String QuestionID) throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql = "INSERT INTO exam_question "
					+"VALUES ('"+ExamID+"' , '"+QuestionID+"')";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ps.executeUpdate();
	}
	
	public static boolean checkQuestion(String ExamID,String QuestionID) throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql = "select count(QuestionID) as Count from exam_question "
					+"where QuestionID='"+QuestionID+"' and ExamID='"+ExamID+"'";
		
		int count=0;
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
			count = rs.getInt("Count");
		if(count==0)
			return true;
		return false;
	}
	
	public static void DeleteWhereExamID(String ExamID) throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		
		String sql="DELETE FROM Exam_Question " +
                "WHERE ExamID='"+ExamID+"'";
		
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ps.executeUpdate();
		//System.out.println("sadasd"+ExamID);
	}
	
}
