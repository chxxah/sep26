<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DREAMBOX</title>
<script src="./js/jquery-3.7.0.min.js"></script>
<meta name="viewport"
   content="width=device-width, initial-scale=1.0, user-scalable=yes" />

<link rel="stylesheet" href="../css/mhome/main.css">
<link rel="stylesheet" href="../css/mhome/megabox.min.css">
<link rel="stylesheet" href="../css/mhome/common.css">

<script type="text/javascript">
   var totalcnt = 0; // 영화총개수
   var moviecnt = 0; // 영화개수
   var sortValue = 0; // 분류값
   var type = 0; //분류값 개봉,개봉예정구분
   var moviesPerPage = 5; //영화제한개수
   
   //#1.페이지 로드시 영화목록 박스오피스 순으로 정렬해서 출력하기 
   $(document).ready(function() {

      if (moviesPerPage >= totalcnt) {
         $("#btnAddMovie").hide(); // 모든 영화를 표시한 경우 더보기 버튼 숨김
      } else {
         $("#btnAddMovie").show(); // 아직 표시할 영화가 있는 경우 더보기 버튼 표시
      }

      sortMovies(0); // 예시로 sort=0으로 초기 데이터 로드

      //개봉예정작
      $("#btnMovie1").on("click", function() {
         sortValue = $(this).data("sort");
         type = 5;
         sortMovies(sortValue, type);

      }); //끝부분 

      //개봉작
      $("#btnMovie").on("click", function() {
         sortValue = $(this).data("sort");
         type = 4;
         sortMovies(sortValue, type);

      }); //끝부분 

      // 예매순 , 누적관객순 ,개봉일순 정렬버튼 
      $("#sort1").on("click", function() {
         sortValue = $(this).data("sort");
         sortMovies(sortValue, type);

      });
      // 예매순 , 누적관객순 ,개봉일순 정렬버튼 
      $("#sort2").on("click", function() {
         sortValue = $(this).data("sort");
         sortMovies(sortValue, type);

      });
      // 예매순 , 누적관객순 ,개봉일순 정렬버튼 
      $("#sort3").on("click", function() {
         sortValue = $(this).data("sort");
         sortMovies(sortValue, type);

      });

      // 더보기 버튼
      $("#btnAddMovie").on("click", function() {

         moviesPerPage += 5; // 다음 페이지로 이동
         sortMovies(sortValue, type);

         if (moviesPerPage >= totalcnt) {
            $("#btnAddMovie").hide();
         }

      });

   });

   //#2. 정렬버튼눌렀을때 정렬하고 새롭게 출력하기 
   function sortMovies(sortValue, type) {

      $.ajax({
         type : "GET",
         url : "/movie/list",
         data : {
            "sort" : sortValue

         },

         success : function(data) {

            jsonData = JSON.parse(data);
            var movieListContainer = $("#movieList");

            movieListContainer.empty();
            moviecnt = 0;
            totalcnt = jsonData.list.length;

            for (var i = 0; i < jsonData.list.length; i++) {

               var movie = jsonData.list[i];

               if (type === 4) {

                  if (movie.au_status === "개봉") {

                     if (moviecnt < moviesPerPage) {

                        updateMovieList(movie);
                        moviecnt++;

                     }
                  }

               } else if (type === 5) {

                  if (movie.au_status === "개봉예정") {

                     if (moviecnt < moviesPerPage) {
                        updateMovieList(movie);
                        moviecnt++;

                     }
                  }

               } else {

                  if (moviecnt < moviesPerPage) {

                     updateMovieList(movie);
                     moviecnt++;

                  }
               }

            }
            // 더보기 버튼 표시 여부 결정
            if (moviesPerPage >= totalcnt) {

               $("#btnAddMovie").hide(); // 모든 영화를 표시한 경우 더보기 버튼 숨김
            } else {
               $("#btnAddMovie").show(); // 아직 표시할 영화가 있는 경우 더보기 버튼 표시
            }
         },

         error : function(request, status, error) {
            alert("서버 오류가 발생했습니다." + error);
         }

      });
   }

   // 날짜 형식을 바꾸는 함수
   function formatDate(dateString) {
      var parts = dateString.split('-');
      if (parts.length === 3) {
         return parts.join('.');
      }
      return dateString; // 원래 문자열 형식과 일치하지 않는 경우 원래 문자열을 반환합니다.
   }

   // mv_sdate 속성의 값을 포맷팅한 후 새로운 속성에 할당

   //#3.영화정렬 및 등록
   function updateMovieList(movie) {

      //moviecnt++;
      var movieListContainer = $("#movieList");
         

      //더보기 추가버튼 페이지개수 제한

      var update = movie;
      var listItem = $("<li>").addClass("no-img");
      var grade = movie.mv_grade;
      

      movie.formattedDate = formatDate(movie.mv_sdate);

      if (grade == "전체관람가" || grade == "null" || grade == "") {
         var grade1 = "age-all";
      } else if (grade == "12세이상관람가") {
         var grade1 = "age-12";
      } else if (grade == "15세이상관람가") {
         var grade1 = "age-15";
      } else if (grade == "19세이상관람가" || grade == "청소년관람불가") {
         var grade1 = "age-19";
      } 

      listItem
            .append(
                  $("<div>").addClass("movie-list-info").append(
                        $("<img>").attr("src", movie.mv_poster).attr(
                              "alt", movie.mv_name).attr("onclick",
                              "datacode(" + movie.mv_code + ")")
                              .attr("role", "button").attr("data-no",
                                    movie.mv_code).addClass(
                                    "poster lozad")),

                  $("<div>").addClass("tit-area").append(
                        $("<p>").addClass("movie-grade").addClass(
                              grade1).text(","),
                        $("<p>").attr("title", movie.mv_name).addClass(
                              "tit").attr("data-no",
                                    movie.mv_code).attr("onclick",
                                    "datacode(" + movie.mv_code + ")").text(movie.mv_name)),
                  $("<div>").addClass("rate-date").append(
                        $("<span>").addClass("rate")
                              .text("예매율 "+ movie.mv_rate +"위"),
                        $("<span>").addClass("date").text(
                              "개봉일 " + movie.formattedDate)),
                  $("<div>")
                        .addClass("btn-util")
                        .append(
                              $("<div>")
                                    .addClass(
                                          "case col-2 movieStat3")
                                    .css("display", "")
                                    .append(
                                          $("<a>")
                                                .attr("href",
                                                      "#")
                                                .addClass(
                                                      "button purple bokdBtn")
                                                .attr(
                                                      "data-no",
                                                      movie.mv_code)
                                                .attr("title",
                                                      "영화 예매하기").attr(
                                                            "data-no",
                                                            movie.mv_code).attr("onclick",
                                                                  "sendToReservation(" + movie.mv_code + ")")
                                                .text("예매"),
                                          $("<a>")
                                                .attr("href",
                                                      "#")
                                                .addClass(
                                                      "button purple img splBtn")
                                                .attr(
                                                      "data-no",
                                                      movie.mv_code).attr("onclick",
                                                            "datacode(" + movie.mv_code + ")")
                                                .text("상세정보")))

            );

      // 영화 항목을 목록에 추가
         
      movieListContainer.append(listItem);


   }

   //#포스터 클릭시 mv_code반환 디테일작업시 연계
   function datacode(mv_code) {

      var datacode = mv_code;

      

      sendToController(datacode); 

   }
   //# 큰영화사진,포스터,상세정보,영화제목 클릭시 디테일로 이동
   function sendToController(datacode) {
       window.location.href = "/detail?mv_code=" + datacode;
   }
   
   //# 예매 클릭시 예약페이지로 이동 
   function sendToReservation(datacode) {
       window.location.href = "/reservation?mv_code=" + datacode;
   }
