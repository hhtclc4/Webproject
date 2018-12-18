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

@WebServlet("/UpdateQuestionBank")
public class UpdateQuestionBank extends HttpServlet {
	private static final long serialVersionUID = 1L;
   public UpdateQuestionBank() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

		try {
				String QuestionID = request.getParameter("hdquestionID");
				String question = request.getParameter("mdquestion");
				Question qs = Question.getQuestionDetail(QuestionID);
				
				if(question!=null && !(qs.getQuestion().equals(question)))
						Question.Update(QuestionID, question);
				
				for(Answer ans: qs.ansList)
				{
					String answer = request.getParameter(ans.getAnswerID());
					int correct = Integer.parseInt(request.getParameter("Correct"+ans.getAnswerID()));
					if( (answer!=null && !(ans.getAnswer()).equals(answer)) ||  (correct != ans.getCorrect()))
					{
						Answer.Update(ans.getAnswerID(), ans.getQuestionID(), answer, correct);
					}
				}

				request.setAttribute("CallBack", "True");
				request.setAttribute("SubjectID", qs.getSubjectID());
				
		} catch (SQLException | ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		response.sendRedirect("GUI/QuestionBank/QuestionBank.jsp");
	}

}
