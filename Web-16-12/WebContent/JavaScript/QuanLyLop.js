function MessageSure(obj)
{
	if(confirm("Bạn Muốn Xóa ?") == true)
	{
		var hd = document.getElementById("ClassID");
		hd.value = obj.value;
		$("#tb-inforClass").submit();
	}
}