package Servlet_QuestionManager;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Answer;
import Model.Question;
import Model.Exam;

@WebServlet("/DeleteQuestionBank")
public class DeleteQuestionBank extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteQuestionBank() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String QuestionID = (String)request.getParameter("QuestionID-Del");
		System.out.println(QuestionID);
		try {
				if(Exam.FindWhereQuestionID(QuestionID) == false)
				{
					Answer.DeleteWhereQuestionID(QuestionID);
					Question.Delete(QuestionID);
				}
				else
				{
					request.setAttribute("Warning", "ExistQuestionInExam");
				}
				
		} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
		}
		request.setAttribute("CallBackQuestionDetail", "true");
		request.getRequestDispatcher("LoadQuestionBank").forward(request, response);
	}

}
