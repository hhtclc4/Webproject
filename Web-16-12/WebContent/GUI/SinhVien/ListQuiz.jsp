<%@page import="Model.Exam"%>
<%@page import="Model.InforClass"%>
<%@page import="Model.Account"%>
<%@page import="Model.Answer"%>
<%@page import="Model.Student"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Subject"%>
<%@page import="com.sun.xml.internal.bind.v2.schemagen.xmlschema.List"%>
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
 	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
 	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="shortcut icon" href="http://www.dota2.com/images/favicon.ico" type="image/x-icon">
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 	<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/General.css">
 	<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/SinhVien.css">
 	<script type="text/javascript" src="<%=request.getContextPath()%>/JavaScript/Script.js"></script>
 	
  </head>
  
  <body style="height: 2500px;" onload='renderTime()'>
	  <%
	  HttpSession ss = request.getSession();


		String UserID = (String)ss.getAttribute("UserID");
		String UserType = (String)ss.getAttribute("UserType");

	
		if (UserID == null || UserID.isEmpty() || UserType.isEmpty() || UserType == null
				|| (UserType != null && !UserType.equals(new Account().Student))) {
			out.print("<script>alert('Lỗi Đăng Nhập')</script>");
			response.sendRedirect(request.getContextPath() + "/DeleteUserLogging");
		}
	  %>
	<br>
	<br>
	<!--Banner-->
	<div id="Banner" class="container-fluid clearfix shadow p-4 mb-4 ">
		<div class="clearfix rounded">
			<div class="img-container">
				<a href="#"><img class="rounded-circle icon"
					src="<%=request.getContextPath()%>/Image/fb.png" alt="logo"></a>
			</div>
			<div class="img-container">
				<a href="#"><img class="rounded-circle icon"
					src="<%=request.getContextPath()%>/Image/twitter.png" alt="logo"></a>
			</div>
			<div class="img-container">
				<a href="#"><img class="rounded-circle icon"
					src="<%=request.getContextPath()%>/Image/youtube.png" alt="logo"></a>
			</div>
		</div>
		<div>
			<img class="WebQuizOnline"
				src="<%=request.getContextPath()%>/Image/WebQuizOnline.png">
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

		<div id="containerbody" class="container-fluid">
			<div class="row">
				<div class="col-sm-3 bodycolumn"
					style="margin-top: 20px; margin-right: 20px; border-radius: 10px;">
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
				<div class="col-sm-8 bodycolumn clearfix"
					style="margin-top: 20px; border-radius: 10px;">
					<div class="sidenav">
						<h1 style='text-align: center; color: red;'>Danh Sách Đề Thi</h1><hr>
					</div>
						<div class="container" >
						<%
							@SuppressWarnings("unchecked")
							ArrayList<Exam> exList = (ArrayList<Exam>)request.getAttribute("exList");
							if(exList!=null && !exList.isEmpty())
							 {
								
								out.print("<div class='sidenav'>");
								int dem=1;
								out.print("<table>");
								out.print("<tr class='header'>");
								out.print("<th style='width: 15%;background-color:red'>Số Thứ Tự</th>");
								out.print("<th style='background-color:#4CAF50;color:white;'><h4><b>Tên Đề Thi</b></h4></th>");
								out.print("</tr>");
								for (Exam e : exList)
								{
									out.print("<tr>");
									out.print("<td style='text-align: center;'>"+dem+"</td>");
									out.print("<td style='text-align: center;'>");
									out.print("<a style='text-align: center; width: auto;' href='"
												+request.getContextPath()+"/GUI/SinhVien/StartQuiz.jsp?Index="+dem+"'>"
												+"<h4><b>"+e.getExamName()+"</b></h4>"+"</a>");
									out.print("</td>");
									out.print("</tr>");
									ss.setAttribute("Exam"+dem, e);
									dem++;
								}
								out.print("</table>");
							 }
							else
								out.print("<h1>Hiện Tại Không Có Đề Thi Cho Môn Này</h1>");
						%>
						</div>
					</div>
				</div>
			</div>
		
		
		
</body>
  
</html>