<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DREAM :: ID</title>
<link rel="stylesheet" href="./css/findid.css">
<script src="./js/jquery-3.7.0.min.js"></script>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>
<%@ include file="menu.jsp"%>
<script type="text/javascript">
	$(function() {
		$("#findid").on('input', function() {
			var emailVal = $("#findid").val();
			const msgBox = $(this).siblings(".msg_box");

			var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

			if (emailVal.match(regExp) != null) {
				msgBox.text("확인되었습니다.");
			} else {
				msgBox.text("잘못된 이메일 형식입니다.");
			}
		});

		$(".logbtn").hide();
		$(".pwbtn").hide();

		$(".fbtn").click(function() {
			let findid = $("#findid").val();

			if (findid != null) {
				$.ajax({
					url: "./findid",
					type: "post",
					data: {
						findid: findid
					},
					dataType: "json",
					success: function(data) {
						if (data.m_id != null) {
							if (data.naver != null) {
								$("#msg")
									.text(data.naver)
									.css({
										color: "black",
										fontSize: "16px",
										fontWeight: "bold"
									});
			
							} else {
								$("#msg")
									.text(
										data.m_name +
										" 님의 아이디는 " +
										data.m_id +
										" 입니다. "
									)
									.css({
										color: "black",
										fontSize: "16px",
										fontWeight: "bold"
									});
							}
								$(".fbtn").hide();
								$(".logbtn").show();
								$(".pwbtn").show();
						} else {
							alert("입력하신 이메일로 회원가입 되어있는 계정이 없습니다. 다시 확인해주세요.");
						}
					},
					error: function(xhr, status, error) {
					    console.error("에러 발생:", status, error); // 구체적인 오류 메시지를 콘솔에 출력합니다.
					    $("#msg").text("에러가 발생했습니다. 관리자에게 문의해주세요.");
					}
				});
			} else {
				alert("아이디를 입력하세요.");
			}
		});
	});
</script>


</head>
<body>
	<div class="findid-box">
		<a href="/"> <img class="logo" src="/img/movielogo.png" alt="logo"
			height="100">
		</a>
		<form action="./findid" method="post"></form>
		<div class="text-center">
		<b>👇 계정을 만드실 때 사용하셨던 이메일을 입력해주세요.</b> <br>
		</div>
		<div class="email-area">
			<input type="text" id="findid" name="findid" class=form-control
				placeholder="이메일을 입력해주세요"> <span class="msg_box"></span>
			<div>
				<button type="submit" class="fbtn">아이디 찾기</button>
				<br> <span id="msg"></span><br>
				<div class="abcd">
					<form action="./login" method="get">
						<button type="submit" class="logbtn">로그인 하기</button>
					</form>
					<form action="./findpw" method="get">
						<button type="submit" class="pwbtn">비밀번호 찾기</button>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>