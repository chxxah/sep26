<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DREAM :: TICKET</title>
<script src="./js/jquery-3.7.0.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<link rel="stylesheet" href="./bootstrapt/css/bootstrap.min.css" />
<link rel="stylesheet" href="css/menu.css" />
<link rel="stylesheet" href="css/ticket.css" />
</head>
<body>
	<%@ include file="menu.jsp"%>


	<h1 id="title">TICKET</h1>


	<div id="msIdx">${msIdx}</div>
	<div id="box1">
		<br>
		<br> 예매번호 <br>
		<div id="rsNum">${rsNum}</div>
		<br> <br> 영화제목 <br>
		<div id="movieName">${tcInfo.mv_name}
			/
			<c:if test="${tcInfo.th_kind == 1 || tcInfo.th_kind == 2}">
		2D
	</c:if>
			<c:if test="${tcInfo.th_kind == 3}">
		3D
	</c:if>
			<c:if test="${tcInfo.th_kind == 4}">
		아이맥스
	</c:if>
		</div>
		<br>
		<br> 관람등급 <br>
		<div id="mvGrade">${mvGrade}</div>
	</div>
	<div id=box2>
		상영관<br>
		<div id="theaterName">${tcInfo.th_city}${tcInfo.th_kind}관</div>
		<br>
		<br> 상영일 <br>
		<div id="date">${date}</div>
		<br> <br> 상영시간 <br>
		<div id="time">${tcInfo.ms_stime}~ ${tcInfo.ms_etime}</div>
		<br> <br> 좌석 <br>
		<div id="seat">${list}</div>
		<div id="people">성인 ${adult}명, 청소년 ${youth}명, 우대 ${special}명</div>
	</div>

	<img id="qrcode" src="/img/QR코드.png">



	<button id="cancel">예매 취소하기</button>
	<button id="okay" onclick="location.href='/ticketlist'">확인</button>





	<script>
	$(document).ready(function() {
				
				  var date = "${date}";
				    var date2 = date.substring(0, 4) + "년 " + date.substring(4, 6) + "월 " + date.substring(6, 8) + "일";
				    $("#date").text(date2);
				
	

					$("#msIdx").hide();

					var adultNum = parseInt("${adult}");
					var youthNum = parseInt("${youth}");
					var specialNum = parseInt("${special}");

				
					 
					 let formattedDate = date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6, 8);

					 let msStime = "${tcInfo.ms_stime}";
					 msStime += ":00"; // 시간에 초를 추가

					 let dateTimeString = formattedDate + "T" + msStime;

					 let msSdate = new Date(dateTimeString);
			            
					var currentTime = new Date();
					
				
					$("#cancel").click(function() {

						var canConfirm = confirm('해당 예매를 취소하시겠습니까?');

						if (canConfirm) {
							
							if (currentTime <= msSdate) {
								alert("예매가 취소되었습니다");

								$.ajax({
									type : "POST",
									url : "/updateSeat2",
									data : {
										list : "${list}",
										msIdx : "${msIdx}",
										rsNum : "${rsNum}"
									},
									success : function() {
										location.href = "/reservation";

									},
									error : function() {
										alert("에러. 다시 시도하세요");
									}
								});

							} else {
								alert("상영시간이 지나 취소할 수 없습니다");
				              }
			            }
			        });
	}); 
			
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>