<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DREAM :: 추가 정보</title>
<link rel="stylesheet" href="/css/join.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script>
$(function() {
    $(".email").on('input', function () {
        const email = $(this).val();
        const msgBox = $(this).siblings(".msg_box");
        const regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

        if (regExp.test(email)) {
            let data = {
                value: email,
                valueType: "m_email"
            };

            // AJAX를 사용하여 중복 이메일 확인
            $.ajax({
                url: "/overlapCheck",
                type: "GET",
                data: data,
                success: function (result) {
                    if (result === 0) {
                        msgBox.text("사용 가능한 이메일입니다").css("color", "#209BF2");
                        // 여기서 버튼 활성화 코드 추가
                        $(".login_btn").prop("disabled", true);
                    } else {
                        msgBox.text("이미 사용중인 이메일입니다").css("color", "red");
                        // 여기서 버튼 비활성화 코드 추가
                        $(".login_btn").prop("disabled", true);
                    }
                },
                error: function () {
                    alert("에러 발생"); // 에러 처리
                }
            });
        } else {
            msgBox.text("잘못된 이메일 형식입니다.").css("color", "red");
            // 여기서 버튼 비활성화 코드 추가
            $(".login_btn").prop("disabled", true);
        }
    });
    
    $(".nickName").on('input', function () {
        const nickName = $(this).val();
        const msgBox = $(this).siblings(".msg_box");
        const regExp = /^.{1,10}$/;

        if (regExp.test(nickName)) {
            let data = {
                value: nickName,
                valueType: "m_nickname"
            };

            // AJAX를 사용하여 중복 이메일 확인
            $.ajax({
                url: "/overlapCheck",
                type: "GET",
                data: data,
                success: function (result) {
                    if (result === 0) {
                        msgBox.text("사용 가능한 닉네임입니다").css("color", "#209BF2");
                        // 여기서 버튼 활성화 코드 추가
                        $(".login_btn").prop("disabled", false).css("background-color", "#209BF2");
                    } else {
                        msgBox.text("이미 사용중인 닉네임입니다").css("color", "red");
                        // 여기서 버튼 비활성화 코드 추가
                        $(".login_btn").prop("disabled", true);
                    }
                },
                error: function () {
                    alert("에러 발생"); // 에러 처리
                }
            });
        } else {
            msgBox.text("닉네임은 10글자 이내여야 합니다.").css("color", "red");
            // 여기서 버튼 비활성화 코드 추가
            $(".login_btn").prop("disabled", true);
        }
    });
});
</script>
</head>
<body>

	<div class="login_box">
		<a href="/"> <img class="logo" src="/img/movielogo.png" alt="logo"
			height="100">
		</a>
		<form action="/userRegisterForm" id="userRegisterForm" method="POST">
			<input type="hidden" id="id" name="id" value="${id}">
			<input type="hidden" id="name" name="name" value="${name}">
			<b>이메일</b>
			<div class="input_aera">
				<input type="text" id="email" name="email" class="email form-control"
					placeholder="이메일을 입력해 주세요"> <span class="msg_box"></span>
			</div>
			<b>닉네임</b>
			<div class="input_aera">
				<input type="text" class="nickName form-control" name="nickName"
					maxlength="20" placeholder="닉네임을 10글자 이내로 입력해주세요."> <span
					class="msg_box"></span>
			</div>

			<button class="btn-lg col-3 back" onclick="window.open('/');">취소</button>
			<button class="btn-lg col-3 login_btn">회원가입</button>

		</form>
	</div>
</body>
</html>