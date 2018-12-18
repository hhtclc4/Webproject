package Servlet_ClassManager;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Student;

/**
 * Servlet implementation class AddStudent
 */
@WebServlet("/AddStudentToClass")
public class AddStudentToClass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddStudentToClass() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession ss = request.getSession();
		String ClassID =(String) ss.getAttribute("ClassID");
		String StudentID = (String)request.getParameter("studentID");
		try {
			Student.AddToClass(StudentID, ClassID);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("GUI/QuanLyLop/QuanLyThiSinh.jsp");
	}

}
