<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/mhome/movieupdate.css">
<meta charset="UTF-8">
<title>ADMIN :: UPLOAD</title>

<style type="text/css">
</style>

<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>


<script type="text/javascript">

var currentPage = 1;

/*
$(document).ready(function() {
	
$(".pagination-link").on("click", function() {

	currentPage = $(this).data("page");
	


}); //끝부분 

$(".mvupdate").on("click", function() {

	index = $(this).data("index");
	
alert(index);

}); //끝부분 
});



	var divLow = document.querySelector(".div-table");
divLow.style.display = "none";

  var editForm = document.querySelector(".edit-form");
    editForm.style.display = "block";
    
    var editForm = document.querySelector(".pagination");
    editForm.style.display = "none";
    

*/
/*
$(document).ready(function() {
    var executed = false;

    if (!executed) {
        executed = true;
        setTimeout(function() {
            location.reload();
        }, 1000);
    }

});
*/
function toggleEdit(mvcode) {
	

	window.location.href = "/admin/mvdetail?mvcode=" + mvcode;
	
	
	}
	
	function newmovie() {
		window.location.href = "/admin/newmovie";
		
	}
	

	function delete1(mvcode) {
		
		if (confirm("정말 삭제 하시겠습니까?")) {
			
			
			$.ajax({
			      
		         url : "/admin/mvdelete",
		         type : "post",
		         data : {
		            "mvcode" : mvcode
		            
		         },

		         success : function(data) {
		        	 
		        window.location.href = "/admin/movieupload";
		            
		         },
		         error : function(request, status, error) {
		            alert("서버 오류가 발생했습니다." + error);
		         }
		         
		      });
			
			
		} else {
			window.location.href = "/admin/movieupload";
		}
	
		
	}
	
	
	
	/*
	function searchMovies() {
	    var input, filter, table, rows, cells, cell, i, j, txtValue;
	    input = document.getElementById("movie-search");
	    filter = input.value.replace(/\s+/g, "").toLowerCase();
	    table = document.getElementsByClassName("div-table")[0];
	    rows = table.getElementsByClassName("div-row");

	    for (i = 0; i < rows.length; i++) {
	    	var found = false; // 검색어를 찾았는지 여부를 나타내는 변수
	        cells = rows[i].getElementsByClassName("cell3"); // Cell3에는 영화 제목이 들어 있습니다.
	        for (j = 0; j < cells.length; j++) {
	            cell = cells[j];
	            txtValue = cell.textContent || cell.innerText;
	            if (txtValue.toLowerCase().indexOf(filter) > -1) {
	            	   found = true;
	             
	                break; // 검색어가 포함된 셀이 하나라도 있으면 행을 표시합니다.
	            } 
	            
	            if (found) {
	            	   rows[i].style.display = "";
	            } else {
	                rows[i].style.display = "none"; // 일치하는 셀이 없으면 행을 숨깁니다.
	            }
	            
	            if (filter !== "") {
	                for (i = 0; i < rows.length; i++) {
	                	var found = false;
	                
	                	 cells = rows[i].getElementsByClassName("cell3");
	                     for (j = 0; j < cells.length; j++) {
	                         cell = cells[j];
	                         txtValue = cell.textContent || cell.innerText;
	                         
	                         if (txtValue.toLowerCase().indexOf(filter) > -1) {
	                             found = true;
	                             break;
	                         }
	                	
	                }
	                     
	                     if (found) {
	  	            	   rows[i].style.display = "";
	  	            } else {
	  	                rows[i].style.display = "none"; // 일치하는 셀이 없으면 행을 숨깁니다.
	  	            }
	        }
	    } else {
	        // 검색어가 비어 있을 때는 모든 행을 표시
	        for (i = 0; i < rows.length; i++) {
	            rows[i].style.display = "";
	        }
	}
	}
	
	    }
	}
	*/
	//document.getElementById("movie-search").addEventListener("input", searchMovies);
	
	
	
		
		//function searchMovies() {
	    // 검색어 입력 필드에 이벤트 리스너 추가
			
	    
	    $(document).ready(function() {
	    
	    $("#movie-search").on("input", function() {
	        // 입력 필드에서 검색어 가져오기

	       var input = $(this).val();
	        
	    
	      
	        // AJAX 요청 보내기
	        $.ajax({
	            url: "/admin/mainserch", // 서버의 검색 API 엔드포인트
	            method: "GET", // 또는 POST 등 요청 메서드 선택
	            data: 
	            { "movieNm": input }, // 서버로 전달할 데이터
	            dataType: "json", // 받을 데이터 형식 (JSON을 기대하면 "json"으로 설정)
	            success: function(data) {
	            	 var searchResultsContainer = $(".div-table");
	            	 var searchResultsContainer1 = $(".divall");
	            	 //var searchResultsContainer2 = $("#divrow");
	            	 
	           
	            	 //var searchResultsContainer1 = $(".div-table");
	                 //검색 결과 초기화
	                 //searchResultsContainer.hide();
	            	 //if (data.error === "검색어를 입력하세요" || data.error === "오류 발생") {
	            	        // 서버에서 반환한 메시지를 처리합니다.
	            	        if("error" in data) {
	            	        	//searchResultsContainer.empty();
	            	        	
	            	        	$(".delete1").remove();
	            	       		 searchResultsContainer1.show();
	            	    } else if("error1" in data) {
	            	    	
	            	    	
	            	  
	            	    	
	            	    }else {
	            	    	
	            	    	//initialMovieListContainer.hide();
	            	    	searchResultsContainer1.hide();
	            	
	            	 
	            	    for (var i = 0; i < data.results.length; i++) {
	            	            var result = data.results[i];
	                   
	                     	//var result = data.results;
	                     var resultHTML = '<div class="div-row divall delete1">';
	                     resultHTML += '<img src="' + result.mv_poster + '" alt="Movie Poster" class="div-cell poster cell1 table-bottom)">';
	                     resultHTML += '<div class="div-cell cell2 table-bottom">' + result.mv_code + '</div>';
	                     resultHTML += '<div class="div-cell cell3 table-bottom">' + result.mv_name + '</div>';
	                     resultHTML += '<div class="div-cell cell4 table-bottom">' + result.mv_sdate + '</div>';
	                     resultHTML += '<div class="div-cell cell5 table-bottom">' + result.mv_maker + '</div>';
	                     resultHTML += '<div class="div-cell cell6 table-bottom">' + result.au_status + '</div>';
	                     resultHTML += '<div class="div-cell cell7 table-bottom">' + result.au_acccnt + '명</div>';
	                     resultHTML += '<div class="div-cell cell8 table-bottom"><button class="button update mvupdate" id="mvupdate" onclick="toggleEdit(' + result.mv_code + ')">수정하기</button></div>';
	                     resultHTML += '<div class="div-cell cell9 table-bottom"><button class="button delete" id="mvdelete" onclick="delete1(' + result.mv_code + ')">삭제하기</button></div>';
	                     resultHTML += '</div>';

	                     // 결과를 화면에 추가
	                	   searchResultsContainer.append(resultHTML);
	            	    }
	            	    /*
	                     var appif=true;
						if(appif) {
	                	   searchResultsContainer.append(resultHTML);
	                	   appif=false;
						}
						*/
	                 //});
	                 // 결과 테이블 닫기
	                 resultHTML += '</div>';
                
                // 검색 결과를 반복해서 처리
         
              

	                 //searchResultsContainer.show();
	            	    }
	            },
	            error : function(request, status, error) {
		            alert("서버 오류가 발생했습니다." + error);
		         }
	        });
	      
	        
	      

	    });
	    
	});

	        