</script>

</head>
<body>
   <%@ include file="menu-black.jsp"%>
   
   <div id="visual_top" class="visual_top visual_movie_home"
   >

   <div class="inner">

      <div class="owl-item cloned" style="width: 1920px;">
         <div class="item" id="videoContainer"
            data-video="https://caching2.lottecinema.co.kr/lotte_image/2023/MountCHIAK/MountCHIAK_1280720.mp4">


            <img
               src="https://caching2.lottecinema.co.kr/lotte_image/2023/MountCHIAK/MountCHIAK_1920420.jpg"
               alt="치악산 9월 13일 극장 대개봉 15세이상관람가 충격적 괴담의 실체가 밝혀진다 윤균상 김예원" data-no="20225824" 
               onclick="datacode(20225824)"> 
                                 
         </div>
      </div>
   </div>
</div>

<!-- 비디오 플레이어를 위한 비디오 태그 -->
<video id="videoPlayer" controls style="display: none;">
   <source id="videoSource" src="" type="video/mp4">
</video>



<div class="container">



   <!-- contents 여기서부터 사용 -->
   <div id="contents" class="location-fixed tab-fixed">
      <!-- inner-wrap -->
      <div class="inner-wrap">
         <h2 class="tit"></h2>


         <!-- movie-list-util -->
         <div class="movie-list-util mt40">

            <!-- 개봉작 메뉴바 -->
            <div class="topSort" style="display: block;">
               

               <div class="onair-condition">

                  <a href="javascript:void(0)" class="btn-onair btnOnAir" onclick=""
                     data-sort="4" id="btnMovie"><h3>현재 개봉작</h3></a>
               </div>
               <div class="onair-condition">

                  <a href="javascript:void(0)" class="btn-onair btnOnAir" onclick=""
                     data-sort="5" id="btnMovie1"><h3>상영 예정작</h3></a>
               </div>


            </div>
            
            <!--정렬순-->

            <div class="movie-search">

               <a class="list123" href="javascript:void(0)" onclick=""
                  data-sort="1" role="button" id="sort1">예매순</a> <a class="list123"
                  href="javascript:void(0)" onclick="" data-sort="2" role="button"
                  id="sort2">누적관객순</a> <a class="list123" href="javascript:void(0)"
                  onclick="" data-sort="3" role="button" id="sort3">개봉일순</a>

            </div>
         </div>
         <!--// movie-list-util -->



         <!-- 영화등록될 div 태그-->
         <div class="movie-list">
            <ol class="list" id="movieList">

               <!--    1번영화시작 -->

            </ol>  <!-- 영화등록 끝 태그 -->
         </div>

      </div>
      
   </div>  <!--  /contents -->


   <div class="btn-more v1" id="addMovieDiv" style="">
      <button type="button" class="btn" id="btnAddMovie">
         더보기 <i class="iconset ico-btn-more-arr"></i>
      </button>
   </div>

