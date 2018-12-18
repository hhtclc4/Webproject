package Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import ConnectJDBC.ConnectionJDBC;

public class Exam {
	private String ExamID;
	private int Minute;
	private String ClassID;
	private String SubjectID;
	private Timestamp StartExam;
	private String ExamName;
	
	
	public String getExamName() {
		return ExamName;
	}
	public void setExamName(String examName) {
		ExamName = examName;
	}
	public Timestamp getStartExam() {
		return StartExam;
	}
	public void setStartExam(Timestamp startExam) {
		StartExam = startExam;
	}

	private int Index;
	
	
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
	public String getExamID() {
		return ExamID;
	}
	public void setExamID(String examID) {
		ExamID = examID;
	}
	
	public int getMinute() {
		return Minute;
	}
	public void setMinute(int minute) {
		Minute = minute;
	}
	public int getIndex() {
		return Index;
	}
	public void setIndex(int index) {
		Index = index;
	}
	public static boolean FindWhereQuestionID(String QuestionID) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="select count(QuestionID) as Count FROM exam_question " +
				"WHERE QuestionID = '"+QuestionID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		int dem = 0;
		while(rs.next())
		{
			dem = rs.getInt("Count");
		}
		conn.close();
		if(dem>0)
			return true;
		return false;
	}
	
	
	public static ArrayList<Exam> getExamByClass_Subject(String ClassID,String SubjectID) throws ClassNotFoundException, SQLException   
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql ="select * from exam where classid ='"+ClassID+"' and subjectid = '"+SubjectID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		ArrayList<Exam> exList = new ArrayList<Exam>();
		while(rs.next())
		{
			Exam ex = new Exam();
			ex.setClassID(ClassID);
			ex.setSubjectID(SubjectID);
			ex.setExamID(rs.getString("ExamID"));
			ex.setExamName(rs.getString("ExamName"));
			ex.setMinute(rs.getInt("Minute"));
			ex.setStartExam(rs.getTimestamp("StartExam"));
			exList.add(ex);
		}
		conn.close();
		return exList;
	}
	

	public static String findSubjectNameWhereExamID(String ExamID) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql ="select SubjectName from subject sb, exam ex where sb.SubjectID = ex.SubjectID and ExamID ='"+ExamID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		String SubjectName="";
		while(rs.next())
			SubjectName = rs.getString("SubjectName");
		conn.close();
		return SubjectName;
	}

	
	

	public static ArrayList<Exam> getListExam() throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql ="select * from exam";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
	    ArrayList<Exam> exList = new ArrayList<Exam>();
		while(rs.next())
		{
			Exam ex = new Exam();
			ex.setClassID(rs.getString("ClassID"));
			ex.setExamID(rs.getString("ExamID"));
			ex.setMinute(rs.getInt("Minute"));
			ex.setStartExam(rs.getTimestamp("StartExam"));
			ex.setSubjectID(rs.getString("SubjectID"));
			ex.setExamName(rs.getString("ExamName"));
			exList.add(ex);
		}
		conn.close();
		return exList;
	}
	
	public static void DeleteExam(String ExamID) throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql = "DELETE FROM Exam " +
                "WHERE ExamID= '"+ExamID+"'";
		
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ps.executeUpdate();
		conn.close();
	}
	public static void UpdateExamDetail(Exam ex) throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="UPDATE Exam set StartExam= '"+ex.getStartExam()+"' , Minute = "+ex.getMinute()+", ClassID = '"+ex.getClassID()+"' , ExamName ='"+ex.getExamName()+"'"
		+" where ExamID='" +ex.getExamID()+"'";
		
		
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ps.executeUpdate();
		conn.close();
	}
	public static String InsertExam(Exam exam) throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		
		String sql_index = "select MAX(`Index`) as Indexs from Exam ";
		PreparedStatement ps_index = (PreparedStatement) conn.prepareStatement(sql_index);
		ResultSet rs_index = ps_index.executeQuery();
		int index=0;
		while(rs_index.next())
			index = rs_index.getInt("Indexs");
		index++;
		String ExamID = "EX_"+index;
		String sql_insertExam = "INSERT INTO Exam " +
                "VALUES ('"+ExamID+"','"+exam.getStartExam()+"', "+exam.getMinute()+", '"+exam.getClassID()+"','"+exam.getSubjectID()
                	+"',"+index+", '"+exam.getExamName()+"')";
		PreparedStatement ps_insertExam = (PreparedStatement) conn.prepareStatement(sql_insertExam);
		ps_insertExam.executeUpdate();
		
		return ExamID;
	}
}

