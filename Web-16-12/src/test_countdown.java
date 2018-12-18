import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Calendar;
import java.sql.Date;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.ResultSet;
import com.sun.jmx.snmp.Timestamp;

import ConnectJDBC.ConnectionJDBC;
import Model.Exam;


public class test_countdown {

	@SuppressWarnings("deprecation")
	public static void main(String[] args) throws SQLException, ClassNotFoundException {
		
		Connection conn = (Connection) ConnectionJDBC.getMySQLConnection();
		String sql ="select * from Exam";
		PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = (ResultSet) ps.executeQuery();
		ArrayList<Exam> list =  new ArrayList<Exam>();
		
		while(rs.next())
		{
			Exam ex = new Exam();
			Calendar c = Calendar.getInstance();
			ex.setExamID(rs.getString("ExamID"));
			ex.setClassID(rs.getString("ClassID"));
			ex.setMinute(rs.getInt("Minute"));
			ex.setSubjectID(rs.getString("SubjectID"));
			ex.setStartExam(rs.getTimestamp("StartExam"));
			list.add(ex);
		}
		
		
		
		//System.out.println( t2.getTime() - timestamp.getTime() );
		for(Exam e: list)
		{
			long t1 = System.currentTimeMillis();
			java.sql.Timestamp tt1 = new java.sql.Timestamp(t1);
			
			System.out.println( tt1 + "/" + (e.getStartExam()));
			
			System.out.println( (e.getStartExam().getTime() + 60*5*1000) - e.getStartExam().getTime());
		}
		
	}

}
