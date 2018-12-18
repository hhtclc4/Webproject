package Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import ConnectJDBC.ConnectionJDBC;

public class Answer {	
		
	private String AnswerID;
	private String Answer;
	private int Correct;
	private String QuestionID;
	private int Index;
	
	
	
	public int getIndex() {
		return Index;
	}

	public void setIndex(int index) {
		Index = index;
	}

	public String getAnswerID() {
		return AnswerID;
	}

	public void setAnswerID(String answerID) {
		AnswerID = answerID;
	}

	public String getAnswer() {
		return Answer;
	}

	public void setAnswer(String answer) {
		Answer = answer;
	}

	public int getCorrect() {
		return Correct;
	}

	public void setCorrect(int correct) {
		Correct = correct;
	}

	public String getQuestionID() {
		return QuestionID;
	}

	public void setQuestionID(String questionID) {
		QuestionID = questionID;
	}


	public static String FindAnswer(String AnswerID) throws ClassNotFoundException, SQLException
	{
		String answer= "";
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="select * from Answer where AnswerID='"+AnswerID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			answer = rs.getString("Answer");
		}
		System.out.println("answer taggg: " + answer);
		return answer;
	}

	public static void Update(String AnswerID,String QuestionID,String Answer,int Correct) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="UPDATE Answer set Answer='"+Answer+"' , Correct ='"+Correct+"' where AnswerID='" +AnswerID+"'" + "and QuestionID ='"+QuestionID+"'" ;
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ps.executeUpdate();
	}
	
	public static ArrayList<Answer> getAnswerList(String QuestionID) throws ClassNotFoundException, SQLException
	{

		Connection conn = ConnectionJDBC.getMySQLConnection();	
		String sql = "select * from Answer where Answer.QuestionID= '"+QuestionID+"' order by QuestionID,AnswerID";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		ArrayList<Answer> asList = new ArrayList<>();
		while(rs.next())
		{
			Answer as = new Answer();
			as.AnswerID = rs.getString("AnswerID");
			as.Answer = rs.getString("Answer");
			as.Correct = rs.getInt("Correct");
			as.QuestionID = rs.getString("QuestionID");
			asList.add(as);
		}
		conn.close();
		return asList;
	}
	
	
	public static Answer getAnswerDetail(String AnswerID) throws SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();	
		String sql = "select * from Answer where AnswerID ='"+AnswerID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		Answer as = new Answer();
		while(rs.next())
		{
			
			as.AnswerID = rs.getString("AnswerID");
			as.Answer = rs.getString("Answer");
			as.Correct = rs.getInt("Correct");
			as.QuestionID = rs.getString("QuestionID");
		
		}
		return as;
	}
	
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		
		for(Answer e: getAnswerList("AV1_2"))
		{
			System.out.println(e.Answer+" "+e.AnswerID);
		}
	}
	
	
	public static void Add(Answer answer) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String AnswerID = String.valueOf(answer.Index);
		String sql="INSERT INTO Answer " +
                "VALUES ('"+AnswerID+"', '"+answer.Answer+"', "+answer.Correct+", '"+answer.QuestionID+"'"+","+answer.Index+")";
		
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ps.executeUpdate();
	}
	
	public static void DeleteWhereQuestionID(String QuestionID) throws ClassNotFoundException, SQLException
	{
		Connection conn = ConnectionJDBC.getMySQLConnection();
		String sql="DELETE FROM Answer " +
                "WHERE QuestionID = '"+QuestionID+"'";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ps.executeUpdate();
	}
}	
