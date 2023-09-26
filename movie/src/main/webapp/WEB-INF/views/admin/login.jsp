<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/login.css">
<meta charset="UTF-8">
<title>ADMIN :: LOGIN</title>
<script src="../js/jquery-3.7.0.min.js"></script>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>
<style>
.button-area{
margin-bottom: 40px;
}
</style>
<body>
<script>
    $(document).ready(function() {
        let error = '${error}';
        if (error !== '') {
            alert(error);
        }
    });
</script>
	<div class="signin_wrap">

		<form action="/admin/login" method="post" id="signInForm">
			<a href="/"> <img class="logo" src="/img/movielogo.png"
				alt="logo" height="100">
			</a> <br>
			<div class=input-area>
			<div class="form-floating col-8">
				<input type="text" class="form-control" placeholder="ID" name="id"
					maxlength="41"> <label for="id">아이디</label>
			</div>
			<div class="form-floating col-8">
				<input type="password" class="form-control" placeholder="Password"
					name="pw" maxlength="16"> <label for="pw">비밀번호</label>
			</div>
			<div class="error_message text-start float-start" id="idErrorMsg"
				style="display: none;">아이디를 입력해주세요.</div>
			<div class="error_message text-start float-start" id="pwErrorMsg"
				style="display: none;">비밀번호를 입력해주세요.</div>
			</div>
			<br>
			<div class="button-area">
				<button class="btn-lg col-5" type="submit">
					<span class="btn_text">관리자 모드</span>
				</button>
			<br>
				</div>
		</form>
	</div>
	<script type="text/javascript" src="/js/member/login.js"></script>
</body>
</html>