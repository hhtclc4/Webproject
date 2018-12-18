
<%@page import="Model.InforClass"%>
<%@page import="Model.Exam"%>
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
       <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
 	<script type="text/javascript" src="<%=request.getContextPath()%>/JavaScript/Script.js"></script>
 		<script type="text/javascript" src="<%=request.getContextPath()%>/JavaScript/jquery-3.3.1.js"></script>
 		<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 	<link rel="shortcut icon" href="http://www.dota2.com/images/favicon.ico" type="image/x-icon">
 	<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/General.css">
 	<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/NguoiRaDe.css">
 <script type="text/javascript" src="<%=request.getContextPath()%>/JavaScript/NguoiRaDe.js"></script>
 
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
  	ss.removeAttribute("ExamID_FixExam");
  	ss.removeAttribute("SubjectID_FixExam");
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
					<h3 ><span class="glyphicon glyphicon-time"></span>Server Clock</h3><hr>
					</div>
				
				<div class="sidenav">
					<div id="clockDisplay" class="clockStyle"></div>
				</div>
			</div>



			<div class="col-sm-9 bodycolumn"
				style="margin-top: 20px; margin-right: 20px; border-radius: 10px;">
				
				
				<div class="sidenav">
				<h1>Quản lý đề thi</h1><hr>
				</div>
				<div class="sidenav" style="padding-left: 15px;">
					
					<form action="#"
						method="post" id="tb-ListExam" style="margin-top: 0px;">
					
							<%
							out.print("<button type='button' style='width:auto;' class='btn btn-primary' "
									+"onclick='openModalInsert()';'"
									+">Tạo Đề Thi</button>");
							out.print("<table>");
								out.print("<tr class='header'>");
								out.print("<th style='background-color: red; width: 15%;'>Số Thứ Tự</th>");
								out.print("<th style='background-color:#4CAF50;color:white;'>Tên Đề Thi</th>");
								out.print("<th style='background-color:#4CAF50;color:white;'>Chỉnh Sửa</th>");
								out.print("<th style='background-color:#4CAF50;color:white;'>Xóa</th>");
								out.print("</tr>");
								
								ArrayList<Exam> exList = Exam.getListExam();
								if(exList!=null && !exList.isEmpty())
								{
									int Index=1;
									for(Exam ex: exList)
									{
										out.print("<tr>");
										out.print("<td>"+Index+"</td>");
										
									 	out.print("<td><a href='"+request.getContextPath()+"/GUI/NguoiRaDe/ChinhSuaDeThi.jsp?ExamID="+ex.getExamID()+"&SubjectID="+ex.getSubjectID()+"'>"+ex.getExamName()+"</a></td>");
									 	String SubjectName = Subject.findSubjectName(ex.getSubjectID());
									 	String str = ex.getExamID() + "___" + ex.getExamName() + "___" + ex.getStartExam() + "___" 
									 				+ ex.getMinute() + "___" + ex.getClassID() + "___" + SubjectName;
									 	
										out.print("<td><button type='button' "
											+" style='width:auto;' value='"+str+"' onclick='OpenModalFix(this)' class='btn btn-primary'><span class='glyphicon glyphicon-pencil'></span></button></td>");
										
										out.print("<td><button type='button' value='"+ex.getExamID()+"' onclick='MessageSureDel(this)' style='width:auto;' class='btn btn-danger'><i class='fa fa-trash'></i></button></td>");
										out.print("</tr>");
										Index++;
									}
								}
							out.print("</table>");
						%>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<form action="<%=request.getContextPath()%>/DeleteExam" id="form_DeleteExam" method="post">
		<input type="hidden" id = "ExamID" name="ExamID">
	</form>
	
	<div id="modalfix" class="modal">
	<div class="modal-dialog">
	<div class="modal-content">
		<span onclick= "CloseModalFix()" class="close" title="Close Modal">&times;</span>
		<form class="modal-content animate" style="margin-top:50px;background-color:lightblue;"  action="<%=request.getContextPath() %>/UpdateExamDetail" method="post" id="formfix">
		<div class="modal-header">
			<h3>Chi tiết Đề Thi</h3>
		</div>
		<div class="modal-body">
			<label id="label_SubjectName" style="margin-right:10px;font-weight:bold;font-size:130%;"></label>
			<br>
			<label id="label_ExamID" style="font-weight:bold;font-size:130%;"></label>
			<hr>
			<input type="hidden" id="ExamID_Fix" name="ExamID_Fix" >
			<label for="ExamName_Fix">Tên Đề Thi : <br><input style="width:210%;" type="text" id="ExamName_Fix" name="ExamName_Fix"></label>
			<br>
			<label for="select_ClassID"> Tên Lớp : <br>
				
				<select style="width:470%;" id="select_ClassID" name="select_ClassID">
					<%
						ArrayList<InforClass> incList = InforClass.getListInforClass();
						for(InforClass inc : incList)
							out.print("<option value='"+inc.getClassID()+"'>"+inc.getClassName()+"</option>");
					%>
				</select>
				
			</label>
			<br>
			<label for = "StartExam_Fix">Thời Gian Bắt Đầu :<br> <input style="width:210%;" type="text" id="StartExam_Fix" name="StartExam_Fix"></label>
			<br>
			<label for = "Minute_Fix">Thời Lượng Làm Bài : <br><input style="width:210%;" type="text" id="Minute_Fix" name="Minute_Fix"></label>
			</div>
			<div class="modal-footer">
			<button type="button" class="btn btn-primary" onclick="checkStartExam()"><span class="glyphicon glyphicon-floppy-saved"></span></button>
			</div>
		</form>
		</div>
		</div>
	</div>

	
	
	<%
			out.print("<div id='InsertExam' class='modal'>");
				out.print("<div class='modal-dialog'>");
					out.print("<div class='modal-content'>");
					
								out.print("<span onclick= 'closeModalInsert()' "
										+" class='close' title='Close Modal'>&times;</span>");	
								
								out.print("<form id='form_CreateExam' style='margin-top:50px;background-color:lightblue;' class='modal-content animate' action='"
										+request.getContextPath()+"/CreateRandomExam' method='post'>");
								
								
								
								out.print("<div class='modal-header'><h1>Tạo Đề Thi</h1></div>");	
									
								out.print("<div class='modal-body'>");
									out.print("<div>");
									ArrayList<Subject> sbList = Subject.getSubject();
				
									out.print("<select  id='select_subject' style='width:100%;' class='custom-select mb-3' name='select_subject' onchange='setMaxNumber(this)'>");
									out.print("<option value='MH'>--Chọn Môn Học--</option>");
									for(Subject sb : sbList)
									{
										out.print("<option value='"+Subject.CountQuestion(sb.getSubjectID())+"___"+sb.getSubjectID()+"'>"+sb.getSubjectName()+"</option>");
										//System.out.println(Subject.CountQuestion(sb.getSubjectID()));
									}
									out.print("</select>");
									out.print("<br>");
									
									out.print("<select style='width:100%;' class='custom-select mb-3' id='select_class' name='select_class'>");
									out.print("<option value = 'LH'>--Chọn Lớp--</option>");
									ArrayList<InforClass> icList = InforClass.getListInforClass();
									for(InforClass icl : icList)
									{
										out.print("<option value='"+icl.getClassID()+"'>"+icl.getClassName()+"</option>");
									}
									out.print("</select>");
									
									
									out.print("<label for='ExamName'>Tên Đề Thi : <input class='custom-select mb-3' style='width:133%;' type='text' id='ExamName' name = 'ExamName'></label>");
									
									out.print("<label>Thời Gian Bắt Đầu : <input class='custom-select mb-3' style='width:115%;' type='text' id='StartExam' name='StartExam' placeholder='yyyy/mm/dd hh:mm'></label>");
									
								
									out.print("<div   style='margin-top: 20px;'><label>Thời Lượng Làm Bài : <input style='width: 30px;' type='text' id='Minute'"
									    +"name='Minute' onkeydown='validateNumber(event);'"
									    +"></label></div>");
									
									
									
									out.print("<div style='margin-top: 20px;'><label>Số Lượng Câu Hỏi Còn Lại Tối Đa</label></div>");
									
									out.print("<label id='lb_MaxQuestion'>Dễ : X   _____Trung Bình : Y   _____Khó : Z"+"</label>");
									
									out.print("<div>");
									
									out.print("<input type='hidden' id='MaxDe' value=''>");
									out.print("<input type='hidden' id='MaxTrungBinh' value=''>");
									out.print("<input type='hidden' id='MaxKho' value=''>");
									
									out.print("<input type='hidden' id='SubjectID' name='SubjectID'>");
									
									out.print("<div style='margin-top: 20px;margin-bottom:20px;'><label>Nhập Số Lượng Câu Hỏi Tương Ứng</label></div>");
									out.print("<label>Dễ : <input style='width:30px;' type='text' id='De' name='De' onkeydown='validateNumber(event);'> "
											+" _____Trung Bình : <input style='width:30px;' type='text' id='TrungBinh' name='TrungBinh' onkeydown='validateNumber(event);'>"
											+" _____Khó : <input style='width:30px;' type='text' id='Kho' name='Kho' onkeydown='validateNumber(event);'></label>");
														
								out.print("</div>");
								out.print("<div class='modal-footer'><button class='btn btn-danger' type='button' style='width:auto' "
										+" onclick='checkMaxNumber()'>"
										+"Tạo Đề</button></dib>");	
									
									
								
								out.print("</div>");
								out.print("</div>");
								out.print("</form>");
					out.print("</div>");
				out.print("</div>");
			out.print("</div>");			
	%>
</body>
</html>
