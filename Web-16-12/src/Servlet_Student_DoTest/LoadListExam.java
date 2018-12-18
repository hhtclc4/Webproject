package Servlet_Student_DoTest;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Exam;

/**
 * Servlet implementation class LoadListExam
 */
@WebServlet("/LoadListExam")
public class LoadListExam extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public LoadListExam() {
        super();
   
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");	
		HttpSession ss = request.getSession();
		String ClassID = (String) ss.getAttribute("ClassID");
		String SubjectID = request.getParameter("Subject");
		
		try {
				ArrayList<Exam> exList = Exam.getExamByClass_Subject(ClassID, SubjectID);
				request.setAttribute("exList", exList);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.getRequestDispatcher("GUI/SinhVien/ListQuiz.jsp").forward(request, response);
		

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
