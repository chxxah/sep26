<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="">
<meta charset="UTF-8">
<title>ADMIN :: MOVIE</title>
<link rel="stylesheet" href="../css/mhome/newmovie.css">
<style type="text/css">
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>



<script type="text/javascript">


//숫자만 입력가능
function validateNumbers2(input) {
    var value = input.value;
    if (!/^\d+$/.test(value)) {
        input.value = value.replace(/[^\d]/g, "");
        alert("숫자만 입력할 수 있습니다.");
    }
}



//문자 특수문자 공백 안됨
	function preventspace(input) {
		var value = input.value;
		if (/[^\w\d]/.test(value) || /\s/.test(value)) {
			var newValue = value.replace(/[^\w\d]/g, "").replace(/\s/g, "");
			input.value = newValue; // 입력값을 다시 원래상태로 되돌리기 
			alert("특수문자와 공백은 입력할 수 없습니다.");

		}
	}


	
	 function save() {
	    // 입력된 값을 가져옴
	    let mvcode = $("#mv_code").val();
	    let mvname = $("#mv_name").val();
	    // 입력된 값의 길이를 계산
	    let inputLength = mvcode.length;


	    // 길이 조건을 검사
	    
	      if (inputLength < 1) {
				        alert("영화코드는 필수 입력 값입니다. 숫자로 입력해주세요.");
				        
				        var mvCodeInput = document.querySelector('input[name="mv_code"]');
				        mvCodeInput.value = "0";
				        mvCodeInput.classList.add("filled-input");
				        
				        return false; // 저장을 막음
				    }
	    
	    
	    	 $.ajax({
				
				url : "/admin/mvcodeck", //
				type : "post",
				data :
				
				{
					
					"mvcode" : mvcode
					
				},
			
				
			    success: function (data) {
			        if (data == 1) {
			            $("#resultMSG").text("이미 등록된 고유번호 입니다.");
			            $("#resultMSG").css("color", "red");

			            $("#mv_code").focus();

			            return false; // 저장을 막음
			        } else {
			            $("#resultMSG").css("color", "green");
			            $("#resultMSG").text("등록 성공.");
			                document.getElementById("myForm").submit(); // 폼을 ID로 선택하여 전송
			              
			            mvinfoupdate(mvcode, mvname);
			          
			            
			            // 페이지 이동을 비동기적으로 처리
		
			        }
			      
			    },
			    error: function (request, status, error) {
			        $("#resultMSG").text("오류가 발생 했습니다. 등록 할 수 없습니다.");
			    }
			
				
				
				
			
			}); //  ajax 시작 선언
	}
			
	

	function mvinfoupdate (mvcode,mvname) {
		
		$.ajax({

			url : "/admin/mvinfoupdate",
			type : "get",
			data : {
				"mvcode" : mvcode,
				"mvname" : mvname

			},

			success : function(data) {
		
			
		    	
			
			},
			
			error: function(request,status,error){
				
			      alert("서버 오류가 발생했습니다." + error);
			}
			
			
	
		}); //  ajax 시작 
				
		
	}
	
	function mvinfo(mvname) {

		$.ajax({

			url : "/admin/mvinfo",
			type : "get",
			data : {
				"mvname" : mvname

			},

			success : function(data) {

				var jsonData = JSON.parse(data);

				var mvcode =jsonData.movieCd;
				var mvname =jsonData.movieNm;
				
			
		
				
	
			
				

				if (jsonData.movieCd !== null && jsonData.movieCd !== "") {
					$("#resultMSG").html(
							"개봉일 : " + jsonData.openDt + "<br>" + "고유코드 : "
									+ jsonData.movieCd + "<br>" + "개봉상태 : "
									+ jsonData.prdtStatNm + "<br>" + "영화제목 : "
									+ jsonData.movieNm + "<br>"
									+ "고유코드만 등록하시면 영화정보가 자동으로 등록 됩니다.");

					var mvCodeInput = document
							.querySelector('input[name="mv_code"]');
					var mvNameInput = document
							.querySelector('input[name="mv_name"]');
					var mvSdateInput = document
							.querySelector('input[name="mv_sdate"]');
					var auStatusInput = document
							.querySelector('input[name="au_status"]');

					mvCodeInput.value = jsonData.movieCd;
					mvNameInput.value = jsonData.movieNm;
					mvSdateInput.value = jsonData.openDt;
					auStatusInput.value = jsonData.prdtStatNm;

					mvCodeInput.classList.add("filled-input");
					mvNameInput.classList.add("filled-input");
					mvSdateInput.classList.add("filled-input");
					auStatusInput.classList.add("filled-input");

				} else {
					$("#resultMSG").text("정확하게 검색하거나 수동등록으로 진행해주세요.");

				}
			},

			error : function(request, status, error) {

				$("#resultMSG").text("오류가 발생 했습니다. 수동으로 진행해주세요.");
			}

		}); //  ajax 시작 선언

	}

	function serch() {

		var mvname = document.getElementById("mvname").value;
		var mvname1 = mvname.replace(/ /g, '');

		if (mvname1 == "" || mvname1.length < 1) {

			$("#mvname").focus();
			$("#resultMSG").text("영화 제목을 입력해주세요 ");
			$("#resultMSG").css("color", "red").css("font-weight", "bold").css(
					"font-size", "15pt");
		} else {

			$.ajax({

				url : "/admin/mvserch",
				type : "get",
				data : {
					"mvname" : mvname1

				},

				success : function(data) {

					if (data == 1) {
						$("#resultMSG").text(
								"이미 등록된 영화입니다. 확인후 수동등록으로 진행 해주세요.");
						$("#resultMSG").css("color", "red");
						$("#mvname").focus();
					} else {
						$("#resultMSG").css("color", "green");
						$("#resultMSG").text("등록 가능한 영화 입니다.");

						mvinfo(mvname);
					
					}

				},

				error : function(request, status, error) {
					$("#resultMSG").text("오류가 발생 했습니다. 가입할 수 없습니다.");
				}

			}); //  ajax 시작 선언

		}
	}
	
	function cancel() {
		window.location.href = "/admin/movieupload";

		}


