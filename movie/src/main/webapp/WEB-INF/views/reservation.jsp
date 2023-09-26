<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DREAM :: RESERVATION</title>
<link rel="stylesheet" href="./css/mselect.css">
<script src="./js/jquery-3.7.0.min.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	let mv_code = $("#pmv_code").val();
	 $.ajax({
         url: "./mv_code",
         type: "post",
         dataType: "json",
         data: {mv_code : mv_code},
         success: function(data){
        	 for(let i = 0; i < 10; i++) {
        		 if(data.j_movielist.mv_name == $(".movie"+i).children(".movie_list_all").text()) {
        			 $(".movie"+i).addClass("mSelBlack");
        			 $(".selected_poster").html('<img src="'+data.j_movielist.mv_poster+'">');
                     $(".selected_movie").text(data.j_movielist.mv_name);
                     $(".sMovie").text(data.j_movielist.mv_name);
                     $(".selected_genre").text(data.j_movielist.mv_genre);
                     $(".selected_movie_title").html('<img src="'+data.j_movielist.mv_gradeimg+'">  '+ data.j_movielist.mv_name);
                     $(".sImg").html('<img src="'+data.j_movielist.mv_gradeimg+'">');
                     
                     $(".selected_poster img").css("width", "100%");   
                     $(".selected_poster img").css("height", "100%");
                     
                     let gradeBox = '';
                     /* 관람등급 안내 */
                     if (data.j_movielist.mv_grade === "15세이상관람가") {
                        $(".selected_grade").text("15세 이상 관람가");
                        gradeBox += "<div class='sGrade_title'>본 영화는 <span style='color:#DD7430'>[15세 이상 관람가]</span>입니다.</div>";
                        gradeBox += "<div>만 15세 미만 고객님은 만 19세 이상 성인 보호자 동반 시 관람이 가능합니다. 연령 확인 불가 시 입장이 제한될 수 있습니다.</div>";
                     } else if (data.j_movielist.mv_grade === "12세이상관람가") {
                        $(".selected_grade").text("12세 이상 관람가");
                        gradeBox += "<div class='sGrade_title'>본 영화는 <span style='color:#E9B72F'>[12세 이상 관람가]</span>입니다.</div>";
                        gradeBox += "<div>만 12세 미만 고객님은 만 19세 이상 성인 보호자. 동반 시 관람이 가능합니다. 연령 확인 불가 시 입장이 제한될 수 있습니다.</div>";
                     } else if (data.j_movielist.mv_grade === "청소년관람불가") {
                        $(".selected_grade").text("청소년 관람불가");
                        gradeBox += "<div class='sGrade_title'>본 영화는 <span style='color:#D92B36'>[청소년 관람불가]</span>입니다.</div>";
                        gradeBox += "<div>만 18세 미만의 고객님(영, 유아 포함)은 부모님 또는 성인 보호자를 동반하여도 관람이 불가합니다. 영화 관람 시, 반드시 신분증을 지참하여 주시기 바랍니다. 연령 확인 불가 시 입장이 제한될 수 있습니다.</div>";
                     } else if (data.j_movielist.mv_grade === "전체관람가") {
                        $(".selected_grade").text("전체 관람가");
                        gradeBox += "<div class='sGrade_title'>본 영화는 <span style='color:#249D57'>[전체 관람가]</span>입니다.</div>";
                     }
                     
                     $(".sGrade").html(gradeBox);
        		 }
        	 }
         },
         error: function(error){
            alert("Error");
         }
      });
 });
   $(function(){
      $(".2D").addClass("mHide");
      $(".IMAX").addClass("mHide");
      $(".4DX").addClass("mHide");
 
      let final_date = '';
      let final_th_kind = '';
      let final_ms_idx = '';

      /* 영화 선택 */
      $(document).on("click", ".movie_list_all", function(){
         
         $(".2D").addClass("mHide");
         $(".IMAX").addClass("mHide");
         $(".4DX").addClass("mHide");
         $(".btn-primary").removeClass("btn_blue");
         
         $(".theater_kind").text('');
         $(".reset").text('');
         $(".selected_sch").removeClass("mSelBold");
         let selmovie = $(this).text();
         
         $(".select_date_button").removeClass("mSelBlack");
         $(".mSelBlack").removeClass("mSelBlack");
         $(this).addClass("mSelBlack");
         
         
         $.ajax({
            url: "./selmovie",
            type: "post",
            data: {selmovie : selmovie},
            dataType: "json",
            success: function(m){
               $(".selected_poster").html('<img src="'+m.movielist.mv_poster+'">');
               $(".selected_movie").text(m.movielist.mv_name);
               $(".sMovie").text(m.movielist.mv_name);
               $(".selected_genre").text(m.movielist.mv_genre);
               $(".selected_movie_title").html('<img src="'+m.movielist.mv_gradeimg+'">  '+ m.movielist.mv_name);
               $(".sImg").html('<img src="'+m.movielist.mv_gradeimg+'">');
               
               $(".selected_poster img").css("width", "100%");   
               $(".selected_poster img").css("height", "100%");   
               
               let gradeBox = '';
               /* 관람등급 안내 */
               if (m.movielist.mv_grade === "15세이상관람가") {
                  $(".selected_grade").text("15세 이상 관람가");
                  gradeBox += "<div class='sGrade_title'>본 영화는 <span style='color:#DD7430'>[15세 이상 관람가]</span>입니다.</div>";
                  gradeBox += "<div>만 15세 미만 고객님은 만 19세 이상 성인 보호자 동반 시 관람이 가능합니다. 연령 확인 불가 시 입장이 제한될 수 있습니다.</div>";
               } else if (m.movielist.mv_grade === "12세이상관람가") {
                  $(".selected_grade").text("12세 이상 관람가");
                  gradeBox += "<div class='sGrade_title'>본 영화는 <span style='color:#E9B72F'>[12세 이상 관람가]</span>입니다.</div>";
                  gradeBox += "<div>만 12세 미만 고객님은 만 19세 이상 성인 보호자. 동반 시 관람이 가능합니다. 연령 확인 불가 시 입장이 제한될 수 있습니다.</div>";
               } else if (m.movielist.mv_grade === "청소년관람불가") {
                  $(".selected_grade").text("청소년 관람불가");
                  gradeBox += "<div class='sGrade_title'>본 영화는 <span style='color:#D92B36'>[청소년 관람불가]</span>입니다.</div>";
                  gradeBox += "<div>만 18세 미만의 고객님(영, 유아 포함)은 부모님 또는 성인 보호자를 동반하여도 관람이 불가합니다. 영화 관람 시, 반드시 신분증을 지참하여 주시기 바랍니다. 연령 확인 불가 시 입장이 제한될 수 있습니다.</div>";
               } else if (m.movielist.mv_grade === "전체관람가") {
                  $(".selected_grade").text("전체 관람가");
                  gradeBox += "<div class='sGrade_title'>본 영화는 <span style='color:#249D57'>[전체 관람가]</span>입니다.</div>";
               }
               
               $(".sGrade").html(gradeBox);
               
            },
            error: function(error){
               alert("Error");
            }
         });
      });
      
      /* 전체 극장 선택 */
      $(document).on("click", ".theater_all", function(){
         $(".selected_area").text("");
         $(".selected_kind").text("");
         $(".selected_city").text("");
         $(".theater_special_list").html("");
         $(".btn-primary").removeClass("btn_blue");
         
         $(".2D").addClass("mHide");
         $(".IMAX").addClass("mHide");
         $(".4DX").addClass("mHide");
         
         $(".theater_all").removeClass("sp_st");
         $(".theater_all").addClass("all_st");
         $(".theater_special").removeClass("all_st");
         $(".theater_special").addClass("sp_st");
         
         
         $.ajax({
            url: "./seltheater",
            type: "post",
            dataType: "json",
            success: function(m){
               
               let tlist = '';
               for (let i = 0; i < m.tlist.length; i++) {
                  tlist += "<div class='theater_list_all'>"+m.tlist[i].th_area
                  tlist += "<span class='city"+i+"'></span></div>";
               }
               $(".theater_list").html(tlist);
               $(".city0").text(" ("+m.tlist[0].seoul+")");
               $(".city1").text(" ("+m.tlist[0].incheon+")");
               $(".city2").text(" ("+m.tlist[0].gangwon+")");
               $(".city3").text(" ("+m.tlist[0].daejeon+")");
               $(".city4").text(" ("+m.tlist[0].busan+")");
               $(".city5").text(" ("+m.tlist[0].gwangju+")");
               
            },
            error: function(error){
               alert("Error");
            }
         });
      });
      
      /* 지역 선택 */
      $(document).on("click", ".theater_list_all", function(){
         $(".selected_area").text("");
         $(".selected_kind").text("");
         $(".selected_city").text("");
         $(".theater_kind").text('');
         $(".reset").text('');
         $(".select_date_button").removeClass("mSelBlack");
         $(".selected_sch").removeClass("mSelBold");
         $(".selected_list").hide();
         $(".btn-primary").removeClass("btn_blue");
         
         $(".2D").addClass("mHide");
         $(".IMAX").addClass("mHide");
         $(".4DX").addClass("mHide");
         
          let selarea = $(this).text().slice(0,-4);
          
          $(".theater_list_all").removeClass("mSelGray");
          $(this).toggleClass("mSelGray");
          
          $(".selected_area").text(selarea);
          $(".selected_kind").text("");
      
          $.ajax({
              url: "./selarea",
              type: "post",
              data: {selarea : selarea},
              dataType: "json",
              success: function(c){
                  let city = '';
                  let selcity = '';
                  for (let i = 0; i < c.selcitylist.length; i++) {
                      selcity = c.selcitylist[i].th_city;
                      city += "<div class='theater_list_city'>" + selcity + "</div>";
                  }
                  $(".theater_special_list").html(city);
              },
              error: function(error){
                  alert("Error");
              }
          });
      });
      
      /* 일반 도시 선택 */
      $(document).on("click", ".theater_list_city", function(){
         $(".theater_kind").text('');
         $(".reset").text('');
          let selectcity = $(this).text();
          
         $(".2D").addClass("mHide");
         $(".IMAX").addClass("mHide");
         $(".4DX").addClass("mHide");
         $(".select_date_button").removeClass("mSelBlack");
         $(".selected_sch").removeClass("mSelBold");
         $(".selected_list").hide();
         $(".btn-primary").removeClass("btn_blue");
          
         $(".theater_list_city").removeClass("mSelBlack");
         $(this).toggleClass("mSelBlack");
         
          $(".selected_city").text("DREAMBOX " + selectcity + "점");
          $(".selected_kind").text("");
          $("#sp_kind").val("");
      });
      
      /* 특별관 선택 */
      $(document).on("click", ".theater_special", function(){
         $(".selected_area").text("");
         $(".selected_kind").text("");
         $(".selected_city").text("");
         $(".theater_kind").text('');
         $(".2D").addClass("mHide");
         $(".IMAX").addClass("mHide");
         $(".4DX").addClass("mHide");
         $(".select_date_button").removeClass("mSelBlack");
         $(".btn-primary").removeClass("btn_blue");
         
         $(".theater_special_list").html("");
         let list = "<div class='special_list_all'>4DX (21)</div>";
         list += "<div class='special_list_all'>IMAX (9)</div>";
         $(".theater_list").html(list);
         
         $(".theater_all").removeClass("all_st");
         $(".theater_all").addClass("sp_st");
         $(".theater_special").removeClass("sp_st");
         $(".theater_special").addClass("all_st");
         
         $(".special_list_all").click(function(){
            $(".selected_area").text("");
            $(".selected_kind").text("");
            $(".selected_city").text("");
            $(".selected_sch").removeClass("mSelBold");
            $(".selected_list").hide();
            $(".reset").text('');
            $(".2D").addClass("mHide");
            $(".IMAX").addClass("mHide");
            $(".4DX").addClass("mHide");
            $(".select_date_button").removeClass("mSelBlack");
            
            $(".special_list_all").removeClass("mSelGray");
            $(this).toggleClass("mSelGray");
            
            let selimax = $(this).text().slice(0,-4);
            if (selimax === "IMAX") {
               selimax = 4;
            } else {
               selimax = 3;
            }
            $(".selected_area").text('');
            $(".selected_city").text('');
            $.ajax({
               url: "./selimax",
               type: "post",
               data: {selimax : selimax},
               dataType: "json",
               success: function(imax){
                  
                     $("#sp_kind").val(selimax);
                     let imaxlist = '';
                     for (let i = 0; i < imax.imaxlist.length; i++) {
                        imaxlist += "<div class='special_list_city'>" + imax.imaxlist[i].th_city + "</div>";
                     }
                     $(".theater_special_list").html(imaxlist);
               },
               error: function(error){
                  alert("Error");
               }
            });
         });
      });
      
      /* 특별관 선택 후 도시 선택 */
      $(document).on("click", ".special_list_city", function(){
         
         $(".2D").addClass("mHide");
         $(".IMAX").addClass("mHide");
         $(".4DX").addClass("mHide");
         $(".reset").text('');
         $(".select_date_button").removeClass("mSelBlack");
         $(".selected_sch").removeClass("mSelBold");
         $(".selected_list").hide();
         $(".btn-primary").removeClass("btn_blue");
         
         $(".theater_kind").text('');
         let selectkind = $("#sp_kind").val();
         let selectimax = $(this).text();
         
         $(".special_list_city").removeClass("mSelBlack");
         $(this).toggleClass("mSelBlack");
         
         $.ajax({
              url: "./selspecial",
              type: "post",
              data: {selectimax : selectimax},
              dataType: "json",
              success: function(m){
                 
                 $(".selected_area").text(m.selspecial);
               $(".selected_city").text("DREAMBOX "+selectimax+"점");
               if (selectkind ==='3') {
                  $(".selected_kind").text("  |  4DX");
               }
               if (selectkind ==='4') {
                  $(".selected_kind").text("  |  IMAX");
               }
              },
              error: function(error){
                  alert("Error");
              }
          });
      });

      /* 도시 선택 후 스케줄 가져오기 */
      $(document).on("click", ".select_date_button", function(){
    	  $(".selected_sch").removeClass("mSelBold");
          $(".selected_list").hide();
          $(".btn-primary").removeClass("btn_blue");
         let selYear = $(this).prevAll(".year").html();
         let selMonth = $(this).prevAll(".month").html();
         let selDate = $(this).text();
         let selDay = selDate.slice(1);
         let selDayOfWeek = selDate.slice(0,1);
         /* 이거 */
         $(".selected_date").text(selYear+"년 "+selMonth+"월 "+selDay+"일 ("+selDayOfWeek+")");
         $(".sDate").text(selYear+"년 "+selMonth+"월 "+selDay+"일 ("+selDayOfWeek+")");
         final_date = selYear+selMonth+selDay;
         
         
         $(".select_date_button").removeClass("mSelBlack");
         $(this).toggleClass("mSelBlack");
         /* $(".reset").text(''); */
         
          let selFilm = $(".selected_movie").text();// 영화 선택
          let selCity = $(".selected_city").text();// 도시 선택
          selCity = selCity.slice(9, selCity.length - 1);// 도시 이름만 가져오기
         let selKind = $("#sp_kind").val();// 상영관 종류
         
           if(selFilm === "") {
              alert("영화를 선택해주세요.");
              $(".select_date_button").removeClass("mSelBlack");
           } else if (selCity === "") {
              alert("도시를 선택해주세요.");
              $(".select_date_button").removeClass("mSelBlack");
           } else {
              $.ajax({
                  url: "./timetable",
                  type: "post",
                  data: {selFilm:selFilm, selCity:selCity, selKind:selKind},
                  dataType: "json",
                  success: function(m){
                     
                     if(selKind === "") {
                        // 일반 영화 선택
                        if(m.movietime.length != 0) {
                           
                              $(".2D").removeClass("mHide");
                              $(".IMAX").removeClass("mHide");
                              $(".4DX").removeClass("mHide");
                           
                             let box = "";
                             let box2 = "";
                             let box3 = "";
                             box += "<div class='selected_th_kind'>2D</div>";
                             box2 += "<div class='selected_th_kind'>4DX</div>";
                             box3 += "<div class='selected_th_kind'>IMAX</div>";
                             
                                for (let i = 0; i < m.movietime.length; i++) {
                                 if (m.movietime[i].th_kind == '1' || m.movietime[i].th_kind == '2') {
                                       box += "<div class='selected_sch'>";
                                       box += "<div class='start_time'>"+m.movietime[i].ms_stime+"</div>";
                                       box += "<div class='last_time'>~ "+m.movietime[i].ms_etime+"</div>";
                                       box += "<div class='seats'><span class='blue'>"+m.movietime[i].countseat + "</span> / " +m.movietime[i].th_seatcnt+"</div>";
                                       box += "<div class='screen_num'>"+m.movietime[i].th_kind+"관</div>";
                                       box += "<input id='ms_idx' name='ms_idx' type='hidden' value='"+ m.movietime[i].ms_idx +"'>"
                                       box += "</div>";
                                 } else if (m.movietime[i].th_kind == '3') {
                                       box2 += "<div class='selected_sch'>";
                                       box2 += "<div class='start_time'>"+m.movietime[i].ms_stime+"</div>";
                                       box2 += "<div class='last_time'>~ "+m.movietime[i].ms_etime+"</div>";
                                       box2 += "<div class='seats'><span class='blue'>"+m.movietime[i].countseat + "</span> / " +m.movietime[i].th_seatcnt+"</div>";
                                       box2 += "<div class='screen_num'>"+m.movietime[i].th_kind+"관</div>";
                                       box2 += "<input id='ms_idx' name='ms_idx' type='hidden' value='"+ m.movietime[i].ms_idx +"'>"
                                       box2 += "</div>";
                                 } else if (m.movietime[i].th_kind == '4') {
                                       box3 += "<div class='selected_sch'>";
                                       box3 += "<div class='start_time'>"+m.movietime[i].ms_stime+"</div>";
                                       box3 += "<div class='last_time'>~ "+m.movietime[i].ms_etime+"</div>";
                                       box3 += "<div class='seats'><span class='blue'>"+m.movietime[i].countseat + "</span> / " +m.movietime[i].th_seatcnt+"</div>";
                                       box3 += "<div class='screen_num'>"+m.movietime[i].th_kind+"관</div>";
                                       box3 += "<input id='ms_idx' name='ms_idx' type='hidden' value='"+ m.movietime[i].ms_idx +"'>"
                                       box3 += "</div>";
                                    }
                              }
                                if (box === "<div class='selected_th_kind'>2D</div>") {box = ''; $(".2D").addClass("mHide")};
                                if (box2 === "<div class='selected_th_kind'>4DX</div>") {box2 = ''; $(".4DX").addClass("mHide")}
                                 if (box3 === "<div class='selected_th_kind'>IMAX</div>") {box3 = ''; $(".IMAX").addClass("mHide")}
                                $(".2D").html(box);
                                $(".4DX").html(box2);
                                $(".IMAX").html(box3);
                        } else {// 일반 영화 끝
                          
                          $(".4DX").html("<div class='mcomment' style='margin-top: 110px;'><img src='./img/information.png' style='width: 40px;'><br>선택한 극장에 상영 가능한 시간이 없습니다.<br>다시 선택해 주세요.</div>")
                        }
                     } else {// 스페셜관 선택
                        if(m.specialtime.length != 0) {
                           
                              $(".2D").removeClass("mHide");
                              $(".4DX").removeClass("mHide");
                              $(".IMAX").removeClass("mHide");
                           
                             let box4DX = "";
                             let boxIMAX = "";
                             
                                for (let i = 0; i < m.specialtime.length; i++) {
                                   if (m.specialtime[i].th_kind === 3) {
                                    box4DX += "<div class='selected_th_kind'>4DX</div>";
                                    box4DX += "<div class='selected_sch'>";
                                    box4DX += "<div class='start_time'>"+m.specialtime[i].ms_stime+"</div>";
                                    box4DX += "<div class='last_time'>~ "+m.specialtime[i].ms_etime+"</div>";
                                    box4DX += "<div class='seats'><span class='blue'>"+m.specialtime[i].countseat + "</span> / " +m.specialtime[i].th_seatcnt+"</div>";
                                    box4DX += "<div class='screen_num'>"+m.specialtime[i].th_kind+"관</div>";
                                    box4DX += "<input id='ms_idx' name='ms_idx' type='hidden' value='"+ m.specialtime[i].ms_idx +"'>"
                                    box4DX += "</div>";
                                } else {
                                   boxIMAX += "<div class='selected_th_kind'>IMAX</div>";
                                   boxIMAX += "<div class='selected_sch'>";
                                   boxIMAX += "<div class='start_time'>"+m.specialtime[i].ms_stime+"</div>";
                                   boxIMAX += "<div class='last_time'>~ "+m.specialtime[i].ms_etime+"</div>";
                                   boxIMAX += "<div class='seats'><span class='blue'>"+m.specialtime[i].countseat + "</span> / " +m.specialtime[i].th_seatcnt+"</div>";
                                   boxIMAX += "<div class='screen_num'>"+m.specialtime[i].th_kind+"관</div>";
                                   boxIMAX += "<input id='ms_idx' name='ms_idx' type='hidden' value='"+ m.specialtime[i].ms_idx +"'>"
                                   boxIMAX += "</div>";
                                }
                                   
                              }
                                if (box4DX === "") {box4DX = ''; $(".4DX").addClass("mHide")}
                                 if (boxIMAX === "") {boxIMAX = ''; $(".IMAX").addClass("mHide")}
                                $(".2D").addClass("mHide");
                                $(".4DX").html(box4DX);
                                $(".IMAX").html(boxIMAX);
                        } else {
                           $(".4DX").html("<div class='mcomment' style='margin-top: 110px;'><img src='./img/information.png' style='width: 40px;'><br>선택한 극장에 상영 가능한 시간이 없습니다.<br>다시 선택해 주세요.</div>")
                        }
                     }// 스페셜관 선택 끝

              },
              error: function(error){
                  alert("Error");
              }
          });//ajax 끝
          }
   });

      /* 스케줄 선택 */
      $("body").on("click", ".selected_sch", function(){
         
         let selScreen = $(this).siblings(".selected_th_kind").html();
         let selStime = $(this).children(".start_time").html();
         let selLtime = $(this).children(".last_time").html();
         let screenNum = $(this).children(".screen_num").html();
         let sCity = $(".selected_city").text();
        
         
         $(".selected_screen").text(selScreen);
         $(".selected_time").text("  |  "+selStime+selLtime);
         $(".sTime").text(selStime+selLtime);
         
         $(".sTheater").text(sCity + " " + screenNum);
         final_th_kind = screenNum.slice(0,1);
         final_ms_idx = $(this).children("#ms_idx").val();
         $(".selected_sch").removeClass("mSelBold");
         $(this).toggleClass("mSelBold");
         
         $(".selected_list").show();
         $(".btn-primary").addClass("btn_blue");
      });
      
      // 모달 저장버튼
      $("#btn_save").click(function(){
         let form = $('<form></form>');
         form.attr("action","./reservation");
         form.attr("method", "post");
         form.append($("<input>", {type:"hidden", name:"final_date", value : final_date}));//value에 변수 안 만들고 바로 넣어도 됨
         form.append($("<input>", {type:"hidden", name:"final_th_kind", value : final_th_kind}));//value에 변수 안 만들고 바로 넣어도 됨
         form.append($("<input>", {type:"hidden", name:"final_ms_idx", value : final_ms_idx}));//value에 변수 안 만들고 바로 넣어도 됨
         form.appendTo("body");
         form.submit();
      });
   });
   
   // theater_count
   $(document).ready(function(){
      $(".city0").text("("+${theaterlist[0].seoul}+")");
      $(".city1").text("("+${theaterlist[0].incheon}+")");
      $(".city2").text("("+${theaterlist[0].gangwon}+")");
      $(".city3").text("("+${theaterlist[0].daejeon}+")");
      $(".city4").text("("+${theaterlist[0].busan}+")");
      $(".city5").text("("+${theaterlist[0].gwangju}+")");
   });
   
   // 날짜
   $(document).ready(function(){
      let date = new Date();// 오늘 날짜 뽑기
      let year = date.getFullYear();
      let month = (date.getMonth() + 1).toString().padStart(2, '0');
      let reserveDate = $(".select_date");
      let weekOfDay = ["일", "월", "화", "수", "목", "금", "토"];// 요일 뽑기
      
      //주말 색 변경
      const holidays = [0];
      const saturdays = [6];
      
      let todayYearLabel = $("<div>").addClass("year").text(year);
      let todayMonthLabel = $("<div>").addClass("month").text(month);
      reserveDate.prepend(todayYearLabel, todayMonthLabel); // 오늘 날짜 위에 추가
      
      for (let i = 0; i < 30; i++){
         
         let currentDate = new Date(year, month - 1, date.getDate() + i);
           let dayOfMonth = currentDate.getDate();
           
           // 월이 바뀔 때마다 월 표시
           if (dayOfMonth === 1) {
              let monthName = currentDate.getMonth() + 1;
              let yearName = currentDate.getFullYear();
              if(monthName < 10){
                 monthName = "0" + monthName;
              }
               let yearLabel = $("<div>").addClass("year").text(yearName);
               let monthLabel = $("<div>").addClass("month").text(monthName);
               reserveDate.append(yearLabel, monthLabel);
           }
           
         
         // 해당 태그로 클래스 추가하기
         let button = $("<button>").addClass("select_date_button").attr("name", "date");
         let spanWeekOfDay = $("<span>").addClass("week");
         let spanDay = $("<span>").addClass("day");
         
         // 배열 이용해서 요일 뽑아내기
         let dayOfWeek = weekOfDay[currentDate.getDay()];
         
         // 일요일 클래스 추가
         if (holidays.includes(currentDate.getDay())) {
             button.addClass("holiday");
         }
         // 토요일 클래스 추가
         if (saturdays.includes(currentDate.getDay())) {
             button.addClass("saturday");
         }
         
         // 요일 넣기
           spanWeekOfDay.text(dayOfWeek);
           button.append(spanWeekOfDay);
           
           // 날짜 넣기
           spanDay.text(dayOfMonth);
           button.append(spanDay);
           
           reserveDate.append(button);
      }
   });
