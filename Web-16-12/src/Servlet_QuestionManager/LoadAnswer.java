package Servlet_QuestionManager;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



@WebServlet("/LoadAnswer")
public class LoadAnswer extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public LoadAnswer() {
        super();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	String questionID = (String)request.getParameter("QuestionID_Fix");
    	HttpSession session = request.getSession();
    	session.setAttribute("QuestionID", questionID);
    	request.setAttribute("Modal_Fix_Block", "true");
      	request.getRequestDispatcher("LoadQuestionBank").forward(request, response);  
    	}

}
