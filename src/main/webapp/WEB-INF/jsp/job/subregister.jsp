<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<jsp:include page="./aside.jsp" />

<c:set var="today" value="<%=new java.util.Date()%>" />
<!--작업 등록 --> 
         <h2 class="tit-level1"> 
			새작업
         </h2>
         <div class="subConView">
            <!-- 메인 화면  -->
            		 <div class="col-md-6">
                        <div class="form-group">
                           <label class="control-label"><label class="star01">작업명</label></label>
                           <label><span id="name_counter">(0/50)</span></label>
                           <div class="formInput">
                              	<input type="text" name="name" class="form-control" id="name" placeholder="작업명을 입력해 주세요.">
                           </div>
                        </div>
                     </div>
                     <div class="col-md-4">
                        <div class="form-group">
                           <label class="control-label"><label class="star01">기간</label></label>
                           <div class="formInput">
                              <div id="dateStart" class="dateStart">
                                 <div class="input-group input-daterange date">
                                    <input class="form-control" name="start_date" id="start_date" >
                                    <div class="input-group-addon"> ~ </div>
                                    <input class="form-control" name="end_date" id="end_date" >
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="col-md-1">
                        <div class="form-group">
                           <label class="control-label"><label class="star01">단계</label></label>
                           <div class="formInput">
                              <div class="selects">
                                 <select class="form-control" name="" id="privacy_state" onchange="changeProgress(this.options[this.selectedIndex].value)">
                                    <option value="111">진행전</option>
                                    <option value="112">진행중</option>
                                    <option value="113">완료</option>
                                    <option value="110">중단</option> 
                                 </select>
                              </div>
                           </div>
                        </div>
                     </div>
                      <div class="col-md-1">
                     		<div class="form-group">
                     		<label class="control-label"><label class="">진행률</label></label> 
                     			<div class="formInput">
			                          <div class="input-group unit">
		                                 <input type="text" class="form-control" id="real_progress" value="0">
		                                 <span class="input-group-addon">%</span>
			                          </div>   
		                      	</div>
		                  </div>
                     </div>
                     <div class="col-md-1">
                        <div class="form-group">
                              <div class="formInput text-center">
                              <label class="control-label"><label class="">보고서 포함</label></label>
                              <div class="formInput text-center">
                                    <input type="checkbox" id="week" style="zoom:1.6;"  checked="checked"/>
                                 </div>
                           	   </div>
                          </div>
                     </div>
                     <div class="col-md-1">
						<label class="control-label mt-2"><label class="">관련 프로젝트</label></label>
	                     <select onchange="onBtnClick()" class="form-control" name="selectState" id="selectState">
							<option value="111">진행전</option>
							<option value="112">진행중</option>
							<option value="113">완료</option>
							<option value="110">중단</option>
						</select>
					</div>
                     <div class="col-md-4">
                     	<label class="control-label mt-2"><label class=""> </label></label>
                     	<select class="form-control" name="project_id" id="project_id" >
                     		<option value=0  data-value=기타>기타</option>
                     	</select>
                     </div>
                     <div class="col-md-2">
                        <div class="form-group">
                           <label class="control-label"><label class="">업무 종류</label></label>
                           <div class="formInput">
                              <div class="selects">
                                 <select class="form-control" name="" id="work_type">
                                    <option value="개발">개발</option>
                                    <option value="업무관리">업무관리</option>
                                    <option value="제안">제안</option>
                                    <option value="기타">기타</option>
                                 </select>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="col-md-2">
                        <div class="form-group">
                           <label class="control-label"><label class="">상세 업무</label></label>
                           <div class="formInput">
                              <div class="selects">
                                 <select class="form-control" name="work_detail_type" id="work_detail_type">
                                    <option value="개발">개발</option>
                                    <option value="버그수정">버그수정</option>
                                    <option value="미팅">미팅</option>
                                    <option value="보고">보고</option>
                                    <option value="출장">출장</option>
                                    <option value="산출물">산출물</option>
                                    <option value="테스트">테스트</option>
                                    <option value="작성">작성</option>
                                    <option value="보완">보완</option>
                                    <option value="사업관리">사업관리</option>
                                    <option value="신규개발">신규개발</option>
                                    <option value="신규(분석)">신규(분석)</option>
                                    <option value="신규(설계)">신규(설계)</option>
                                    <option value="자기계발">자기계발</option>
                                    <option value="건강검진">건강검진</option>
                                    <option value="휴가">휴가</option>
                                    <option value="기타">기타</option>
                                 </select>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="col-md-2">
                        <div class="form-group">
                           <label class="control-label"><label class="">업무 구분</label></label>
                           <div class="formInput">
                              <div class="selects">
                                 <select class="form-control" name="work_division"
                                    id="work_division">
                                    <option value="주 업무">주 업무</option>
                                    <option value="지원 업무">지원 업무</option>
                                 </select>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="col-md-12" style="margin-top: 10px;">
                        <div class="form-group form-group-block">
                           <label class="control-label"><label class="">작업 내용</label></label>
                           <label><span id="contents_counter">(0/1000)</span></label>
                           <div class="formInput">
                              <textarea class="form-control" placeholder="내용을 입력해 주세요." rows="5" name="contents" id="contents"></textarea>
                           </div>
                        </div>
                     </div>
                     <div class="col-md-12" style="margin-top: 10px;">
                        <div class="form-group form-group-block">
                           <label class="control-label"><label class="">비고</label></label>
                           <label><span id="contents_comment">(0/100)</span></label>
                           <div class="formInput">
                              <textarea class="form-control" placeholder="비고를 입력해 주세요." rows="2" name="comment" id="comment"></textarea>
                           </div>
                        </div>
                     </div>
                     <div class="col-md-12 btnArea text-right">
                        <a class="btn btn-primary" onclick="save();">저장</a>
                     </div>
                  </div>
            <!-- .main-section e -->
         </div>
         <!-- .container-inner e -->

