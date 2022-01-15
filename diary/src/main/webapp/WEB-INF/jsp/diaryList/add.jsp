<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
<c:set var="fileInputMaxCount" value="5" />
<script>
DiaryListAdd__fileInputMaxCount = parseInt("${fileInputMaxCount}");
</script>

<script>
DiaryListAdd__submited = false;
function DiaryListAdd__checkAndSubmit(form) {
	if ( DiaryListAdd__submited ) {
		alert('처리중입니다.');
		return;
	}
	
	form.selectedDate.value = form.selectedDate.value.trim();
	if ( form.selectedDate.value.length == 0 ) {
		alert('날짜를 입력해주세요.');
		form.selectedDate.focus();
		return false;
	}
	form.title.value = form.title.value.trim();
	if ( form.title.value.length == 0 ) {
		alert('제목을 입력해주세요.');
		form.title.focus();
		return false;
	}
	form.body.value = form.body.value.trim();
	if ( form.body.value.length == 0 ) {
		alert('내용을 입력해주세요.');
		form.body.focus();
		return false;
	}
	var maxSizeMb = 50;
	var maxSize = maxSizeMb * 1024 * 1024;
	
	for ( let inputNo = 1; inputNo <= DiaryListAdd__fileInputMaxCount; inputNo++ ) {
		const input = form["file__0__" + inputNo];
		
		if (input.value) {
			if (input.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				input.focus();
				
				return;
			}
		}
	}
	const startSubmitForm = function(data) {
		if (data && data.body && data.body.genFileIdsStr) {
			form.genFileIdsStr.value = data.body.genFileIdsStr;
		}
		
		for ( let inputNo = 1; inputNo <= DiaryListAdd__fileInputMaxCount; inputNo++ ) {
			const input = form["file__0__" + inputNo];
			input.value = '';
		}
		
		form.submit();
	};
	const startUploadFiles = function(onSuccess) {
		var needToUpload = false;
		for ( let inputNo = 1; inputNo <= DiaryListAdd__fileInputMaxCount; inputNo++ ) {
			const input = form["file__0__" + inputNo];
			if ( input.value.length > 0 ) {
				needToUpload = true;
				break;
			}
		}
		
		if (needToUpload == false) {
			onSuccess();
			return;
		}
		
		var fileUploadFormData = new FormData(form);
		
		$.ajax({
			url : '/common/genFile/doUpload',
			data : fileUploadFormData,
			processData : false,
			contentType : false,
			dataType : "json",
			type : 'POST',
			success : onSuccess
		});
	}
	DiaryListAdd__submited = true;
	
	startUploadFiles(startSubmitForm);
}
</script>

<section class="section-1">
	<div class="bg-white shadow-md rounded container mx-auto p-8 mt-8">
		<form onsubmit="DiaryListAdd__checkAndSubmit(this); return false;" action="doAdd" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="genFileIdsStr" value="" />
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>날짜</span>
				</div>
				<div class="lg:flex-grow">
					<input type="text" id="startDate" name="selectedDate" class="form-row-input w-full rounded-sm border-2" autocomplete="off" placeholder="날짜를 입력해주세요.">
				</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>제목</span>
				</div>
				<div class="lg:flex-grow">
					<input type="text" name="title"
						class="form-row-input w-full rounded-sm border-2" placeholder="제목을 입력해주세요." />
				</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>내용</span>
				</div>
				<div class="lg:flex-grow">
					<textarea name="body" class="form-row-input w-full rounded-sm border-2 h-96" placeholder="내용을 입력해주세요."></textarea>
				</div>
			</div>
			
			<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
				<div class="form-row flex flex-col lg:flex-row">
					<div class="lg:flex lg:items-center lg:w-28">
						<span>첨부파일 ${inputNo}</span>
					</div>
					<div class="lg:flex-grow">
						<input type="file" name="file__0__${inputNo}" class="form-row-input w-full rounded-sm"/>
					</div>
				</div>
			</c:forEach>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex-grow">
					<div class="btns">
						<input type="submit" class="btn-primary bg-blue-500 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded" value="작성">
						<input onclick="history.back();" type="button" class="btn-info bg-red-500 hover:bg-red-dark text-white font-bold py-2 px-4 rounded" value="취소">
					</div>
				</div>
			</div>
		</form>
	</div>
</section>

<%@ include file="../part/foot.jspf"%>