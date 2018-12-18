
<%@page import="Model.InforClass"%>
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
    <title>Welcome To Class-Manage</title>
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
 	<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/QuanLyLop.css">
 	<script type="text/javascript" src="<%=request.getContextPath()%>/JavaScript/QuanLyLop.js"></script>
  </head>

  <body>
 
 <%
 	HttpSession ss = request.getSession();


	String UserID = (String)ss.getAttribute("UserID");
	String UserType = (String)ss.getAttribute("UserType");


	if (UserID == null || UserID.isEmpty() || UserType.isEmpty() || UserType == null
			|| (UserType != null && !UserType.equals(new Account().ClassM))) {
		out.print("<script>alert('Lỗi Đăng Nhập')</script>");
		response.sendRedirect(request.getContextPath() + "/DeleteUserLogging");
	}

  		String check = (String) request.getAttribute("ClassNameAlreadyExist");
  		if (check != null && check.equals("true")) {
  			out.print("<script>alert('Tên Này Đã Tồn Tại')</script>");
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

	<div class="navbar navbar-expand-lg bg-primary clearfix">
		<a class="active" href="#"><i class="fa fa-fw fa-home"></i> Home</a> <a
			href="#"><i class="fa fa-fw fa-envelope"></i> Contact</a>
		<div>
			<label>Hello User!</label> <a
				href="<%=request.getContextPath()%>/GUI/Main/Main.jsp"><i
				class="fa fa-fw fa-user"></i>Logout</a>
		</div>
	</div>

	<%--container for forms about search question --%>
	<div class="container-fluid" style="width: 97%;">
		<div class="row">
			<div class="col-sm-2 bodycolumn" style="margin-top:20px;margin-right:20px;border-radius:10px;">
				<div class="sidenav bordertit" >
					<h3><span class="glyphicon glyphicon-time"></span>Server Clock</h3>
					<hr>
				</div>
				
				<div class="sidenav">
					<div id="clockDisplay" class="clockStyle"></div>
				</div>
			</div>
			<div class="col-sm-9 bodycolumn"
				style="margin-top: 20px; margin-right: 20px; border-radius: 10px;">
				<div class="sidenav bordertit" style="padding-left: 15px;">
				
					<div><h1>Danh Sách Lớp Học</h1></div><hr>
				</div>
				<div class="sidenav">
					<div style="margin-top: 50px;">
						<form id="frm-addClass" action="<%=request.getContextPath()%>/InsertInfo" method="post">
							<label for="ClassName-Insert"><b>Tên Lớp Học :</b>
								<input type="text" id="ClassName-Insert" name="ClassName-Insert" value="">
							</label>
							<button type="submit" class="btn btn-primary" style='width:auto'>Tạo Lớp Học</button>
						</form>
					</div>
					<form action="<%=request.getContextPath()%>/DeleteInforClass" method="post" id="tb-inforClass">
						<input type="hidden" id='ClassID' name='ClassID'>
						<%
								ArrayList<InforClass> iclList = InforClass.getListInforClass();
								if(iclList!=null)
								{
									int dem=1;
									out.print("<table>");
									out.print("<tr class='header'>");
									out.print("<th style='background-color: red; width: 15%;'>Số Thứ Tự</th>");
									out.print("<th style='background-color:#4CAF50;color:white;'>Tên Lớp</th>");
									out.print("<th style='background-color:#4CAF50;color:white;'>Xóa</th>");
									out.print("</tr>");
									for(InforClass e: iclList)
									{
										out.print("<tr>");
										out.print("<td style='text-align: center;''>"+dem+"</td>");
										out.print("<td style='text-align: center;'><a href='"+request.getContextPath()
													+"/LoadClass?ClassID="+e.getClassID()+"&ClassName="+e.getClassName()
													+"'>"+e.getClassName()
													+"</a></td>");
										out.print("<td style='text-align: center;'><button class='btn btn-danger' "
												+ " value='"+e.getClassID()+"'"
												+ "type = 'button' onclick='MessageSure(this)'"
												+"style='width:auto;'><i class='fa fa-trash'></i></button></td>");
										out.print("</tr>");
										dem++;
									}
									out.print("</table>");
								}	
						%>	
					</form>
				</div>
			</div>
			
		</div>
	</div>





</body>
</html>
