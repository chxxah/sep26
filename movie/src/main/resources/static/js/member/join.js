$(".login_btn").css("background", "#F3F3F3");

const isSubmit = (function(){
    let idCheck = false;
    let passwordCheck = false;
    let emailCheck = false;
    let nameCheck = false;
    let nicknameCheck = false;
    let yyCheck = false;


    const setidCheck = function(set){
        idCheck = set ? true : false;
        isSubmit();
    }
    const setpasswordCheck = function(set){
        passwordCheck = set ? true : false;
        isSubmit();
    }
    const setemailCheck = function(set){
        emailCheck = set ? true : false;
        isSubmit();
    }

    const setnameCheck = function(set){
        nameCheck = set ? true : false;
        isSubmit();
    }

    const setnicknameCheck = function(set){
        nicknameCheck = set ? true : false;
        isSubmit();
    }


    const setyyCheck = function(set){
        yyCheck = set ? true : false;
        isSubmit();
    }

    const isSubmit = function(){
        if(idCheck && passwordCheck && emailCheck && nameCheck && nicknameCheck && yyCheck) {
            $(".login_btn").css("background", "#209BF2");
            return true;
        } else {
            $(".login_btn").css("background", "#F3F3F3");
            return false;
        }
    }

    return {
        setidCheck : setidCheck,
        setpasswordCheck : setpasswordCheck,
        setemailCheck : setemailCheck,
        setnameCheck : setnameCheck,
        setnicknameCheck : setnicknameCheck,
        setyyCheck : setyyCheck,
        isSubmit : isSubmit
    }
})();

function pwdCheck() {
    const password1 = $(".pw").val().replaceAll(" ", "");
    const password2 = $(".pw2").val().replaceAll(" ", "");
    const msgBox = $(".pw2").siblings(".msg_box"); 
    
    if(password1 && password2) {
        if(password1.includes(" ")  || password2.includes(" ")) {
            msgBox.text("비밀번호를 확인해 주세요").css("color", "red");
            isSubmit.setpasswordCheck(false);
            return;
        }
        
        if(password1 != password2) {
            msgBox.text("비밀번호를 확인해 주세요").css("color", "red");
            isSubmit.setpasswordCheck(false);
        } else {
            msgBox.text("비밀번호가 일치합니다").css("color", "#209BF2");
            isSubmit.setpasswordCheck(true);
        }
    }
}

$(".id").focusout(function(){
    const id = $(".id").val().replaceAll(" ", "");
    const msgBox = $(this).siblings(".msg_box"); 
    
    if(!id) {
        msgBox.text("아이디를 입력해주세요").css("color", "red");
        isSubmit.setidCheck(false);
        return;
    }
    
    if(!idCheck(id)) {
        msgBox.text("사용할수 없는 아이디입니다").css("color", "red");
        isSubmit.setidCheck(false);
        return;
    }
    
    const data = {
        value : id,
        valueType : "m_id"
    };
    
    if(overlapCheck(data)) {
        msgBox.text("사용 가능합니다").css("color", "#209BF2");
        isSubmit.setidCheck(true);
    } else {
        msgBox.text("이미 사용중인 아이디입니다").css("color", "red");
        isSubmit.setidCheck(false);
    }
});


function overlapCheck(data) {

	let isUseable = false;
	$.ajax({
		url: "/overlapCheck",
		type: "get",
		data: data,
		async: false
	})
	.done(function(result){
		if(result == 0 ) {
			isUseable = true;
		} 
	})
	.fail(function(){
		alert("에러");
	});
	
	return isUseable;

}


$(".pw").focusout(function() {
    pwdCheck();
});

$(".pw2").focusout(function() {
    pwdCheck();
});

$(".email").focusout(function() {
    const email = $(".email").val();
    const msgBox = $(this).siblings(".msg_box"); 

    if (!email) {
        msgBox.text("이메일을 입력해 주세요").css("color", "red");
        isSubmit.setemailCheck(false);
        return;
    }

    if(!emailCheck(email)) {
        msgBox.text("사용 불가능합니다").css("color", "red");
        isSubmit.setemailCheck(false);
		return;
    }

    let data = {
        value: email,
        valueType : "m_email" 
    };


 if(!overlapCheck(data)){
        msgBox.text("이미 사용중인 이메일 입니다").css("color", "red");
        isSubmit.setemailCheck(false);
    } else {
        msgBox.text("이메일은 계정찾기와 예매내역확인에 이용됩니다.").css("color", "#209BF2");
        isSubmit.setemailCheck(true);
    }



});

$(".name").focusout(function() {
    const name = $(".name").val();
    const msgBox = $(this).siblings(".msg_box"); 

    if (!name) {
        msgBox.text("이름을 입력해 주세요").css("color", "red");
        isSubmit.setnameCheck(false);
        return;
    }

    if(!nameCheck(name)) {
        msgBox.text("사용 불가능합니다").css("color", "red");
        isSubmit.setnameCheck(false);
    } else {
        msgBox.text("");
        isSubmit.setnameCheck(true);
    }
}); 

 

$(".nickName").focusout(function() {
    const nickname = $(".nickName").val();
    const msgBox = $(this).siblings(".msg_box"); 

    if (!nickname) {
        msgBox.text("닉네임을 입력 해주세요").css("color", "red");
        isSubmit.setnicknameCheck(false);
        return;
    }

    const regex = /^.{1,10}$/; // 길이가 1에서 10 사이여야 함
    if (!regex.test(nickname)) {
        msgBox.text("닉네임은 10글자 이내여야 합니다.").css("color", "red");
        isSubmit.setnicknameCheck(false);
        return;
    }

    if (!nicknameCheck(nickname)) {
        msgBox.text("올바른 닉네임을 입력해주세요.").css("color", "red");
        isSubmit.setnicknameCheck(false);
        return;
    }

    let data = {
        value: nickname,
        valueType : "m_nickname" 
    };
    
    if(!overlapCheck(data)){
        msgBox.text("이미 사용중인 닉네임입니다").css("color", "red");
        isSubmit.setnicknameCheck(false);
    } else {
        msgBox.text("사용 가능합니다").css("color", "#209BF2");
        isSubmit.setnicknameCheck(true);
    }
});



$("#yy").focusout(function() {
    const yy = $("#yy").val();
    const msgBox = $(this).parent().parent().siblings(".msg_box");

    if (!yy) {
        msgBox.text("생년월일을 입력해주세요.").css("color", "red");
        isSubmit.setyyCheck(false);
        return;
    }

    if(!yyCheck(yy)) {
        msgBox.text("사용 불가능합니다").css("color", "red");
        isSubmit.setyyCheck(false);
    } else {
        msgBox.text("");
        isSubmit.setyyCheck(true);
    }
}); 
