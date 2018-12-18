
<%@page import="Model.Student"%>
<%@page import="Model.Student_DoTest"%>
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
    <title>Welcome To Student-Manage</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
 		<script type="text/javascript" src="<%=request.getContextPath()%>/JavaScript/jquery-3.3.1.js"></script>
 	<link rel="shortcut icon" href="http://www.dota2.com/images/favicon.ico" type="image/x-icon">
 	<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 	<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/General.css">
 	<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/QuanLyLop.css">
 	<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/QuanLyThiSinh.css">
 	<script type="text/javascript" src="<%=request.getContextPath()%>/JavaScript/Script.js"></script>
 	<script type="text/javascript" src="<%=request.getContextPath()%>/JavaScript/QuanLyThiSinh.js"></script>
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
			<div class="col-sm-2 bodycolumn"
				style="margin-top: 20px; margin-right: 20px; border-radius: 10px;">
				<div class="sidenav" >
					<h3 style="color: red; text-align: center;"><span class="glyphicon glyphicon-time"></span>Server Clock</h3><hr>
					</div>
					<div class="sidenav">
					<div id="clockDisplay" class="clockStyle"></div>
				
					<form action="<%=request.getContextPath()%>/GUI/QuanLyLop/QuanLyLop.jsp">
						<div><button type="submit" class="btn btn-primary" style="width: auto;margin-left:50%;margin-right:50%;transform: translate(-50%, -50%);margin-top:40px;"> <span class="glyphicon glyphicon-chevron-left"></span>Back</button></div>
					</form>
				</div>
			</div>
			<div class="col-sm-9 bodycolumn"
				style="margin-top: 20px; margin-right: 20px; border-radius: 10px;">
				<div class="sidenav" style="padding-left: 15px;">
					<h1 style="text-align: center; color: red;">Danh Sách Sinh Viên Lớp</h1>
					<h1 style="text-align: center; color: red;"><%=ss.getAttribute("ClassName")%></h1>
					<hr>
					</div>
					<div class="sidenav">
					
					<button class="btn btn-primary" style="width: auto;" type="button" onclick="OpenModalAdd()"><span class="glyphicon glyphicon-plus"></span>Thêm Sinh Viên</button>
					
					
					<form action="<%=request.getContextPath()%>/RemoveStudent"
						method="post" id="tb-StudentList" style="margin-top: 0px;">
						<input type="hidden" id='StudentID_Del' name='StudentID_Del'>
						<%
							String ClassID = (String) ss.getAttribute("ClassID");
							if (ClassID != null) {
								ArrayList<Account> accList = Student.getInforStudent(ClassID);
								if (accList != null && !accList.isEmpty()) {
									int dem = 1;
									out.print("<table>");
									out.print("<tr class='header'>");
									out.print("<th style='background-color: red; width: 15%;'>Số Thứ Tự</th>");
									out.print("<th style='background-color:#4CAF50;color:white;'>Tên Sinh Viên</th>");
									out.print("<th style='background-color:#4CAF50;color:white;'>Chỉnh Sửa</th>");
									out.print("<th style='background-color:#4CAF50;color:white;'>Xóa</th>");
									out.print("</tr>");
									for (Account e : accList) {
										out.print("<tr>");
										out.print("<td style='text-align: center;''>" + dem + "</td>");
										out.print("<td style='text-align: center;'>" + e.getUserName() + "</td>");

										String str = e.getUserID() + "___" + e.getUserName() + "___" + e.getSDT()
													+ "___" +e.getEmail() + "___" + e.getGioiTinh();
										
										out.print("<td style='text-align: center;'><button class='btn btn-primary' " 
												+ "type='button' "
												+ "value='"+str+"' onclick='OpenModalFix(this)'"
												+ "style='width:auto;'><span class='glyphicon glyphicon-pencil'></span></button></td>");

										out.print("<td style='text-align: center;'><button class='btn btn-danger' " + "value='"
												+ e.getUserID() + "'" + "type='button' onclick='MessageSure(this)'"
												+ "style='width:auto;'><i class='fa fa-trash'></i></button></td>");
										out.print("</tr>");
										dem++;
									}
									out.print("</table>");
								}
							}
						%>
					</form>
				</div>
			</div>
		</div>
	</div>
	<form action="<%=request.getContextPath()%>/LoadStudentDetail" id="frm_LoadDetail" method="post">
		<input type="hidden" id = "StudentID_Fix" name = "StudentID_Fix">
	</form>

	<div id='fix' class='modal' role='dialog'>
		<div class='modal-dialog' style='margin-left:40%;'>
			<div class='modal-content' style='width:70%;'>
				<span onclick= 'CloseModalFix()'  class='close' title='Close Modal'>&times;</span>
				
				
				<form class="modal-content animte" style="margin-top:60px;background-color:lightblue;"action="<%=request.getContextPath()%>/UpdateStudentDetail" method="post" id="formfix">
					<div class='modal-header' ><h3>Chi Tiết Sinh Viên</h3></div>
					<div class='modal-body' style="margin-left:18%">
						<label id="label_studentID"></label>
						<input style='width:100%;' type='hidden' id='stuID' name='stuID' value=''>
						<br>
						
						<label id="label_studentName" for='stuName'>Họ Tên :<br>
						<input style='width:100%;' value='username' type='text' id='stuName' name='stuName'></label>
						<br>
						
						<label id="label_studentPhone" for='stuSDT'>Số Điện Thoại :<br>
						<input style='width:100%;' value='SDT' type='text' id='stuSDT' name='stuSDT'></label>
						<br>
						
						<input type='hidden' id = 'stuGT' name = 'stuGT' value='"+gt+"'>
						
						
						<label id="label_studentGioiTinh" for='selectGT'>Giới Tính :<br>
								<select style='width:100%;' id='selectGT' onchange='setGT_fix(this)'>
										<option value="Nam" value='Nam'>Nam</option>
										<option value="Nu" value='Nữ'>Nữ</option>
								</select>
						</label>
						<br>
						
						<label id="label_studentEmail" for='stuEmail'>Email :<br>
						<input style='width:100%;' value='email' type='text' id='stuEmail' name='stuEmail'></label>
						<div class="modal-footer">
						<button type="button" class='btn btn-primary' onclick="CheckFix()"><span class="glyphicon glyphicon-floppy-saved"></span></button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	
	<div id='add' class='modal'>
	<div class="modal-dialog">
		<div class="modal-content">
		<span onclick= 'CloseModalAdd()' class='close' title='Close Modal'>&times;</span>
			<form id='forminsert' style="margin-top:60px;background-color:lightblue;" class='modal-content animate' action='<%=request.getContextPath()%>/AddStudentToClass' method='post'>
					
					
					<div >
						<%
							ArrayList <Student> studList_NoClass = Student.getListStudentNoClass();						 				
							if (studList_NoClass==null || studList_NoClass.isEmpty())
									out.print("<div class='modal-header'><h3>Hiện Không Có Sinh Viên Nào Chưa Có Lớp</h3></div>");
							else
							{
									out.print("<div class='modal-header'><h3>Danh Sách Sinh Viên Chưa Có Lớp</h3></div>");
									out.print("<div class='modal-header'>");
									out.print("<div>");
									String selectStudentID = "<select id='ListUserID' name='ListUserID'>";
									int Index = 1;
									String stud1="";
									for(Student e : studList_NoClass)
									{
										Account stud = Account.getAccountDetail(e.getStudentID());
										stud1 = stud.getUserID();
										selectStudentID+= "<option id='opt"+Index+"' value='"+Index+"'>"+stud.getUserID()+"</option>";
										
										out.print("<div id='HoTen"+Index+"'><label>Họ Tên : "+stud.getUserName()+"</label></div>");
										
										out.print("<div id='SDT"+Index+"'><label>SDT : "+stud.getSDT()+"</label></div>");
										
										String gioitinh="";
										if(stud.getGioiTinh()!=null && stud.getGioiTinh().equals("Nam"))
											gioitinh="Nam";
										else
											if(stud.getGioiTinh()!=null && stud.getGioiTinh().equals("Nu"))
												gioitinh="Nữ";
											else
												gioitinh=null;
										out.print("<div id='GT"+Index+"'><label>GT : "+gioitinh+"</label></div>");
										
										out.print("<div id='Email"+Index+"'><label>Email : "+stud.getEmail()+"</label></div>");
										
										out.print("<script>Display_None('"+Index+"')</script>");
										Index++;
									}
										selectStudentID += "</select>";
										out.print("<div><label>Danh Sách Mã Sinh Viên : "+selectStudentID+"</label>"
												+"<button style='margin-left:20px;width:auto' type='button' class='btn btn-primary' onclick='Display_Block()'><span class='glyphicon glyphicon-zoom-in'></span></button>"
												+"</div>");
										out.print("<input type='hidden' id = 'IndexOld'>");
										out.print("</div>");
										out.print("</div>");
										out.print("<div class='modal-footer'>");
										out.print("<button value='"+stud1+"' type='submit' id='studentID' name='studentID' class='btn btn-primary' style='width:auto;'><span class='glyphicon glyphicon-plus'></span>Thêm Sinh Viên</button>");	
										out.print("</div>");
							}
						%>
						
					</div>
			</form>
			</div>
			</div>
	</div>
</body>
</html>
