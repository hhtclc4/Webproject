package Servlet_ClassManager;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Student;

@WebServlet("/LoadStudentNoClass")
public class LoadStudentNoClass extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public LoadStudentNoClass() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession ss = request.getSession();
		System.out.println(ss.getAttribute("ClassID") + "/" + ss.getAttribute("ClassName"));
		try {
			ArrayList<Student> stuList = Student.getListStudentNoClass();
			request.setAttribute("ListStudentDetail_NoClass", stuList);
			request.setAttribute("Modal_Insert_Block", "true");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		request.getRequestDispatcher("GUI/QuanLyLop/QuanLyThiSinh.jsp").forward(request, response);
	}

}
