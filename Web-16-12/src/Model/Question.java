package Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import ConnectJDBC.ConnectionJDBC;

public class Question {
	private String QuestionID;
	private String Question;
	private String SubjectID;
	private int level;
	private int Index;

	public ArrayList<Answer> ansList = new ArrayList<Answer>();



	public int getIndex() {
		return Index;
	}

	public void setIndex(int index) {
		Index = index;
	}
	public String getQuestionID() {
		return QuestionID;
	}
	public void setQuestionID(String questionID) {
		QuestionID = questionID;
	}
	public String getQuestion() {
		return Question;
	}
	public void setQuestion(String question) {
		Question = question;
	}
	public String getSubjectID() {
		return SubjectID;
	}
	public void setSubjectID(String subjectID) {
		SubjectID = subjectID;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level)  {
		this.level = level;
	}

	public static String FindQuestion(String QuestionID) throws ClassNotFoundException, SQLException
	{
		String question= "";
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="select * from QuestionBank where QuestionID='"+QuestionID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			question = rs.getString("Question");
		}

		return question;
	}

	public static ArrayList<Question> getQuestionBank(String SubjectID,String Level) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql = "";
		if(SubjectID!=null && !SubjectID.equals("MH"))
		{
			if(Level!=null && !Level.equals("LV"))
				sql = 
				"select * " 
						+"from questionbank "
						+"WHERE level ='"+Level
						+"' and SubjectID='"+SubjectID+"'" 
						+" order by Level";
			else
				if(Level!=null)
				{
					sql = "select *"
							+"from questionbank "
							+"Where SubjectID= '"+SubjectID+"'" 
							+" order BY Level";
				}
		}
		else
			return null;
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		ArrayList<Question> qList = new ArrayList<>();
		while(rs.next())
		{
			Question qs = new Question();
			qs.QuestionID = rs.getString("QuestionID");
			qs.Question = rs.getString("Question");
			qs.SubjectID = rs.getString("SubjectID");
			qs.level = rs.getInt("Level"); 
			//////////////////////////////////////////////////////////////////////////

			String sqlans="select * from answer where questionid = '"+qs.QuestionID+"'";
			PreparedStatement psans = (PreparedStatement) conn.prepareStatement(sqlans);
			ResultSet rsans = psans.executeQuery();
			while(rsans.next())
			{
				Answer ans = new Answer();
				ans.setAnswer(rsans.getString("Answer"));
				ans.setAnswerID(rsans.getString("AnswerID"));
				ans.setCorrect(rsans.getInt("Correct"));
				ans.setQuestionID(qs.QuestionID);
				qs.ansList.add(ans);
			}
			qList.add(qs);
		}
		conn.close();
		return qList;
	}

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
	}

	public static void Update(String QuestionID,String Question) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();

		String sql="UPDATE QuestionBank set Question='"+Question+"' where QuestionID='" +QuestionID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ps.executeUpdate();
	}
	public static void Add(Question question) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sIndex = "select MAX(`Index`) as Indexs "+" from QuestionBank "+" where SubjectID ='"+question.SubjectID+"'";

		PreparedStatement ps1 = (PreparedStatement) conn.prepareStatement(sIndex);

		ResultSet rs = ps1.executeQuery();
		int Index = 0;
		while(rs.next())
		{
			Index = rs.getInt("Indexs");
		}

		System.out.println("index: "+Index);
		Index++;
		String QuestionID = question.SubjectID + "_" + String.valueOf(Index);
		question.QuestionID = QuestionID;
		String sql="INSERT INTO QuestionBank " +
				"VALUES ('"+QuestionID+"', "+question.level+", '"+question.Question+"', '"+question.SubjectID+"',"+Index+")";

		PreparedStatement ps2 = (PreparedStatement) conn.prepareStatement(sql);
		ps2.executeUpdate();


	}

	public static void Delete(String QuestionID) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="DELETE FROM QuestionBank " +
				"WHERE QuestionID = '"+QuestionID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ps.executeUpdate();
	}


	public static ArrayList<Question> getListQuestionByExam(String ExamID) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="select exq.QuestionID,qb.Question,qb.level from exam_question exq , questionbank qb "
				+ "where exq.QuestionID = qb.QuestionID and exq.ExamID='"+ExamID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		ArrayList<Question> qlist = new ArrayList<Question>();
		while(rs.next())
		{
			Question qs = new Question();
			qs.setQuestion(rs.getString("Question"));
			qs.setQuestionID(rs.getString("QuestionID"));
			qs.setLevel(rs.getInt("level"));

			//////////////////////////////////////////////////////////////////////////

			String sqlans="select * from answer where questionid = '"+qs.QuestionID+"'";
			PreparedStatement psans = (PreparedStatement) conn.prepareStatement(sqlans);
			ResultSet rsans = psans.executeQuery();
			while(rsans.next())
			{
				Answer ans = new Answer();
				ans.setAnswer(rsans.getString("Answer"));
				ans.setAnswerID(rsans.getString("AnswerID"));
				ans.setCorrect(rsans.getInt("Correct"));
				ans.setQuestionID(qs.QuestionID);
				qs.ansList.add(ans);
			}
			qlist.add(qs);
		}

		return qlist;
	}

	public static Question getQuestionDetail(String QuestionID) throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="select * from questionbank where questionid = '"+QuestionID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		Question qs= new Question();
		while(rs.next())
		{
			qs.setQuestion(rs.getString("Question"));
			qs.setSubjectID(rs.getString("SubjectID"));
			qs.setQuestionID(QuestionID);
			qs.setLevel(rs.getInt("Level"));

			////////////////////////////////
			String sqlans="select * from answer where questionid = '"+QuestionID+"'";
			PreparedStatement psans = (PreparedStatement) conn.prepareStatement(sqlans);
			ResultSet rsans = psans.executeQuery();
			while(rsans.next())
			{
				Answer ans = new Answer();
				ans.setAnswer(rsans.getString("Answer"));
				ans.setAnswerID(rsans.getString("AnswerID"));
				ans.setCorrect(rsans.getInt("Correct"));
				ans.setQuestionID(QuestionID);
				qs.ansList.add(ans);
			}

		}
		return qs;
	}






	public static ArrayList<Question> getListQuestionDetailBySubject(String SubjectID) throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql_question="select * from questionbank where subjectid = '"+SubjectID+"'";
		PreparedStatement ps_question = (PreparedStatement) conn.prepareStatement(sql_question);
		ResultSet rs_question = ps_question.executeQuery();

		ArrayList<Question> qlist = new ArrayList<Question>();
		while(rs_question.next())
		{
			Question qs = new Question();
			qs.setQuestion(rs_question.getString("Question"));
			qs.setQuestionID(rs_question.getString("QuestionID"));
			qs.setLevel(rs_question.getInt("level"));

			String sql_Answer = "select * from answer where questionid ='"+qs.getQuestionID()+"'";
			PreparedStatement ps_answer = (PreparedStatement) conn.prepareStatement(sql_Answer);
			ResultSet rs_answer = ps_answer.executeQuery();
			while(rs_answer.next())
			{
				Answer ans = new Answer();
				ans.setAnswer(rs_answer.getString("Answer"));
				ans.setCorrect(rs_answer.getInt("Correct"));
				qs.ansList.add(ans);
			}

			qlist.add(qs);
		}
		return qlist;
	}

}
