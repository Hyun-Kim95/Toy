<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.toy.kh.diary.util.Util"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../part/head.jspf"%>

<c:set var="fileInputMaxCount" value="5" />

<section class="section-1">
	<div class="bg-white shadow-md rounded container mx-auto p-8 mt-8">
		<div class="w-full">
			<div class="flex items-center mt-4">
				<div class="flex-grow"></div>
				<a href="modify?id=${diaryList.id}"
					class="btn-primary bg-blue-500 hover:bg-blue-dark text-white font-bold mx-1 py-1 px-2 rounded">수정</a>
				<a onclick="if ( !confirm('삭제하시겠습니까?') ) return false;"
					href="doDelete?id=${diaryList.id}"
					class="btn-primary bg-blue-500 hover:bg-blue-dark text-white font-bold py-1 px-2 rounded">삭제</a>
			</div>
			<div class="flex flex-row mt-2 py-3">
				<div class="flex flex-col mb-2 mt-1">
					<fmt:parseDate var="parseDate" value="${diaryList.regDate}" pattern="yyyy-MM-dd"/>
					<fmt:formatDate var="resultDt" value="${parseDate}" pattern="yyyy-MM-dd"/>
					<div class="font-bold text-xl">${resultDt}</div>
				</div>
			</div>
			<div class="border-b border-gray-100"></div>
			<div class="text-gray-400 font-medium text-sm mb-7 mt-6">
				<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
					<c:set var="fileNo" value="${String.valueOf(inputNo)}" />
					<c:set var="file" value="${diaryList.extra.file[fileNo]}" />
					<a href="${file.downloadUrl}" target="_blank" class="w-full text-blue-500 hover:underline">
						<c:if test="${file.fileExtTypeCode == 'jpg' || file.fileExtTypeCode == 'img'}">
							${file.mediaHtml}<br>
						</c:if>
						<c:if test="${file.fileExtTypeCode != null && file.fileExtTypeCode != 'jpg' && file.fileExtTypeCode != 'img'}">
							${file.originFileName}<br>
						</c:if>
					</a>
				</c:forEach>
			</div>
			<div class="text-gray-600 font-semibold text-lg mb-2">제목 : ${diaryList.title}</div>
			<div class="text-gray-500 font-thin text-sm mb-6 whitespace-pre-wrap">${diaryList.body}</div>
		</div>
    </div>
</section>

<%@ include file="../part/foot.jspf"%>