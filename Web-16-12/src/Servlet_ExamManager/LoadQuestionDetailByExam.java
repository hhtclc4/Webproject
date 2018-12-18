package Servlet_ExamManager;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Answer;
import Model.Question;


@WebServlet("/LoadQuestionDetailByExam")
public class LoadQuestionDetailByExam extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LoadQuestionDetailByExam() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String QuestionID = request.getParameter("btn_QuestionDetail");
	    try {
			ArrayList<Answer> ansList = Answer.getAnswerList(QuestionID);
			String question = Question.FindQuestion(QuestionID); 
			request.setAttribute("AnswerList", ansList);
			request.setAttribute("Question", question);
			request.setAttribute("Modal_Detail_Block", "true");
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.getRequestDispatcher("GUI/NguoiRaDe/ChinhSuaDeThi.jsp").forward(request, response);
	}

}
