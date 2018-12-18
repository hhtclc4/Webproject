package Servlet_ExamManager;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Question;

@WebServlet("/LoadQuestionDetaiBySubject")
public class LoadQuestionDetaiBySubject extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public LoadQuestionDetaiBySubject() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		HttpSession ss = request.getSession();
		String SubjectID = (String)ss.getAttribute("SubjectID_FixExam");
		
		try {
			ArrayList<Question> qList = Question.getListQuestionDetailBySubject(SubjectID);
			request.setAttribute("QuestionDetailBySubject", qList);
			request.setAttribute("openModelAddQuestion", "true");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.getRequestDispatcher("GUI/NguoiRaDe/ChinhSuaDeThi.jsp").forward(request, response);
	}

}
