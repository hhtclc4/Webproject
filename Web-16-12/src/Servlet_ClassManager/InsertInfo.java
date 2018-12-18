package Servlet_ClassManager;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.InforClass;

@WebServlet("/InsertInfo")
public class InsertInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public InsertInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String ClassName = request.getParameter("ClassName-Insert");
		try {
			if(InforClass.checkClassName(ClassName))
			{
				InforClass icl = new InforClass();
				icl.setClassName(ClassName);
				InforClass.Add(icl);
			}
			else
			{
				request.setAttribute("ClassNameAlreadyExist", "true");
			}
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.getRequestDispatcher("GUI/QuanLyLop/QuanLyLop.jsp").forward(request, response);
	}

}
