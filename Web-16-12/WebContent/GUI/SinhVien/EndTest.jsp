<%@page import="Model.Account"%>
<%@page import="Model.Answer"%>
<%@page import="Model.Exam"%>
<%@page import="Model.Question"%>
<%@page import="Model.Student_DoTest"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	HttpSession ss = request.getSession();
	String UserID = (String)ss.getAttribute("UserID");
	String UserType = (String)ss.getAttribute("UserType");
	

	if (UserID == null || UserID.isEmpty() || UserType.isEmpty() || UserType == null
			|| (UserType != null && !UserType.equals(new Account().Student))) {
		
		out.print("<script>alert('Lỗi Đăng Nhập')</script>");
		response.sendRedirect(request.getContextPath() + "/DeleteUserLogging");
	}
	else
		System.out.print("Endtest : "+UserID+"/"+UserType);
	%>

	<h1 style="text-align: center;color: red;">Hết Giờ Làm Bài</h1>
		<h1>Điểm : <%=(Float)request.getAttribute("Point")%></h1>
		
		<%
					String ExamID = "";
					Cookie[] cks = request.getCookies();
					if(cks!=null)
					{
						for(int i=0;i<cks.length;i++)
							if(cks[i].getName().equals("ExamID"))
							{
								ExamID = cks[i].getValue();
								cks[i].setMaxAge(0);
								response.addCookie(cks[i]);
								break;
							}
						
						ArrayList<Student_DoTest> studList = Student_DoTest.getStudentDoTest((String)ss.getAttribute("UserID"), ExamID);
						ArrayList<Question> qList = Question.getListQuestionByExam(ExamID);
						int indexQ = 1;
						for(Question question : qList)
						{
							out.print("Câu " + indexQ + " : " + question.getQuestion() + "<br>");
							
							Question questionDetail = Question.getQuestionDetail(question.getQuestionID());
							int indexA = 1;
							for (Answer ans : questionDetail.ansList) //answer sheet
							{
								String correct = "";
								for(int i=0;i<cks.length;i++)
									if(cks[i].getName().equals(question.getQuestionID()+"___"+ans.getAnswerID()))
									{
										cks[i].setMaxAge(0);
										response.addCookie(cks[i]);
										break;
									}
								
								if (Student_DoTest.checkStudentAnswer(UserID, ExamID, questionDetail.getQuestionID(), ans.getAnswerID()) == 1)
								{
									if (ans.getCorrect() == 1)
										correct = "<span class='glyphicon glyphicon-ok'>";
									else
										correct = "<span class='glyphicon glyphicon-remove'></span>";
	
								}
								out.print("Đáp Án " + indexA + " : " + ans.getAnswer() + correct + " <br>");
								indexA++;
							}
							indexQ++;
						}
					}
				%>
</body>
</html>