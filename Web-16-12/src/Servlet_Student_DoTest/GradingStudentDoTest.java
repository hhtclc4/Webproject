package Servlet_Student_DoTest;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import Model.Student_DoTest;

@WebServlet("/GradingStudentDoTest")
public class GradingStudentDoTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public GradingStudentDoTest() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		HttpSession ss = request.getSession();
	
			String StudentID = (String) ss.getAttribute("UserID");
			String ExamID = (String)ss.getAttribute("ExamIDTemp");
			System.out.println(StudentID +"/"+ExamID);
			int Diem = 0;
			int SCD = 0;
			try {
				
				String Diem_SoCauDung = Student_DoTest.Grading(request.getCookies(), ExamID,StudentID);
				String[] mysplit = Diem_SoCauDung.split("___");
				
				Diem = Integer.parseInt(mysplit[0]);
				SCD = Integer.parseInt(mysplit[1]);
				
				

			} catch (ClassNotFoundException | SQLException e) 
			{
				e.printStackTrace();
			}
		
		request.getRequestDispatcher("GUI/SinhVien/EndGame.jsp?Diem="+Diem+"&SCD="+SCD).forward(request, response);
		
	}

}
