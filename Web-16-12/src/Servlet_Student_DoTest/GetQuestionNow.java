package Servlet_Student_DoTest;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Answer;


@WebServlet("/GetQuestionNow")
public class GetQuestionNow extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public GetQuestionNow() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		try {
			SaveAnswerChoose(request,response);
			String Index = request.getParameter("Index");
			String QuestionIDUpdate = request.getParameter("btnQuestion"+Index);
			
			System.out.print("ASDASDASD : "+QuestionIDUpdate);
			
			if(QuestionIDUpdate!=null)
				request.setAttribute("QuestionIDNow", QuestionIDUpdate);
			
			
		} catch (ClassNotFoundException | SQLException e) {

			e.printStackTrace();
		}

			request.getRequestDispatcher("GUI/SinhVien/DoQuiz.jsp").forward(request, response);
	}
	
	void SaveAnswerChoose(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException
	{
		HttpSession ss = request.getSession();
		//String QuestionIDOld = (String)ss.getAttribute("QuestionIDOld");
		//ArrayList<Answer> aList = (ArrayList<Answer>)ss.getAttribute("ListAnswer");
		System.out.println("asdsad");
		String QuestionIDOld = request.getParameter("QuestionIDOld");
		
		ArrayList<Answer> aList = Answer.getAnswerList(QuestionIDOld);
		if(aList!=null && !aList.isEmpty())
		{
			System.out.println("Here Vinh : " + QuestionIDOld);
			for(Answer e : aList)
			{
				System.out.println(e.getAnswer());
				String choose = (String)request.getParameter(e.getAnswerID());
				System.out.println("choose ne : "+ choose);
				if(choose!=null && choose.equals("1")) // insert 
				{	
					Cookie[] cks = request.getCookies();
					boolean check = true;
					for(int i =0;i<cks.length;i++)
					{
						if(cks[i].getName().equals(QuestionIDOld+"___"+e.getAnswerID()))
						{
							cks[i].setValue("1");
							response.addCookie(cks[i]);
							ss.setAttribute("Paint"+QuestionIDOld, "1");
							System.out.println("Here Vinh2 : " + QuestionIDOld);
							check=false;
							break;
						}
					}
					if(check)
					{
						Cookie ck = new Cookie(QuestionIDOld+"___"+e.getAnswerID(),"1");
						response.addCookie(ck);
						ss.setAttribute("Paint"+QuestionIDOld, "1");
					}
				}
				else
				{
					if(choose!=null && choose.equals("0"))//remove
					{
						Cookie[] cks = request.getCookies();
						for(int i =0; i<cks.length;i++)
						{
							if(cks[i].getName().equals(QuestionIDOld+"___"+e.getAnswerID()))
							{
								cks[i].setValue("0");
								response.addCookie(cks[i]);
							}
						}
					}
				}
			}
		}
	}
}
