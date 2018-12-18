<%@page import="Model.Account"%>
<%@page import="Model.Answer"%>
<%@page import="Model.Subject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Question"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Welcome To Exam Page</title>
        <title>Welcome To Question-Bank</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
 	<script type="text/javascript" src="<%=request.getContextPath()%>/JavaScript/Script.js"></script>
 		<script type="text/javascript" src="<%=request.getContextPath()%>/JavaScript/jquery-3.3.1.js"></script>
 	<link rel="shortcut icon" href="http://www.dota2.com/images/favicon.ico" type="image/x-icon">
 	<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 	<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/General.css">
 	<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/NguoiRaDe.css">
 <script type="text/javascript" src="<%=request.getContextPath()%>/JavaScript/ChinhSuaDeThi.js"></script>
  </head>

  <body>

	<%
		HttpSession ss = request.getSession();


		String UserID = (String)ss.getAttribute("UserID");
		String UserType = (String)ss.getAttribute("UserType");

	
		if (UserID == null || UserID.isEmpty() || UserType.isEmpty() || UserType == null
				|| (UserType != null && !UserType.equals(new Account().ExamM))) {
			out.print("<script>alert('Lỗi Đăng Nhập')</script>");
			response.sendRedirect(request.getContextPath() + "/DeleteUserLogging");
		}
		
		String ExamID_FixExam = (String) ss.getAttribute("ExamID_FixExam");
		String SubjectID_FixExam = (String) ss.getAttribute("SubjectID_FixExam");

		String ExID = request.getParameter("ExamID");
		String SubID = request.getParameter("SubjectID");

		if (ExamID_FixExam == null || (ExamID_FixExam != null && ExID != null && !ExamID_FixExam.equals(ExID)))
			ss.setAttribute("ExamID_FixExam", request.getParameter("ExamID"));

		if (SubjectID_FixExam == null
				|| (SubjectID_FixExam != null && SubID != null && !SubjectID_FixExam.equals(SubID)))
			ss.setAttribute("SubjectID_FixExam", request.getParameter("SubjectID"));
	%>

	<div id="Banner" class="container-fluid clearfix shadow p-4 mb-4 ">
		<div class="clearfix rounded">
			<div class="img-container"><a href="#"><img class="rounded-circle icon" src="<%=request.getContextPath()%>/Image/fb.png"  alt="logo"></a></div>
			<div class="img-container"><a href="#"><img class="rounded-circle icon" src="<%=request.getContextPath() %>/Image/twitter.png"  alt="logo"></a></div>
			<div class="img-container"><a href="#"><img class="rounded-circle icon" src="<%=request.getContextPath() %>/Image/youtube.png"  alt="logo"></a></div>
		</div>
		<div>
			<img class="WebQuizOnline" src="<%=request.getContextPath() %>/Image/WebQuizOnline.png">
		</div>
	</div>

	<div class="navbar navbar-expand-lg bg-primary sticky-top clearfix">
		<a class="active" href="#"><i class="fa fa-fw fa-home"></i> Home</a> <a
			href="#"><i class="fa fa-fw fa-envelope"></i> Contact</a>
		<div>
			<label style="color: white;">Hello <%
				out.print((String)ss.getAttribute("UserName"));
			%></label> 
			<a href="<%=request.getContextPath()%>/GUI/Main/Main.jsp"><i class="fa fa-fw fa-user"></i>Logout</a>
		</div>
	</div>

	<%--container for forms about search question --%>
	<div class="container-fluid" style="width: 97%;">
		<div class="row">
			<div class="col-sm-2 bodycolumn" style="margin-top:20px;margin-right:20px;border-radius:10px;">
				<div class="sidenav" >
					<h3 style="color: red; text-align: center;">  <span class="glyphicon glyphicon-time"></span>Server Clock</h3><hr>
				</div>
				<div class="sidenav">
					<div id="clockDisplay" class="clockStyle"></div>
					
					
					
					
						<form action="#">
							<div><button style="width: auto;margin-left:50%;margin-right:50%;transform: translate(-50%, -50%);margin-top:40px;" type="submit" formaction="<%=request.getContextPath()%>/GUI/NguoiRaDe/NguoiRaDe.jsp" class="btn btn-primary">
							<span class="glyphicon glyphicon-chevron-left"></span>Back</button></div>
						</form>
				
					</div>
				
			</div>



			<div class="col-sm-9 bodycolumn"
				style="margin-top: 20px; margin-right: 20px; border-radius: 10px;">
				<div class="sidenav" style="padding-left: 15px;">
						<%--form for choosing what type of question --%>
						
						<form action="#"
							method="post">
							<div><h1 style="text-align: center;">Mã  Đề  : <%=ss.getAttribute("ExamID_FixExam")%></h1></div>
							<div><h1 style="text-align: center;">Môn Học : <%=Subject.findSubjectName((String)ss.getAttribute("SubjectID_FixExam"))%></h1></div>
							<hr>
							
							<div>
									<button type="button" onclick="document.getElementById('addQuestion').style.display='block'"
										class="btn btn-primary" style="width:auto"
										><span class="glyphicon glyphicon-plus"></span>Thêm Câu Hỏi</button>
							</div>
						</form>
						</div>
						

					
					
					
					<div class="sidenav">
					<form id="tb-question" style="background-color: white;"
						action="#"
						method="post">
						
						<%
							ArrayList<Question> qList = Question.getListQuestionByExam((String)ss.getAttribute("ExamID_FixExam"));
								if (qList != null) {
									out.print("<table id=" + "Question-tb" + ">");
									out.print("<tr class=" + "header" + ">");
									out.print("<th style=" + "'background-color: red; width: 10%;'" + ">Level</th>");
									out.print("<th style='background-color:#4CAF50;color:white;'>Câu Hỏi</th>");
									out.print("<th style='background-color:#4CAF50;color:white;'>Chi Tiết</th>");
									out.print("<th style='background-color:#4CAF50;color:white;'>Xóa</th>");
									out.print("</tr>");
									out.print("<tr>");

									for (Question e : qList) {
										out.print("<tr>");
										out.print("<td>" + e.getLevel() + "</td>");
										out.print("<td  style=" + "'text-align: left;' >" + e.getQuestion() + "</td>");
										out.print("<td>");
										
										String str = e.getQuestion()+"question_answer";
										for(Answer ans : e.ansList)
										{
											str+= ans.getAnswer() + "___";
										}
										out.print("<button class='btn btn-primary' style='width: auto;' type='button' "
										+"value='"+ str + "'" + " id='"+e.getQuestionID()+"' onclick='OpenModalQuestionDetail(this)'><span class='glyphicon glyphicon-zoom-in'></span></button>");
										
										out.print("</td>");
										
										out.print("<td><button"
												+" class='btn btn-danger' style='width: auto;' type='button' value='"
												+ e.getQuestionID() + "'"+" onclick='MessageSure(this)'><i class='fa fa-trash'></i></button></td>");
										
										out.print("</tr>");
									}
									out.print("</table>");
								}
						%>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
	<form id="form_RemoveQuestion" action="<%=request.getContextPath()%>/RemoveQuestion" method="post">
		<input type="hidden" id='QuestionID' name='QuestionID'>
	</form>
	
	
	
	

	
	
	<div id='modal_questionDetail' class='modal' role='dialog'>
		<div class='modal-dialog'>
			
			<div class='modal-content'>
					<span onclick= "document.getElementById('modal_questionDetail').style.display='none';" class='close' title='Close Modal'>&times;</span>
					<form action="#" class="modal-content animate" style="margin-top:60px;background-color:lightblue;">
					<div class='modal-header'><h3>Chi tiết câu hỏi</h3></div>
					
						<div style="margin-left:10%;margin-top:10px;" id='myContainerDetail'></div>
						
					</form>
			</div>
		</div>
	</div>
	
	
	
	<div id='addQuestion' class='modal' role='dialog'>
		<div class='modal-dialog'>
			<div class='modal-content'>
				<span onclick= 'CloseModalAddQuestion()' class='close' title='Close Modal'>&times;</span>
				<form id='form_addQuestion' class='modal-content animate' style='margin-top:60px;background-color:lightblue;'>
					<div class='modal-header'><h3 style='margin-left:10%;color:red;'>Các Câu Hỏi Còn Lại</h3></div>
					<div class='modal-body'>
						<input type='hidden' id='Add_QuestionID' name='Add_QuestionID'>
						<label for='selector_Question'>Chọn Câu Hỏi : 
							<select onchange='showDetail(this)'  name='selector_Question' id='selector_Question' class='custom-select mb-3' style='width: auto;'>
								
								<%
									ArrayList<Question> qdtList = Question
											.getListQuestionDetailBySubject((String) ss.getAttribute("SubjectID_FixExam"));
									if (qdtList != null) 
									{
										boolean selectedf = true;
										for (Question e : qdtList) {
											String detail = e.getQuestionID();
											int dem = 1;
											
											if(selectedf)
											{
												out.print("<script>document.getElementById('Add_QuestionID').value='"+e.getQuestionID()+"'</script>");
												selectedf=false;
											}
											for (Answer ans : e.ansList) {
												detail += "___" + ans.getAnswer();
												dem++;
											}
											out.print("<option "+selectedf+" value='" + detail + "'>" + e.getQuestion() + "</option>");
										}
										out.print("</select>");
										out.print("<div id='myContainerAnswer'></div>");
										out.print("</div>");
									}
								%>
						</select>
						</label>
						<div class='modal-footer'><button formaction="<%=request.getContextPath()%>/AddQuestion" formmethod='post'
							 type='submit' class='btn btn-primary' style='width:auto;'><span class="glyphicon glyphicon-plus"></span>Thêm</button></div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<%
	String error = (String)request.getAttribute("QuestionAlreadyExist");
	if(error!=null && error.equals("true"))
	{
		out.print("<script>alert('Câu Hỏi Đã Tồn Tại Trong Đề Thi Không Thể Thêm !!!');</script>");
	}
	
	%>
	
	


</body>
</html>
