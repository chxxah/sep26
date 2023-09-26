<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DREAM :: JOIN</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="./css/join.css">
<script src="./js/jquery-3.7.0.min.js"></script>
</head>
<body>
<%@ include file="menu.jsp"%>
	<script>
		var successMsg = "${successMsg}";

		if (successMsg) {
			alert(successMsg);
			window.location.href = "/login"
		}
	</script>
	<div class="article">
	<div class="login_box">
		<a href="/"> <img class="logo" src="/img/movielogo.png" alt="logo"
			height="100">
		</a>
		<form action="/join" method="post">
			<b>아이디</b>
			<div class="input_aera">
				<input type="text" name="id" class="form-control id " maxlength="20"
					placeholder="아이디는 소문자를 포함한 5글자 이상으로 입력해야합니다."> <span
					class="msg_box">${errorMsg.id}</span>
			</div>
			<b>비밀번호</b>
			<div class="input_aera">
				<input type="password" class="pw form-control" name="pw"
					maxlength="20" placeholder="비밀번호는 영문 숫자 조합한 6글자 이상으로 입력해야합니다.">
			</div>
			<b>비밀번호 확인</b>
			<div class="input_aera">
				<input type="password" class="pw2 form-control" maxlength="20"
					placeholder="비밀번호를 한번더 입력해 주세요"> <span class="msg_box">${errorMsg.pw}</span>
			</div>
			<b>이메일</b>
			<div class="input_aera">
				<input type="text" name="email" class="email form-control"
					placeholder="이메일을 입력해 주세요"> <span class="msg_box">${errorMsg.email}</span>
			</div>
			<b>이름</b>
			<div class="input_aera">
				<input type="text" class="name form-control" name="name"
					maxlength="20" placeholder="사용하실 이름을 입력해 주세요. 한글만 가능합니다.">
				<span class="msg_box">${errorMsg.name}</span>
			</div>
			<b>닉네임</b>
			<div class="input_aera">
				<input type="text" class="nickName form-control" name="nickName"
					maxlength="20" placeholder="닉네임을 10글자 이내로 입력해주세요."> <span
					class="msg_box">${errorMsg.nickName}</span>
			</div>
			<b>성별</b>
			<div class="gender form-control">
				<div>
					<label><input type="radio" name="gender" id="m" value="m">남자</label>
					<label><input type="radio" name="gender" id="f" value="f">여자</label>
				</div>
			</div>
			<br>
			<!-- BIRTH -->
			<b>생년월일</b>
			<div class="birth form-control">
				<!-- BIRTH_YY -->
				<div id="bir_yy">
					<span class="box"> <input type="text" id="yy"
						name="birthYear" class="sel" maxlength="4" placeholder="년(4자)">
					</span>
				</div>

				<!-- BIRTH_MM -->
				<div id="bir_mm">
					<span class="box"> <select id="mm" name="birthMonth"
						class="sel">
							<option>월</option>
							<option value="01">1</option>
							<option value="02">2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
					</select>
					</span>
				</div>

				<!-- BIRTH_DD -->
				<div id="bir_dd">
					<span class="box"> <input type="text" id="dd"
						name="birthDay" class="sel" maxlength="2"
						placeholder="일 (2자 ex:05)">
					</span>
				</div>
				<span class="msg_box">${errorMsg.birthYear}</span>
				<span class="msg_box1">${errorMsg.birthMonth}</span>
				<span class="msg_box1">${errorMsg.birthDay}</span>
			</div>
			<br> <br>

			<button class="btn-lg col-3 back" onclick="window.open('/');">취소</button>
			<button class="btn-lg col-3 login_btn">회원가입</button>

		</form>
	</div>
	<div class="enter"></div>
	</div>
	<script type="text/javascript" src="/js/common/util.js"></script>
	<script type="text/javascript" src="/js/member/join.js"></script>
</body>
</html>