<jsp:include page="../includes/footer.jsp" />
<script>

$(document).ready(function(e){
	$('#selectState').val(112);
	onBtnClick();
	
	document.getElementById('start_date').value = new Date().toISOString().substring(0, 10);
    document.getElementById('end_date').value = new Date().toISOString().substring(0, 10);
	
		//제목
		$('#name').on('keyup', function() {
	    $('#name_counter').html("("+$(this).val().length+"/ 50)");
	    if($(this).val().length > 50) {
		        $(this).val($(this).val().substring(0, 50));
		        $('#name_counter').html("(50 / 50)");
		    }
		});
	
		//내용
		$('#contents').on('keyup', function() {
		    $('#contents_counter').html("("+$(this).val().length+"/ 1000)");
		
		    if($(this).val().length > 1000) {
		        $(this).val($(this).val().substring(0, 1000));
		        $('#contents_counter').html("(1000 / 1000)");
		    }
		});
		
		//비고
		$('#comment').on('keyup', function() {
		    $('#comment_counter').html("("+$(this).val().length+"/ 100)");
		
		    if($(this).val().length > 100) {
		        $(this).val($(this).val().substring(0, 100));
		        $('#comment_counter').html("(100 / 100)");
		    }
		});
});

$(document).ready(function(e){
    var name = $("#name").val();
    var namech = RegExp(/^[가-힣]{2,5}$/);
   
    if(namech.test($('#name').val())){
    	$("#name-no").css('display', 'none'); 	
        return true;
    } 
    $("#name-no").css('display', 'inline-block');
    return false;
    
});


//==============job list 들어왔을 때 바로 셀렉트 박스 디폴트 값 가져온다. 시작===========================	   

