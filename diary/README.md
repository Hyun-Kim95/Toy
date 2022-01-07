# 일기장

* textarea로 적은 글을 출력하면 줄바꿈도 안되고 칸을 넘어가 버림
  * pre 태그를 붙히면 크기에 맞춰서 자동 줄바꿈 됨
  * whitespace-pre-wrap
    * 테일윈드로 이 클래스를 붙히면 원래의 줄바꿈도 적용되고 크기에 맞춰서 자동 줄바꿈도 됨

* 일기 날짜 선택

  ```jsp
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
  
  <input type="text" id="startDate" >
  ```

  

