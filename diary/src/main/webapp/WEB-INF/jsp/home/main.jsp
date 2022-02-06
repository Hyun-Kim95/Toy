<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>
<script>
    $(function(){
        var today = new Date();
        var date = new Date();           
        $("input[name=preMon]").click(function() { // 이전달
            $("#calendar > tbody > td").remove();
            $("#calendar > tbody > tr").remove();
            today = new Date ( today.getFullYear(), today.getMonth()-1, today.getDate());
            buildCalendar();
        })
        
        $("input[name=nextMon]").click(function(){ //다음달
            $("#calendar > tbody > td").remove();
            $("#calendar > tbody > tr").remove();
            today = new Date ( today.getFullYear(), today.getMonth()+1, today.getDate());
            buildCalendar();
        })
        
        function buildCalendar() {
            
            nowYear = today.getFullYear();
            nowMonth = today.getMonth();
            firstDate = new Date(nowYear,nowMonth,1).getDate();
            firstDay = new Date(nowYear,nowMonth,1).getDay(); //1st의 요일
            lastDate = new Date(nowYear,nowMonth+1,0).getDate();
            if((nowYear%4===0 && nowYear % 100 !==0) || nowYear%400===0) { //윤년 적용
                lastDate[1]=29;
            }
            $(".year_mon").text(nowYear+"년 "+(nowMonth+1)+"월");
            for (i=0; i<firstDay; i++) { //첫번째 줄 빈칸
                $("#calendar tbody:last").append("<td class='shadow rounded container'></td>");
            }
            for (i=1; i <=lastDate; i++){ // 날짜 채우기
                plusDate = new Date(nowYear,nowMonth,i).getDay();
                if (plusDate==0) {
                    $("#calendar tbody:last").append("<tr></tr>");
                }
                $("#calendar tbody:last").append("<td class='date flex-shrink shadow rounded container sm:text-xl md:text-2xl'>"
                		+ "<button name=\""+"selectedDate\""+" class=\""+"btn-primary px-3 2xl:px-24 xl:px-20 lg:px-16 md:px-10 sm:px-9 sm:py-4 md:py-5 lg:py-8\""+ "value=\"" + nowYear + "-" + (nowMonth+1) + "-" + i + "\">"+ i +"</button>" +"</td>");
            }
            if($("#calendar > tbody > td").length%7!=0) { //마지막 줄 빈칸
                for(i=1; i<= $("#calendar > tbody > td").length%7; i++) {
                    $("#calendar tbody:last").append("<td class='shadow rounded container></td>");
                }
            }
            $(".date").each(function(index){ // 오늘 날짜 표시
                if(nowYear==date.getFullYear() && nowMonth==date.getMonth() && $(".date").eq(index).text()==date.getDate()) {
                    $(".date").eq(index).addClass('colToday font-bold bg-green-100');
                }
            })
        }
        buildCalendar();
    })
    
</script>

<section class="section-1">
	<form action="../diaryList/list" class="mx-2">
	    <table id="calendar" class="bg-white shadow rounded container mx-auto p-8 mt-8">
	        <thead>
	            <tr class="shadow">
	                <th><input class="bg-white sm:text-3xl md:text-5xl rounded" name="preMon" type="button" value="◀"></th>
	                <th colspan="5" class="year_mon sm:text-3xl md:text-5xl p-5"></th>
	                <th><input class="bg-white sm:text-3xl md:text-5xl rounded" name="nextMon" type="button" value="▶"></th>
	            </tr>
	            <tr class="md:text-2xl sm:text-xl">
	                <th class="shadow flex-grow-0 flex-shrink-0">일</th>
	                <th class="shadow">월</th>
	                <th class="shadow">화</th>
	                <th class="shadow">수</th>
	                <th class="shadow">목</th>
	                <th class="shadow">금</th>
	                <th class="shadow">토</th>
	            </tr>
	        </thead>
	        <tbody>
	        </tbody>
	    </table>
	    <div class="bg-white shadow rounded container mx-auto p-8 mt-5">
	    	<div class="text-3xl text-center">한달 이내에 빠진 날짜</div>
	    	<div class="flex">
		    	<c:forEach items="${missings}" var="missing">
		    		<div class="flex">
		    			<c:if test="${missing != null}">
		    				<button name="selectedDay" class="m-3 btn-primary bg-blue-500 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded" value="${missing}">${missing}</button>
		    			</c:if>
		    		</div>
		    	</c:forEach>
	    	</div>
	    </div>
	</form>
</section>

<%@ include file="../part/foot.jspf"%>