</script>
<script type="text/javascript">
	// 모달
   $(function(){
	  var sessionId = "<%=session.getAttribute("id") %>"
      $(".btn-primary").click(function(){
    	  if(sessionId === "null" || sessionId ==="") {
    		  alert("로그인이 필요한 서비스입니다.")
    		  location.href="./login";
    	  } else {
    		  let selectedScreen = $(".selected_time").text();
    	         if (selectedScreen == null || selectedScreen === '') {
    	        	 alert("상영시간표를 선택해 주세요.");
    	         } else {
    	         $("#staticBackdrop").modal("show");
    	         }
    	  }
      })
   });
</script>
</head>
<body>
   <%@ include file="menu.jsp"%>

   <!-- 값 가져오기 용 -->
   <input id="sp_kind" name="sp_kind" type="hidden" value="">
   <input id="pmv_code" name="pmv_code" type="hidden" value="${pmv_code}">

   <div class="mselect">
   <h2>RESERVATION</h2>
      <!-- 영화 선택 -->
      <div class="select_movie">
         <div class="select_title">영화</div>
         <div class="select_content">
            <div class="movie_all">전체</div>
            <div class="movie_list">
               <c:forEach begin="0" end="${fn:length(movielist) - 1}" var="row">
                  <div class="movie_list_box movie${row}">
                     <div class="movie_list_img"><img src="${movielist[row].mv_gradeimg}"></div>
                     <div class="movie_list_all">${movielist[row].mv_name}</div>
                  </div>
               </c:forEach>
            </div>

            <!-- 선택한 영화 -->
            <div class="movie_selected">
               <div class="selected_poster">
                  <img src="./img/logo2.png" style="padding: 5px; box-sizing: border-box;">
               </div>
               <div class="selected_info">
                  <div class="selected_title">MOVIE</div>
                  <div class="selected_movie"></div>
                  <div class="selected_genre"></div>
                  <div class="selected_grade"></div>
               </div>
            </div>
         </div>
      </div>

      <!-- 극장 선택 -->
      <div class="select_theater">
         <div class="select_title">극장</div>
         <div class="select_content">
            <div class="theater_all all_st">전체</div>
            <div class="theater_special sp_st">특별관</div>
            <div class="theater_list">
               <!-- <div class="special_list_all"></div> -->
               <c:forEach begin="0" end="${fn:length(theaterlist) - 1 }" var="row">
                  <div class='theater_list_all'>${theaterlist[row].th_area} <span class="city${row}"></span></div>
               </c:forEach>
            </div>
            <div class="theater_special_list">
               <!-- 도시를 누르면 지역이 나옴 -->
               <!-- <div class="theater_list_city"></div>
               <div class="special_list_city"></div> -->
            </div>

            <!-- 선택한 극장 -->
            <div class="theater_selected">
               <div class="selected_title">THEATER</div>
               <div class="selected_area"></div>
               <div class="selected_kind"></div>
               <div class="selected_city"></div>
            </div>
         </div>
      </div>

      <!-- 날짜 선택 -->
      <div class="select_calendar">
         <div class="select_title" style="margin-bottom: 3px;">날짜</div>
         <div class="select_date">
            <!-- <div class="year"></div>
            <div class="month"></div>
            <button></button> -->
         </div>
      </div>

      <!-- 시간 선택 -->
      <div class="select_time">
         <div class="select_title">시간</div>
         <div class="select_content">
            <div class="selected_movie_title">
               <!-- <img>영화제목 -->
            </div>
            <div class="timetable">
               <div class="2D theater_kind">
               <!--    <div class="selected_th_kind"></div>
                     <div class="selected_sch">
                        <div class="start_time"></div>
                        <div class="last_time"></div>
                        <div class="seats"></div>
                        <div class="screen_num"></div>
                     </div> -->
               </div>
               <div class="4DX theater_kind">
                     <div class="mcomment">
                        <img src="./img/popcorn.png" style="width: 120px;"><br>
                        영화, 극장, 날짜를 선택하시면<br>상영 시간표를 보실 수 있습니다.
                     </div>
               </div>
               <div class="IMAX theater_kind"></div>
            </div>

            <!-- 선택한 시간 -->
            <div class="timetable_selected">
               <div class="selected_title">TIMETABLE</div>
               <div class="selected_list">
                  <div class="selected_date reset"></div>
                  <div class="selected_screen reset"></div>
                  <div class="selected_time reset"></div>
                  <!-- Button trigger modal -->
               </div>
               <button type="button" class="btn btn-primary">NEXT</button>
            </div>
         </div>
      </div>


   </div>

   <!-- Modal -->

   <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
         <!-- 모달 화면 시작 -->
         <div class="modal-content">
            
            <div class="modal-header">
               <h5 class="modal-title" id="staticBackdropLabel" style="color:#A6A6A6; padding-top:3px;">DREAMBOX</h5>
               <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
               <div  style="margin-bottom: 15px;">
                  <div style="font-size:15pt; text-align: center; font-weight: 700; margin:0 0 20px 0; color: #209BF2;">선택하신 예약 내역 안내 🎬</div>
                  <div class="modal_row">
                     <div class="row_title">영     화</div>
                     <div class="sMovie row_content"></div>
                  </div>
                  <div class="modal_row">
                     <div class="row_title">상 영 관</div>
                     <div class="sTheater row_content"></div>
                  </div>
                  <div class="modal_row">
                     <div class="row_title">날     짜</div>
                     <div class="sDate row_content"></div>
                  </div>
                  <div class="modal_row">
                     <div class="row_title">시     간</div>
                     <div class="sTime row_content"></div>
                  </div>
               </div>
               <hr style="border: 0.005em solid #3C3C3C">
               <div class="grade_info">
                  <div class="sImg"></div>
                  <div class="sGrade"></div>
               </div>
            </div>
            
            <div class="modal-footer">
               <button type="button" class="btn-default" data-bs-dismiss="modal">취소</button>
               <button id="btn_save">인원/좌석 선택</button>
            </div>
            
         </div>

      </div>
   </div>
<br>
<br>
<br>
<br>
<br>
<br>
<br><br><br><br><br><br><br>
   <!-- Bootstrap core JS -->
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
   <script src="js/scripts.js"></script>
   <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>

</body>
</html>