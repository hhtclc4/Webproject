

function CloseModalQuestionDetail()
{
	document.getElementById('QuestionDetail').style.display='none';
}

function MessageSure(obj)
{
	if(confirm("Bạn Muốn Xóa ?") == true)
	{
		var hd = document.getElementById("QuestionID");
		hd.value = obj.value
		$("#form_RemoveQuestion").submit();
	}
}


function CloseModalAddQuestion()
{
	document.getElementById('addQuestion').style.display='none';
}



function showDetail(select)
{
	var mysplit = (select.value).split("___");
	var div = document.getElementById("myContainerAnswer");
	var hd = document.getElementById("Add_QuestionID");
	hd.value = mysplit[0];
	
	
	
	count = div.childElementCount;
	while(count>0)
	{
		div.removeChild(div.lastChild);
		count--;
	}
	
	
		
		
	for(i=1;i<mysplit.length;i++)
	{
		var label = document.createElement("label");
		label.innerHTML = "Đáp Án " + i +": "+mysplit[i];
		label.id = "ans"+i;
		div.appendChild(label);
		div.appendChild(document.createElement("br"))
	}
}

function OpenModalQuestionDetail(buttonDetail)
{
	//alert("vinh dz");
	QuestionDetail = (buttonDetail.value).split("question_answer");
	AnswerDetail = QuestionDetail[1].split("___");
	
	var modal = document.getElementById("myContainerDetail");
	

	count = modal.childElementCount;
	
	while(count>0)
	{
		modal.removeChild(modal.lastChild);
		count--;
	}
	
	
	
	var question = document.createElement("label");
	question.innerHTML = "Câu Hỏi : " + QuestionDetail[0];
	modal.appendChild(question);
	modal.appendChild(document.createElement("br"));
	for(i = 0 ;i<AnswerDetail.length ; i++)
	{
		if(AnswerDetail[i]!="")
		{
			var label = document.createElement("label");
			label.innerHTML = "Đáp Án "+ (i+1) + " : " + AnswerDetail[i];
			modal.appendChild(label);
			modal.appendChild(document.createElement("br"));
		}
	}
	document.getElementById('modal_questionDetail').style.display='block';
}
