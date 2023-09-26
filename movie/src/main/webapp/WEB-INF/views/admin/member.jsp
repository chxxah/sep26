<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN :: MEMBER</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="../css/admin.css">
<link rel="stylesheet" href="../css/member.css">
<style type="text/css">
h1 {
	text-align: center;
}

.header {
	display: flex;
	justify-content: space-between;
}

.left-div, .center-div, .right-div {
	width: 100%;
	max-width: 900px; /* 최대 너비 설정 */
	text-align: center; /* 수평 가운데 정렬 */
	vertical-align: middle;
	background-color: white;
	box-shadow: 2px 2px 2px 2px #becddb;
	padding: 20px;
	margin: 50px;
}


.navbar {
	width: 100%; /* 100% 너비 설정 */
	max-width: 900px; /* 최대 너비 설정 */
	margin: 0 auto; /* 가운데 정렬 */
	padding: 5px 0;
	box-shadow: 2px 2px 2px 2px #becddb;
}

.form-control {
    height: 40px; 
    font-size: 14px; 
    vertical-align: middle;
    text-align: center;
      margin-left: 15px;
}

.form-select{
width: 150px;
    height: 40px;
    font-size: 14px;
    vertical-align: middle;
    text-align: center;
      margin-left: 15px;
}

.btn {
width: 100px;
  height: 40px;
  font-size: 14px; /
}

.div-table {
	align-items: center;
	margin: 0 auto;
	display: table;
	width: 900px;
	height: auto;
	border-collapse: separate; /* 테이블 셀 경계를 분리 */
	/* 테이블 셀 간격 설정 */
	border-spacing: 0;
	box-shadow: 2px 2px 2px 2px #becddb;
}

.div-row {
	display: table-row;
	height: 40px;
	line-height: 40px; /* 높이와 동일하게 맞춰줍니다 */
	vertical-align: middle; /* 수직 가운데 정렬 */
}

.div-cell {
	display: table-cell;
	border-bottom: 1px solid gray;
	text-align: center; /* 수평 가운데 정렬 */
	vertical-align: middle; /* 수직 가운데 정렬 */
	background-color: white;
}

.table-head {
	background-color: #becddb;
	color: white;
	text-align: center;
}

.gray {
	color: #A6A6A6;
}

.yellow {
	color: #77C2F7;
}

</style>
</head>
<body>
	<%@ include file="admenu.jsp"%>
	<div class="container">

		<div class="main">
			<div class="header">
				<div class="left-div">드림박스 총 회원 수 ${totalMember} 명</div>
				<div class="center-div">9월 매출 목표 1,000만원</div>
				<fmt:formatNumber value="${totalIncome}" pattern="#,###" var="formattedTotalIncome" />
<div class="right-div">9월 매출 현황 ${formattedTotalIncome}원</div>
			</div>
			<div class="article">
				<nav class="navbar navbar-light bg-light">
					<div class="container-fluid">
		<a class="navbar-brand" style="font-size: 18px; color:gray;">회원 조회</a>
						<form class="d-flex" action="./member" method="get">
							<select name="search" class="form-select">
							<optgroup label="검색조건">
								<option value="nameSearch">이름</option>
								<option value="idSearch">아이디</option>
								</optgroup>
							</select> <input class="form-control me-2" type="text" name="searchV"
								required="required">
							<button class="btn btn-outline-secondary" type="submit">검색</button>
						</form>
					</div>
				</nav>
		<br>
				<div class="div-table">
					<div class="div-row table-head">
						<div class="div-cell table-head">회원번호</div>
						<div class="div-cell table-head">아이디</div>
						<div class="div-cell table-head">이름</div>
						<div class="div-cell table-head">닉네임</div>
						<div class="div-cell table-head">이메일</div>
						<div class="div-cell table-head">가입날짜</div>
						<div class="div-cell table-head">상태</div>
						<div class="div-cell table-head">가입유형</div>
					</div>
					<c:forEach items="${memberList }" var="row">
						<div
							class="div-row <c:if test="${row.m_status eq 2 }">gray</c:if><c:if test="${row.m_status eq 0 }"> yellow</c:if>"
							onclick="location.href='./userpage?mno=${row.m_no}'">
							<div class="div-cell">${row.m_no }</div>

							<div class="div-cell">
								<c:choose>
									<c:when test="${row.m_type eq 'naver'}">네이버연동회원</c:when>
									<c:otherwise>${row.m_id}</c:otherwise>
								</c:choose>
							</div>
							<div class="div-cell">${row.m_name }</div>
							<div class="div-cell">${row.m_nickname }</div>
							<div class="div-cell">${row.m_email }</div>
							<div class="div-cell">
								<fmt:formatDate value="${row.m_join_dt}" pattern="yyyy-MM-dd" />
							</div>
							<div class="div-cell">
								<c:if test="${row.m_status eq 2 }">정지회원</c:if>
								<c:if test="${row.m_status eq 1 }">일반회원</c:if>
								<c:if test="${row.m_status eq 0 }">운영자</c:if>
							</div>
							<div class="div-cell">${row.m_type }</div>
						</div>
					</c:forEach>
				</div>

			</div>
		</div>
	</div>
</body>
</html>