
// Get the modal
var modal = document.getElementById('Login');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}


jQuery(document).ready(function() {
	    $(".clickable-row").dblclick(function() {

	    	document.getElementById('Login').style.display='block';
	    });
	});

//When click sidenav
function ExamDropdown()
{
	var dropdown = document.getElementsByClassName("dropdown-btn");
	var i;

	for (i = 0; i < dropdown.length; i++) {
	  dropdown[i].addEventListener("click", function() {
	    this.classList.toggle("active");
	    var dropdownContent = this.nextElementSibling;
	    if (dropdownContent.style.display === "block") {
	      dropdownContent.style.display = "none";
	    } else {
	      dropdownContent.style.display = "block";
	    }
	  });
	}
}


//Clock

function renderTime() {
	var currentTime = new Date();
	var diem = "AM";
	var h = currentTime.getHours();
	var m = currentTime.getMinutes();
    var s = currentTime.getSeconds();
	setTimeout('renderTime()',1000);
    if (h == 0) {
		h = 12;
	} else if (h > 12) { 
		h = h - 12;
		diem="PM";
	}
	if (h < 10) {
		h = "0" + h;
	}
	if (m < 10) {
		m = "0" + m;
	}
	if (s < 10) {
		s = "0" + s;
	}
    var myClock = document.getElementById('clockDisplay');
	myClock.textContent = h + ":" + m + ":" + s + " " + diem;
	myClock.innerText = h + ":" + m + ":" + s + " " + diem;
}
renderTime();

