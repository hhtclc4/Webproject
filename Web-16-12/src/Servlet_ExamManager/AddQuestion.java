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

/**
 * Servlet implementation class AddQuestion
 */
@WebServlet("/AddQuestion")
public class AddQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddQuestion() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession ss = request.getSession();
		response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
		String QuestionID = request.getParameter("Add_QuestionID");
		String ExamID = (String) ss.getAttribute("ExamID_FixExam");
		
		try {
				if(Exam_Question.checkQuestion(ExamID, QuestionID))
				{
					Exam_Question.AddQuestion(ExamID, QuestionID);
					request.setAttribute("QuestionAlreadyExist", "false");
				}
				else
					request.setAttribute("QuestionAlreadyExist", "true");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.getRequestDispatcher("GUI/NguoiRaDe/ChinhSuaDeThi.jsp").forward(request, response);
	}

}
