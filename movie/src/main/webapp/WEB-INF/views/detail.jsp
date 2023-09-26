<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DREAM :: MOVIE</title>
<link rel="stylesheet" href="./css/detail.css" />
<script src="./js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>


<script type="text/javascript">

	$(function() {
		let WURL = window.location.href;
		let count = $("#count").val();
		count = parseInt(count);
		$(".count").html("누적관객수<br>" + count.toLocaleString() + "명");
		/* 하트 바꾸기 */
		$(".like").click(function() {
			let icon = $(this).find('i');

			if (icon.hasClass('xi-heart-o')) {
				icon.removeClass('xi-heart-o').addClass('xi-heart');
			} else {
				icon.removeClass('xi-heart').addClass('xi-heart-o');
			}
		});

		$(".goto:contains('예정')").click(function() {
			alert("아직 미개봉입니다")
			return false;
		});

		let show = false;
		$(".share").click(function() {
			if (show) {
				$("#sharediv, #triangle").hide();
			} else {
				$("#sharediv, #triangle").show();
			}
			show = !show;

		});

		/* url복사 */
		$(document).on('click', "#link", function() {

			let textArea = document.createElement("textarea");
			textArea.value = WURL;

			// textarea를 body에 추가
			document.body.appendChild(textArea);

			// textarea를 선택하고 복사 명령 실행
			textArea.select();
			document.execCommand("copy");

			// textarea를 삭제
			document.body.removeChild(textArea);

			alert("URL이 복사되었습니다.");
		});

		// Kakao Link 초기화
		Kakao.init('5e6035c5b6dc0c23f98779b6f6fded6d');

		// 버튼 클릭 이벤트 핸들러
		$(document).on("click", "#kakao", function() {
			// 공유할 정보 설정
			var title = 'WELCOME TO DREAMBOX';
			var description = '이 웹 페이지를 카카오톡으로 공유합니다.';
			var imageUrl = '${detail.mv_poster}';
			var webUrl = window.location.href;

			// 카카오톡으로 공유하기
			Kakao.Link.sendDefault({
				objectType : 'feed',
				content : {
					title : title,
					description : description,
					imageUrl : imageUrl,
					link : {
						mobileWebUrl : webUrl,
						webUrl : webUrl,
					},
				},
			});
		});

		$(".dli").click(function() {
			$(this).addClass("on");
			$(this).siblings("li").removeClass("on");
			if ($(this).hasClass("minfo")) {
				$(".info").show();
				$(".trailer").hide();
				$(".stillcut").hide();
				$(".actor").hide();
			} else if ($(this).hasClass("mtrailer")) {
				$(".info").hide();
				$(".trailer").show();
				$(".stillcut").hide();
				$(".actor").hide();
			} else if ($(this).hasClass("mstillcut")) {
				$(".info").hide();
				$(".trailer").hide();
				$(".stillcut").show();
				$(".actor").hide();

			} else if ($(this).hasClass("mactor")) {
				$(".info").hide();
				$(".trailer").hide();
				$(".stillcut").hide();
				$(".actor").show();
			}
		})

		$(".phname").click(function() {
			let name = $(this).children(".ac_actor").text();
			$(".urlname").attr("src", "https://ko.wikipedia.org/wiki/" + name);
			$("#staticBackdrop").modal("show");
		})
		$(".ac_director").click(function() {
			let name = $(this).text();
			$(".urlname").attr("src", "https://ko.wikipedia.org/wiki/" + name);
			$("#staticBackdrop").modal("show");
		})

	});
