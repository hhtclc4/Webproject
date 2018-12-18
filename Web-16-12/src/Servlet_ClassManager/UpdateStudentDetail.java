package Servlet_ClassManager;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Account;

@WebServlet("/UpdateStudentDetail")
public class UpdateStudentDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public UpdateStudentDetail() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
			String stuName = request.getParameter("stuName");
			String stuSDT  = request.getParameter("stuSDT");
			String stuGT  = request.getParameter("stuGT");
			String stuEmail  = request.getParameter("stuEmail");
			String stuID = request.getParameter("stuID");
			Account student = new Account();
			student.setUserID(stuID);
			student.setEmail(stuEmail);
			student.setGioiTinh(stuGT);
			student.setSDT(stuSDT);
			student.setUserName(stuName);
			System.out.println("abccc "+request.getParameter("testsss"));
			System.out.println(request.getParameter("stuName")+" abc");
			try {
				Account.Update(student);
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.getRequestDispatcher("GUI/QuanLyLop/QuanLyThiSinh.jsp").forward(request, response);
	}

}
