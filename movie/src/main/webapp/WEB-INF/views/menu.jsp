<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<link rel="stylesheet" href="./css/menu.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="icon" href="./img/dream_favicon.ico" type="image/x-icon">
<script src="./js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">

	$(function(){
			$.ajax({
	              url: "./menu",
	              type: "get",
	              dataType: "json",
	              success: function(data){
	            	  $(".m_mposter img").attr("src", data.mlist[0].mv_poster);
	            	  for (let i = 0; i < data.mlist.length; i++) {
	            		  $(".m_mlist" + (i+1) ).html("<span class='boldtext'>"+(i+1)+"</span>" + data.mlist[i].mv_name);
	            		  $(".m_mlist" + (i+1) ).parents(".m_mall a").attr("href", "detail?mv_code="+data.mlist[i].mv_code);
	            	  }
	            	  
	            	  $(".m_mall > a > li").mouseover(function(){
	            		  for (let i = 0; i < data.mlist.length; i++) {
	            			  if(data.mlist[i].mv_name == $(this).text().slice(1)) {
	            				  $(".m_mposter img").attr("src", data.mlist[i].mv_poster);
	            			  }
		            	  }
	            	  });
	              },
	              error: function(error){
	                  alert("Error");
	              }
	          });
	});
	
	$(function(){
		
		$(document).on("click", ".xi-bars" ,function(){
			let box = '<div class="xi-close-circle menu-close icon" style="padding-right: 10px"></div><div class="xi-search icon mmsearch"></div>';
			$("#m_mallbox").hide();
			$("#c_mallbox").show();
			$(".menu_map").html(box);
		});
		
		$(document).on("click", ".menu-close" ,function(){
			let box = '<div class="xi-bars icon" style="padding-right: 10px"></div><div class="xi-search icon mmsearch"></div>';
			$("#c_mallbox").hide();
			$(".menu_map").html(box);
		});
		
		$(document).on("click", ".xi-search" ,function(){
			let box = '<div class="xi-bars icon" style="padding-right: 10px"></div><div class="xi-close-circle search-close icon mmsearch"></div>';
			$("#c_mallbox").hide();
			$("#m_mallbox").show();
			$(".menu_map").html(box);
		});
		
		$(document).on("click", ".search-close " ,function(){
			let box = '<div class="xi-bars icon" style="padding-right: 10px"></div><div class="xi-search icon mmsearch"></div>';
			$("#m_mallbox").hide();
			$(".menu_map").html(box);
		});
			
		
	});
</script>

<!-- 메뉴 -->
<nav class="menunavbar">

	<div class="menu">
		<div class="menu_header">
			<div class="header_logo">
				<a href="./"><img alt="" src="./img/logo.png"></a>
			</div>
			<div class="header_wrap">
				<div class="aside">
					<ul class="aside_list">
						<c:choose>
							<c:when test="${sessionScope.id eq null}">
								<li onclick="link('login')"><span class="xi-lock-o icon"></span>
									<span class="text">로그인</span></li>
								<li onclick="link('join')"><span
									class="xi-user-plus-o icon"></span> <span class="text">회원가입</span>
								</li>
							</c:when>
							<c:otherwise>
								<c:if test="${sessionScope.status eq 0 }">
									<li onclick="link('admin/member')"><span class="xi-cog icon"></span>
										<span class="text">관리자</span></li>
								</c:if>
								<li onclick="logout()"><span class="xi-unlock-o icon"></span>
									<span class="text">로그아웃</span></li>
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${sessionScope.id eq null}">
								<li onclick="login()"><span class="xi-profile-o icon"></span>
									<span class="text">MY DREAM</span></li>
							</c:when>
							<c:otherwise>
								<li onclick="link('mypage')"><span
									class="xi-profile-o icon"></span><span class="text">MY DREAM</span></li>
							</c:otherwise>
						</c:choose>
						<li onclick="link('입력하시오')"><span class="xi-forum-o icon"></span>
							<span class="text">고객센터</span></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="menu_nav">
			<div class="menu_map">
				<div class="xi-bars icon" style="padding-right: 10px"></div>
				<div class="xi-search icon mmsearch"></div>
			</div>
			<div class="menu_side">
				<ul class="menu_wrap">
					<li onclick="link('')" class="list"><span class="text">영화</span></li>
					<li onclick="link('reservation')" class="list"><span class="text">예매</span></li>
					<li onclick="link('theaterinfo')" class="list"><span class="text">극장</span></li>
					<li onclick="link('schedule')" class="list"><span class="text">상영시간표</span></li>
					<li onclick="link('benefit')" class="list"><span class="text">EVENT</span></li>
				</ul>
			</div>
		</div>
	</div>
