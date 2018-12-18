<%@page import="Model.Account"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="Model.Student_DoTest"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="Model.Answer"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Question"%>
<%@page import="Model.Exam"%>

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
<link rel="shortcut icon" href="http://www.dota2.com/images/favicon.ico"
	type="image/x-icon">
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/CSS/General.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/CSS/Doquiz.css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/JavaScript/Script.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/JavaScript/SinhVien.js"></script>
</head>

<body style="overflow-x: hidden;">
	<%
		HttpSession ss = request.getSession();
		Cookie[] cksCheck = request.getCookies();

		String UserID = (String) ss.getAttribute("UserID");
		String UserType = (String) ss.getAttribute("UserType");

		
		if (UserID == null || UserID.isEmpty() || UserType.isEmpty() || UserType == null
				|| (UserType != null && !UserType.equals(new Account().Student))) {
			out.print("<script>alert('Lỗi Đăng Nhập')</script>");
			response.sendRedirect(request.getContextPath() + "/DeleteUserLogging");
		}
		
	%>



	<div class="navbar navbar-expand-lg bg-primary sticky-top clearfix">
		<a class="active" href="#"><i class="fa fa-fw fa-home"></i> Home</a> <a
			href="#"><i class="fa fa-fw fa-envelope"></i> Contact</a>
		<div>
			<label style="color: white;">Hello <%
				out.print((String) ss.getAttribute("UserName"));
			%></label> <a href="<%=request.getContextPath()%>/GUI/Main/Main.jsp"><i
				class="fa fa-fw fa-user"></i>Logout</a>
		</div>
	</div>

	<div class="container-fluid" style="width: 97%;">
		<div class="row">
			<div class="col-sm-12 bodycolumn"
				style="margin-top: 20px; margin-right: 20px; border-radius: 10px;">
				<div class="sidenav">
					<h1>Bài Thi</h1>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-8 bodycolumn"
				style="margin-top: 20px; margin-right: 20px; border-radius: 10px;">
				<div id="questionsentence">
					<%

						String ExamID = (String) ss.getAttribute("ExamID");
						if (ExamID != null) {
							ArrayList<Question> qList = Question.getListQuestionByExam(ExamID);
							if (qList != null && !qList.isEmpty()) {
								
								String QuestionIDNow = (String)request.getAttribute("QuestionIDNow");
								if(QuestionIDNow==null)
									QuestionIDNow = qList.get(0).getQuestionID();
								
								
								System.out.print("ASDASDASD : "+QuestionIDNow);
								
								
								String question = Question.FindQuestion(QuestionIDNow);
								
								
								out.print("<div class='row'>");
								out.print("<h3 style='margin-left: 30px;'>" + question + "</h3><hr><br><br>");

								ArrayList<Answer> aList = Answer.getAnswerList(QuestionIDNow);

								ArrayList<String> ansList = new ArrayList<String>(); // chua ansID +___+ choose

								Cookie[] cks = request.getCookies();
								// cookie chua thong tin câu hỏi = cách QuestionID___AnswerID voi value = 1|0
								for (int i = 0; i < cks.length; i++) {
									if ( cks[i].getName().contains(QuestionIDNow) ) 
									{
										String[] QuestionID_AnswerDetail = cks[i].getName().split("___"); // QuestionID_AnswerDetail[0] chua questionid // QuestionID_AnswerDetail[1] chua answerid
										
										ansList.add(QuestionID_AnswerDetail[1] + "___" + cks[i].getValue()); // QuestionID_AnswerDetail[0] => qsid QuestionID_AnswerDetail[1] => ansid + choose
									}
								}

								if (aList != null && !aList.isEmpty()) { // chua ansID + choose
									char x = 'A';
									int count = 0;

									out.print("<ul style='list-style:none;margin-left: 25px;font-size:150%;'>");
									for (Answer e : aList) {
										String checked = "";

										if (ansList != null && !ansList.isEmpty()) {
											for (String asnID : ansList) {
												String[] AnswerDetail = asnID.split("___");

												if (AnswerDetail[0].equals(e.getAnswerID()) && AnswerDetail[1].equals("1")) {
													checked = "checked";
													break;
												}

											}
										}
										out.print("<li><label><input id='" + count + "'" + "' onclick='setChoosedAnswer(this)' "
												+ checked + " type='checkbox'> " + x + ". " + e.getAnswer() + "</label></li>");
										x++;
										count++;

									}
									out.print("</ul>");
									out.print("</div>");
								}
							
					%>
					<hr>

				</div>
			</div>


			<div class="col-sm-3 bodycolumn"
				style="margin-top: 20px; border-radius: 10px;">
				<div class="sidenav">
					<h1 style='text-align: center;'>Danh Sách Câu hỏi</h1>
					<hr>
				</div>
				<div class="sidenav">
					
					<form>
						<%
							if (qList != null && !qList.isEmpty()) {
									ArrayList<Answer> ansCheck = (ArrayList<Answer>) Answer.getAnswerList(QuestionIDNow);
									int count = 0;
									if (aList != null && !aList.isEmpty())
										for (Answer e : ansCheck) {
											out.print("<input type='hidden' name='" + e.getAnswerID() + "' id='AnswerID" + count
													+ "' >");
											count++;
										}
	
									int dem = 1;
								//	int end = 5;
									out.print("<table id='quizlist'>");
									for (Question e : qList) {
										String Paint = "";
										if (ss.getAttribute("Paint" + e.getQuestionID()) != null
												&& ss.getAttribute("Paint" + e.getQuestionID()).equals("1"))
											Paint = "style='background-color:#80ffff'";
										if ((dem) % 5 == 1)
											out.print("<tr>");
										out.print("<td>");
										out.print("<button " + Paint + " class='btn btn-primary' " + "" + " formaction='"
												+ request.getContextPath() + "/GetQuestionNow?QuestionIDOld="+(String)request.getAttribute("QuestionIDNow")+"&Index="+dem+"' formmethod='post'"
												+ "type='submit' name='btnQuestion" + dem + "' value='" + e.getQuestionID() + "'><b>"
												+ dem + "</b></button>");
										out.print("</td>");
										if (dem %5 == 0)
										{
											out.print("</tr>");
									//		end=end+5;
										}
										dem++;
									}
									out.print("</table>");
								}
							}
						%>
						<%
							String Index = (String) ss.getAttribute("IndexExam");
							if (Index != null) {
								Exam ex = (Exam) ss.getAttribute("Exam" + Index);
								if (ex != null) {
									
									ss.setMaxInactiveInterval(60 * 60 + ex.getMinute() * 60);
									
									long time = ex.getStartExam().getTime() + ex.getMinute() * 60 * 1000;
									Timestamp EndTime = new java.sql.Timestamp(time);
									EndTime.getTime();
									System.out.print(EndTime);
									out.print("<input type='hidden' id='TimeEndTest' value='" + EndTime.getTime()
											+ "'>");
									if (ss.getAttribute("EndTest") == null)
										ss.setAttribute("EndTest", EndTime.getTime());
								}
							}
						}
						%>
						<p id="CountDownClock" class="clockStyle"></p>
						
						<button type="button" onclick="MessageSureToFinish()"
							class="btn btn-success" style="width: auto;margin-left:50%;margin-right:50%;transform: translate(-50%, -50%);margin-top:40px;">Nộp
							bài</button>
					</form>
					<form id="EndTest"
						action="<%=request.getContextPath()%>/GradingStudentDoTest"
						method="post">

					</form>
				</div>
			</div>
		</div>
	</div>
</body>

</html>