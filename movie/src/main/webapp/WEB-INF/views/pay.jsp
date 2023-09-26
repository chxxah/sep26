<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DREAM :: PAY</title>
<script src="./js/jquery-3.7.0.min.js"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<link rel="stylesheet" href="./bootstrapt/css/bootstrap.min.css" />
<link rel="stylesheet" href="css/menu.css" />
<link rel="stylesheet" href="css/pay.css" />

<style>
</style>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<h1 id="title">결제하기</h1>

	<!--
		<form id="rsNum" action="/pay" method="post">
      <input type="hidden" name="rsNum" value="${rsNum}"> 
	 </form>  -->


	<div id="between">
		<div id="movieInfo">
			<br>
			<br> 영화제목 <br>
			<div id="movieName">${tcInfo.mv_name}</div>
			<br> <br> 상영일 <br><div id="date">${date}</div><br> <br>
			상영시각 <br> ${tcInfo.ms_stime} ~ ${tcInfo.ms_etime}<br> <br>
			상영관
			<div id="theaterName">${tcInfo.th_city}${tcInfo.th_kind}관</div>
			<br> <br>좌석정보
			<div id="adult">성인 ${adult}명,</div>
			<div id="youth">청소년 ${youth}명,</div>
			<div id="special">우대 ${special}명</div>
			<br> ${list }
		</div>

		<br>



		<div id=discountList>할인수단</div>

		<!-- 할인쿠폰 버튼 -->
		<button type="button" id="modal_open_btn">할인쿠폰</button>

		<div id="modal">
			<div class="modal_content">
				<div class="modal-header">
					<h2 class="modal-title">할인쿠폰</h2>
				</div>

				<div class="modal-code">
					쿠폰 등록 <input type="text" name="couponCode" id="couponCode"
						placeholder="쿠폰번호 16자리를 입력해주세요">
					<button id="couponCheck">등록</button>
				</div>

				<div class="modal-body">
					<c:forEach items="${couponList}" var="c">
						<c:if test="${not empty c.rs_coupon}">
							<input type="checkbox" class="chk" id="cchk"
								data-coupon="${c.rs_coupon}">
               ${c.rs_cindex} ${c.rs_coupon}<p>
						</c:if>
					</c:forEach>
				</div>
				<div class="modal-foot">
					<button type="button" class="submit_btn" id="modal_submit_btn">적용</button>
					<button type="button" class="cancel_btn" id="modal_close_btn">취소</button>
				</div>

			</div>
			<div class="modal_layer"></div>
		</div>


		<p>

			<!-- 관람권 버튼 -->
			<button type="button" id="modal_open_btn2">관람권</button>
		<div id="modal2">
			<div class="modal_content">
				<div class="modal-header">
					<h2 class="modal-title">관람권</h2>
				</div>

				<div class="modal-code">
					관람권 등록 <input type="text" name="admCode" id="admCode"
						placeholder="관람권번호 12자리를 입력해주세요">
					<button id="admCheck">등록</button>
				</div>

				<div class="modal-body">
					<c:forEach items="${couponList}" var="a">
						<c:if
							test="${not empty a.rs_admission && empty a.rs_aindex && 
				(tcInfo.th_kind == 1 || tcInfo.th_kind == 2) }">
							<input type="checkbox" class="chk" id="achk"
								data-adm="${a.rs_admission}">
               [2D] ${a.rs_admission}<p>
						</c:if>
					</c:forEach>
					<c:forEach items="${couponList}" var="b">
						<c:if
							test="${not empty b.rs_admission && not empty b.rs_aindex && (tcInfo.th_kind == 3 || tcInfo.th_kind == 4)}">
							<input type="checkbox" class="chk" id="achk"
								data-adm="${b.rs_admission}">
               ${b.rs_aindex}${b.rs_admission}<p>
						</c:if>
					</c:forEach>
				</div>

				<div class="modal-foot">
					<button type="button" class="submit_btn" id="modal_submit_btn2">적용</button>
					<button type="button" class="cancel_btn" id="modal_close_btn2">취소</button>
				</div>
			</div>
			<div class="modal_layer"></div>
		</div>

		<p>


			<!-- 포인트 모달 -->
			<button type="button" id="modal_open_btn3">포인트 조회</button>
		<div id="modal3">
			<div class="modal_content" id="modal_content3">
				<div class="modal-header">
					<h2 class="modal-title">포인트</h2>
				</div>

				<div class="modal-body" id="modal_body3">
					보유 포인트 :  ${havePoint.m_point} 포인트<br> 사용 포인트 :<input type="text"
						name="usePoint" id="usePoint"> 포인트
				</div>
				<div class="modal-foot">
					<button class="submit_btn" id="modal_submit_btn3">적용</button>
					<button class="cancel_btn" id="modal_close_btn3">취소</button>
				</div>

			</div>
			<div class="modal_layer"></div>
		</div>


		<br>
		<br>
		<button id="couponCancel">적용취소</button>
		<br>

	</div>


	<div id=price>
		결제금액 <br>
		<br> <br> 티켓금액 : <span id="ticketDisplay"></span>원 <br>
		할인금액 : <span id="discountDisplay">0</span>원 <br>
		<div id="amount">
			최종 결제금액 : <span id="pamountDisplay"></span>원
		</div>
	</div>


	<div id="payment">결제수단</div>

	<button type="button" class="cancel_btn" id="cancel">결제 취소</button>


	<!-- 일반결제 모달 -->
	<button type="button" id="modal_open_btn4">일반 결제</button>
	<div id="modal4">
		<div class="modal_content" id="modal_content4">
			<div class="modal-header">
				<h2 class="modal-title">일반 결제</h2>
			</div>

			<div id="modal_body4">
				<select id="cardSelect">
					<option value="비씨카드">비씨카드</option>
					<option value="국민카드">국민카드</option>
					<option value="신한카드">신한카드</option>
					<option value="삼성카드">삼성카드</option>
					<option value="롯데카드">롯데카드</option>
					<option value="농협카드">농협카드</option>
					<option value="하나카드">하나카드</option>
					<option value="현대카드">현대카드</option>
					<option value="기업은행카드">IBK기업은행카드</option>
					<option value="우리카드">우리카드</option>
				</select>
				<p>
					<input type="text" id="cardNum"
						placeholder="카드번호 '-'없이 입력(13~16자리)">
				<p>
					<input type="password" id="cardExp" placeholder="카드 유효기간(MM/YY)">
				<p>
					<input type="password" id="cardPw" placeholder="비밀번호 앞2자리">
				<p>
					<input type="text" id="cardBir" placeholder="생년월일 6자리">
				<p>

					<input type="checkbox" class="chk2">결제대행서비스 약관에 모두 동의

					<button class="submit_btn" id="modal_submit_btn4">결제하기</button>
					<button class="cancel_btn" id="modal_close_btn4">취소</button>
			</div>
		</div>
		<div class="modal_layer"></div>
	</div>

	<p>





		<!-- 간편결제 모달 -->
		<button type="button" id="modal_open_btn5">간편 결제</button>
	<div id="modal5">
		<div id="modal_change1">
			<div class="modal_content" id="modal_content5">
				<div class="modal-header">
					<h2 class="modal-title">간편결제</h2>
				</div>
				<div id="container">
					<div class="slide_wrap">
						<div class="slide_box">
							<div class="slide_list clearfix">
								<c:if test="${cardChk != 0}">
									<c:forEach var="card" items="${cardList}" varStatus="loop">
										<div class="slide_content slide${loop.index + 1}">
											<img src="/img/${card.rs_cname}.png" width="300"
												height="auto" /> <br> ${card.rs_cname}<br>
											${card.rs_cnum}
										</div>
									</c:forEach>
								</c:if>
								<div class="slide_content slide${loop.index + 2}">
									<img src="/img/카드 추가하기.png" id="cardAdd" width="300"
										height="auto" /> <br>카드 추가하기
								</div>
							</div>
							<!-- // .slide_list -->
						</div>
						<!-- // .slide_box -->
						<div class="slide_btn_box">
							<img src="/img/left-arrow.png" class="slide_btn_left"> <img
								src="/img/right-arrow.png" class="slide_btn_right">
						</div>
						<!-- // .slide_btn_box -->
						<ul class="slide_pagination"></ul>
						<!-- // .slide_pagination -->
					</div>
					<!-- // .slide_wrap -->
				</div>
				<!-- // .container -->


				<div id="agreeAll">
					<input type="checkbox" class="chk3">전체약관 동의하기
				</div>
				<button class="submit_btn" id="modal_submit_btn5">결제하기</button>
				<button class="cancel_btn" id="modal_close_btn5">취소</button>
			</div>
			<div class="modal_layer"></div>
		</div>



		<!-- 간편결제 카드등록 모달 -->
		<div id="modal_change2">
			<div class="modal_content" id="modal_content6">
				<div class="modal-header">
					<h2 class="modal-title">카드 등록하기</h2>
				</div>
				<div id="modal_body4">
					<select id="cardSelect2">
						<option value="비씨카드">비씨카드</option>
						<option value="국민카드">국민카드</option>
						<option value="신한카드">신한카드</option>
						<option value="삼성카드">삼성카드</option>
						<option value="롯데카드">롯데카드</option>
						<option value="농협카드">농협카드</option>
						<option value="하나카드">하나카드</option>
						<option value="현대카드">현대카드</option>
						<option value="기업은행카드">IBK기업은행카드</option>
						<option value="우리카드">우리카드</option>
					</select>
					<p>

						<input type="text" id="cardNum2"
							placeholder="카드번호 '-'없이 입력(13~16자리)">
					<p>
						<input type="password" id="cardExp2" placeholder="카드 유효기간(MM/YY)">
					<p>
						<input type="password" id="cardPw2" placeholder="비밀번호 앞2자리">
					<p>
						<input type="text" id="cardBir2" placeholder="생년월일 6자리">
					<p>

						<input type="checkbox" class="chk4">전체약관 동의하기
						<button class="submit_btn" type="button" id="modal_submit_btn6">등록하기</button>
						<button type="button" class="cancel_btn" id="modal_close_btn6">취소</button>
				</div>
			</div>
			<div class="modal_layer"></div>
		</div>
	</div>




	<script>
   
   
   /*
   극장 유형
   1:2D
   2:2D
   3:4DX
   4:아이맥스  
   */

   $(document).ready(function() {
	   
	   var date = "${date}";
	    var date2 = date.substring(0, 4) + "년 " + date.substring(4, 6) + "월 " + date.substring(6, 8) + "일";
	    $("#date").text(date2);
	    
   });
  
   var thKind = "${tcInfo.th_kind}";
   var adult; 
   var youth; 
   var special;
   var adultNum = parseInt("${adult}");
   var youthNum = parseInt("${youth}");
   var specialNum = parseInt("${special}");
   var msIdx = "${msIdx}";
   var selectAdm = [];
   var selectCouponList = [];

   function refreshMemList(){
       location.reload();
    }
   

	  
    
       
   
   
     if(thKind == 1 || thKind == 2) {
        adult = 14000;
        youth = 11000;
        special = 8000;
     } else if(thKind == 3) {
        adult = 20000;
        youth = 15000;
        special = 12000;
     } else {
        adult = 22000;
        youth = 17000;
        special = 14000;
     }
     
     var totalAmount = adult*adultNum + youth*youthNum + special*specialNum;
       

     $("#ticketDisplay").text(totalAmount);
      $("#pamountDisplay").text(totalAmount);


      $("#modal_open_btn").click(function() {
         $("#modal").show();
         
      });
      $("#modal_close_btn").click(function() {
         $("#modal").hide();
      });


      $("#modal_open_btn2").click(function() {
         $("#modal2").show();
      });
      $("#modal_close_btn2").click(function() {
         $("#modal2").hide();
      });


      $("#modal_open_btn3").click(function() {
         $("#modal3").show();
      });
      $("#modal_close_btn3").click(function() {
         $("#modal3").hide();
      });


      $("#modal_open_btn4").click(function() {
         $("#modal4").show();
      });
      $("#modal_close_btn4").click(function() {
         $("#modal4").hide();
      });


      $("#modal_close_btn5").click(function() {
         $("#modal_change1").hide();
      });

      $("#modal_close_btn6").click(function() {
         $("#modal_change2").hide();
      });
      
      
      
      
      // 쿠폰, 관람권 체크 박스 //
      const checkboxes = document.querySelectorAll('.chk');
            let checkedCheckboxes = document.querySelectorAll('.chk:checked'); // 초기에 체크된 상태를 가져옴
            
      checkboxes.forEach((checkbox, index) => {
          checkbox.addEventListener('change', function() {
             
        	  // 현재 체크된 체크박스 수 계산
              checkedCheckboxes = document.querySelectorAll('.chk:checked');

              if (checkedCheckboxes.length > adultNum + youthNum + specialNum) {
                  alert("관람 인원수 만큼 할인을 적용할 수 있습니다");
                  this.checked = false;
              }
          });
      });
       
            
    
     

      
      // 쿠폰 유효성 검사, 등록 // 
      $("#couponCheck").click(function() {
          let cCode = parseInt($("#couponCode").val()); // 입력된 usepoint 값을 정수로 파싱
          let cLength = cCode.toString().length;         
          if (cLength != 16) {
               alert("16자리 숫자로 입력하세요.");
           } else{
           $.ajax({
               url: "/couponChk", 
               type: "post",
               data: {"cCode": cCode},
               dataType:"json",
               success: function(result) {
               
                   if (result.result == 1) {
                       alert("쿠폰 등록 완료");
                       refreshMemList();
                   
                   } else {
                       alert("유효하지 않는 코드입니다");
                   }
               },
               error: function() {
                   alert("에러. 다시 시도하세요");
               }
           });           
           }
       });
      
      
      var cDiscount = 0;
      var newAmount = totalAmount - cDiscount;
      var aDiscount = 0;
      var newAmount2 = newAmount - aDiscount;
      var usePoint = 0;
      var newAmount3 = newAmount2 - usePoint;
         
      
      
      //쿠폰 사용 버튼//
      $("#modal_submit_btn").click(function() {
          
    	  selectCouponList = []; // 선택된 쿠폰 코드 배열
          $("#cchk:checked").each(function() {
             selectCouponList.push($(this).data("coupon"));
             });

             if (selectCouponList.length > 0) { //하나 이상의 쿠폰이 선택되었을 때
                 $.ajax({
                     type: "POST",
                     url: "/couDiscount",
                     data: JSON.stringify(selectCouponList),
                     contentType: "application/json",
                     dataType: "json",
                     success: function(totalDiscount) {
                         
                         cDiscount = parseInt(totalDiscount);
         
                        newAmount = totalAmount - cDiscount;
                        $("#discountDisplay").text(cDiscount);
                         $("#pamountDisplay").text(newAmount);
                         $("#modal").hide();
                     },
                     error: function() {
                         alert("에러. 다시 시도하세요");
                     }
                 });
    } else { // 쿠폰 체크 안하고 적용
        alert("쿠폰을 적용하지 않습니다");
        newAmount = totalAmount;
        cDiscount = 0;
        $("#discountDisplay").text(cDiscount);
        $("#pamountDisplay").text(newAmount);
        $("#modal").hide();
    }
});
      
       const btn1 = document.getElementById('modal_open_btn');
        const btn2 = document.getElementById('modal_open_btn2');

      newAmount = totalAmount - cDiscount;
      
      // 관람권 유효성 검사, 등록 // 
      $("#admCheck").click(function() {
          let aCode = parseInt($("#admCode").val()); // 입력된 usepoint 값을 정수로 파싱
          let aLength = aCode.toString().length;         
          if (aLength != 12) {
               alert("12자리 숫자로 입력하세요.");
           } else{
           $.ajax({
               url: "/admChk", 
               type: "post",
               data: {"aCode": aCode},
               dataType:"json",
               success: function(result) {
               
                   if (result.result == 1) {
                       alert("관람권 등록 완료");
                       refreshMemList();
                      
                   } else {
                       alert("유효하지 않는 관람권코드 입니다");
                   }
               },
               error: function() {
                   alert("에러. 다시 시도하세요");
               }
           });           
           }
       });
      
      
      
      //관람권 사용 버튼//
      $("#modal_submit_btn2").click(function() {

      selectAdm = [];
       $("#achk:checked").each(function() {
              selectAdm.push($(this).data("adm"));
          });

       aDiscount = 0;
       
       if (selectAdm.length > 0) {
   
           if (adultNum > 0) {
               for (let i = 0; i < Math.min(adultNum, selectAdm.length); i++) {
                   aDiscount += adult;
               }

           }
           if (youthNum > 0) {
               for (let i = 0; i < Math.min(youthNum, selectAdm.length - aDiscount / youth); i++) {
                   aDiscount += youth;
               }
           }
           if (specialNum > 0) {
               for (let i = 0; i < Math.min(specialNum, selectAdm.length - aDiscount / special); i++) {
                   aDiscount += special;
               }
           }
           
       newAmount2 = newAmount - aDiscount; 
       
       $("#discountDisplay").text(cDiscount + aDiscount);
       $("#pamountDisplay").text(newAmount2);
       $("#modal2").hide();
       
       btn1.disabled = true;
  
       
       } else {
          alert("관람권을 적용하지 않습니다");
           newAmount2 = newAmount
           aDiscount = 0;
           $("#discountDisplay").text(cDiscount);
           $("#pamountDisplay").text(newAmount2);
           $("#modal2").hide();
           btn1.disabled = false;

       }
      
      });
      
      
      var newPoint = ${havePoint.m_point};
      
    
      // 포인트 적용버튼 //
      $("#modal_submit_btn3").click(function() {
         
      newAmount2 = newAmount - aDiscount;
         usePoint = parseInt($("#usePoint").val()); // 입력된 usepoint 값을 정수로 파싱
  
         
         if (checkedCheckboxes.length === adultNum + youthNum + specialNum) { // 인원수 합산(0910)
                    alert("관람 인원수 만큼 할인을 적용할 수 있습니다");
                 } else { 
          if (usePoint <= ${havePoint.m_point}) {
             if(newAmount2 < usePoint){
                alert("포인트를 결제 금액이내로 사용해주세요");
             } else if(usePoint == 0){
                 $("#modal3").hide();
                 $("#discountDisplay").text(cDiscount + aDiscount);
                 $("#pamountDisplay").text(newAmount2);
                 newPoint = ${havePoint.m_point};

                 if(aDiscount == 0) {
                	 btn1.disabled = false;
                	 btn2.disabled = false;
                 } else {
                	 btn2.disabled = false;
                 }
   
            } else {
             
            newAmount3 = newAmount2 - usePoint;
            $("#discountDisplay").text(cDiscount + aDiscount + usePoint);
              $("#pamountDisplay").text(newAmount3);
              $("#modal3").hide();
               newPoint = ${havePoint.m_point} - usePoint; // db에 넣을값 (point)
   
              btn1.disabled = true;
              btn2.disabled = true;
    
              
             }
               
          } else if(isNaN(usePoint)){
              alert("사용하실 포인트 금액을 입력해주세요");

                
          } else {
             alert("보유하신 포인트 금액을 초과했습니다");
             
          }
          
             }
           
      });

      
     //쿠폰/관람권/포인트 적용 취소 버튼
  $("#couponCancel").click(function() {
    	  
    	  var couponConfirm = confirm('적용된 할인을 취소하시겠습니까?');  
    	  if(couponConfirm) {	  
    		  refreshMemList();
    	 
    	  }
      });
            
      
  var amount = $("#pamountDisplay").text();
  var savePoint = amount / 10;
  var newPoint2 = newPoint + savePoint;
      
         
       //일반 결제 승인 버튼//
       $("#modal_submit_btn4").click(function(){
          var cardSelect = $("#cardSelect").val();
          var cardNum = $("#cardNum").val();
          var cardExp = $("#cardExp").val();
          var cardPw = $("#cardPw").val();
          var cardBir = $("#cardBir").val();
          const agree = document.querySelector('.chk2');
         
          
          $.ajax({
                  url: "/charge", 
                  type: "post",
                  data: {"cardSelect": cardSelect,
                     "cardNum": cardNum,
                     "cardExp": cardExp,
                     "cardPw": cardPw,
                     "cardBir": cardBir},
                  dataType:"json",
                  success: function(result){
                      if (result.result == "success") {
                           alert("결제가 완료되었습니다.");
                           if(!agree.checked){
                             alert("약관에 동의해주세요");
                           } else {
                        	   
                        	   clearTimeout(timer);
                        	   amount = $("#pamountDisplay").text();
                	           savePoint = amount / 10;
                	           newPoint2 = newPoint + savePoint;
                        	   var rpPayment1 = "a";
                        	   
                        	   var mailmail = {
                  	                 seat: "${list}",
                  	                 mvName: "${tcInfo.mv_name}",
                  	                 msSdate: "${date}",   
                  	                 msStime: "${tcInfo.ms_stime}", 
                  	                 msEtime: "${tcInfo.ms_etime}",   
                  	                 thCity: "${tcInfo.th_city}",   
                  	                 thKind: "${tcInfo.th_kind}",    
                  	                 adultNum: adultNum,
                  	                 youthNum: youthNum,
                  	                 specialNum: specialNum,
                  	                 msIdx: "${msIdx}",
                  	   				peopleNum: adultNum + youthNum + specialNum,
                  	   			amount:amount,
           	                	newPoint:newPoint,
           	                	savePoint:savePoint,
           	                	rpPayment:rpPayment1,
           	                	usePoint:usePoint
                  	                 };

                  	           $.ajax({
                  	                type: "POST",
                  	                url: "/email",
                  	                data: mailmail,
                  	                success: function(result) {
                  	                	// 이메일 전송 성공
                       	                	 location.href="/ticket?ms_idx=" + msIdx + "&adult="+ adultNum + "&youth=" + youthNum + "&special=" + specialNum +"&list=" + "${list}"+ "&date=" + "${date}";
  
                  	                },
                  	                error: function() {
                  	                  //  alert("이메일 전송 실패");
                  	                }
                  	   });
        
                  	      
                  	         $.ajax({
           	                  type: "POST",
           	                  url: "/updatePoint",
           	                  data: {"newPoint":newPoint,
        	                	  "savePoint":savePoint},
           	                  success: function() {
           	                	 // alert("포인트적용");
           	                  },
           	                  error: function() {
           	                     // alert("에러. 다시 시도하세요");
           	                  }
           	              });
                  	           


                  	       selectCouponList = []; // 선택된 쿠폰 코드 배열
            	           $("#cchk:checked").each(function() {
            	              selectCouponList.push($(this).data("coupon"));
            	              });
           	           
           	           
            	           $.ajax({
           	        	    type: "POST", 
           	        	    url: "/couDelete",
           	        	    data: {selectCouponList: selectCouponList},
           	        	    traditional: true,
           	        	    success: function(response) {

           	        	    },
           	        	    error: function() {
           	        	      //  alert("데이터 전송 오류!");
           	        	    }
           	        	});
           	           
           	           
            	           selectAdm = [];
            	           $("#achk:checked").each(function() {
            	                  selectAdm.push($(this).data("adm"));
            	              });
            	           
            	           $.ajax({
            	        	    type: "POST", 
            	        	    url: "/admDelete",
            	        	    data: {selectAdm: selectAdm},
            	        	    traditional: true,
            	        	    success: function(response) {

            	        	    },
            	        	    error: function() {
            	        	      //  alert("데이터 전송 오류!");
            	        	    }
            	        	});
            	
 
                           }
                       } else {
                          alert(result.result);
                       }
                  },
                  error: function() {
                    //  alert("에러. 다시 시도하세요");
                  }
       });
       });
       
          
       
		//간편결제 결제하기//
        $("#modal_submit_btn5").click(function() {
        	 const agree2 = document.querySelector('.chk3');
        	
        	 
        	 if(!agree2.checked){
                 alert("약관에 동의해주세요");
               } else {

            	   amount = $("#pamountDisplay").text();
    	           savePoint = amount / 10;
    	           newPoint2 = newPoint + savePoint;
            	   var rpPayment2 = "b";
            	   
            	   alert("결제가 완료되었습니다.");
            	   clearTimeout(timer);
            	   
            	   //이메일 보내기, 예매내역 등록하기
            	   var mailmail = {
            	                 seat: "${list}",
            	                 mvName: "${tcInfo.mv_name}",
            	                 msSdate: "${date}",   
            	                 msStime: "${tcInfo.ms_stime}", 
            	                 msEtime: "${tcInfo.ms_etime}",   
            	                 thCity: "${tcInfo.th_city}",   
            	                 thKind: "${tcInfo.th_kind}",
            	                 adultNum: adultNum,
            	                 youthNum: youthNum,
            	                 specialNum: specialNum,
            	                 msIdx: "${msIdx}",
            	   				peopleNum: adultNum + youthNum + specialNum,
            	   				amount:amount,
           	                	newPoint:newPoint,
           	                	savePoint:savePoint,
           	                	rpPayment:rpPayment2,
           	                	usePoint:usePoint
            	                 };


            	           $.ajax({
            	                type: "POST",
            	                url: "/email",
            	                data: mailmail, 
            	                success: function(response) {
            	                        // 이메일 전송 성공
            	                	location.href="/ticket?ms_idx=" + msIdx + "&adult="+ adultNum + "&youth=" + youthNum + "&special=" + specialNum +"&list=" + "${list}"+ "&date=" + "${date}";
            	                	
            	                },
            	                error: function() {
            	                  //  alert("이메일 전송 에러");
            	                }
            	   });
            	           
            	          

           	           
            	           $.ajax({
            	                  type: "POST",
            	                  url: "/updatePoint",
            	                  data: {"newPoint":newPoint,
            	                	  "savePoint":savePoint},
            	                  success: function() {
            	                //	  alert("포인트 적용");
            	                  },
            	                  error: function() {
            	               //       alert("포인트 적용 에러");
            	                  }
            	              });
           	           
           	           
            	           selectCouponList = []; // 선택된 쿠폰 코드 배열
            	           $("#cchk:checked").each(function() {
            	              selectCouponList.push($(this).data("coupon"));
            	              });
           	           
           	           
            	           $.ajax({
           	        	    type: "POST", 
           	        	    url: "/couDelete",
           	        	    data: {selectCouponList: selectCouponList},
           	        	   	traditional: true,
           	        	    success: function(response) {

           	        	    },
           	        	    error: function() {
           	        	      //  alert("쿠폰 업데이트 오류");
           	        	    }
           	        	});
           	           
           	           
            	           selectAdm = [];
            	           $("#achk:checked").each(function() {
            	                  selectAdm.push($(this).data("adm"));
            	              });
            	           
            	           $.ajax({
            	        	    type: "POST", 
            	        	    url: "/admDelete",
            	        	    data: {selectAdm: selectAdm},
            	        	   	traditional: true,
            	        	    success: function(response) {

            	        	    },
            	        	    error: function() {
            	        	      //  alert("관람권 업데이트 오류");
            	        	    }
            	        	});
               }
         });
       
  
  
		
       
       //간편결제 카드 등록하기
       $("#cardAdd").click(function() {
              $("#modal_change1").hide(); // 카드리스트 모달 숨기기
                $("#modal_change2").show(); // 카드등록 모달 보이기
         });
       

       
       
      //간편 결제 카드 추가 버튼//
       $("#modal_submit_btn6").click(function(){
          var cardSelect = $("#cardSelect2").val();
          var cardNum = $("#cardNum2").val();
          var cardExp = $("#cardExp2").val();
          var cardPw = $("#cardPw2").val();
          var cardBir = $("#cardBir2").val();
          const agree3 = document.querySelector('.chk4');
          
          $.ajax({
                  url: "/cardAdd", 
                  type: "post",
                  data: {"cardSelect": cardSelect,
                     "cardNum": cardNum,
                     "cardExp": cardExp,
                     "cardPw": cardPw,
                     "cardBir": cardBir,
                     "agree": agree3.checked},
                  dataType:"json",
                  success: function(result){
                      if (result.result == "success") {
                           alert("카드를 등록하였습니다");
                           refreshMemList(); 
                           // 카드목록 새로고침 (보류)
                                   // $("#modal_change2").hide(); 
                               // $("#modal_change1").show(); 
         
                           } else {
                          alert(result.result);
                       }
                  },
                  error: function() {
                      alert("에러. 다시 시도하세요");
                  }
       });
       });
          
       
       
       //간편결체창 등록카드 목록
       $("#modal_open_btn5").click(function() {
          $("#modal_change1").show();
         
    });
     
     
     //결제취소 버튼//
       $("#cancel").click(function() {
      		
 		  var canConfirm = confirm('해당 예매를 취소하시겠습니까?');

 		   if (canConfirm) {
 	           
 	                $.ajax({
 	                     type: "POST",
 	                     url: "/updateSeat",
 	                     data: {
 	                    	 list:"${list}",
 	                    	 msIdx:"${msIdx}"
 	                     },
 	                     success: function() {
 	                    	 
 	                     },
 	                     error: function() {
 	                         alert("에러. 다시 시도하세요");
 	                     }
 	                 });
 	                
 						alert("예매가 취소되었습니다");
 						location.href="/reservation";
 		   }
 		
 	});
     
     
     
    // 타이머 변수 선언
       let timer;

       // 페이지 진입 시 타이머 시작
       function startTimer() {
           timer = setTimeout(function () {
        	   
               // 타이머가 만료되면 선택한 좌석을 자동으로 취소
        	   $.ajax({
                    type: "POST",
                    url: "/updateSeat",
                    data: {
                   	 list:"${list}",
                   	 msIdx:"${msIdx}"
                    },
                    success: function() {
                   	 
                    },
                    error: function() {
                        alert("에러. 다시 시도하세요");
                    }
                });
               
					alert("예매가 취소되었습니다");
					location.href="/reservation";
					
           }, 5 * 60 * 1000); // 1분 (단위: 밀리초)
       }

       // 페이지 진입 시 타이머 시작
       startTimer();
     
     
 
   
       //간편결제 카드 슬라이드//
         (function () {
             const slideList = document.querySelector('.slide_list');  // Slide parent dom
             const slideContents = document.querySelectorAll('.slide_content');  // each slide dom
             const slideBtnRight = document.querySelector('.slide_btn_right'); // next button
             const slideBtnLeft = document.querySelector('.slide_btn_left'); // prev button
             const pagination = document.querySelector('.slide_pagination');
             const slideLen = slideContents.length;  // slide length
             const slideWidth = 400; // slide width
             const slideSpeed = 300; // slide speed
             const startNum = 0; // initial slide index (0 ~ 4)
             
             
             slideList.style.width = slideWidth * (slideLen + 2) + "px";
             
             // Copy first and last slide
             let firstChild = slideList.firstElementChild;
             let lastChild = slideList.lastElementChild;
             let clonedFirst = firstChild.cloneNode(true);
             let clonedLast = lastChild.cloneNode(true);

             // Add copied Slides
             slideList.appendChild(clonedFirst);
             slideList.insertBefore(clonedLast, slideList.firstElementChild);

             // Add pagination dynamically
             let pageChild = '';
             for (var i = 0; i < slideLen; i++) {
               pageChild += '<li class="dot';
               pageChild += (i === startNum) ? ' dot_active' : '';
               pageChild += '" data-index="' + i + '"><a href="#"></a></li>';
             }
             pagination.innerHTML = pageChild;
             const pageDots = document.querySelectorAll('.dot'); // each dot from pagination

             slideList.style.transform = "translate3d(-" + (slideWidth * (startNum + 1)) + "px, 0px, 0px)";

             let curIndex = startNum; // current slide index (except copied slide)
             let curSlide = slideContents[curIndex]; // current slide dom
             curSlide.classList.add('slide_active');
             
             
          // Check if there's only one slide
             if (slideLen === 1) {
                 $("#modal_submit_btn5").hide();
             }
          
          
             function hideButtonIfLastSlide() {
                 if (curIndex === slideLen - 1) {
                     $("#modal_submit_btn5").hide();
                 } else {
                     $("#modal_submit_btn5").show();
                 }
             }
             
             
             

             /** Next Button Event */
             slideBtnRight.addEventListener('click', function() {
                 if (curIndex <= slideLen - 1) {
                     slideList.style.transition = slideSpeed + "ms";
                     slideList.style.transform = "translate3d(-" + (slideWidth * (curIndex + 2)) + "px, 0px, 0px)";
                 }
                 if (curIndex === slideLen - 1) {
                     setTimeout(function() {
                         slideList.style.transition = "0ms";
                         slideList.style.transform = "translate3d(-" + slideWidth + "px, 0px, 0px)";
                     }, slideSpeed);
                     curIndex = -1;
                 }
                 curSlide.classList.remove('slide_active');
                 pageDots[(curIndex === -1) ? slideLen - 1 : curIndex].classList.remove('dot_active');
                 curSlide = slideContents[++curIndex];
                 curSlide.classList.add('slide_active');
                 pageDots[curIndex].classList.add('dot_active');
                 hideButtonIfLastSlide(); // Check if it's the last slide and hide the button
             });

             /** Prev Button Event */
             slideBtnLeft.addEventListener('click', function() {
                 if (curIndex >= 0) {
                     slideList.style.transition = slideSpeed + "ms";
                     slideList.style.transform = "translate3d(-" + (slideWidth * curIndex) + "px, 0px, 0px)";
                 }
                 if (curIndex === 0) {
                     setTimeout(function() {
                         slideList.style.transition = "0ms";
                         slideList.style.transform = "translate3d(-" + (slideWidth * slideLen) + "px, 0px, 0px)";
                     }, slideSpeed);
                     curIndex = slideLen;
                 }
                 curSlide.classList.remove('slide_active');
                 pageDots[(curIndex === slideLen) ? 0 : curIndex].classList.remove('dot_active');
                 curSlide = slideContents[--curIndex];
                 curSlide.classList.add('slide_active');
                 pageDots[curIndex].classList.add('dot_active');
                 hideButtonIfLastSlide(); // Check if it's the last slide and hide the button
             });

             
             
             /** Pagination Button Event */
             let curDot;
             Array.prototype.forEach.call(pageDots, function (dot, i) {
                 dot.addEventListener('click', function (e) {
                     e.preventDefault();
                     curDot = document.querySelector('.dot_active');
                     curDot.classList.remove('dot_active');
                     
                     curDot = this;
                     this.classList.add('dot_active');

                     curSlide.classList.remove('slide_active');
                     curIndex = Number(this.getAttribute('data-index'));
                     curSlide = slideContents[curIndex];
                     curSlide.classList.add('slide_active');
                     slideList.style.transition = slideSpeed + "ms";
                     slideList.style.transform = "translate3d(-" + (slideWidth * (curIndex + 1)) + "px, 0px, 0px)";
                     
                     // Check if it's the last dot
                     if (curIndex === slideLen - 1) {
                         $("#modal_submit_btn5").hide();
                     } else {
                         $("#modal_submit_btn5").show();
                     }
                 });
             });
             
             
           })();
       
       
      
       
       
       
        
   </script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>