</script>
<style type="text/css">
.top-content::before {
	background-image: url("${detail.mv_bgimg}");
}
</style>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<div class="top">
		<div class="top-content">
			<div class="poster">

				<div>
					<img class="posterimg" src="${detail.mv_poster}">
				</div>
				<div class="svg-wrapper">
					<svg height="40" width="150" xmlns="http://www.w3.org/2000/svg">
                    <rect id="shape" height="40" width="150" />
                    <div id="text">
                        <a class="goto"
								href="./reservation?mv_code=${detail.mv_code }"><span
								class="spot"></span>
							<c:if test="${detail.au_status.equals('개봉') }">예매하기</c:if>
							<c:if test="${detail.au_status.equals('개봉예정') }">개봉예정</c:if></a>
                    </div>
                </svg>
				</div>
			</div>
			<div class="title">

				<div class="mvtitle">
					<img src="${detail.mv_gradeimg}">
					<h1>${detail.mv_name}</h1>
				</div>

				<div>${detail.mv_nameen }</div>
				<br>

				<button class="like" type="button">
					<i class="xi-heart-o"></i> 좋아요
				</button>
				<button class="share" type="button">
					<i class="xi-share-alt-o"></i> 공유하기
				</button>
				<div id="triangle"></div>
				<div id="sharediv">
					<button id="kakao">
						<i class="xi-kakaotalk xi-2x" style="color: #FBC02D"></i><br>
						카카오톡
					</button>
					<button id="kakao">
						<i class="xi-line xi-2x" style="color: green"></i><br> 라인
					</button>
					<button id="link">
						<i class="xi-link xi-2x"></i><br> 링크 복사
					</button>
				</div>

				<div class="title-info">
					<div class="rank">
						예매율 <br>${detail.mv_idx }위
					</div>
					<div class="count">
						<input id="count" type="hidden" value="${detail.au_acccnt}">
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="clear"></div>
	<div class="content">
		<ul>
			<li class="dli minfo on">영화 정보</li>
			<li class="dli mactor">감독 / 출연진</li>
			<li class="dli mtrailer">예고편</li>
			<li class="dli mstillcut">스틸컷</li>
		</ul>
	</div>

	<div class="info">
		<div class="clear"></div>
		<h2>${detail.mv_name }</h2>
		<div class="detailinfo">
			<img src="./img/runningtime.png">${detail.mv_runtime }분 &nbsp
			&nbsp | &nbsp &nbsp <img src="${detail.mv_gradeimg }">
			${detail.mv_grade } &nbsp &nbsp | &nbsp &nbsp <img
				src="./img/country.png"> ${detail.mv_country }
		</div>
		<br> <br> 장르 : ${detail.mv_genre }<br> 감독 :
		${detail.mc_director }<br> 출연진 : ${detail.mc_actor } <br> <br>
		제작사 : ${detail.mv_maker }<br> 개봉일 : ${detail.mv_sdate }<br>
		<div class="clear"></div>
		<hr>
		<div class="clear"></div>
		${detail.mv_sinop }
		<div class="clear"></div>
	</div>


	<div class="clear"></div>

	<div class="trailer">
		<iframe width="100%" height="100%" src="${detail.au_trailer }"
			title="YouTube video player" frameborder="0"
			allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
			allowfullscreen></iframe>
	</div>



	<div class="actor">
		<div class="ac_content">
			<div class="acfont">감독</div>
			<div class="ac_director">
				<img src="${detail.mc_diphoto }"><br>${detail.mc_director }</div>

			<br>
			<hr>
			<div class="acfont">출연진</div>
			<div class="clear"></div>

			<div class="ac_actor_container">
				<c:forEach begin="0" end="${fn:length(mc_actor)-1}" var="i">
					<div class="phname">
						<div class="ac_actorphoto">
							<img src="${mc_acphoto[i] }">
						</div>
						<br>
						<div class="ac_actor">${mc_actor[i] }</div>
					</div>
				</c:forEach>

			</div>
			<div class="clear"></div>

		</div>
	</div>
	<div class="stillcut">
		<c:forEach items="${au_img}" var="im">
			<img alt="" src="${im}">
		</c:forEach>
	</div>
	<img alt="" src="${poster.mv_poster }">



	<div class="clear"></div>


	<!-- Modal -->

	<div class="modal fade " id="staticBackdrop" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<!-- 모달 화면 시작 -->
			<div class="modal-content">

				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel"
						style="color: #A6A6A6; padding-top: 3px;">DREAMBOX</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<div class="modal-body">
					<div style="margin-bottom: 15px;">
						<div
							style="font-size: 15pt; text-align: center; font-weight: 700; margin: 0 0 20px 0; color: #209BF2;">인물
							정보</div>
						<iframe class="urlname" src="" id="chat_iframe"
							style="width: 100%; height: 60vh;">대체 내용</iframe>
					</div>
					<hr style="border: 0.005em solid #3C3C3C">
					<div class="grade_info">
						<div class="sImg"></div>
						<div class="sGrade"></div>
					</div>
				</div>

			

			</div>

		</div>
	</div>

	<!-- Bootstrap core JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>