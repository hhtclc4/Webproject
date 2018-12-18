package Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.Cookie;

import com.mysql.jdbc.PreparedStatement;

import ConnectJDBC.ConnectionJDBC;

public class Student_DoTest {

	private String StudentID;
	private String AnswerID;
	private String QuestionID;
	private String ExamID;
	
	public Student_DoTest()
	{}
	
	public Student_DoTest(String studentID, String answerID, String questionID, String examID) {
		super();
		StudentID = studentID;
		AnswerID = answerID;
		QuestionID = questionID;
		ExamID = examID;
	}
	public String getStudentID() {
		return StudentID;
	}
	public void setStudentID(String studentID) {
		StudentID = studentID;
	}
	public String getAnswerID() {
		return AnswerID;
	}
	public void setAnswerID(String answerID) {
		AnswerID = answerID;
	}
	public String getQuestionID() {
		return QuestionID;
	}
	public void setQuestionID(String questionID) {
		QuestionID = questionID;
	}
	public String getExamID() {
		return ExamID;
	}
	public void setExamID(String examID) {
		ExamID = examID;
	}
	
	public static void InsertStudentAnswer(ArrayList<Student_DoTest> studList,float Diem) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		for(Student_DoTest e : studList)
		{
			String sql = "INSERT INTO Student_DoTest " +
	                "VALUES ('"+e.getStudentID()+"', '"+e.getAnswerID()+"', '"+e.getQuestionID()+"', '"+e.getExamID()+"' ,"+Diem+")";
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
			ps.executeUpdate();
		}
	}
	
	public static ArrayList<String> getChooseAnswerWhereQuestionID(ArrayList<Student_DoTest> studList,String QuestionID)
	{
		ArrayList<String> ansList = new ArrayList<String>();
		if(studList!=null && !studList.isEmpty())
		{
			for(Student_DoTest e: studList)
			{
				if(e.getQuestionID()!=null && QuestionID!=null && e.getQuestionID().equals(QuestionID))
					ansList.add(e.getAnswerID());
			}
		}
		return ansList;
	}
	
	
	public static boolean CheckChooseAnswer(String QuestionID,String AnswerID,ArrayList<Student_DoTest> studList)
	{
		
		for(Student_DoTest stud: studList)
		{
			if(QuestionID.equals(stud.getQuestionID()) && AnswerID.equals(stud.getAnswerID()))
				return true;
		}
		return false;
	}
	
	public static boolean CheckChooseAnswerCorrect(Cookie[] cks,String QuestionID,Answer ans)
	{
		for(int i =0;i<cks.length;i++)
		{
			if(cks[i].getName().equals(QuestionID+"___"+ans.getAnswerID()))
				return true;
		}
		return false;
	}
	

	
	public static String Grading(Cookie[] cks,String ExamID,String StudentID) throws ClassNotFoundException, SQLException
	{
		
		ArrayList<Question> qList =	Question.getListQuestionByExam(ExamID);
		ArrayList<Student_DoTest> studList = new ArrayList<Student_DoTest>();
		int Correct = 0;
		for(Question qs : qList)
		{
			ArrayList<Answer> ansList = Answer.getAnswerList(qs.getQuestionID());
			boolean flag = true;
			for(Answer ans : ansList)
			{
				for(int i = 0;i<cks.length;i++)
				{
					if(cks[i].getName().equals(qs.getQuestionID()+"___"+ans.getAnswerID()))
					{
						Student_DoTest stud = new Student_DoTest();
						stud.setAnswerID(ans.getAnswerID());
						stud.setExamID(ExamID);
						stud.setStudentID(StudentID);
						stud.setQuestionID(qs.getQuestionID());
						
						studList.add(stud);
						
						if(	ans.getCorrect() == 0 && cks[i].getValue().equals("1") ) // chon cau sai
						{
							flag = false;
							break;
						}
					}
					if(ans.getCorrect()==1 && CheckChooseAnswerCorrect(cks,qs.getQuestionID(),ans)==false) // khÃ´ng chá»�n cÃ¢u Ä‘Ãºng
					{
						flag = false;
						break;
					}
				}
				if(flag == false)
					break;
			}
			if(flag)
			{
				Correct++;
			}
		}
		
		if(qList!=null && !qList.isEmpty() )
		{
			int Diem = (Correct *10) / qList.size();
			String Diem_SoCauDung = String.valueOf(Diem) +"___"+ String.valueOf(Correct);
			
			System.out.println("Hhereasdsa" + Diem);
			InsertStudentAnswer(studList,Diem);
			return Diem_SoCauDung;
		}
		return null;
	}
	
	public static ArrayList<Question> getExamQuestion(ArrayList<Student_DoTest> studList,String ExamID) throws SQLException
	{
		ArrayList<Question> qList = new ArrayList<Question>();
		
		Connection conn = ConnectionJDBC.getMySQLConnection();
		
		String sql = "select qb.QuestionID,qb.Question,ans.AnswerID,ans.Answer,ans.Correct " 
					+" from QuestionBank qb,Answer ans, exam_question exq "
					+" where qb.QuestionID = ans.QuestionID and qb.QuestionID = exq.QuestionID and exq.ExamID='"+ExamID+"'";
		
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next())
		{
			Question qs = new Question();
			qs.setQuestion(rs.getString("Question"));
			qs.setQuestionID(rs.getString("QuestionID"));
			
			Answer ans = new Answer();
			ans.setAnswerID(rs.getString("AnswerID"));
			ans.setAnswer(rs.getString("Answer"));
			ans.setCorrect(rs.getInt("Correct"));
			
			qs.ansList.add(ans);
			
			qList.add(qs);
		}
		return qList;
	}
	
	
	public static void DeleteWhereExamID(String ExamID) throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql = "DELETE FROM Student_DoTest " +
                "WHERE ExamID= '"+ExamID+"'";
		
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ps.executeUpdate();
	}
	
	public static ArrayList<Student_DoTest> getStudentDoTest(String StudentID,String ExamID) throws SQLException
	{

		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql = "select * from student_dotest where  studentid = '"+StudentID+"' and examid ='"+ExamID+"'";
		
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		ArrayList<Student_DoTest> studList = new ArrayList<Student_DoTest>();
		while(rs.next())
		{
			Student_DoTest stud = new Student_DoTest();
			stud.setExamID(ExamID);
			stud.setStudentID(StudentID);
			stud.setAnswerID(rs.getString("AnswerID"));
			stud.setQuestionID(rs.getString("QuestionID"));
			studList.add(stud);
		}
		return studList;
	}
	
	public static int checkStudentAnswer(String StudentID,String ExamID,String QuestionID,String AnswerID) throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql = "select Count(AnswerID) as Count from student_dotest "
					+"where  studentid = '"+StudentID+"' and examid ='"+ExamID+"' and questionid ='"+QuestionID+"' and answerid = '"+AnswerID+"'";
		
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		int Count = 0;
		while(rs.next())
		{
			Count = rs.getInt("Count");
		}
		return Count;
	}
}
