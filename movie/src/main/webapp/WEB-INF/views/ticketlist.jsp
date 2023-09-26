<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DREAM :: 예매내역</title>
<script src="./js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="css/menu.css" />
<link rel="stylesheet" href="css/ticketlist.css" />
</head>
<body>

	<%@ include file="menu.jsp"%>


	<div class="content">
		<ul>
			<li class="nowTicket">예매내역</li>
			<li class="cancelTicket">취소 예매내역</li>
		</ul>
	</div>

<div id=list>
	<div class="nownow">
		<c:forEach items="${ticketList}" var="t">
			<c:if test="${t.rs_status == 1}">
				<button type="submit" id=button1
					onclick="ticketLink(
        '${t.ms_idx}', ${t.ri_adult}, ${t.ri_youth}, ${t.ri_special}, '${t.ss_seat}', '${t.ri_date}')">
					<h3 id="mvName">${t.mv_name}</h3>
					<c:set var="formattedDate" value="${t.ri_date}" />
					<fmt:parseDate value="${formattedDate}" pattern="yyyyMMdd"
						var="parsedDate" />
					<div class="date">
						<fmt:formatDate value="${parsedDate}" pattern="yyyy년 MM월 dd일" />
					</div>
					${t.ms_stime} ~ ${t.ms_etime} <br> ${t.th_city} <br> <br>
				</button>
				<br>
				<br>
			</c:if>
		</c:forEach>
	</div>


	<div class="cancelcancel">
		<c:forEach items="${ticketList}" var="t">
			<c:if test="${t.rs_status == 0}">
				<button type="submit" id=button2>
					<h3 id="mvName">${t.mv_name}</h3>
					<c:set var="formattedDate" value="${t.ri_date}" />
					<fmt:parseDate value="${formattedDate}" pattern="yyyyMMdd"
						var="parsedDate" />
					<div class="date">
						<fmt:formatDate value="${parsedDate}" pattern="yyyy년 MM월 dd일" />
					</div>
					${t.ms_stime} ~ ${t.ms_etime} <br> ${t.th_city} <br> <br>
				</button>
				<br>
				<br>
			</c:if>
		</c:forEach>
	</div>
</div>

	<script>
	

function ticketLink(ms_idx, ri_adult, ri_youth, ri_special, ss_seat, ri_date) {
    var url = 'ticket?ms_idx=' + ms_idx + '&adult=' + ri_adult + '&youth=' + ri_youth + '&special=' + ri_special + '&list=' + ss_seat + '&date=' + ri_date;
    location.href = url;
}



$(document).ready(function() {

    $(".nowTicket").addClass("on");
    $(".nownow").show();
    $(".cancelcancel").hide();

    
$("li").click(function() {
	$(this).addClass("on");
	$(this).siblings("li").removeClass("on");
	if ($(this).hasClass("nowTicket")) {
		$(".nownow").show();
		$(".cancelcancel").hide();

	}

	else if ($(this).hasClass("cancelTicket")) {
		$(".nownow").hide();
		$(".cancelcancel").show();

}
});
});

//var currentTime = new Date().getTime();


</script>
</body>
</html>