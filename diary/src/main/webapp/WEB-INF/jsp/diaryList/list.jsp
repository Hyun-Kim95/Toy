<%@ page import="com.toy.kh.diary.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../part/head.jspf"%>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
            $.datepicker.setDefaults($.datepicker.regional['ko']); 
            $( "#startDate" ).datepicker({
                 changeMonth: true, 
                 changeYear: true,
                 nextText: '다음 달',
                 prevText: '이전 달', 
                 dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                 dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
                 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 dateFormat: "yy-mm-dd",
                 maxDate: 0                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
            });    
    });
</script>
<section class="section-1">
	<div class="bg-white shadow-md rounded container mx-auto p-8 mt-8">
		<div class="flex items-center">
			<div class="flex-grow"></div>
			<a href="add"
				class="btn-primary bg-blue-500 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded">일기쓰기</a>
		</div>
		<form class="flex mt-2">
			<span class="container mx-auto text-center w-14">날짜 선택</span>
			<input type="text" id="startDate" name="selectedDate" class="ml-3 shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" autocomplete="off" placeholder="날짜를 입력해주세요.">
			<input class="ml-3 btn-primary bg-blue-500 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded"
				type="submit" value="선택 날짜로 이동" />
		</form>
		<form class="flex mt-3">
			<select name="searchKeywordType">
				<option value="titleAndBody">전체</option>
				<option value="title">제목</option>
				<option value="body">본문</option>
			</select>
			<script>
				if (param.searchKeywordType) {
					$('.section-1 select[name="searchKeywordType"]').val(
							param.searchKeywordType);
				}
			</script>
			<input class="ml-3 shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker"
				name="searchKeyword" type="text" placeholder="검색어를 입력해주세요."
				value="${param.searchKeyword}" />
			<input class="ml-3 btn-primary bg-blue-500 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded"
				type="submit" value="검색" />
		</form>

		<div>
			<c:forEach items="${diaries}" var="diary">
				<c:if test="${loginedDiaryUserId == diary.userId}">
					<div class="bg-gray-100 m-1 p-2 shadow-md">
						<c:set var="detailUrl" value="detail?id=${diary.id}" />
						<c:set var="thumbFileNo" value="${String.valueOf(1)}" />
						<c:set var="thumbFile" value="${diary.extra.file[thumbFileNo]}" />
						<c:set var="thumbUrl" value="${thumbFile.mediaHtml}" />
						<div class="flex items-center mt-10">
							<fmt:parseDate var="parseDate" value="${diary.regDate}" pattern="yyyy-MM-dd"/>
							<fmt:formatDate var="resultDt" value="${parseDate}" pattern="yyyy-MM-dd"/>
							<a href="${detailUrl}" class="ml-2 font-bold text-xl">${resultDt}(${Util.getDateDay(resultDt)})</a>
							<fmt:parseDate var="parseDate" value="${diary.updateDate}" pattern="yyyy-MM-dd"/>
							<fmt:formatDate var="resultDt2" value="${parseDate}" pattern="yyyy-MM-dd"/>
							<div class="flex-grow"></div>
							<div class="text-gray-300">update : ${resultDt2}</div>
						</div>
						<div class="mt-2">
							<a href="${detailUrl}"
								class="text-2xl text-gray-700 font-bold hover:underline">${diary.title}</a>
							<c:if test="${thumbUrl != null}">
								<a class="block" href="${detailUrl}">
									${thumbUrl}
								</a>
							</c:if>
						</div>
						<div class="flex items-center mt-4">
							<a href="detail?id=${diary.id}"
								class="text-blue-500 hover:underline">자세히보기</a>
							<a href="modify?id=${diary.id}"
								class="ml-3 text-blue-500 hover:underline">수정</a>
							<a onclick="if ( !confirm('삭제하시겠습니까?') ) return false;"
								href="doDelete?id=${diary.id}"
								class="ml-3 text-blue-500 hover:underline">삭제</a>
							<div class="flex-grow"></div>
							<div>
								<a class="flex items-center">
									<h1 class="text-gray-700 font-bold hover:underline">작성자 :
										${diary.extra__writer}</h1>
								</a>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
		<!-- 페이징 시작 -->
		<nav class="flex justify-center rounded-md mt-3"
			aria-label="Pagination">
			<c:if test="${pageMenuStart != 1}">
				<a href="${Util.getNewUrl(requestUrl, 'page', 1)}"
					class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
					<span class="sr-only">Previous</span> <i
					class="fas fa-chevron-left"></i>
				</a>
			</c:if>

			<c:forEach var="i" begin="${pageMenuStart}" end="${pageMenuEnd}">
				<c:set var="aClassStr"
					value="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium" />
				<c:if test="${i == page}">
					<c:set var="aClassStr"
						value="${aClassStr} text-red-700 hover:bg-red-50" />
				</c:if>
				<c:if test="${i != page}">
					<c:set var="aClassStr"
						value="${aClassStr} text-gray-700 hover:bg-gray-50" />
				</c:if>
				<a href="${Util.getNewUrl(requestUrl, 'page', i)}"
					class="${aClassStr}">${i}</a>
			</c:forEach>

			<c:if test="${pageMenuEnd != totalPage}">
				<a href="${Util.getNewUrl(requestUrl, 'page', totalPage)}"
					class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">

					<span class="sr-only">Next</span> <i class="fas fa-chevron-right"></i>
				</a>
			</c:if>
		</nav>
		<!-- 페이징 끝 -->
	</div>
</section>

<%@ include file="../part/foot.jspf"%>