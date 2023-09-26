function idCheck(id) {
	const joinid = /^[0-9a-z]{5,15}$/g;
	
	if(joinid.test(id)) {
		return true;
	} else {
		return false;
	}
}
 
function emailCheck(email){
	const joinemail = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/g;
	
	if(joinemail.test(email)) {
		return true;
	} else {
		return false;
	}
}

function nameCheck(name) {
	const joinname = /^[가-힣]{2,5}$/g;
	if (joinname.test(name)) {
		return true;
	} else {
		return false;
	}
}
 
 
 
function nicknameCheck(nickname) {
	const joinNickname = /^[가-힣|a-z|A-Z|0-9|]+$/g;
	if (joinNickname.test(nickname)) {
		return true;
	} else {
		return false;
	}
}


function yyCheck(yy) {
	const joinyy = /^(19[0-9][0-9]|200[0-7])$/;
	if (joinyy.test(yy)) {
		return true;
	} else {
		return false;
	}
}
 
  
 
 
function lenthCheck(e, length) {
	if(e.value.length >= length) {
		return false;
	}
	
	$(this).off().focusout(function(){
		if(e.value.length > length) {
			e.value = "";
		}
	})
	
	return true; 
}