</nav>
<!-- 전체메뉴 -->
<div id="c_mallbox">
	<ul class="c_topul">
		<li class="c_topli">영화
			<ul>
				<li>현재 상영작</li>
				<li>상영 예정작</li>
			</ul>
		</li>
		<li class="c_topli">예매
			<ul>
				<li>예매하기</li>
				<li>상영시간표</li>
			</ul>
		</li>
		<li class="c_topli">극장
			<ul>
				<li>드림 영화관</li>
				<li>드림 특별관</li>
			</ul>
		</li>
		<li class="c_topli">이벤트
			<ul>
				<li>SPECIAL</li>
				<li>시사회/무대인사</li>
			</ul>
		</li>
		<li class="c_topli">혜택
			<ul>
				<li>드림박스 멤버십</li>
				<li>제휴/할인</li>
			</ul>
		</li>
		<li class="c_topli">고객센터
			<ul>
				<li>자주 묻는 질문</li>
				<li>공지사항</li>
			</ul>
		</li>
		<li class="c_topli">MY DREAM
			<ul>
				<li>나의 드림박스</li>
				<li>예매내역</li>
				<li>할인/제휴쿠폰</li>
				<li>나의 문의내역</li>
				<li>회원정보</li>
			</ul>
		</li>
	</ul>

</div>


<!-- 통합검색 -->
<div id="m_mallbox">
	<div class="m_mrate">
		<div class="mmtitle">
			<div class="mmsquare"></div>
			<h2>  예매 순위</h2>
		</div>
		<div class="m_mposter">
			<img src="">
		</div>
		<div class="m_mlist">
			<ul class="m_mall">
				<a href=""><li class="m_mlist1 mmlist"></li></a>
				<a href=""><li class="m_mlist2 mmlist"></li></a>
				<a href=""><li class="m_mlist3 mmlist"></li></a>
				<a href=""><li class="m_mlist4 mmlist"></li></a>
				<a href=""><li class="m_mlist5 mmlist"></li></a>
			</ul>
		</div>
	</div>
	<div class="m_msearch">
		<div class="mm_1">
			<img src="./img/logo_white.png">
		</div>
		<div class="mm_2">
			<form action="./search" method="post">
				<input type="text" name="mv_name" id="search" placeholder="영화를 검색하세요" list="movielist">
					<datalist id="movielist">
						<option value="잠">
						<option value="오펜하이머">
						<option value="달짝지근해: 7510">
						<option value="콘크리트 유토피아">
						<option value="타겟">
						<option value="밀수">
						<option value="치악산">
						<option value="해리 포터와 혼혈 왕자">
						<option value="엘리멘탈">
						<option value="듣보인간의 생존신고">
						<option value="여름을 향한 터널, 이별의 출구">
						<option value="1947 보스톤">
						<option value="베니스 유령 살인사건">
						<option value="아이유 콘서트 : 더 골든 아워">
						<option value="닌자터틀: 뮤턴트 대소동">
					</datalist>
					<button class="mmbutton"><span style="color: white;" class="xi-search"></span></button>
			</form>
		</div>
		<div class="mm_3">
			<img src="./img/logo_slogan.png">
		</div>
	</div>
</div>


<script>
	function link(url) {
		location.href = "./" + url;
	}
	
	function login() {
		alert("로그인을 해주세요.");
		location.href="./login";
	}
	
	function logout() {
		if(confirm("로그아웃 하시겠습니까?")) {
			location.href="./logout";
		}
	}
</script>