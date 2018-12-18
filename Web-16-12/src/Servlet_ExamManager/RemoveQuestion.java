package Servlet_ExamManager;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Exam_Question;

@WebServlet("/RemoveQuestion")
public class RemoveQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public RemoveQuestion() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			HttpSession ss = request.getSession();
			String ExamID = (String)ss.getAttribute("ExamID_FixExam");
			String QuestionID = request.getParameter("QuestionID");
			try {
				Exam_Question.RemoveQuestion_EXQ(ExamID, QuestionID);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.getRequestDispatcher("GUI/NguoiRaDe/ChinhSuaDeThi.jsp").forward(request, response);
	}

}
