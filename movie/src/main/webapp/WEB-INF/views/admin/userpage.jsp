<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN :: USER</title>
<style type="text/css">
body {
	background-color: white;
}

#closebtn2 {
	position: absolute;
	top: 90px;
	left: -180px;
}
}
</style>
<script src="../js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="../css/mypage.css" />
<script type="text/javascript">
var name = "${myInfo.m_name}";

function gradeCh(mno, name, value){

	if(confirm(name + "님의 등급을 변경하시겠습니까?")){
		$.ajax({
			url: "./gradeChange2",
			type: "post",
			data: { mno: mno, name: name, grade: value },
			dataType: "json",
			success: function(data) {
				if(data.result == 1) {
					$("#msg").text("등급 변경 완료");
					$("#modal2").show();
				} else {
					$("#msg").text("등급 변경 실패");
				}
			},
			error: function(error) {
				$("#msg").text("등급 변경 실패.");
			}
		});
	}
}

$(function() {	
	
	
	$("#send").click(function(event) {
		event.preventDefault();
		
		let email = $("#email").val();
		let content = $("#reason").val();
		
		if(email != null && content != null) {
			alert("확인");
			$.ajax({
				url: "./email",
				type: "post",
				data: { email: email, content: content },
				dataType: "json",
				success: function(data) {
					if(data.send == 1) {
						$(".msg").text("이메일 전송 완료");
					} else {
						$(".msg").text("이메일 전송 실패");
					}
				},
				error: function(error) {
					$(".msg").text("이메일 전송 단단히 실패.");
				}
			});
		}
	});
	
	$(".nbtn").click(function(){
		if(confirm(name + "님의 닉네임을 제재하시겠습니까?")){
			let before = $("#before").val();
			let id = $("#user").val();
			let button = $(this);

			$.ajax({
				url: "./nicknameChange",
				type: "post",
				data: { before: before, id: id },
				dataType: "json",
				success: function(data) {
					if(data.change == 1) {
						alert("성공");
						$(".nick").text("제재된닉네임으로 변경완료");
						$("#modal2").show();
					} else {
						alert("실패");
					}
				},
				error: function(error) {
					alert("단단히 실패");
				}
			});
		}
	});

	$(".pbtn").click(function(){
		if(confirm(name + "님의 포인트를 변경하시겠습니까?")){
			$("#pointChangeForm").show(); // 포인트 변경 폼 보이기
		}
	});

});
</script>
</head>
<body>
	
	<%@ include file="admenu.jsp"%>

	<table class="admin_table">
		<tr>
			<td id="index">성명</td>
			<td id="content">${myInfo.m_name}</td>
		</tr>
		<tr>
			<td id="index">닉네임</td>
			<td id="content" class="nickname">${myInfo.m_nickname}<input
				type="hidden" name="before" id="before" value="${myInfo.m_nickname}">
				<input type="hidden" name="user" id="user" value="${myInfo.m_no}">
				<button class="nbtn" type="button">닉네임 제재</button>
				<div class="nick">
					<span id="nick"></span>
				</div>
			</td>
		</tr>
		<tr>
			<td id="index">아이디</td>
			<td id="content"><c:choose>
					<c:when test="${myInfo.m_type eq 'naver'}">네이버연동회원</c:when>
					<c:otherwise>${myInfo.m_id}</c:otherwise>
				</c:choose></td>
		</tr>
		<tr>
			<td id="index">생년월일</td>
			<td id="content">${myInfo.m_birth}</td>
		</tr>
		<tr>
			<td id="index">회원유형</td>
			<td id="content">${myInfo.m_type}</td>
		</tr>
		<tr>
			<td id="index">이메일</td>
			<td id="content">${myInfo.m_email}</td>
		</tr>
		<tr>
			<td id="index">보유 포인트</td>
			<td id="content"><fmt:formatNumber value="${myInfo.m_point}"
					pattern="#,###" />
				<button class="pbtn" type="button">포인트변경</button>
				<form action="./pointChange" method="post" id="pointChangeForm"
					style="display: none;">
					<input type="text" name="point" id="point"
						value="${myInfo.m_point}"> <input type="hidden" name="mno"
						value="${myInfo.m_no}">
					<button class="submitBtn" type="submit">변경</button>
				</form></td>
		</tr>
		<tr>
			<td id="index">회원상태</td>
			<td id="content"><c:if test="${myInfo.m_status eq 0}">관리자</c:if>
				<c:if test="${myInfo.m_status eq 1}">일반회원</c:if> <c:if
					test="${myInfo.m_status eq 2 }">정지회원</c:if> <select id="grade"
				class="grade"
				onchange="gradeCh(${myInfo.m_no }, '${myInfo.m_name }', this.value)">

					<optgroup label="회원상태">
						<option value="0"
							<c:if test="${myInfo.m_status eq 0}">selected="selected"</c:if>>관리자</option>
						<option value="1"
							<c:if test="${myInfo.m_status eq 1}">selected="selected"</c:if>>일반회원</option>
						<option value="2"
							<c:if test="${myInfo.m_status eq 2}">selected="selected"</c:if>>정지회원</option>
					</optgroup>
			</select></td>
		</tr>

		<tr>
			<td id="index">제재 메일보내기</td>
			<td id="content">
				<button type="button" id="modal_open_btn2">메일 보내기</button>
				<div class="msg">
					<span id="msg"></span>
				</div>
			</td>
		</tr>
	</table>



	<!-- 제재메일모달 -->
	<div id="modal2">
		<div class="modal_content1">
			<div class="modal-header">
				<h2 class="modal-title" id="myModalLabel">제재매일</h2>
			</div>

			<div class="modal-body">
				<input type="hidden" id="email" name="email"
					value="${myInfo.m_email}">
				<textarea id="reason" class="code" name="content"
					placeholder="제재 내용 입력"></textarea>
				<div>
					<button type="submit" class="okay" id="send">메일보내기</button>
				</div>
				<div class="msg">
					<span class="msg"></span>
				</div>
				<button type="button" id="closebtn2">뒤로가기</button>
			</div>
		</div>
		<div class="modal_layer"></div>
	</div>


	<script>


		$("#modal_open_btn2").click(function() {
			$("#modal2").show();

		});

		$("#closebtn2").click(function() {
			$("#modal2").hide();
		});


	</script>
</body>
</html>