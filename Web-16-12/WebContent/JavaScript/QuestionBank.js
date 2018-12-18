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

//How Many Answers are inserted ?
function DynamicInputAnswer()
{

	var obj = document.getElementById("CountAnswer");
	if(obj.value >= 2 && obj.value <=5)
	{
		var modal = document.getElementById('MyContainerForAnswer');
		count = modal.childElementCount;
		while(count > 0)
		{
			modal.removeChild(modal.lastChild);
			count--;
		}

		for(i = 1;i<=obj.value;i++)
		{
			var lable = document.createElement("label");
			//input.type = "text";
			lable.innerHTML = "<div>Đáp Án " + i 
			+  ": <input style='width: 58%;' type='text' id='answer-Insert" + i + "' name='answer-Insert" + i + "'> " 
			+ "<select  name='Correct" + i + "' id='Correct"+i+"'>" 
			+ "<option value='T'>True</option>"
			+ "<option value='F'>False</option>"
			+ "</select></div>";
			lable.name = "answer" + i;
			lable.id ="answer" +i;
			modal.appendChild(lable);
			modal.appendChild(document.createElement("br"))
		}
		
	}
	else
		alert('Số Lương Câu Hỏi Tối Thiểu Là 2 Và Tối Đa là 5');
}


function CloseModalFix()
{
	document.getElementById('modal_fix').style.display='none';
}
//<%--check for if was detail question inserted ? --%>
function checkAdd()
{
	var sb_add = document.getElementById("Subject-Insert");
	var lv_add = document.getElementById("Level-Insert");
	var qs_add = document.getElementById("question-Insert");

	var count_as_add = document.getElementById("CountAnswer");


	
	if(sb_add.value == null || sb_add.value == "MH" || lv_add.value == null || lv_add.value=="LV" || count_as_add.value=="" || qs_add.value=="")
		alert('Nhập Thiếu Thông Tin');
	else
	{
		var checkWrongAnswer = 0;
		for(i=1;i<=count_as_add.value;i++)
		{
			var input = document.getElementById("answer-Insert" + i);
			if(input !=null && input.value !="")
				checkWrongAnswer=1;
			else
			{
				checkWrongAnswer = 0;
				break;
			}
		}
		if(checkWrongAnswer == 1)
		{
			var form =document.getElementById("frm-addQuestion");
			form.submit();
		}
		else
			alert('Chưa Nhập Đáp Án ?');
	}

}


function OpenModalFix(buttonFix)
{
	var questionDetail = (buttonFix.value).split("question_answer");
	var QuestionID_Question = questionDetail[0].split("___");
	
	var QuestionID = QuestionID_Question[0];
	var Question = QuestionID_Question[1];
	
	
	
	var hdquestionID = document.getElementById("hdquestionID");
	hdquestionID.value = QuestionID;
	
	var mdquestion = document.getElementById("mdquestion");
	mdquestion.value = Question;
	

	
	
	var answerDetail = questionDetail[1].split("___");
	
	var div = document.getElementById("ContainerAnswerForFix");
	count = div.childElementCount;
	while(count > 0)
	{
		div.removeChild(div.lastChild);
		count--;
	}
	
	for(i =0;i<answerDetail.length;i++)
	{
		if(answerDetail[i]!="")
		{
			var AnswerID_Answer = answerDetail[i].split("ansID_ans");
			var AnswerID = AnswerID_Answer[0];
			
			var Answer_Correct = AnswerID_Answer[1].split("ans_correct");
			var Answer = Answer_Correct[0];
			var Correct = Answer_Correct[1];
			
			var opt1="",opt2="";
			
			if(Correct=="1")
				opt1="selected";
			else
				opt2="selected";
			
			var label_answer = document.createElement("label");
			label_answer.innerHTML = "Đáp Án " + (i+1) + " : "
										//+"<input type='hidden' id='ansid"+i+"' name='ansid"+i+"' value='"+AnswerID+"'>"
										+"<input style='width: 50%;' name='"+AnswerID+"' id='"+AnswerID+"' type='text' "
										+"value='" + Answer
										+ "'>"
										+"<select style='margin-left:5px;' name='Correct" + AnswerID + "' id='Correct" + AnswerID + "'>"
										+"<option "+opt1+" value='1'>True</option>"
										+"<option "+opt2+" value='0'>False</option>"
										+"</select>";
										
			
			var counthd = document.getElementById("aswCount");
			counthd.value=i;
			
		
			
			div.appendChild(label_answer);
			div.appendChild(document.createElement("br"));
		}
	}
	
	
	document.getElementById('modal_fix').style.display='block' ;
}



function SaveQuestionForDel(obj)
{
	var obj_1 = document.getElementById('QuestionID-Del');
	obj_1.value = obj.value;
	if(confirm("Bạn Muốn Xóa ?") == true)
		$("#tb-question").submit();
}

function CheckFix()
{
	if(confirm("Bạn Muốn Lưu ?") == true){$("#formfix").submit();}
}
function OpenModalAdd()
{
	document.getElementById('addQuestion').style.display='block';
}
