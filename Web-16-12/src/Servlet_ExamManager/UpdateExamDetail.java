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


@WebServlet("/UpdateExamDetail")
public class UpdateExamDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateExamDetail() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
		String ExamID = request.getParameter("ExamID_Fix");
		String ExamName = request.getParameter("ExamName_Fix");
		String ClassID = request.getParameter("select_ClassID");
		String StartExam = request.getParameter("StartExam_Fix")+":00";
		String FixformatStartExam = StartExam.replace("/", "-");
		int Minute = Integer.parseInt(request.getParameter("Minute_Fix")); 
		
		Exam ex = new Exam();
		ex.setExamID(ExamID);
		ex.setExamName(ExamName);
		ex.setClassID(ClassID);
		ex.setStartExam(Timestamp.valueOf(FixformatStartExam));
		ex.setMinute(Minute);
		
		try {
			Exam.UpdateExamDetail(ex);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		response.sendRedirect("GUI/NguoiRaDe/NguoiRaDe.jsp");
	}
}
