<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DREAM :: SCHEDULE</title>
<script src="./js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="./css/schedule.css" />

</head>
<script type="text/javascript">
	$(function() {
		$(".on").show();
		$(".content ul li").click(function() {
			let son = $(this).attr('class');

			if (son === "sli1") {
				$(".posterimg").attr("src", "${scheduleinfo[0].mv_poster}");
				$(".sc_mvname").text("${scheduleinfo[0].mv_name}");

			}


			if (son === "sli2") {
				$(".posterimg").attr("src", "${scheduleinfo[1].mv_poster}");
				$(".sc_mvname").text("${scheduleinfo[1].mv_name}");
				}

			if (son === "sli3") {
				$(".posterimg").attr("src", "${scheduleinfo[2].mv_poster}");
				$(".sc_mvname").text("${scheduleinfo[2].mv_name}");

			}

			if (son === "sli4") {
				$(".posterimg").attr("src", "${scheduleinfo[3].mv_poster}");
				$(".sc_mvname").text("${scheduleinfo[3].mv_name}");

			}

			if (son === "sli5") {
				$(".posterimg").attr("src", "${scheduleinfo[4].mv_poster}");
				$(".sc_mvname").text("${scheduleinfo[4].mv_name}");

			}

			if (son === "sli6") {
				$(".posterimg").attr("src", "${scheduleinfo[5].mv_poster}");
				$(".sc_mvname").text("${scheduleinfo[5].mv_name}");

			}

			if (son === "sli7") {
				$(".posterimg").attr("src", "${scheduleinfo[6].mv_poster}");
				$(".sc_mvname").text("${scheduleinfo[6].mv_name}");

			}

			if (son === "sli8") {
				$(".posterimg").attr("src", "${scheduleinfo[7].mv_poster}");
				$(".sc_mvname").text("${scheduleinfo[7].mv_name}");

			}

			if (son === "sli9") {
				$(".posterimg").attr("src", "${scheduleinfo[8].mv_poster}");
				$(".sc_mvname").text("${scheduleinfo[8].mv_name}");

			}

			if (son === "sli10") {
				$(".posterimg").attr("src", "${scheduleinfo[9].mv_poster}");
				$(".sc_mvname").text("${scheduleinfo[9].mv_name}");

			}

			$(".on").removeClass("on");
			$(".sc_totalone").hide();
			$(".whole ." + son).addClass("on");
			$(".on").show();
		});

	});
</script>

