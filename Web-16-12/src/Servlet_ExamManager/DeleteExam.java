package Servlet_ExamManager;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Exam;
import Model.Exam_Question;
import Model.Student_DoTest;

@WebServlet("/DeleteExam")
public class DeleteExam extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public DeleteExam() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String ExamID = (String)request.getParameter("ExamID");
		
		try {
			
			Student_DoTest.DeleteWhereExamID(ExamID);
			Exam_Question.DeleteWhereExamID(ExamID);
			Exam.DeleteExam(ExamID);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.getRequestDispatcher("GUI/NguoiRaDe/NguoiRaDe.jsp").forward(request, response);;
		
	}

}
