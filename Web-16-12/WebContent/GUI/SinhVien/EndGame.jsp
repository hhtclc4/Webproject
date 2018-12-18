<%@page import="Model.Answer"%>
<%@page import="Model.Question"%>
<%@page import="Model.Student_DoTest"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Welcome To Online_Quiz</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="shortcut icon" href="http://www.dota2.com/images/favicon.ico"
	type="image/x-icon">
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/CSS/General.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/CSS/SinhVien.css">
</head>

<body>
<%
	HttpSession ss = request.getSession();
	String StudentID =(String) ss.getAttribute("UserID");
	String ExamID = (String) ss.getAttribute("ExamIDTemp");
%>
<div class="container-fluid">
	<div class="bodycolumn" style="padding-right:15px;">
	<div class="sidenav">
		<h1 class="text-center" style="font-size: 60px;">Kết quả làm bài</h1>
		</div>
	</div>
	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 bodycolumn">
				<div class="sidenav">
					<div style="margin-left: 20px;">
						<h2>
							Số câu đúng:<span class="label label-default"><%=request.getParameter("SCD")%></span>
						</h2>
						<h2>
							Điểm của bạn:<span class="label label-default"><%=request.getParameter("Diem") %></span>
						</h2>
						<br>
						
					</div>
					</div>
					<div class="sidenav">
					


					<%
							
								Cookie[] cks = request.getCookies();
								ArrayList<Student_DoTest> studList = Student_DoTest.getStudentDoTest(StudentID, ExamID);
								ArrayList<Question> qList = Question.getListQuestionByExam(ExamID);
								int indexQ = 1;
								for (Question question : qList) {
									out.print("<div style='margin-left:2%;'>");
									out.print("<p class='CauHoi'><b> Câu " + indexQ + " : " + question.getQuestion() + "</b></p>");
									Question questionDetail = Question.getQuestionDetail(question.getQuestionID());
									int indexA = 1;

									out.print("<ol type='A'>");
									for (Answer ans : questionDetail.ansList) //answer sheet
									{
										String correct = "";
										String studentChoose="";
										for (int i = 0; i < cks.length; i++)
											if (cks[i].getName().equals(question.getQuestionID() + "___" + ans.getAnswerID())) {
												cks[i].setMaxAge(0);
												response.addCookie(cks[i]);
												break;
											}

										/*if (Student_DoTest.checkStudentAnswer((String) ss.getAttribute("16110267"), "2",
												questionDetail.getQuestionID(), ans.getAnswerID()) == 1) {
											if (ans.getCorrect() == 1)
												correct = "<span class='glyphicon glyphicon-ok'>";
											else
												correct = "<span class='glyphicon glyphicon-remove'></span>";

										}*/
										
										
										for(Student_DoTest stud : studList)
										{
											if(stud.getQuestionID().equals(question.getQuestionID()) && stud.getAnswerID().equals(ans.getAnswerID()) && ans.getCorrect()==0)
											{
													correct = "<span class='glyphicon glyphicon-remove'></span>";
													studentChoose= " style='background-color:yellow;' ";
													break;
											
											}
											if(stud.getQuestionID().equals(question.getQuestionID()) && stud.getAnswerID().equals(ans.getAnswerID()) && ans.getCorrect()==1)
											{
												correct = "<span class='glyphicon glyphicon-ok-circle'></span>";
												studentChoose= " style='background-color:yellow;' ";
												break;
											}
												
										}
										
										System.out.println(correct);
										
										out.print("<li><label "+studentChoose+">Đáp Án " + indexA + " : " + ans.getAnswer() + correct + "</label></li>");
										indexA++;
									}
									out.print("</ol>");
									out.print("<hr>");
									out.print("</div>");
									indexQ++;
								}
							
						%>




				</div>
			</div>
		</div>
	</div>
</body>
</html>