<body>
	<%@ include file="menu.jsp"%>
	<div class="clear"></div>
	<img class="backcolor" alt="" src="./img/backcolor.png">
	<div class="content">
		<div class="sc_movie">영화별</div>
		<ul>
			<li class="sli1">잠</li>
			<li class="sli2">오펜하이머</li>
			<li class="sli3">달짝지근해:7510</li>
			<li class="sli4">콘크리트 유토피아</li>
			<li class="sli5">타겟</li>
			<li class="sli6">밀수</li>
			<li class="sli7">치악산</li>
			<li class="sli8">해리 포터와 혼혈 왕자</li>
			<li class="sli9">엘리멘탈</li>
			<li class="sli10">듣보인간의 생존신고</li>
		</ul>
		<div class="sc_img">
			<img class="posterimg" src="${scheduleinfo[0].mv_poster}">

		</div>

	</div>

	<div class="sc_name">
		<h2 class="blue">『 </h2>
		<h2 class="sc_mvname blue">${scheduleinfo[0].mv_name}</h2>
		<h2 class="blue"> 』</h2>
		&nbsp&nbsp&nbsp
		<h2>상영 시간표 🎞️</h2>
		<br> <br> <br> <br>
	</div>
	<div class="sc_tinfo">
		<div>지역</div>
		<div>DREAMBOX 지점</div>
		<div>상영관 종류</div>
		<div>감독/출연진</div>
		<div>상영시간</div>
		<div>예매</div>
	</div>
	<hr>
	<div class="whole">
		<div class="sc_totalone on sli1">
			<div class="sc_info sli1">
				<c:forEach items="${schedule1}" var="one">
					<div>${one.th_area }</div>
					<div>DREAMBOX&nbsp${one.th_city }점</div>
					<div>
						<c:if test="${one.th_kind eq 1 }">일반관(1관)</c:if>
						<c:if test="${one.th_kind eq 2 }">일반관(2관)</c:if>
						<c:if test="${one.th_kind eq 3 }">4DX관</c:if>
						<c:if test="${one.th_kind eq 4 }">IMAX관</c:if>
					</div>
					<div style="text-align: left">${one.mc_director },
						${one.mc_actor }</div>
					<div>${one.ms_stime } ~ ${one.ms_etime }</div>
					<button class="sc_detail"
						onclick="window.location.href='./detail?mv_code=${one.mv_code}'">상세보기</button>
 				&nbsp&nbsp
				<button class="sc_reservation"
						onclick="window.location.href='./reservation?mv_code=${one.mv_code}'">예매하기</button>
					<br>
					<br>
				</c:forEach>
			</div>
		</div>


		<div class="sc_totalone sli2">

			<div class="sc_info">
				<c:forEach items="${schedule2}" var="one">
					<div>${one.th_area }</div>
					<div>${one.th_city }점DREAMBOX</div>
					<div>
						<c:if test="${one.th_kind eq 1 }">일반관(1관)</c:if>
						<c:if test="${one.th_kind eq 2 }">일반관(2관)</c:if>
						<c:if test="${one.th_kind eq 3 }">4DX관</c:if>
						<c:if test="${one.th_kind eq 4 }">IMAX관</c:if>
					</div>
					<div style="text-align: left">${one.mc_director },
						<c:if test="${fn:length(one.mc_actor) >= 20}">
    					${fn:substring(one.mc_actor, 0, 20)} 
					</c:if>
					</div>
					<div>${one.ms_stime }~${one.ms_etime }</div>
					<button class="sc_detail"
						onclick="window.location.href='./detail?mv_code=${one.mv_code}'">상세보기</button>
 				&nbsp&nbsp
				<button class="sc_reservation"
						onclick="window.location.href='./reservation?mv_code=${one.mv_code}'">예매하기</button>
					<br>
					<br>
				</c:forEach>
			</div>
		</div>

		<div class="sc_totalone sli3">

			<div class="sc_info">
				<c:forEach items="${schedule3}" var="one">
					<div>${one.th_area }</div>
					<div>${one.th_city }점DREAMBOX</div>
					<div>
						<c:if test="${one.th_kind eq 1 }">일반관(1관)</c:if>
						<c:if test="${one.th_kind eq 2 }">일반관(2관)</c:if>
						<c:if test="${one.th_kind eq 3 }">4DX관</c:if>
						<c:if test="${one.th_kind eq 4 }">IMAX관</c:if>
					</div>
					<div style="text-align: left">${one.mc_director },
						${one.mc_actor }</div>
					<div>${one.ms_stime }~${one.ms_etime }</div>
					<button class="sc_detail"
						onclick="window.location.href='./detail?mv_code=${one.mv_code}'">상세보기</button>
 				&nbsp&nbsp
				<button class="sc_reservation"
						onclick="window.location.href='./reservation?mv_code=${one.mv_code}'">예매하기</button>
					<br>
					<br>
				</c:forEach>
			</div>
		</div>

		<div class="sc_totalone sli4">

			<div class="sc_info">
				<c:forEach items="${schedule4}" var="one">
					<div>${one.th_area }</div>
					<div>${one.th_city }점DREAMBOX</div>
					<div>
						<c:if test="${one.th_kind eq 1 }">일반관(1관)</c:if>
						<c:if test="${one.th_kind eq 2 }">일반관(2관)</c:if>
						<c:if test="${one.th_kind eq 3 }">4DX관</c:if>
						<c:if test="${one.th_kind eq 4 }">IMAX관</c:if>
					</div>

					<div style="text-align: left">${one.mc_director },
						${one.mc_actor }</div>
					<div>${one.ms_stime }~${one.ms_etime }</div>
					<button class="sc_detail"
						onclick="window.location.href='./detail?mv_code=${one.mv_code}'">상세보기</button>
 				&nbsp&nbsp
				<button class="sc_reservation"
						onclick="window.location.href='./reservation?mv_code=${one.mv_code}'">예매하기</button>
					<br>
					<br>
				</c:forEach>
			</div>
		</div>
		<div class="sc_totalone sli5">

			<div class="sc_info">
				<c:forEach items="${schedule5}" var="one">
					<div>${one.th_area }</div>
					<div>${one.th_city }점DREAMBOX</div>
					<div>
						<c:if test="${one.th_kind eq 1 }">일반관(1관)</c:if>
						<c:if test="${one.th_kind eq 2 }">일반관(2관)</c:if>
						<c:if test="${one.th_kind eq 3 }">4DX관</c:if>
						<c:if test="${one.th_kind eq 4 }">IMAX관</c:if>
					</div>
					<div style="text-align: left">${one.mc_director },
						${one.mc_actor }</div>
					<div>${one.ms_stime }~${one.ms_etime }</div>
					<button class="sc_detail"
						onclick="window.location.href='./detail?mv_code=${one.mv_code}'">상세보기</button>
 				&nbsp&nbsp
				<button class="sc_reservation"
						onclick="window.location.href='./reservation?mv_code=${one.mv_code}'">예매하기</button>
					<br>
					<br>
				</c:forEach>
			</div>
		</div>


		<div class="sc_totalone sli6">

			<div class="sc_info">
				<c:forEach items="${schedule6}" var="one">
					<div>${one.th_area }</div>
					<div>${one.th_city }점DREAMBOX</div>
					<div>
						<c:if test="${one.th_kind eq 1 }">일반관(1관)</c:if>
						<c:if test="${one.th_kind eq 2 }">일반관(2관)</c:if>
						<c:if test="${one.th_kind eq 3 }">4DX관</c:if>
						<c:if test="${one.th_kind eq 4 }">IMAX관</c:if>
					</div>
					<div style="text-align: left">${one.mc_director },
						${one.mc_actor }</div>
					<div>${one.ms_stime }~${one.ms_etime }</div>
					<button class="sc_detail"
						onclick="window.location.href='./detail?mv_code=${one.mv_code}'">상세보기</button>
 				&nbsp&nbsp
				<button class="sc_reservation"
						onclick="window.location.href='./reservation?mv_code=${one.mv_code}'">예매하기</button>
					<br>
					<br>
				</c:forEach>
			</div>
		</div>

		<div class="sc_totalone sli7">

			<div class="sc_info">
				<c:forEach items="${schedule7}" var="one">
					<div>${one.th_area }</div>
					<div>${one.th_city }점DREAMBOX</div>
					<div>
						<c:if test="${one.th_kind eq 1 }">일반관(1관)</c:if>
						<c:if test="${one.th_kind eq 2 }">일반관(2관)</c:if>
						<c:if test="${one.th_kind eq 3 }">4DX관</c:if>
						<c:if test="${one.th_kind eq 4 }">IMAX관</c:if>
					</div>
					<div style="text-align: left">${one.mc_director },
						${one.mc_actor }</div>
					<div>${one.ms_stime }~${one.ms_etime }</div>
					<button class="sc_detail"
						onclick="window.location.href='./detail?mv_code=${one.mv_code}'">상세보기</button>
 				&nbsp&nbsp
				<button class="sc_reservation"
						onclick="window.location.href='./reservation?mv_code=${one.mv_code}'">예매하기</button>
					<br>
					<br>
				</c:forEach>
			</div>
		</div>

		<div class="sc_totalone sli8">

			<div class="sc_info">
				<c:forEach items="${schedule8}" var="one">
					<div>${one.th_area }</div>
					<div>${one.th_city }점DREAMBOX</div>
					<div>
						<c:if test="${one.th_kind eq 1 }">일반관(1관)</c:if>
						<c:if test="${one.th_kind eq 2 }">일반관(2관)</c:if>
						<c:if test="${one.th_kind eq 3 }">4DX관</c:if>
						<c:if test="${one.th_kind eq 4 }">IMAX관</c:if>
					</div>
					<div style="text-align: left">${one.mc_director },
						<c:if test="${fn:length(one.mc_actor) >= 20}">
    					${fn:substring(one.mc_actor, 0, 20)} 
					</c:if>
					</div>
					<div>${one.ms_stime }~${one.ms_etime }</div>
					<button class="sc_detail"
						onclick="window.location.href='./detail?mv_code=${one.mv_code}'">상세보기</button>
 				&nbsp&nbsp
				<button class="sc_reservation"
						onclick="window.location.href='./reservation?mv_code=${one.mv_code}'">예매하기</button>
					<br>
					<br>
				</c:forEach>
			</div>
		</div>

		<div class="sc_totalone sli9">

			<div class="sc_info">
				<c:forEach items="${schedule9}" var="one">
					<div>${one.th_area }</div>
					<div>${one.th_city }점DREAMBOX</div>
					<div>
						<c:if test="${one.th_kind eq 1 }">일반관(1관)</c:if>
						<c:if test="${one.th_kind eq 2 }">일반관(2관)</c:if>
						<c:if test="${one.th_kind eq 3 }">4DX관</c:if>
						<c:if test="${one.th_kind eq 4 }">IMAX관</c:if>
					</div>
					<div style="text-align: left">${one.mc_director },
						${one.mc_actor }</div>
					<div>${one.ms_stime }~${one.ms_etime }</div>
					<button class="sc_detail"
						onclick="window.location.href='./detail?mv_code=${one.mv_code}'">상세보기</button>
 				&nbsp&nbsp
				<button class="sc_reservation"
						onclick="window.location.href='./reservation?mv_code=${one.mv_code}'">예매하기</button>
					<br>
					<br>
				</c:forEach>
			</div>
		</div>
		<div class="sc_totalone sli10">

			<div class="sc_info">
				<c:forEach items="${schedule10}" var="one">
					<div>${one.th_area }</div>
					<div>${one.th_city }점DREAMBOX</div>
					<div>
						<c:if test="${one.th_kind eq 1 }">일반관(1관)</c:if>
						<c:if test="${one.th_kind eq 2 }">일반관(2관)</c:if>
						<c:if test="${one.th_kind eq 3 }">4DX관</c:if>
						<c:if test="${one.th_kind eq 4 }">IMAX관</c:if>
					</div>
					<div style="text-align: left">${one.mc_director },
						${one.mc_actor }</div>
					<div>${one.ms_stime }~${one.ms_etime }</div>
					<button class="sc_detail"
						onclick="window.location.href='./detail?mv_code=${one.mv_code}'">상세보기</button>
 				&nbsp&nbsp
				<button class="sc_reservation"
						onclick="window.location.href='./reservation?mv_code=${one.mv_code}'">예매하기</button>
					<br>
					<br>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="clear"></div>
</body>
</html>