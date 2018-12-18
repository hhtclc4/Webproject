function MessageSure()
{
	if(confirm("Bạn Muốn Bắt Đầu Làm Bài ?") == true)
		$("#startQuiz").submit();
}

function setChoosedAnswer(obj)
{	
	var id = "AnswerID"+obj.id;
	var hidden = document.getElementById(id);
	if( obj.checked)
		hidden.value=1;
	else
		hidden.value=0;
}



window.onload = function()
{
	var countDownDate = document.getElementById("TimeEndTest").value;
	
	
	var x = setInterval(function() 
			{
	var now = new Date().getTime();
	var distance = countDownDate - now;
	var minutes = Math.floor((distance / (1000*60)) );
	var seconds = Math.floor((distance % (1000 * 60)) / 1000);

	document.getElementById("CountDownClock").innerHTML ="Còn Lại "+  minutes + ":" + seconds;
	 
	if(distance <=0)
	{
		$("#EndTest").submit();
	}
	}, 1000);
};

function MessageSureToFinish()
{
	if(confirm("Bạn Muốn Kết Thúc Bài Làm ?") == true)
		$("#EndTest").submit();
}