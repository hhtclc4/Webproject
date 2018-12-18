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
  
  <body style="overflow-y:hidden;" >
  
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
	
	<div> <marquee style="position:absolute;top:0%;opacity:0.6;" direction="scroll"><h3 style="opacity:1.0 !important;">Welcome to Web_Quiz_Online!!!!</h3></marquee></div>
  	<div class="bg-image"></div>
	<div class="bg-text">
	  <img id="bannerimg" src="<%=request.getContextPath()%>/Image/WebQuizOnline.png">
	  <button id ="login" onclick="document.getElementById('Login').style.display='block'">Login</button>
	</div>
	<div class="footer">
		<div class="clearfix rounded">
			<div class="img-container" style="position: absolute;top: 42%;left: 30%;transform: translate(-50%, -50%);">
				<a href="#"><img class="rounded-circle icon"
					src="<%=request.getContextPath()%>/Image/fb.png" alt="logo"></a>
					<p>Facebook</p>
			</div>
			<div class="img-container" style="position: absolute;top: 42%;left: 50%;transform: translate(-50%, -50%);">
				<a href="#"><img class="rounded-circle icon"
					src="<%=request.getContextPath()%>/Image/twitter.png" alt="logo"></a>
					<p>Twitter</p>
			</div>
			<div class="img-container" style="position: absolute;top: 42%;left: 70%;transform: translate(-50%, -50%);">
				<a href="#"><img class="rounded-circle icon"
					src="<%=request.getContextPath()%>/Image/youtube.png" alt="logo"></a>
					<p>Youtube</p>
			</div>
		</div>
	</div>
	
  </body>
  
</html>