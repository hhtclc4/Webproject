
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
    <title>Welcome To QuestionBank</title>
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
 	<script type="text/javascript" src="<%=request.getContextPath()%>/JavaScript/Script.js"></script>
 		<script type="text/javascript" src="<%=request.getContextPath()%>/JavaScript/jquery-3.3.1.js"></script>
 	<link rel="shortcut icon" href="http://www.dota2.com/images/favicon.ico" type="image/x-icon">
 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 	<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 	<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/General.css">
 	<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/QuestionBank.css">
 	<script type="text/javascript" src="<%=request.getContextPath()%>/JavaScript/QuestionBank.js"></script>
 
  </head>

  <body>
	<%
	HttpSession ss = request.getSession();


	String UserID = (String)ss.getAttribute("UserID");
	String UserType = (String)ss.getAttribute("UserType");


	if (UserID == null || UserID.isEmpty() || UserType.isEmpty() || UserType == null
			|| (UserType != null && !UserType.equals(new Account().QuestionM))) {
		out.print("<script>alert('Lỗi Đăng Nhập')</script>");
		response.sendRedirect(request.getContextPath() + "/DeleteUserLogging");
	}
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
					<h3 style="color: red; text-align: center;"><span class="glyphicon glyphicon-time"></span>Server Clock</h3><hr>
					</div>
				
				<div class="sidenav">
					<div id="clockDisplay" class="clockStyle"></div>
				</div>
				 
			</div>



			<div class="col-sm-9 bodycolumn"
				style="margin-top: 20px; margin-right: 20px; border-radius: 10px;">
				<div class="sidenav">
					<h1>Quản lý ngân hàng câu hỏi</h1><hr>
				</div>
				<div class="sidenav" style="padding-left: 15px;">
					<div id="selector-subject">


						<%--form for choosing what type of question --%>
						<form action="<%=request.getContextPath()%>/LoadQuestionBank"
							method="post">
							<select name="Subject" id="Subject" class="custom-select mb-3"
								style="width: 20%;" onchange="getSubject(this)">
								<option selected value="MH">Môn Học</option>



							<%
									ArrayList<Subject> sbList = Subject.getSubject();
									for (Subject e : sbList)
										out.print("<option value=" + e.getSubjectID() + ">" + e.getSubjectName() + "</option>");
								%>


							</select> <select name="Level" id="Level" class="custom-select mb-3"
								style="width: 20%;" onchange="getLevel(this)">
								<option selected value="LV">Độ Khó</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
							</select> <input class="custom-select mb-3" style="width: 30%;"
								type="text" id="mySearchBar" onkeyup="myFunction()"
								placeholder="Search for names.." title="Type in a name">
							<br>
							<br>
							<button class="btn btn-primary" type="submit"><span class="glyphicon glyphicon-search"></span>Tìm</button>
							<button class="btn btn-primary" type="button"
								onclick="OpenModalAdd()"><span class="glyphicon glyphicon-plus"></span>Thêm</button>

						</form>
						<br>
					</div>

					<%--for for load question with conditions in above --%>
					<form id="tb-question" style="background-color: white;"
						action="<%=request.getContextPath()%>/DeleteQuestionBank"
						method="post">
						<input type="hidden" name="QuestionID-Del" id="QuestionID-Del">
						<table id="Question-tb" >
							<tr class="header">
								<th style="background-color: red; width: 10%;">Level</th>
								<th>Câu hỏi</th>
								<th>Chỉnh Sửa</th>
								<th>Xóa</th>
							</tr>
						<%
							
								@SuppressWarnings("unchecked")
								ArrayList<Question> qlist = (ArrayList<Question>)request.getAttribute("qList");
								if (qlist != null) {
									for (Question e : qlist) {
										out.print("<tr>");
										out.print("<td>" + e.getLevel() + "</td>");
										out.print("<td  style=" + "'text-align: left;' >" + e.getQuestion() + "</td>");
										
										
										String str = e.getQuestionID()+"___"+e.getQuestion()+"question_answer";
										for(Answer ans : e.ansList)
										{
											str += ans.getAnswerID() + "ansID_ans" + ans.getAnswer() +"ans_correct"+ ans.getCorrect() + "___";
											System.out.print(str);										}
										out.print("<td>");
										out.print("<button class='btn btn-primary' style='width: auto;' type='button' value='"
											+ str + "'  onclick= 'OpenModalFix(this)' ><span class='glyphicon glyphicon-pencil'></span></button>");
										out.print("</td>");
										
										
										out.print("<td><button class='btn btn-danger' style='width: auto;' type='button' value='"
												+ e.getQuestionID() + "'"
												+ "onclick= 'SaveQuestionForDel(this);' ><i class='fa fa-trash'></i></button></td>");
										out.print("</tr>");
									}
								}
						%>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
	<%--LoadAnswer + callback to right page with old question --%>
	<div id="hiden" class="modal">		
		<form class="modal-content animate" action="<%=request.getContextPath()%>/LoadAnswer" method="post" id="hidden-submit">	
			<input id="QuestionID_Fix" name="QuestionID_Fix" type="hidden">
		</form>
	</div>


	<div id="modal_fix" class="modal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<span onclick='CloseModalFix()' class='close' title='Close Modal'>&times;</span>
				<form id='formfix' method="post" action="<%=request.getContextPath()%>/UpdateQuestionBank"
					style='background-color: lightblue; margin-top: 50px;'
					class='modal-content animate'>

					<div>
						<div class="modal-header">
							<h3 style='color: red;'>Chỉnh Sửa Câu Hỏi</h3>
						</div>
						<div class="modal-body">
							<input id="hdquestionID" name="hdquestionID" type="hidden">
							 <label>Câu Hỏi : <input style='width: 70%;' value='' type='text'
								id='mdquestion' name='mdquestion'>
							</label>
							<div id="ContainerAnswerForFix"></div>
							<input type="hidden" name="aswCount" id="aswCount">
						</div>
						<div class="modal-footer">
							<button type='button' class='btn btn-primary'
								onclick='CheckFix()'><span class="glyphicon glyphicon-floppy-saved"></span></button>
						</div>
					</div>
				</form>
			</div>
		</div>

	</div>

	<div id="addQuestion" class="modal">
			<div class="modal-dialog">
				<div class="modal-content">
				<span
							onclick="document.getElementById('addQuestion').style.display='none'"
							class='close' title='Close Modal'>&times;</span>
					<form class="modal-content animate" id="frm-addQuestion"
						action="<%=request.getContextPath()%>/InsertQuestionBank"
						method="post"
						style='background-color: lightblue; margin-top: 50px;'>
						

						<div>
							<div class="modal-header">
								<h3 style="color: red;">Thêm Câu Hỏi</h3>
							</div>

							<div class="modal-body">
							<div>
								<select name="Subject-Insert" id="Subject-Insert"
									class="custom-select mb-3" style="width: 100%;">
									<option selected value="MH">Môn Học</option>

									<%
									for (Subject e : sbList)
										out.print("<option value=" + e.getSubjectID() + ">" + e.getSubjectName() + "</option>");
								%>
								</select> <select name="Level-Insert" id="Level-Insert"
									class="custom-select mb-3" style="width: 100%;">
									<option selected value="LV">Độ Khó</option>
									<option value="1">Dễ</option>
									<option value="2">Trung Bình</option>
									<option value="3">Khó</option>
								</select>
							</div>
							<div>
								<div>
									<input style="width: 40%;" type="text" id="question-Insert"
										name="question-Insert" value="" placeholder="Câu Hỏi">
								</div>
								<div>
									<input style="width: 40%;" type="text" id="CountAnswer"
										name="CountAnswer" onkeydown="validateNumber(event);"
										placeholder="Nhập Số Lượng Đáp Án">
									<%--only number --%>
									<button type="button" class="btn btn-info"
										onclick="DynamicInputAnswer()">Ok</button>
								</div>
							</div>

							<div id="MyContainerForAnswer"></div>

						</div>
						</div>
						<div class="modal-footer">
							<button style="margin-left: 35%;" type="button"
								onclick="checkAdd();" class="btn btn-primary"><span class="glyphicon glyphicon-plus"></span>Thêm</button>
						</div>
					
					</form>
				</div>

			</div>
		</div>

	
	<%
			String warning = (String)request.getAttribute("Warning");
			if(warning!=null && warning.equals("ExistQuestionInExam"))
				out.print("<script>alert('Câu Hỏi Đang Được Phân Công Trong Bài Test, Không Thể Xóa')</script>");
		%>
</body>
</html>

