package Servlet_ClassManager;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.InforClass;

/**
 * Servlet implementation class DeleteInforClass
 */
@WebServlet("/DeleteInforClass")
public class DeleteInforClass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeleteInforClass() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");	
		String ClassID = request.getParameter("ClassID");
			System.out.println(ClassID);
			try {
				InforClass.DeleteClass(ClassID);
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.getRequestDispatcher("GUI/QuanLyLop/QuanLyLop.jsp").forward(request, response);
		
	}

}
