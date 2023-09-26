<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/mhome/movieupdate.css">
<meta charset="UTF-8">
<title>ADMIN :: EDIT</title>

<style type="text/css">
</style>

<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>




<script type="text/javascript">
	/*
	 function saveck(input) {
	 var sdate = $("#saveck").val();
	
	 //if(sdate.length < 8) {
	
	
	 $("#saveck").focus();

	 alert("개봉일을 정확하게 입력 해주세요." + sdate);
	
	
	 //}
	 }
	 */
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
				<h3>영화수정하기</h3>
				<c:forEach items="${movieList}" var="row" begin="0">

					<div class="div-table">

						<div class="div-row table-head">
							<div class="div-cell table-head cell1" rowspan="2">포스터</div>
							<div class="div-cell table-head cell2" rowspan="2">영화코드</div>
							<div class="div-cell table-head cell3" rowspan="2">제목</div>
							<div class="div-cell table-head cell4" rowspan="2">개봉일</div>
							<div class="div-cell table-head cell5" rowspan="2">제작사</div>
							<div class="div-cell table-head cell6" rowspan="2">개봉상태</div>
							<div class="div-cell table-head cell7" rowspan="2">누적관객순</div>


						</div>


						<div class="div-row divall" id="div-row">

							<img src="${row.mv_poster}" alt="Movie Poster"
								class="div-cell poster cell1">
							<div class="div-cell cell2 table-bottom">${row.mv_code}</div>
							<div class="div-cell cell3 table-bottom">${row.mv_name}</div>
							<div class="div-cell cell4 table-bottom">${row.mv_sdate}</div>
							<div class="div-cell cell5 table-bottom">${row.mv_maker}</div>
							<div class="div-cell cell6 table-bottom">${row.au_status}</div>
							<div class="div-cell cell7 table-bottom">${row.au_acccnt}명</div>


						</div>
					</div>
					<div class="content1">

						<form method="post" action="/admin/mvupdate">
							<div class="spanid">
								<div class=content2>포스터 :</div>


								<input type="text" class="mv_input" name="mv_poster"
									value="${row.mv_poster}">
							</div>

							<div class="spanid">
								<div class=content2>영화코드 :</div>


								<input type="text" class="mv_input" name="mv_code"
									value="${row.mv_code}">
							</div>

							<div class="spanid">
								<div class=content2>영화제목 :</div>


								<input type="text" class="mv_input" name="mv_name"
									value="${row.mv_name}">
							</div>

							<div class="spanid">
								<div class=content2>개봉일 :</div>



								<input type="text" class="mv_input" name="mv_sdate"
									id="mv_sdate" value="${row.mv_sdate}">
							</div>

							<div class="spanid">
								<div class=content2>제작사 :</div>


								<input type="text" class="mv_input" name="mv_maker"
									value="${row.mv_maker}">
							</div>

							<div class="spanid">
								<div class=content2>개봉상태 :</div>


								<input type="text" class="mv_input" name="au_status"
									value="${row.au_status}">
							</div>

							<div class="spanid">
								<div class=content2>누적관객수 :</div>



								<input type="text" class="mv_input" name="au_acccnt"
									value="${row.au_acccnt}">
							</div>
							<div class="">
								<button class="button save" type="submit">저장하기</button>
							</div>
							<div class="">
								<button class="button cancel" onclick="cancel()">취소하기</button>
							</div>
						</form>
					</div>

				</c:forEach>



			</div>
			<!--  아티클 끝 -->

			<!-- 페이징 부분 -->



		</div>
	</div>





</body>
</html>