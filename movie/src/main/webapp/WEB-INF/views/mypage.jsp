<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DREAM :: MYPAGE</title>
<script src="./js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="css/menu.css" />
<link rel="stylesheet" href="css/mypage.css" />
</head>
<body>
	<%@ include file="menu.jsp"%>

	<table class="mypage_table">
		<tr>
			<td id="index">성명</td>
			<td id="content">${myInfo.m_name}</td>
		</tr>
		<tr>
			<td id="index">닉네임</td>
			<td id="content">${myInfo.m_nickname}
				<button type="button" id="modal_open_btn1">닉네임 변경</button>
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
			<td id="index">이메일</td>
			<td id="content">${myInfo.m_email}</td>
		</tr>
		<tr>
			<td id="index">보유 포인트</td>
			<td id="content"><fmt:formatNumber value="${myInfo.m_point}" pattern="#,###"/> 포인트</td>
		</tr>
		<tr>
			<td id="index">보유 쿠폰</td>
			<td id="content">
				<button type="button" id="modal_open_btn2">할인쿠폰 조회/등록</button>
			</td>
		</tr>
		<tr>
			<td id="index">보유 관람권</td>
			<td id="content">
				<button type="button" id="modal_open_btn3">관람권 조회/등록</button>
			</td>
		</tr>
		<tr>
			<td id="index">내 예매내역</td>
			<td id="content">
				<button type="button" id="ticketlist"
					onclick="location.href='/ticketlist'">예매내역 조회</button>
			</td>
		</tr>
	</table>
	



	<!-- 닉네임 모달 -->
	<div id="modal1">
		<div class="modal_content1">
			<div class="modal-header">
				<h2 class="modal-title" id="myModalLabel">닉네임 변경</h2>
			</div>

			<div class="modal-body">
				<input type="text" class="code" id="nickName"
					placeholder="변경하고자 하는 닉네임을 적어주세요.">
				<button type="button" class="okay" id="submit_btn1">확인</button>
				<button type="button" id="close_btn1">취소</button>
			</div>
		</div>
		<div class="modal_layer"></div>
	</div>


	<!-- 할인쿠폰 모달 -->
	<div id="modal2">
		<div class="modal_content">
			<div class="modal-header">
				<h2 class="modal-title" id="myModalLabel">할인쿠폰</h2>
			</div>

			<div class="modal-code">
				쿠폰 등록 <input type="text" class="code" id="couponCode"
					placeholder="쿠폰번호 16자리를 입력해주세요">
				<button class="okay" id="couponCheck">등록</button>
				</div>

				<div class="modal-body">
					보유 쿠폰 목록
				<br><br>
				<c:forEach items="${couponList}" var="c">
					<c:if test="${not empty c.rs_coupon}">
               ${c.rs_cindex} ${c.rs_coupon}<p>
					</c:if>
				</c:forEach>
					</div>
				
				<div class="modal-foot">
				<button type="button" id="close_btn2">확인</button>
				</div>
			
		</div>
		<div class="modal_layer"></div>
	</div>


	<!-- 관람권 모달 -->
	<div id="modal3">
		<div class="modal_content">
			<div class="modal-header">
				<h2 class="modal-title" id="myModalLabel">관람권</h2>
			</div>

<div class="modal-code">
				관람권 등록 <input type="text" class="code" id="admCode"
					placeholder="관람권번호 12자리를 입력해주세요">
				<button class="okay" id="admCheck">등록</button>
				</div>

			<div class="modal-body">
				<!-- 보유 관람권 목록 -->
					보유 관람권 목록
				<br><br>
				<c:forEach items="${couponList}" var="a">
					<c:if test="${not empty a.rs_admission && empty a.rs_aindex }">
               [2D/3D] ${a.rs_admission}<p>
					</c:if>
					<c:if test="${not empty a.rs_admission && not empty a.rs_aindex }">
              ${a.rs_aindex} ${a.rs_admission}<p>
					</c:if>
				</c:forEach>
			</div>
			<div class="modal-foot">
				<button type="button" id="close_btn3">확인</button>
				</div>
		</div>
		<div class="modal_layer"></div>
	</div>


<div id="modal1">
		<div class="modal_zzim">
			<div class="modal-header">
				<h2 class="modal-title">즐겨찾기</h2>
			</div>

			<div class="modal-body">
				<img alt="" src="">
				
				<button type="button" id="close_btn1">확인</button>
			</div>
		</div>
		<div class="modal_layer"></div>
	</div>



	<script>
		$("#modal_open_btn1").click(function() {
			$("#modal1").show();

		});

		$("#close_btn1").click(function() {
			$("#modal1").hide();
		});

		$("#modal_open_btn2").click(function() {
			$("#modal2").show();

		});

		$("#close_btn2").click(function() {
			$("#modal2").hide();
		});

		$("#modal_open_btn3").click(function() {
			$("#modal3").show();

		});

		$("#close_btn3").click(function() {
			$("#modal3").hide();
		});

		function refreshMemList() {
			location.reload();
		}

		// 쿠폰 유효성 검사, 등록 // 
		$("#couponCheck").click(function() {
			let cCode = parseInt($("#couponCode").val()); // 입력된 usepoint 값을 정수로 파싱
			let cLength = cCode.toString().length;
			if (cLength != 16) {
				alert("16자리 숫자로 입력하세요.");
			} else {
				$.ajax({
					url : "/couponChk2",
					type : "post",
					data : {
						"cCode" : cCode
					},
					dataType : "json",
					success : function(result) {

						if (result.result == 1) {
							alert("쿠폰 등록이 완료되었습니다");
							refreshMemList();

						} else {
							alert("유효하지 않는 코드입니다");
						}
					},
					error : function() {
						alert("에러. 다시 시도하세요");
					}
				});
			}
		});

		// 관람권 유효성 검사, 등록 // 
		$("#admCheck").click(function() {
			let aCode = parseInt($("#admCode").val()); // 입력된 usepoint 값을 정수로 파싱
			let aLength = aCode.toString().length;
			if (aLength != 12) {
				alert("12자리 숫자로 입력하세요.");
			} else {
				$.ajax({
					url : "/admChk2",
					type : "post",
					data : {
						"aCode" : aCode
					},
					dataType : "json",
					success : function(result) {

						if (result.result == 1) {
							alert("관람권 등록 완료");
							refreshMemList();

						} else {
							alert("유효하지 않는 관람권코드 입니다");
						}
					},
					error : function() {
						alert("에러. 다시 시도하세요");
					}
				});
			}
		});

		//닉네임 변경 버튼//
		$("#submit_btn1").click(function() {

			var nickName = $("#nickName").val();

			if (!nickName) {
				alert("변경하실 닉네임을 입력해주세요");

			} else {

				var canConfirm = confirm('닉네임을 변경하시겠습니까?');

				if (canConfirm) {

					$.ajax({
						type : "POST",
						url : "/updateNickname",
						data : {
							nickName : nickName
						},
						success : function() {
							alert("닉네임이 변경되었습니다.");
							refreshMemList();
						},
						error : function() {
							alert("에러. 다시 시도하세요");
						}
					});

				}
			}

		});
	</script>
</body>
</html>