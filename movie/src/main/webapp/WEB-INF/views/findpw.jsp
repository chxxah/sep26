<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DREAM :: PASSWORD</title>
<link rel="stylesheet" href="./css/findpw.css">
<script src="./js/jquery-3.7.0.min.js"></script>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>
<%@ include file="menu.jsp"%>
<script type="text/javascript">
$(function(){
	 $("#emailcheck").on('input', function(){
	const msgBox = $(this).siblings(".msg_box"); 
		  // 이메일 검증 스크립트 작성
		  var emailVal = $("#emailcheck").val();
		  var regExp = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		  // 검증에 사용할 정규식 변수 regExp에 저장

		  if (emailVal.match(regExp) != null) {
			  msgBox.text("올바른 이메일 형식입니다.");
		    
		  }
		  else {
		msgBox.text("잘못된 이메일 형식입니다.");
          }
     });
	 
	 
	 $("#idcheck").on('input', function(){
		 
		  // 아이디 검증 스크립트
		  var emailVal = $("#idcheck").val();
		  const msgBox = $(this).siblings(".msg_box"); 

		  var regExp = /^(?=.*[a-z]).{5,}$/;
		  // 검증에 사용할 정규식 변수 regExp에 저장

		  if (emailVal.match(regExp) != null) {
			  msgBox.text("올바른 아이디 형식입니다.");
		    
		  }
		  else {
		msgBox.text("아이디를 확인해주세요");
         }
    });

		$(".logbtn").hide();
	$(".fbtn").click(function(){
		event.preventDefault();
		
		let email = $("#emailcheck").val();
		let id = $("#idcheck").val();
		
		 if(email != null && id != null ){
			 //alert("확인")
		  $.ajax({
		    	url : "./findpw",
		      	type : "post",
		    	data : { email: email, id: id },
		    	dataType : "json",
		    	  success : function(data){
		    		  if(data.m_name != null){
		    			 $("#msg").text(data.m_name + "님의 이메일로 임시 비밀번호가 발급되었습니다." );
		    			 $(".fbtn").hide();
		    			 $(".logbtn").show();
		   
		    		  }else{
		    			  alert(data.error);
		    			  msgBox.text("입력하신 아이디와 이메일이 올바르지 않습니다.");
		    		  }
		    	  },
		    	  error : function(error){
		    		  $("#msg").text("일치하는 아이디가 없습니다. 다시 시도해주세요.");
		    	  }
		      });
		}else{
			alert("아이디와 이메일이 올바르지 않습니다.")
		}
	});
});
</script>


</head>
<body>
	<div class="findid-box">
    <a href="/">
        <img class="logo" src="/img/movielogo.png" alt="logo" height="100">
    </a>
    <form action="./findpw" method="post">
        <div class="text-center">
            <b>👇계정을 만드실 때 사용하셨던 이메일을 입력해주세요.</b> <br>
        </div>
        <div class="email-area">
            <input type="text" id="emailcheck" name="email" placeholder="이메일을 입력해주세요" class="form-control">
            <span class="msg_box"></span>
        </div>
        <div class="text-center">
            <b>👇아이디를 입력해주세요.</b> <br>
        </div>
        <div class="id-area">
            <input type="text" id="idcheck" name="id" placeholder="아이디를 입력해주세요" class="form-control">
            <span class="msg_box"></span>
        </div>
        <div class="abcd">
            <button type="button" class="fbtn">임시 비밀번호 발송</button>
        </div>
    </form>
        <div class="msg"><span id="msg"></span></div>
    <div class="abcd">
        <br>
        <form action="./login" method="get">
            <button type="submit" class="logbtn">로그인 하기</button>
        </form>
    </div>
</div>

</body>