package Servlet_QuestionManager;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Question;


@WebServlet("/LoadQuestionBank")
public class LoadQuestionBank extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoadQuestionBank() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");		
		String mh = request.getParameter("Subject");
		String lv = request.getParameter("Level");
		
		String Callback = (String) request.getAttribute("CallBack");
		String mhcb = (String)request.getAttribute("SubjectID");
		if(Callback!=null && Callback.equals("True") && mhcb!=null)
			mh = mhcb;
			
		
		try {
			ArrayList<Question> qList = Question.getQuestionBank(mh, lv);
			request.setAttribute("qList", qList);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("GUI/QuestionBank/QuestionBank.jsp").forward(request, response);

	}

}
