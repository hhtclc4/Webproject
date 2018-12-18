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

/**
 * Servlet implementation class InsertQuestionBank
 */
@WebServlet("/InsertQuestionBank")
public class InsertQuestionBank extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertQuestionBank() {
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
		try 
		{
			String subjectID = (String)request.getParameter("Subject-Insert");
			String level =(String)request.getParameter("Level-Insert");
			String question = (String)request.getParameter("question-Insert");
			int countAs = Integer.parseInt((String)request.getParameter("CountAnswer"));

			Question qs = new Question();
			qs.setQuestion(question);
			qs.setLevel(Integer.parseInt(level));
			qs.setSubjectID(subjectID);

			Question.Add(qs);
			
			
		
			
			
			String answer;
			String correct;
			
			
			for(int i =1;i<=countAs;i++)
			{
				int flag = 0;
				answer = (String)request.getParameter("answer-Insert"+String.valueOf(i));
				correct = (String)request.getParameter("Correct"+String.valueOf(i));
				if(correct!=null && correct.equals("T"))
					flag=1;
				
				Answer as = new Answer();
				as.setAnswer(answer);
				as.setCorrect(flag);
				as.setQuestionID(qs.getQuestionID());
				as.setIndex(i);
				Answer.Add(as);
				System.out.println(i+"/");
			}
			
		} 
		catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("CallBackQuestionDetail", "true");
		request.getRequestDispatcher("LoadQuestionBank").forward(request, response);
	}

}