function onBtnClick() {
		var state = $('#selectState').val();
	    console.log("state :" + state);
	    var userid='<s:authentication property="principal.username"/>';
	    console.log("usr :" + userid);
	    
	     //alert("로그인: "+userid);
	 	 $.ajax({
			 type: "POST",	
			 url: "/job/myjob2",
			 data: {user: userid, state: state},
			 success: function(data){
				 	var $proj = $("#project_id");
				 	$proj.html('');

					 for(var i =0; i<data.length; i++){
						 if(data[i].STATE == state){
						 	$proj.append("<option id="+"selectTitle("+i+") value="+data[i].PROJECT_ID+" data-value="+data[i].PROJECT_NICKNAME+">"+data[i].PROJECT_TITLE+"</option>");
						 }
			   		}
				 	$proj.append('<option value="0" data-value="기타">기타</option>');
			}
		});
}
    
	  var div = document.getElementsByTagName("div");

	  for (var i = 0; i < div.length; i++) {
	 	 div[i].onchange = function (evt) {
	      if (typeof window.onbeforeunload !== "function") {
	        window.onbeforeunload = function () {
	          return "변경사항을 무시하고 이동하시겠습니까?";
	        };
	      }
	    };
	  }
    
	  
   function save() {
	   window.onbeforeunload = null;
      //0.로그인 유저=manager
      var manager = '<s:authentication property="principal.username"/>';
      console.log("로그인 유저: " + manager);
      
      //1.상위 작업명
      var name = document.getElementById('name').value;
      console.log("받은 name : " + String(name));
      if (name == "" || name == undefined) {
          alert("제목 선택해주세요!");
          return;
       } 
      if(String(name).indexOf('\"') >= 0) {
    	   alert("작업명에 따옴표를 제거해주세요");
    	   return;
       }
      
      //alert("상위 작업 명: "+name);
      //2.상위 작업 기간 & 주간업무 활성화 여부
      var start_date = document.getElementById('start_date').value;
      var end_date = document.getElementById('end_date').value;
      //alert("상위 작업 시작기간: "+start_date);
      //alert("상위 작업 종료기간: "+end_date);
      
      
      //3.단계 파악(중단-진행전-진행중-완료)
      var privacy_state = document.getElementById('privacy_state');
      var select_privacy_state = privacy_state.options[privacy_state.selectedIndex].value;
      if (select_privacy_state == "" || select_privacy_state == undefined) {
         alert("단계를 선택해주세요!");
         return;
      }
      
      //4.내작업 진행도
       var real_progress = document.getElementById('real_progress').value;
     if(real_progress==undefined || real_progress==""){
        real_progress=0;
     }  
     

      // 상위 작업 주간보고서 여부
      var parent_week = document.getElementById('week');
      var parent_week_check=parent_week.checked;
      if(parent_week_check==true){
         parent_week.value=1;
      }else if(parent_week_check==false){
         parent_week.value=0;
      }
      //alert("보고서 여부: "+parent_week.value);
      //5.프로젝트 아이디
      //var project_id = document.getElementById('project_id');
      var project_id=document.querySelector('select[name="project_id"] option:checked').value;
      //alert("프로젝트 아이디는?  "+project_id);
      
     //6.업무종류
      var work_type = document.getElementById('work_type');
      var select_work_type = work_type.options[work_type.selectedIndex].value;
      if (select_work_type == "" || select_work_type == undefined) {
         alert("업무 종류를 선택해주세요!");
         return;
      }
      
      //alert("업무 종류: "+select_work_type);
      //7.상세 업무
      var work_detail_type = document.getElementById('work_detail_type');
      var select_work_detail_type = work_detail_type.options[work_detail_type.selectedIndex].value;
      if (select_work_detail_type == "" || select_work_detail_type == undefined) {
         alert("상세 종류를 선택해주세요!");
         return;
      }
      //alert("상세 종류: "+select_work_detail_type);
      //8.업무구분
      var work_division = document.getElementById('work_division');
      var select_work_division = work_division.options[work_division.selectedIndex].value;
      if (select_work_division == "" || select_work_division == undefined) {
         alert("업무 구분을 선택해주세요!");
         return;
      }
      //alert("업무 구분: "+select_work_division);
    
      //9.내용
      var contents = document.getElementById('contents').value;
      //alert("내용: "+contents);
		 if(String(contents).indexOf('\"') >= 0) {
    	   alert("내용에 따옴표를 제거해주세요");
    	   return;
       }
      //10.비고 
      var comment = document.getElementById('comment').value;
      
      if(String(comment).indexOf('\"') >= 0) {
   	   alert("비고에 따옴표를 제거해주세요");
   	   return;
      }
      
      var formData = {
         manager : manager,
         project_id : project_id,
         name : name,
         start_date : start_date,
         end_date : end_date,
         work_type : select_work_type,
         work_detail_type : select_work_detail_type,
         work_division : select_work_division,
         week : parent_week.value,
         privacy_state : select_privacy_state,
         real_progress : real_progress,
         contents : contents,
         comment : comment
      }
      //alert(project_id);
		
      $.ajax({
         type : "post",
         url : "/job/register",
         data : formData,
         async : "true",
         success : function(data) {
            if(data=="success"){
               alert("등록되었습니다");
               location.href = "/job/list";
            }else if(data=="false"){
               alert("오류가 발생하였습니다");
            }
         }
      });//ajax
   }//save
   
   function changeProgress(value){
		var progress = document.getElementById('real_progress');
		if(value==='111'){
			progress.value=0;
		}else if(value==='113'){
			progress.value=100;
		}
	}
   
</script>