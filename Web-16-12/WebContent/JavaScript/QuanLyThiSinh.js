function MessageSure(obj)
{
	if(confirm("Bạn Muốn Xóa ?") == true)
	{
		var hd = document.getElementById("StudentID_Del");
		hd.value = obj.value;
		$("#tb-StudentList").submit();
	}
}

function setGT_fix(obj)
{
	var hd = document.getElementById("stuGT");
	hd.value = obj.value;
}
function OpenModalFix(buttonFix)
{
	var studentDetail = (buttonFix.value).split("___");
	var studentID = document.getElementById("label_studentID");
	
	var inputhd = document.getElementById("stuID");
	studentID.innerHTML = "MSSV : " + studentDetail[0];
	inputhd.value = studentDetail[0];
	
	
	var studentName = document.getElementById("stuName");
	studentName.value = studentDetail[1];
	
	
	
	
	var Phone = document.getElementById("stuSDT");
	Phone.value = studentDetail[2];
	
	
	
	
	var Email = document.getElementById("stuEmail");
	Email.value = studentDetail[3];
	
	
	
	
	var inputhdgt = document.getElementById("stuGT");
	inputhdgt.value = studentDetail[4];
	
	
	var studentGioiTinh = document.getElementById("selectGT");
	for(i=0;i<studentGioiTinh.options.length;i++)
	{
		if(studentGioiTinh.options[i].value == studentDetail[4])
			studentGioiTinh.options[i].selected = true;
	}
	document.getElementById('fix').style.display='block' ;
}

function CloseModalFix()
{
	document.getElementById('fix').style.display='none' ;
}
function CloseModalAdd()
{
	document.getElementById('add').style.display='none' ;
}

function CheckFix()
{
	if(confirm("Bạn Muốn Lưu ?") == true){$("#formfix").submit();}
}



function Display_None(Index)
{
	document.getElementById("HoTen"+Index).style.display = 'none';
	document.getElementById("SDT"+Index).style.display = 'none';
	document.getElementById("GT"+Index).style.display = 'none';
	document.getElementById("Email"+Index).style.display = 'none';
}
function Display_Block()
{
	var select = document.getElementById("ListUserID");
	var Index = select.value;
	var IndexOld = document.getElementById("IndexOld");
	if(IndexOld.value != null && IndexOld.value!="")
	{
		Display_None(IndexOld.value);
	}
	else
		Index=1;
	document.getElementById("HoTen"+Index).style.display = 'block';
	document.getElementById("SDT"+Index).style.display = 'block';
	document.getElementById("GT"+Index).style.display = 'block';
	document.getElementById("Email"+Index).style.display = 'block';
	
	var opt = document.getElementById("opt"+Index);
	var button = document.getElementById("studentID");
	button.value = opt.innerHTML;
	IndexOld.value = Index;
}
function OpenModalAdd()
{
	//alert('asd');
	document.getElementById('add').style.display='block'
}