</script>

</head>
<body>
	<%@ include file="admenu.jsp"%>


	<div class="container">

		<div class="main">
			<div class="article">
				<h3>신규영화등록</h3>

				<div class="serch">
					<div class=content2>영화등록여부</div>
					<input type="text" class="mvname" id="mvname"
						placeholder="영화 이름을 적어주세요" required="required"> <span
						class="serchbtn"><button class="serchbtn" type="button"
							onclick="serch()">찾기</button></span>
					<P>
						<span id="resultMSG"></span>
					</p>
				</div>


				<div class="content1">

					<form id="myForm" method="post" action="/admin/movieinsert">
						<div class="spanid">
							<div class=content2>포스터 :</div>
							<input type="text" class="mv_input" name="mv_poster"
								placeholder="url 주소를 적어주세요">
						</div>

						<div class="spanid">
							<div class=content2>영화코드 :</div>
							<input type="text" class="mv_input" name="mv_code" id="mv_code"
								placeholder="숫자로 8글자 입력해주세요" required="required"
								oninput="validateNumbers2(this)">
						</div>

						<div class="spanid">
							<div class=content2>영화제목 :</div>
							<input type="text" class="mv_input" name="mv_name" id="mv_name"
								placeholder="영화제목" required="required">
						</div>

						<div class="spanid">
							<div class=content2>개봉일 :</div>
							<input type="text" class="mv_input" name="mv_sdate"
								placeholder="yyyymmdd">
						</div>

						<div class="spanid">
							<div class=content2>제작사 :</div>
							<input type="text" class="mv_input" name="mv_maker"
								placeholder="제작사">
						</div>

						<div class="spanid">
							<div class=content2>개봉상태 :</div>
							<input type="text" class="mv_input" name="au_status"
								placeholder="개봉,개봉예정">
						</div>

						<div class="spanid">
							<div class=content2>누적관객수 :</div>

							<input type="text" class="mv_input" name="au_acccnt"
								placeholder="숫자만 입력해주세요" oninput="validateNumbers2(this)">
						</div>
						<div class="">
							<button class="button save" type="button" onclick="save()">저장하기</button>
						</div>
						<div class="">
							<button class="button cancel" onclick="cancel()">취소하기</button>
						</div>
					</form>
				</div>





			</div>
		</div>
	</div>


</body>
</html>