</script>
</head>
<body>
	<%@ include file="admenu.jsp"%>

	<div class="container">

		<div class="main">
			<div class="article">
				<h3>영화목록관리</h3>
				<div class="search-container">
					<div class="searchinput">
						<span class="serinput">검색 :</span> <input type="text"
							id="movie-search" placeholder="영화제목을 입력해주세요">

					</div>
				</div>
				<div class="div-table" id="initialMovieList">
					<div class="div-row table-head">
						<div class="div-cell table-head cell1" rowspan="2">포스터</div>
						<div class="div-cell table-head cell2" rowspan="2">영화코드</div>
						<div class="div-cell table-head cell3" rowspan="2">제목</div>
						<div class="div-cell table-head cell4" rowspan="2">개봉일</div>
						<div class="div-cell table-head cell5" rowspan="2">제작사</div>
						<div class="div-cell table-head cell6" rowspan="2">개봉상태</div>
						<div class="div-cell table-head cell7" rowspan="2">누적관객순</div>
						<div class="div-cell table-head cell8" rowspan="2">수정</div>
						<div class="div-cell table-head cell9" rowspan="2">삭제</div>

					</div>



					<c:if test="${not empty movieList}">
						<c:forEach items="${movieList}" var="row" begin="0"
							end="${movieList.size() - 1}" varStatus="status">


							<div class="div-row divall" id="div-row">

								<img src="${row.mv_poster}" alt="Movie Poster"
									class="div-cell poster cell1${status.index == 0 ? '' : ' table-bottom'} ">
								<div class="div-cell cell2 table-bottom">${row.mv_code}</div>
								<div class="div-cell cell3 table-bottom">${row.mv_name}</div>
								<div class="div-cell cell4 table-bottom">${row.mv_sdate}</div>
								<div class="div-cell cell5 table-bottom">${row.mv_maker}</div>
								<div class="div-cell cell6 table-bottom">${row.au_status}</div>
								<div class="div-cell cell7 table-bottom">${row.au_acccnt}명</div>
								<div class="div-cell cell8 table-bottom">
									<button class="button update mvupdate" id="mvupdate"
										onclick="toggleEdit(${row.mv_code})">수정하기</button>
								</div>
								<div class="div-cell cell9 table-bottom">
									<button class="button delete" id="mvdelete"
										onclick="delete1(${row.mv_code})">삭제하기</button>
								</div>

							</div>

						</c:forEach>
					</c:if>

				</div>





			</div>
			<!--  아티클 끝 -->

			<!-- 페이징 부분 -->
			<div class="pagination">


				<c:forEach begin="1" end="${totalPages}" var="pageNum"
					varStatus="status">
					<c:choose>
						<c:when test="${pageNum == currentPage}">
							<span class="current-page pagination-link"
								data-page="${status.index}">${pageNum}</span>
						</c:when>
						<c:otherwise>
							<a href="?page=${pageNum}" class="pagination-link"
								data-page="${status.index }">${pageNum}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<span class="moviespan">
					<button class="moviebtn" onclick="newmovie()">신규영화등록</button>
				</span>
			</div>


		</div>
	</div>





</body>
</html>