</div>


<div class="contents">
   <div id="main_section04" class="section main-info">

      <h2 class="tit">드림박스 안내</h2>

      <div class="info-special">
         <div class="wrapper1">

            <div class="special-cell imax">
               <img src="./img/mhome/imax.png" class="left"
                  style="width: 650px; height: 315px; border-radius: 30px;"> <span
                  class="textt">IMAX 궁극의 몰입감</span>
            </div>

            <div class="special-cell 4dx">
               <img src="./img/mhome/4dx.png" class="right"
                  style="width: 315px; height: 315px; margin-left: 100px; border-radius: 30px;">
               <span class="textr">4DX 특별한 오감체험 </span>
            </div>

         </div>
      </div>

   </div>
</div>
<!-- info-notice 공지 한줄-->




<div id="main_section04" class="section main-info">

   <div class="contents">
      <div class="main-info">
         <div class="info-notice">
            <div class="wrap">
               <p class="tit">DREAMBOX</p>
               <p class="link">
                  <a href="/support/notice/detail?artiNo=10954&bbsNo=9"
                     title="공지사항 상세보기"> <strong> [공지] </strong> [GS&amp;POINT] 시스템
                     정기 점검 안내 &#40;9/15&#41;
                  </a>
               </p>
            </div>
         </div>
      </div>
   </div>
   <!--// info-notice -->

</div>




<!-- footer -->
<footer id="footer">
   <!-- footer-top -->
   <div class="footer-top">
      <div class="inner-wrap">
         <ul class="fnb">
            <li><a href="/megaboxinfo" title="회사소개 페이지로 이동">회사소개</a></li>
            <li><a href="/recruit" title="인재채용 페이지로 이동">인재채용</a></li>
            <li><a href="/socialcontribution" title="사회공헌 페이지로 이동">사회공헌</a></li>
            <li><a href="/partner" title="제휴/광고/부대사업문의 페이지로 이동">제휴/광고/부대사업문의</a></li>
            <li><a href="/support/terms" title="이용약관 페이지로 이동">이용약관</a></li>
            <li><a href="/support/lcinfo" title="위치기반서비스 이용약관 페이지로 이동">위치기반서비스
                  이용약관</a></li>
            <li class="privacy"><a href="/support/privacy"
               title="개인정보처리방침 페이지로 이동">개인정보처리방침</a></li>
            <li><a href="https://jebo.joonganggroup.com/main.do"
               target="_blank" title="윤리경영 페이지로 이동">윤리경영</a></li>
         </ul>


      </div>
   </div>



   <!--// footer-top -->


   <!-- footer-bottom -->
   <div class="footer-bottom">
      <div class="inner-wrap">
         <div class="ci" style="width: 150px; height: 50px;"></div>

         <div class="footer-info">
            <div>
               <address>서울특별시 강남구 에스코빌딩 6층</address>
               <p>ARS 1000-0000</p>
            </div>
            <p>2조</p>
            <p>&middot; 프로젝트용 홈페이지</p>
            <p>&middot; 사업자등록번호 111-111-1111</p>
            <p>&middot; 통신판매업신고번호 1111</p>
            <p class="copy">COPYRIGHT &copy; MegaboxJoongAng, Inc. All
               rights reserved</p>
         </div>

         <div class="footer-sns">
            <a href="https://www.youtube.com/onmegabox" target="_blank"
               title="DREAMBOX 유튜브 페이지로 이동"> <i class="iconset ico-youtubeN">유튜브</i></a>
            <a href="http://instagram.com/megaboxon" target="_blank"
               title="DREAMBOX 인스타그램 페이지로 이동"> <i
               class="iconset ico-instagramN">인스타그램</i></a> <a
               href="https://www.facebook.com/megaboxon" target="_blank"
               title="DREAMBOX 페이스북 페이지로 이동"> <i class="iconset ico-facebookN">페이스북</i></a>
            <a href="https://twitter.com/megaboxon" title="DREAMBOX 트위터 페이지로 이동">
               <i class="iconset ico-twitterN">트위터</i>
            </a>
         </div>
      </div>
   </div>
   <!--// footer-bottom -->

</footer>
<!--// footer -->
   
   
</body>
</html>