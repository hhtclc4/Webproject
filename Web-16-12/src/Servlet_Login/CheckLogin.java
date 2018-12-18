package Servlet_Login;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Account;

@WebServlet("/CheckLogin")
public class CheckLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CheckLogin() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession ss = request.getSession();
		ss.setMaxInactiveInterval(-1);// tắt trình duyệt => del ss
		
		String UserType = (String)request.getParameter("selector");
		String UserID = (String)request.getParameter("username");
		String Pass = (String)request.getParameter("password");
		
		Account user = new Account();
		user.setUserID(UserID);
		user.setPassword(Pass);
		user.setUserType(UserType);
		
		try {
			if(Account.CheckLogin(user))
			{
				HttpSession session = request.getSession();
				session.setAttribute("UserID", user.getUserID());
				session.setAttribute("UserName", user.getUserName());
				session.setAttribute("UserType", user.getUserType());
				session.setAttribute("Password", Pass);
				
				
			/*	
			    Cookie ckUserID = new Cookie("UserID", user.getUserID());
				Cookie ckUserName = new Cookie("UserName", user.getUserName());
				Cookie ckUserType = new Cookie("UserType", user.getUserType());
				Cookie ckPassword = new Cookie("Password", user.getPassword());
				

				response.addCookie(ckUserID);
				response.addCookie(ckUserName);
				response.addCookie(ckUserType);
				response.addCookie(ckPassword);
				*/
				
				
				switch(user.getUserType())
				{
					case "STU" :	response.sendRedirect("GUI/SinhVien/ListClass.jsp");	break;
					case "EXM" :	response.sendRedirect("GUI/NguoiRaDe/NguoiRaDe.jsp");	break;
					case "QUM" :	response.sendRedirect("GUI/QuestionBank/QuestionBank.jsp");	break;
					case "CLM" :	response.sendRedirect("GUI/QuanLyLop/QuanLyLop.jsp");	break;
				}
			}
			else
			{
				 request.setAttribute("ErrorUser", "true");
				 request.getRequestDispatcher("GUI/Main/Main.jsp").forward(request, response);
			}
				
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

}
