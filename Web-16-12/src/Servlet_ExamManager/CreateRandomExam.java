package Servlet_ExamManager;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Exam;
import Model.Exam_Question;

@WebServlet("/CreateRandomExam")
public class CreateRandomExam extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public CreateRandomExam() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			String De = request.getParameter("De");
			String TB = request.getParameter("TrungBinh");
			String Kho = request.getParameter("Kho");
			String SubjectID = request.getParameter("SubjectID");
			System.out.println(De +"/" + TB + "/" + Kho +"/"+SubjectID);
			String ClassID = request.getParameter("select_class");
			String ExamName = request.getParameter("ExamName");
			String StartExam = request.getParameter("StartExam")+":00";
			String FixformatStartExam = StartExam.replace("/", "-");
			int Minute = Integer.parseInt(request.getParameter("Minute"));
			response.setContentType("text/html;charset=UTF-8");
	        request.setCharacterEncoding("UTF-8");
			
			try {
				Exam exam = new Exam();
				exam.setClassID(ClassID);
				exam.setExamName(ExamName);
				exam.setMinute(Minute);
				exam.setSubjectID(SubjectID);
				exam.setStartExam(Timestamp.valueOf(FixformatStartExam));
				System.out.println("cc");
				String ExamID = Exam.InsertExam(exam);
				
				if(!De.equals("0"))
					Exam_Question.CreateRanDomExam(exam.getSubjectID(), "1", De, ExamID);
				if(!TB.equals("0"))
					Exam_Question.CreateRanDomExam(exam.getSubjectID(), "2", TB, ExamID);
				if(!Kho.equals("0"))
					Exam_Question.CreateRanDomExam(exam.getSubjectID(), "3", Kho, ExamID);
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			response.sendRedirect("GUI/NguoiRaDe/NguoiRaDe.jsp");
	
	}

}