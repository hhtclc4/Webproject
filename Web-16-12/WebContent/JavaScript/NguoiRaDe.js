function openModalInsert()
{
	document.getElementById('InsertExam').style.display='block';
}
function closeModalInsert()
{
	document.getElementById('InsertExam').style.display='none';
}

//only number
function validateNumber(evt) {
	var e = evt || window.event;
	var key = e.keyCode || e.which;

	if (!e.shiftKey && !e.altKey && !e.ctrlKey &&
			key >= 48 && key <= 57 ||
			key >= 96 && key <= 105 ||
			key == 8 || key == 9 || key == 13 ||
			key == 37 || key == 39 ||
			key == 46 || key == 45) 
	{}
	else{
		e.returnValue = false;
		if (e.preventDefault) e.preventDefault();
	}
}

function checkMaxNumber()
{
	
	var select_subject = document.getElementById("select_subject");
	var select_class = document.getElementById("select_class");
	
	var maxDe = document.getElementById("MaxDe");
	var maxTB = document.getElementById("MaxTrungBinh");	
	var maxKho = document.getElementById("MaxKho");
	
	//alert("MAx : " +maxDe.value + "/"+maxTB.value +"/"+maxKho.value);
	
	var inputDe = document.getElementById("De");
	var inputTB = document.getElementById("TrungBinh");
	var inputKho = document.getElementById("Kho");
	
	//alert("input : " +inputDe.value + "/"+inputTB.value +"/"+inputKho.value);
	
	formatDate = /^\d{4}\/\d{1,2}\/\d{1,2}$/;
    var startExam = document.getElementById("StartExam");


    var Date_Time = (startExam.value).split(" ");
    var Date = Date_Time[0];
    var Time = Date_Time[1];
    
    if(!Date.match(formatDate)) 
    {
      alert("Ngày Tháng Năm Sai: " + Date);
      return false;
    }
    formatTime = /^\d{1,2}:\d{2}([ap]m)?$/;
    
    if(!Time.match(formatTime)) 
    {
      alert("Giờ Sai: " + Time);
      return false;
    }

   
	
/*	if(maxDe.value==""  || maxTB.value==""   || maxKho.value==""
						|| inputDe.value=="" || inputTB.value=="" || inputKho.value=="" 
    
						||(inputDe.value > 0 && maxDe.value > 0 &&inputDe.value > maxDe.value) 
			
						|| (inputTB.value > 0 && maxTB.value>0 &&inputTB.value > maxTB.value)
						
						|| (inputKho.value > 0 && maxKho.value>0 && inputKho.value > maxKho.value)
						|| select_subject.value=="MH" || select_class=="LH")
		alert("Nhập Sai");
	else
	{
		alert("Tạo Thành Công");
		$("#form_CreateExam").submit();
	}*/
    alert("Tạo Thành Công");
	$("#form_CreateExam").submit();
}
function setMaxNumber(select)
{
	var mysplit = (select.value).split("___");
	
	var De = Math.floor(mysplit[0] / 1000000,1);
	var TrungBinh = Math.floor((mysplit[0] % 1000000) / 1000,1);
	var Kho = Math.floor((mysplit[0] % 1000000) % 1000,1);
	
	
	var label = document.getElementById("lb_MaxQuestion");
	label.innerHTML = "Dễ : "+De+"   _____Trung Bình : "+TrungBinh+"   _____Khó : "+Kho;
	var MaxDe = document.getElementById("MaxDe");
	var MaxTB =document.getElementById("MaxTrungBinh");
	var MaxKho = document.getElementById("MaxKho");
	
	MaxDe.value = De;
	MaxTB.value = TrungBinh;
	MaxKho.value = Kho;
	
	//alert(MaxDe.value + "/" + MaxTB.value + "/"+ MaxKho.value);
	
	document.getElementById("SubjectID").value = mysplit[1];
}

function MessageSureFix()
{
	if(confirm("Bạn Muốn Lưu ?") == true)
		$("#formfix").submit();	
}

function MessageSureDel(obj)
{
	if(confirm("Bạn Muốn Xóa ?") == true)
	{
		var hd = document.getElementById("ExamID");
		hd.value = obj.value
		$("#form_DeleteExam").submit();
	}
}

function OpenModalFix(buttonFix)
{
	var ExamDetail = (buttonFix.value).split("___");
	
	var select = document.getElementById("select_ClassID");
	var ExamName = document.getElementById("ExamName_Fix");
	
	var label_ExamID = document.getElementById("label_ExamID");
	var hdExamID = document.getElementById("ExamID_Fix");
	
	var StartExam = document.getElementById("StartExam_Fix");
	var Minute = document.getElementById("Minute_Fix");
	
	var SubjectName = document.getElementById("label_SubjectName");
	
	label_ExamID.innerHTML = "Mã Đề Thi : " + ExamDetail[0];
	hdExamID.value = ExamDetail[0];
	
	ExamName.value = ExamDetail[1];
	
	StartExam.value = ExamDetail[2];
	
	Minute.value = ExamDetail[3];
	
	for(i=0;i<select.options.length;i++)
	{
		if(select[i].value == ExamDetail[4])
			select[i].selected = true;
	}
	
	SubjectName.innerHTML = "Môn Học : " + ExamDetail[5];
	
	document.getElementById('modalfix').style.display='block';
}

function checkStartExam()
{
	var formatDate = /^\d{4}\/\d{1,2}\/\d{1,2}$/;
    var startExam = document.getElementById("StartExam_Fix");
    var Date_Time = (startExam.value).split(" ");
    var Date = Date_Time[0];
    var Time = Date_Time[1];
   // alert(Date + "/" + Time + "/"+startExam.value);
    if(Date != '' && !Date.match(formatDate)) 
    {
    	//alert("asdasdasdassd35sasd45fds45f5f4d4d4f4dsf4ds4fds4dsa5d6s");
      alert("Ngày Tháng Năm Sai: " + Date);
      return false;
    }
    
    var formatTime = /^\d{1,2}:\d{2}([ap]m)?$/;
    if(Time != '' && !Time.match(formatTime)) 
    {
      alert("Giờ Sai: " + Time);
      return false;
    }
	$("#formfix").submit();
}


function CloseModalFix()
{
	document.getElementById('modalfix').style.display='none';
}