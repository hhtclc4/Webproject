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
	href="<%=request.getContextPath()%>/CSS/General.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/CSS/LoginForm.css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/JavaScript/Script.js"></script>

</head>

<body  style="height: 1500px; overflow-x: hidden">
	
	<%
					HttpSession ss = request.getSession();
					//ss.invalidate();
					String error = (String) request.getAttribute("ErrorUser");
					if (error != null && error.equals("true")) {
						out.print("<script>alert('Tài Khoản Hoặc Mật Khẩu Không Đúng')</script>");
					}
				%>
	<div id="Login" class="modal">

		<form style="background-color: lightblue;"
			class="modal-content animate"
			action="<%=request.getContextPath()%>/CheckLogin" method="post">
			<div class="imgcontainer">
				<span
					onclick="document.getElementById('Login').style.display='none'"
					class="close" title="Close Modal">&times;</span> <img
					src="<%=request.getContextPath()%>/Image/Avatar.png" alt="Avatar"
					class="avatar">
			</div>

			<div class="container">
				<div class="table-responsive-sm">
					<table id="selector-tb" class="table table-borderless"
						style="font-weight: bold; margin-top: 2%; margin-bottom: 2%; border-radius: 5px;">
						<tr>
							<td><input type="radio" value="STU" id="SV" name="selector"
								checked="checked">Sinh Viên</td>
							<td><input type="radio" value="CLM" id="QLLH"
								name="selector">Người Quản Lý Lớp Học</td>
							<td><input type="radio" value="QUM" id="QLCH"
								name="selector">Người Quản Lý Câu Hỏi</td>
							<td><input type="radio" value="EXM" id="RD" name="selector">Người
								Ra Đề</td>
						</tr>
					</table>
				</div>

				

				<label for="username"><b>Tên người dùng</b></label> <input
					type="text" placeholder="Nhập Tên người dùng" id="username"
					name="username" required> <label for="password"><b>Mật
						khẩu</b></label> <input type="password" placeholder="Nhập mật khẩu"
					id="password" name="password" required>

				<button type="submit" style="width:20%;" class="bg-primary text-center">Login</button>
				<br>
				<label> <input type="checkbox" checked="checked"
					name="remember"> Remember me
				</label>
			</div>

			<div class="container" style="background-color: #f1f1f1">
				<button type="button"
					onclick="document.getElementById('Login').style.display='none'"
					class="cancelbtn">Cancel</button>
				<span class="psw">Forgot <a href="#">password?</a></span>
			</div>
		</form>
	</div>
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
		<a class="active" style="margin-left: 0%;" href="#"><i
			class="fa fa-fw fa-home"></i> Home</a> <a href="#"
			style="margin-left: 0%;"><i class="fa fa-fw fa-envelope"></i>
			Contact</a>
		<button class="bg-danger"
			onclick="document.getElementById('Login').style.display='block'"
			style="width: auto; position: relative; right: -81%;">Login</button>
	</div>
	<br>
	<div> <marquee direction="scroll"><h3>Welcome to Web_Quiz_Online!!!!</h3></marquee></div>
</body>
</html>