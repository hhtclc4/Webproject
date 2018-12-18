package Servlet_ClassManager;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Account;

@WebServlet("/LoadStudentDetail")
public class LoadStudentDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public LoadStudentDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String StudentID = request.getParameter("StudentID_Fix");
		System.out.println(StudentID);
		try {
				Account user = Account.getAccountDetail(StudentID);
				request.setAttribute("StudentDetail_fix", user);
				request.setAttribute("Modal_Fix_Block","true");
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
			request.getRequestDispatcher("GUI/QuanLyLop/QuanLyThiSinh.jsp").forward(request, response);
	}

}
