<%@page import="Model.InforClass"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="Model.Student_DoTest"%>
<%@page import="Model.Question"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Exam"%>
<%@page import="Model.Subject"%>
<%@page import="Model.Account"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
  	<title>Welcome To Online_Quiz</title>
    <meta charset="utf-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<link rel="shortcut icon" href="http://www.dota2.com/images/favicon.ico" type="image/x-icon">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
 	<link rel="stylesheet" href="<%=request.getContextPath() %>/CSS/General.css">
 	<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/SinhVien.css">
 	<script type="text/javascript" src="<%=request.getContextPath()%>/JavaScript/SinhVien.js"></script>
 	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>
  
  <body style="height: 2500px;">
  	<%
	  	HttpSession ss = request.getSession();
	 	String UserType = (String)ss.getAttribute("UserType");
	 	String UserID = (String)ss.getAttribute("UserID");
	 	
	 	if( UserID==null || UserType==null || (UserType!=null && !UserType.equals(new Account().Student)) )
	 	{
	 		out.print("<script>alert('Lỗi Đăng Nhập')</script>");
	 		response.sendRedirect(request.getContextPath()+"/DeleteUserLogging");
	 	}
  	%>
  	<br>
	  <br>
	  	 <!--Banner-->
	 <div id="Banner" class="container-fluid clearfix shadow p-4 mb-4 ">
		<div class="clearfix rounded">
			<div class="img-container"><a href="#"><img class="rounded-circle icon" src="<%=request.getContextPath() %>/Image/fb.png"  alt="logo"></a></div>
			<div class="img-container"><a href="#"><img class="rounded-circle icon" src="<%=request.getContextPath() %>/Image/twitter.png"  alt="logo"></a></div>
			<div class="img-container"><a href="#"><img class="rounded-circle icon" src="<%=request.getContextPath() %>/Image/youtube.png"  alt="logo"></a></div>
		</div>
		<div>
			<img class="WebQuizOnline" src="<%=request.getContextPath() %>/Image/WebQuizOnline.png">
		</div>
	</div>
	 <!--EndBanner-->
	<br>
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
	
	<div id="containerbody" class="container-fluid" style="width:97%;">
		<div class="row">
			<div class="col-sm-3 bodycolumn" style="margin-top:20px;margin-right:20px;border-radius:10px;">
				<div class="sidenav" style="text-align: center;">
						<div><img style="float:left;margin-left:0.2em;"src="<%=request.getContextPath()%>/Image/Info.png" alt="Info">
							<h4 style="color: red;"><b>Thông tin sinh viên</b></h4>
							<h5><b>ID : <%=ss.getAttribute("UserID")%></b></h5>
							<h5><b>Lớp : <%=InforClass.getStudentClassName((String)ss.getAttribute("UserID"))%></b></h5>
							<h5><b>Họ Tên : <%=ss.getAttribute("UserName")%></b></h5>
							<hr>
						</div>
					</div>
			</div>
			
			
			
			<div class="col-sm-8 bodycolumn" style="margin-top:20px;margin-left:20px;border-radius:10px;">
				<form action="<%=request.getContextPath()%>/GUI/SinhVien/DoQuiz.jsp" method="post" id="startQuiz">
					<div class="text-center sidenav">
						<%
							
						
							String Index = request.getParameter("Index");
							if(Index!=null)
							{
								
								Exam ex = (Exam) ss.getAttribute("Exam"+Index);
								if(ex!=null)
								{
									ss.setAttribute("ExamIDTemp", ex.getExamID());
									ArrayList<Student_DoTest> studList = Student_DoTest.getStudentDoTest((String)ss.getAttribute("UserID"), ex.getExamID());
									if(studList.size()==0)
									{
										ss.setAttribute("IndexExam", Index);
										long endTime = ex.getStartExam().getTime() + ex.getMinute()*60*1000; 
										
										long currentTime = System.currentTimeMillis();
										
										long startTime = ex.getStartExam().getTime();
										
										if(endTime>currentTime && currentTime>=startTime)
										{
											out.print("<h1 style='color:red;'>Test<h1>");
											
											out.print("<h3>Môn : <b style='color:red;'>" + Subject.findSubjectName(ex.getSubjectID()) + "</b></h3><br><hr>");
											out.print("</div>");
											out.print("<div class='sidenav text-center'>");
											
											out.print("<h3>Thời gian làm bài: " + ex.getMinute() + " phút </h3>");
											out.print("<h3>Thời gian bắt đầu: <b style='color:red;'>" + ex.getStartExam() + "</b></h3>");
											out.print("<script>('#ExamID').value='"+ex.getExamID()+"'</script>");
											out.print("<button type='button' onclick='MessageSure()'"
													+"class='btn btn-success' style='width: 200px;'>Bắt đầu "
													+"làm bài</button>");
											
										//	ArrayList<Question> qList = Question.getListQuestionByExam(ex.getExamID());
										//	ArrayList<Student_DoTest> studList = new ArrayList<Student_DoTest>();
										//	ss.setAttribute("ListQuestion", qList);
										//	ss.setAttribute("ListStudent_DoTest", studList);
											ss.setAttribute("ExamID", ex.getExamID());
										}
										else
										{
											if(currentTime < startTime)
												out.print("<h1>Hiện Tại Bạn Bài Thi Chưa Mở</h1>");
											else
												if(currentTime > endTime)
													out.print("<h1>Đề Đã Hết Hạn</h1>");
										}
									}
									else
										out.print("<h1>Bạn Đã Làm Bài Thi Này</h1>");
								}
								else
								{
									out.print("<h1>Hiện Tại Bạn Không Có Bài Thi</h1>");
								}
							}
						%>
						
					</div>
				</form>
			</div>
		</div> 
	</div>
	
	
  </body>
  
</html>