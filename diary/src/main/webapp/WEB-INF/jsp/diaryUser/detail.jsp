<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.toy.kh.diary.util.Util"%>

<%@ include file="../part/head.jspf"%>

<section class="section-1">
	<div class="bg-white shadow-md rounded container mx-auto p-8 mt-8">
		<form onsubmit="DiaryUserModify__checkAndSubmit(this); return false;"
			action="doModify" method="POST">
			<input type="hidden" name="genFileIdsStr" />
			<input type="hidden" name="id" value="${diaryUser.id}" />
			<div class="my-1 form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28 font-bold">
					<span>로그인아이디</span>
				</div>
				<div class="lg:flex-grow">${diaryUser.loginId}</div>
			</div>
			<div class="my-1 form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28 font-bold">
					<span>이름</span>
				</div>
				<div class="lg:flex-grow">${diaryUser.name}</div>
			</div>
			<div class="my-1 form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28 font-bold">
					<span>별명</span>
				</div>
				<div class="lg:flex-grow">${diaryUser.nickname}</div>
			</div>
			<div class="my-1 form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28 font-bold">
					<span>이메일</span>
				</div>
				<div class="lg:flex-grow">${diaryUser.email}</div>
			</div>
			<div class="my-1 form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28 font-bold">
					<span>전화번호</span>
				</div>
				<div class="lg:flex-grow">${diaryUser.cellphoneNo}</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row mt-2">
				<div class="lg:flex-grow">
					<div class="btns">
						<a href="modify?id=${diaryUser.id}"
						class="btn-primary bg-blue-500 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded">
						수정</a>
						<a onclick="history.back();" 
						class="btn-info bg-red-500 hover:bg-red-dark text-white font-bold py-2 px-4 rounded">
						되돌아가기</a>
					</div>
				</div>
			</div>
		</form>
	</div>
</section>

<%@ include file="../part/foot.jspf"%>