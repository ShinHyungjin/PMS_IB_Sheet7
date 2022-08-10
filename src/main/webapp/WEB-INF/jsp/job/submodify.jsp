<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/my.css">
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<jsp:include page="./aside.jsp" />
<c:set var="today" value="<%=new java.util.Date()%>" />


<!--작업 등록 -->
         <h2 class="tit-level1">
               	작업내용
         </h2>
         <div class="subConView">
            <!-- 메인 화면  -->
                     <c:choose>
                     <c:when test="${job.wbs_id!=0}">
                           <div class="col-md-3">
                              <div class="form-group">
                                 <label class="control-label"><label class="star01">작업명</label></label>
                                 <label><span id="name_counter<c:out value="${job.id}"/>"></span></label>
                                 <div class="formInput">
                                       <input type="text" name="name" class="form-control" placeholder="50자 이내로 입력해 주세요." id="name" value='${fn:escapeXml(job.name) }' readOnly > 
                                 </div>
                              </div>
                           </div>
                           <div class="col-md-3">
                              <div class="form-group">
                                 <label class="control-label"><label class="star01">할당 받은 날짜</label></label>
                                 <div class="formInput">
                                    <div id="dateStart" class="dateStart">
                                       <div class="input-group input-daterange date">
                                             <input class="form-control" name="start_date"
                                                id="given_start_date" value="<c:out value='${job.start_date}'/>" readOnly>
                                             <div class="input-group-addon"> ~ </div>
                                             <input class="form-control" name="end_date" value="<c:out value='${job.end_date}'/>"
                                                id="given_end_date" readonly="readonly">
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </c:when>
                        <c:when test="${job.wbs_id==0 }">
                           <div class="col-md-6">
                              <div class="form-group">
                                 <label class="control-label"><label class="star01">작업명</label></label>
                                 <label><span id="name_counter"></span></label>
                                 <div class="formInput">
                                      <%-- <input type="text" name="name" class="form-control" id="name" value='${fn:escapeXml(job.name) }'> --%>
                                      <input type="text" name="name" class="form-control" placeholder="50자 이내로 입력해 주세요." id="name" value="<c:out value='${job.name }'/>">
                                 </div>
                              </div>
                           </div>
                        </c:when>
                        </c:choose>
                     <div class="col-md-4">
                        <div class="form-group">
                           <label class="control-label"><label class="star01">실제 진행 날짜</label></label>
                           <div class="formInput">
                              <div id="dateStart" class="dateStart">
                                 <div class="input-group input-daterange date" readonly>
                                      <input class="form-control" name="start_date" id="start_date" value="<c:out value='${job.real_start_date}'/>" disabled >
                                      <div class="input-group-addon"> ~ </div>
                                      <input class="form-control" name="end_date" value="<c:out value='${job.real_end_date}'/>" id="end_date" disabled>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                      <div class="col-md-1">
                        <div class="form-group">
                           <label class="control-label"><label class="">단계</label></label>
                           <div class="formInput">
                              <div class="selects">
                                 <select class="form-control" name="" id="privacy_state"  onchange="changeProgress(this.options[this.selectedIndex].value)">
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
	                             <fmt:formatNumber value="${job.real_progress*100}" type="number" var="numberType"/>
	                             <input type="text" class="form-control" id="real_progress" name="real_progress" value="<c:out value="${numberType}"/>" disabled>
	                             <span class="input-group-addon">%</span>
                        	</div>   
                     </div>
                  </div>
                     </div>
                     <div class="col-md-1">
                        <div class="form-group">
                           <div class="formInput text-center">
                            <!--   <div class="checkbox-out text-center"> -->
                                 <label class="control-label"><label class="">보고서 포함</label></label>
                                 <div class="formInput text-center">
                                 <c:choose>
                                    <c:when test="${job.week==1}">
                                        <input type="checkbox" id="week" style="zoom:1.6;" checked/> 
                                    </c:when>
                                     <c:when test="${job.week==0}">
                                        <input type="checkbox" id="week" style="zoom:1.6;"/> 
                                    </c:when>
                                 </c:choose>
                                 </div>
                           </div>
                        </div>
                     </div>
                     <div class="col-md-5">
                        <label class="control-label mt-2"><label class="">관련 프로젝트</label></label>
                        <c:choose>
                           <c:when test="${job.wbs_id==0 }">
                               <select class="form-control" name="" id="project_title" ></select>
                           </c:when>
                           <c:otherwise>
                                <select class="form-control" name="" id="project_title" disabled></select>
                           </c:otherwise>
                        </c:choose>
                     </div>
                     <div class="col-md-2">
                        <div class="form-group">
                           <label class="control-label mt-2"><label class="">업무 종류</label></label>
                           <div class="formInput">
                              <div class="selects">
                                 <select class="form-control" name="" id="work_type" >
                                    <option value="개발" >개발</option>
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
                           <label><span id="contents_counter"></span></label>
                           <div class="formInput">
                              <textarea class="form-control" placeholder="1000자 이내로 입력해 주세요." rows="5" name="contents" id="contents"><c:out value='${job.contents}'/></textarea>
                           </div>
                        </div>
                     </div>
                      <div class="col-md-12" style="margin-top: 5px;">
                        <div class="form-group form-group-block">
                           <label class="control-label"><label class="">비고</label></label>
                           <label><span id="comment_counter"></span></label>
                           <div class="formInput">
                              <textarea class="form-control" placeholder="100자 이내로 입력해 주세요." rows="2" name="comment" id="comment"><c:out value='${job.comment}'/></textarea>
                           </div>
                        </div>
                     </div>
                     <!-- 하위작업  -->
                     <div class="col-md-12" style="margin-top: 10px;">
                         <details open id="dt">
                        <summary>
                             <h5 style="margin-bottom: 15px;">하위 작업
                            	<button class="btn btn-info" onclick="onAddSubJob();"> + 하위 작업 추가</button>
                            </h5>
                        </summary>
                        
                        <div id="subjob-list">
                          <%--<div style="display: none;">
                             <form class="subjob" onsubmit="return onDeleteSubjob(this);"> 
                            <div class="col-md-7">
                             <div class="form-group">
                                    <div class="formInput">
                                 <input type="text" name="sub_project" class="form-control" id="sub_name"  placeholder="50자 이내로 입력해주세요."/>
                                 </div>
                              </div>
                            </div>
                            <div class="col-md-3">
                             <div class="form-group">
                                    <div class="formInput">
                                     <div id="dateStart" class="dateStart">
                                       <div class="input-group input-daterange date">
                                            <input type="date" class="form-control date" name="sub_start_date" id="sub_start_date" >
                                            <div class="input-group-addon"> ~ </div>
                                            <input type="date" class="form-control date" name="sub_end_date" id="sub_end_date" >
                                       </div>
                                    </div>
                                  </div>
                               </div>
                            </div>
                            <div class="col-md-1 text-center">
                              <div class="form-group">
                                    <div class="formInput">
                                       <div class="input-group unit">
                                   <input type="text" class="form-control" id="sub_real_progress" name="sub_real_progress"/>
                                             <span class="input-group-addon">%</span>
                                 </div>
                              </div>
                           </div>
                            </div>
                            <div class="col-md-1 text-center">
                                <!-- 주간보고서  체크 -->
                                 <div class="form-group">
                                    <label class="control-label"><label class="star01">보고서 포함</label></label>
                                    <div class="formInput">
                                    <input type="checkbox" name="sub_week" id="sub_week" value="0"/>
                                   </div>
                                </div>
                            </div>
                            <div class="col-md-11">
                                    <div class="form-group form-group-block">
                                       <div class="formInput">
                                          <textarea class="form-control"  rows="2" name="sub_contents" placeholder="하위 내용을 입력해주세요" id="sub_contents"></textarea>
                                       </div>
                                    </div>
                             </div>
                             <div class="col-md-1">
                                <input class="btn btn-primary" type="submit" value="제거" />
                             </div>
                               </form>
                          </div> --%>
                             <!-- 등록된 하위 리스트===================================================================================================================== -->                 
                             <c:forEach items="${sub}" var="sub_items" varStatus="status"> 
                             <form class="subjob" onsubmit="return onDeleteSubjob(this);"> 
                                  <div class="col-md-7">
                                        <label class="control-label"><label class="star01">하위작업명</label></label> 
                                        <label><span id="name_counter<c:out value="${sub_items.id}"/>"></span></label>
                                <div class="form-group">
                                       <div class="formInput">
                                       <input type="text" maxlength="50" oninput="maxLengthCheck(this)"  name="sub_project" class="form-control" id="sub_name<c:out value="${sub_items.id}"/>" data-value="${status.index}" value="${fn:escapeXml(sub_items.name) }" placeholder="50자 이내로 입력해주세요."/>
                                    </div>
                                 </div>
                               </div>
                               <div class="col-md-3">
                                     <label class="control-label"><label class="star01">하위작업 기간</label></label>
                                <div class="form-group">
                                       <div class="formInput">
                                        <div id="dateStart" class="dateStart">
                                          <div class="input-group input-daterange date">
                                               <input class="form-control date" value="<c:out value="${sub_items.real_start_date}"/>" name="sub_start_date" id="sub_start_date" >
                                               <div class="input-group-addon"> ~ </div>
                                               <input class="form-control date" value="<c:out value="${sub_items.real_end_date}"/>" name="sub_end_date" id="sub_end_date" >
                                          </div>
                                       </div>
                                     </div>
                                  </div>
                               </div>
                               <div class="col-md-1">
                                 <div class="form-group">
                                    <label class="control-label"><label class="">진행률</label></label>
                                       <div class="formInput text-center">
                                          	<div class="input-group unit">
	                                          <fmt:formatNumber value="${sub_items.real_progress*100}" type="number" var="numberType" />
	                                      	  <input type="text" class="form-control" id="sub_real_progress" name="sub_real_progress" value="<c:out value="${numberType}"/>"/>
	                                          <span class="input-group-addon">%</span>
                                    		</div>
                                 		</div>
                              		</div>
                               </div>
                               <div class="col-md-1 text-center">
                                   <!-- 주간보고서  체크 -->
                                    <div class="form-group">
                                       <label class="control-label"><label class="">보고서 포함</label></label>
                                       <div class="formInput">
                                       <c:choose>
                                           <c:when test="${sub_items.week==1}">
                                               <input type="checkbox" name="sub_week" id="sub_week" value="1" style="zoom:1.6;" checked/>
                                           </c:when>
                                            <c:otherwise>
                                               <input type="checkbox" name="sub_week" id="sub_week" value="0" style="zoom:1.6;"/>
                                           </c:otherwise>
                                       </c:choose>
                                      </div>
                                   </div>
                               </div>
                               <div class="col-md-11">
                                  <label class="control-label"><label class="">하위작업 내용</label></label>
                                  <label><span id="contents_counter<c:out value="${sub_items.id}"/>"></span></label>
                                       <div class="form-group form-group-block">
                                          <div class="formInput">
                                             <textarea maxlength="1000" oninput="maxLengthCheck(this)"  class="form-control"  rows="4" name="sub_contents" placeholder="1000자 이내로 입력해 주세요." value="${sub_items.contents}" id="sub_contents<c:out value="${sub_items.id}"/>"><c:out value="${sub_items.contents}"/></textarea>
                                          </div>
                                       </div>
                                </div>
                            
	                                <div class="col-md-1 text-center">
	                                   <input class="btn btn-info" type="submit" value="하위작업 삭제" style="margin-top: 40px;"/>
	                                </div>
                          
                            </form>
                        </c:forEach>
                          <!-- 등록된 하위 리스트===================================================================================================================== -->          
                       <!--    </form>  -->
                          
<!--================================ 추가 등록 작업 ===========================================================================-->
                         <form class="subjob" onsubmit="return onDeleteSubjob(this);" style="display: none"> 
                              <div class="col-md-7">
                                   <label class="control-label"><label class="star01">하위작업명</label></label>
                                   <label><span id="name_counter<c:out value="${sub_items.id}"/>"></span></label>
                                <div class="form-group">
                                       <div class="formInput">
                                       <input type="text" maxlength="50" oninput="maxLengthCheck(this)" name="sub_project" class="form-control" id="sub_name<c:out value="${sub_items.id}"/>"  placeholder="50자 이내로 입력해주세요."/>
                                    </div>
                                 </div>
                               </div>
                               <div class="col-md-3">
                                     <label class="control-label"><label class="star01">하위작업 기간</label></label>
                                <div class="form-group">
                                       <div class="formInput">
                                        <div id="dateStart" class="dateStart">
                                          <div class="input-group input-daterange date">
                                               <input class="form-control date" name="sub_start_date" id="sub_start_date" >
                                               <div class="input-group-addon"> ~ </div>
                                               <input class="form-control date"  name="sub_end_date" id="sub_end_date" >
                                          </div>
                                       </div>
                                     </div>
                                  </div>
                               </div>
                               <div class="col-md-1">
                                 <div class="form-group">
                                    <label class="control-label"><label class="">진행률</label></label>
                                       <div class="formInput text-center">
                                          <div class="input-group unit">
                                      		<input type="text" class="form-control" id="sub_real_progress" name="sub_real_progress" value="0"/>
                                          <span class="input-group-addon">%</span>
                                    </div>
                                 </div>
                              </div>
                               </div>
                               <div class="col-md-1 text-center">
                                   <!-- 주간보고서  체크 -->
                                    <div class="form-group">
                                       <label class="control-label"><label class="">보고서 포함</label></label>
                                       <div class="formInput">
                                            <input type="checkbox" name="sub_week" id="sub_week" value="0" style="zoom:1.6;"/>
                                      </div>
                                   </div>
                               </div>
                               <div class="col-md-11">
                                  <label class="control-label"><label class="">하위작업 내용</label></label>
                                  <label><span id="contents_counter<c:out value="${sub_items.id}"/>"></span></label>
                                       <div class="form-group form-group-block">
                                          <div class="formInput">
                                             <textarea class="form-control" maxlength="1000" oninput="maxLengthCheck(this)"  rows="4" name="sub_contents" placeholder="1000자 이내로 입력해 주세요." id="sub_contents<c:out value="${sub_items.id}"/>"><c:out value="${sub_items.contents}"/></textarea>
                                          </div>
                                       </div>
                                </div>
                                <div class="col-md-1 text-center">
                                   <input class="btn btn-info" type="submit" value="하위작업 삭제" style="margin-top: 40px;"/>
                                </div>
                          </form>
                    </div>
                </details>
            </div>
            <div class="col-md-12 btnArea text-right">
                 <a class="btn btn-primary" id="save" onclick="save();">저장</a>
                 <c:choose>
                     <c:when test="${job.wbs_id==0}">
                     <button type="submit" id="remove" title="삭제" class="btn btn-primary">삭제</button>
                     </c:when>
                     <c:otherwise>
                     </c:otherwise>
                  </c:choose>
               </div>
          </div>
            <!-- .main-section e -->
         <!-- .container-inner e -->

<input type="hidden" id="project_title_length"> 
<input type="hidden" id="temp_title" value="<c:out value='${job.project.project_title}'/>">
<input type="hidden" id="temp_work_type" value="<c:out value='${job.work_type}'/>">
<input type="hidden" id="temp_work_detail_type" value="<c:out value='${job.work_detail_type}'/>">
<input type="hidden" id="temp_work_division" value="<c:out value='${job.work_division}'/>">
<jsp:include page="../includes/footer.jsp" />
<!-- 지우지 마세요 삭제시 사용됩니다. -->         
<input type="hidden" name="id" id="jobId" value="<c:out value='${job.id}'/>">
<script>
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
        object.value = object.value.slice(0, object.maxLength);
    }    
}

 $(document).ready(function(e){
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

 






var countName=document.getElementsByName('sub_project').length;

/* 
       var dateLast = $('.dateStart .input-group.date').length;
       alert(dateLast);
       alert($('.dateStart .input-group.date')[dateLast-1]);

      
         $("#start_date")[dateLast-1].datepicker({
          }); 
      
         $("#end_date")[dateLast-1].datepicker({
          }); 
       */
//==============job list 들어왔을 때 바로 셀렉트 박스 디폴트 값 가져온다. 시작===========================      
var userid='<s:authentication property="principal.username"/>';
//alert("로그인: "+userid);
var myjob;
var myProject = document.getElementById('temp_title');
//alert(myProject.value);

//==============================내가 참여중인 프로젝트 리스트를 selectBox에 출력====================================
 $.ajax({
    type: "POST",   
    url: "/job/myjob",
    data : {userid : userid},
    success: function(data){
    	window.onbeforeunload = null;
       if(data!=null){
         // alert("일단 값은 들어왔어");
          myjob=data;
       }else{
          alert("오류가 발생하였습니다. 다시 시도해주세요!");
       }
   
       $("#project_title").append("<option id=none value=기타 data-value=0 data-set=0>기타</option>");
       for(var i =0; i<data.length; i++){
         // alert(data[i].PROJECT_TITLE+":"+data[i].PROJECT_NICKNAME);
         
          $("#project_title").append("<option id=select"+i+" value="+data[i].PROJECT_NICKNAME+" data-value="+data[i].PROJECT_NICKNAME+" data-set="+data[i].PROJECT_ID+">"+data[i].PROJECT_TITLE+"</option>");
         // $("#project_list").append("<li id=project_id value="+data[i].PROJECT_ID+" data-value="+data[i].PROJECT_TITLE+"><a href=\"${pageContext.request.contextPath}/project/main?id="+data[i].PROJECT_ID+"\">"+data[i].PROJECT_TITLE+"</li>");

         // $("#project_nickname").append("<option value="+data[i].PROJECT_NICKNAME+">"+data[i].PROJECT_NICKNAME+"</option>");
         var project_title_length= document.getElementById('project_title').length;
         var project_title= document.getElementById('project_title');
         var work_type= document.getElementById('work_type');
         var work_detail_type= document.getElementById('work_detail_type');
         var work_division = document.getElementById('work_division');
         
         var myProject = document.getElementById('temp_title');
            //alert("로그: "+project_title.childNodes.length);
       }
       
       var myProject = document.getElementById('temp_title');
       var myWork_type = document.getElementById('temp_work_type');
       var myWork_detail_type= document.getElementById('temp_work_detail_type');
       var myWork_division = document.getElementById('temp_work_division');
       
       //db랑 일치하는 관련프로젝트 셀렉트박스 셀렉트하기
       for(var j =0; j<project_title.childNodes.length; j++){
           if(project_title.childNodes[j].innerText === myProject.value){
              project_title.childNodes[j].setAttribute('selected','');
           }
         }
       
       for(var j =0; j<work_type.childNodes.length; j++){
           if(work_type.childNodes[j].innerText === myWork_type.value){
              work_type.childNodes[j].setAttribute('selected','');
           }
         }
       
       for(var j =0; j<work_detail_type.childNodes.length; j++){
           if(work_detail_type.childNodes[j].innerText === myWork_detail_type.value){
              work_detail_type.childNodes[j].setAttribute('selected','');
           }
         }
       for(var j =0; j<work_division.childNodes.length; j++){
           if(work_division.childNodes[j].innerText === myWork_division.value){
              work_division.childNodes[j].setAttribute('selected','');
           }
         }
       
         // alert("프로젝트 타이틀 길이: "+temp);
          //alert("프로젝트 히든타이틀: "+document.getElementById('project_title_length').value);
       
    }
    
}); //End ajax

//====================================업무 종류~~~ 상세업무까지 selectBox이며 자동으로 유저에 맞게 selected 된다================================
//들어온 사용자의 업무종류(job_work_type) & 진행도(job_privacy_state) & 업무구분(work_division) & 상세업무(work_detail_type) 를 구분하여 자동으로 셀렉트 박스에 기입한다.
var job_work_type="<c:out value="${job.work_type}"/>";
var job_privacy_state="<c:out value="${job.privacy_state}"/>";
var job_work_division="<c:out value="${job.work_division}"/>";
var job_work_detail_type="<c:out value="${job.work_detail_type}"/>";
var job_progress="<c:out value="${job.real_progress}"/>";

//alert("진행도: "+job_progress);

var work_type_length=document.getElementById('work_type').length;
var work_type_options=document.getElementById('work_type').options;

var privacy_state_length=document.getElementById('privacy_state').length;
var privacy_state_options=document.getElementById('privacy_state').options;

var work_division_length=document.getElementById('work_division').length;
var work_division_options=document.getElementById('work_division').options;

var work_detail_type_length=document.getElementById('work_detail_type').length;
var work_detail_type_options=document.getElementById('work_detail_type').options;
//alert("셀렉트 박스 옵션 길이: "+work_parent_length);
//alert("옵션 벨류: "+work_parent_options[0].innerText);
var temp_job_work_type=document.getElementById('temp_work_type').value;
//alert(temp_job_work_type);
 for(var i=0; i<work_type_length; i++){
    if(work_type_options[i].innerText===job_work_type){
       work_type_options[i].selected=true;
    }
 }
 for(var i=0; i<privacy_state_length; i++){
    if(privacy_state_options[i].value===job_privacy_state){
       privacy_state_options[i].selected=true;
    }
 }
 for(var i=0; i<work_division_length; i++){
    if(work_division_options[i].innerText===job_work_division){
       work_division_options[i].selected=true;
    }
 }
 for(var i=0; i<work_detail_type_length; i++){
    if(work_detail_type_options[i].innerText===job_work_detail_type){
       work_detail_type_options[i].selected=true;
    } 
} 
  
//하위작업 추가============================================================
	  
function onAddSubJob() {
	var detail = document.getElementById('dt');
   	if(detail.open === false) {
   		detail.open = true;
   	}
   	
    var subjobList = document.getElementById("subjob-list");
    var subjobDOM = document.querySelectorAll(".subjob")[0];
    var test1 = subjobDOM.className;
    //alert(subjobList.style.display);
    
    //하위작업 추가시 none 처리 되있던 폼을 등장시킨다.
    if(subjobDOM.style.display == "none"){
       subjobDOM.style.display= 'block';
       subjobDOM.sub_start_date.value= new Date().toISOString().slice(0, 10);
       subjobDOM.sub_end_date.value= new Date().toISOString().slice(0, 10);
    }else{
       var cloneSubJob = subjobDOM.cloneNode(true);
       
       var sub_start_date_Test = document.getElementById('sub_start_date');
       
       //cloneSubJob.sub_project.value = "";
       cloneSubJob.sub_project.value = "";
       cloneSubJob.sub_contents.value = "";
       cloneSubJob.sub_start_date.value = new Date().toISOString().slice(0, 10);
       cloneSubJob.sub_end_date.value = new Date().toISOString().slice(0, 10); 
       cloneSubJob.sub_real_progress.value=Number(0);
       cloneSubJob.sub_week.checked=false;      
       subjobList.appendChild(cloneSubJob);
         
       $('.dateStart .input-group.date').last().datepicker();       
    }
  }

//하위작업 삭제=========================================================
  function onDeleteSubjob(subJob) {
	  window.onbeforeunload = null;
	var subJobCount = document.querySelectorAll(".subjob").length;
    var subJobForm = document.querySelectorAll(".subjob");
   
    /* if(confirm("정말 삭제하시겠습니까 ?") == true){
        alert("삭제 되었습니다.");
    }
    else{
        return ;
    } */
    
    //하위작업이 1개 이상이면 그냥 삭제시킨다.
    /* if (subJobCount > 1 && confirm("하위작업을 삭제하시겠습니까 ?") == true) {
      var parent = subJob.parentNode;
      
      parent.removeChild(subJob);
      alert("삭제 되었습니다.");
    //1개일때 그냥 삭제하면 =>하위작업 추가시 기존에 미리 생성되있는 폼을 복제하는형식으로 추가가되는데 그냥삭제를 진행하면 하위작업 추가버튼을 눌렀을대 기준이 되는 폼이 사리지기 때문에 추가가되지않는 문제가 발생한다. 
    //때문에 삭제를 안하고 display를 none처리를 한다.
    }else if(subJobCount==1 && confirm("하위작업을 삭제하시겠습니까 ?") == true){
       var parent = subJob.parentNode;
       //parent.style.display = "none";
       subJobForm[subJobCount-1].style.display="none";
       alert("삭제 되었습니다.");
       //alert("부모: ");
    }
    return false;
  } */
  if (subJobCount > 1 && confirm("하위작업을 삭제하시겠습니까 ?") == true) {
      var parent = subJob.parentNode;
      parent.removeChild(subJob);
    //1개일때 그냥 삭제하면 =>하위작업 추가시 기존에 미리 생성되있는 폼을 복제하는형식으로 추가가되는데 그냥삭제를 진행하면 하위작업 추가버튼을 눌렀을대 기준이 되는 폼이 사리지기 때문에 추가가되지않는 문제가 발생한다. 
    //때문에 삭제를 안하고 display를 none처리를 한다.
    }else if(subJobCount==1 && confirm("하위작업을 삭제하시겠습니까 ?") == true){
    	//alert(subJobCount);
       var parent = subJob.parentNode;
       //parent.style.display = "none";
       subJobForm[subJobCount-1].style.display="none";
       subJobForm[subJobCount-1].sub_project.value = "";
       subJobForm[subJobCount-1].sub_contents.value = "";
       subJobForm[subJobCount-1].sub_real_progress.value=Number(0);
       //alert("부모: ");
    }
    return false;
  }
  function onDeleteSubjobList(value){
	  window.onbeforeunload = null;
	  var subjob = document.querySelectorAll(".subjob_1")[value];
     subjob.remove();
  }

  var countName=document.getElementsByName('sub_project').length;
  //alert("countName: " + countName);
  
  if(countName<=1){
 	 $("#start_date").attr("disabled",false);
 	 $("#end_date").attr("disabled",false);
 	 $("#real_progress").attr("disabled",false);
  }

function changeProgress(value){
	window.onbeforeunload = null;
	var progress = document.getElementById('real_progress');
	var subprogress = document.getElementsByName('sub_real_progress');
   if(value==='113'){
      progress.value= 100;
      for(i =0; i<999; i++){
      	subprogress[i].value= 100;
      }
   } else {
	   progress.value= ${numberType};
	   for(i =0; i<999; i++){
	      	subprogress[i].value= ${numberType};
	      }
   }
}

/* function changeState(value){
	window.onbeforeunload = null;
	var state = document.getElementById('privacy_state');
	 if(value==='100'){
		 state.value ='113';
	 } else if(value==='0') {
		 state.value ='111';
	 } else {
		 state.value ='112';
	 }
} */


function sub_week(value){
	window.onbeforeunload = null;
	if(value.checked==true){
   //   alert("체크되었습니다.");
      value.value=1;
   }
}



//상위 주간보고서 여부==라벨 사용시 활성화->현재(21.09.14)에는 input checkbox 로 변경됨으로 사용안함
function parent_week(){
	window.onbeforeunload = null;
	//alert("클릭 성공");
    var check=document.getElementById('check1').value;
    var check1=document.getElementById('check1');
    
    if(check==0){
        document.getElementById('check1').value=1;
    }else if(check==1){
        document.getElementById('check1').value=0;
    }
    
    var jobId=document.getElementById('jobId').value;
    
    //alert("프로젝트 아이디: "+jobId);
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


 
function save(){

	
   window.onbeforeunload = null;
    //하위작업 리스트 내용
    var sub_name_list = document.getElementsByName('sub_project');
    var sub_startdate_list = document.getElementsByName('sub_start_date');
    var sub_enddate_list = document.getElementsByName('sub_end_date');
    var sub_week_list = document.getElementsByName('sub_week');
    var sub_contents_list = document.getElementsByName('sub_contents');
    var sub_realprogress_list = document.getElementsByName('sub_real_progress');
   
    
    var project_title = document.getElementById('project_title');
    var selected_Project_title=project_title.options[project_title.selectedIndex].getAttribute('data-set');
    //alert("프로젝트 아이디는?: "+selected_Project_title);
    
    //1.job 아이디
    var jobId=document.getElementById('jobId').value;
    //2.로그인 유저=manager
     var manager="${user}";
     //console.log("로그인 유저: "+manager);
     
    //3.상위 작업명
    var name = document.getElementById('name').value;
    //alert("상위 작업 명: "+name);
     if(String(name).indexOf('\"') >= 0) {
   	   alert("작업명에 따옴표를 제거해주세요");
   	   return;
    } 
    
    //4.상위 작업 기간
    var start_date = document.getElementById('start_date').value;
    var end_date = document.getElementById('end_date').value;
    
    //하위작업 주말제외 일수 구하기============================================================
    var date1 = new Date(start_date);    
    var date2 = new Date(end_date);
   // alert(date1);
   // alert(date2);
    var count = 0;
    while(true){
        var temp_date = date1;
        if(temp_date.getTime() > date2.getTime()) {
            console.log("count : " + count);
            break;
        } else {
            var tmp = temp_date.getDay();
            if(tmp == 0 || tmp == 6) {
                // 주말
                console.log("주말");
            } else {
                // 평일
                console.log("평일");
                count++;         
            }
            temp_date.setDate(date1.getDate() + 1); 
        }
    
    
    }
    //alert("주말제외는?: "+count);
    var parent_count=count;
   

    //5. 작업 단계
    var privacy_state = document.getElementById('privacy_state');

    var select_privacy_state=privacy_state.options[privacy_state.selectedIndex].value;
        if(select_privacy_state=="" || select_privacy_state==undefined ){
            alert("단계를 선택해주세요!");
            return;
        }
    
     var parent_week = document.getElementById('week');
     var parent_week_check=parent_week.checked;
     if(parent_week_check==true){
        parent_week.value=1;
     }else if(parent_week_check==false){
        parent_week.value=0;
     }
     var parent_week_value=document.getElementById('week').value;
     
     
    //7.업무종류
    var work_type = document.getElementById('work_type');
    var select_work_type=work_type.options[work_type.selectedIndex].value;
        if(select_work_type=="" || select_work_type==undefined ){
            alert("업무 종류를 선택해주세요!");
            return;
        }
        //alert("업무 종류: "+select_work_type);
        
    //8.상세종류
    var work_detail_type = document.getElementById('work_detail_type');
    var select_work_detail_type=work_detail_type.options[work_detail_type.selectedIndex].value;
        if(select_work_detail_type=="" || select_work_detail_type==undefined){
            alert("상세 종류를 선택해주세요!");
            return;
        }
        //alert("상세 종류: "+select_work_detail_type);
        
    //9.업무구분
    var work_division = document.getElementById('work_division');
    var select_work_division=work_division.options[work_division.selectedIndex].value;
        if(select_work_division=="" || select_work_division==undefined ){
            alert("업무 구분을 선택해주세요!");
            return;
        }
        //alert("업무 구분: "+select_work_division);

        
   //12.내작업 진행도
    var real_progress = document.getElementById('real_progress').value;
      if(real_progress==undefined || real_progress==""){
         real_progress=0;
      }else if(real_progress<0 || real_progress>100){
         alert("진행률은 0~100% 내로 기입해주세요");
         return;
      }

    //14.상위+하위 내용
    var contents = document.getElementById('contents').value;
    //alert("내용: "+contents);
    
    /* if(String(contents).indexOf('\"') >= 0) {
   	   alert("내용에 따옴표를 제거해주세요");
   	   return;
    } */
   	   
    var comment = document.getElementById('comment').value;
 /*    if(String(comment).indexOf('\"') >= 0) {
    	   alert("비고에 따옴표를 제거해주세요");
    	   return;
     }
     */
    
    
      //alert(sub_name_list[0].value);
     var sub_name_arr=new Array();
     var sub_start_arr=new Array();
     var sub_end_arr=new Array();
     var sub_week_arr=new Array();
     var sub_contents_arr=new Array();
     var sub_progress_arr=new Array();
     var sub_mondays_arr=new Array();
     
     var countName=document.getElementsByName('sub_project').length;
     //alert("등록폼은 몇개있니? "+countName);
  
     var subjob = document.getElementsByClassName("subjob");

     
     
     //하위 작업을 등록할때 유효성 판단 로직
     //start_date, end_date, 
     for(var idx = 0; idx < countName; idx++){

        //하위작업이 1개 초과일 경우==2개이상일 경우
        //하위작업의 모든 유효성을 검사한뒤 진행할수있다.style="display: none"
        //alert(subjob[idx].style.display);
        
        if(subjob[idx].style.display != 'none'){
           if(typeof sub_name_list[idx].value === 'undefined' || sub_name_list[idx].value ==="" ){
              alert((idx)+"번째 하위 작업 제목을 등록해주세요.");
              return;
           }
           
           if(typeof sub_startdate_list[idx].value === 'undefined' || sub_startdate_list[idx].value ==='' ){
              alert((idx)+"번째 하위 작업 시작일을 등록해주세요.");
              return;
           }
           
           if(typeof sub_enddate_list[idx].value === 'undefined' || sub_enddate_list[idx].value ==='' ){
              alert((idx)+"번째 하위 작업 종료일을 등록해주세요.");
              return;
           }
           
          
          
           
   /*         if(typeof sub_contents_list[idx] === 'undefined' || sub_startdate_list[idx].value ===''){
	        	  alert("아무것도없어");
	         	 sub_contents_arr.push(" ");
	          }else{
	         	 sub_contents_arr.push(sub_contents_list[idx].value);
	          } */
	          
	        if(typeof sub_enddate_list[idx].value === 'undefined' ||sub_contents_list[idx].value === ""){
	        	 sub_contents_arr.push(" "); 
	        }else{
	        	 sub_contents_arr.push(sub_contents_list[idx].value); 
	        }  
          
           sub_name_arr.push(sub_name_list[idx].value);
           sub_start_arr.push(sub_startdate_list[idx].value);
           sub_end_arr.push(sub_enddate_list[idx].value);
          
	       
		     //하위작업 진행도에 대해서 사용자가 진행도를 안적었을 경우 기본값은 0으로 세팅한다.
		     if(sub_realprogress_list[idx].value=="" ||sub_realprogress_list[idx].value==undefined){
		        sub_realprogress_list[idx].value=0;
		     }else{
		     	sub_progress_arr.push(sub_realprogress_list[idx].value);
		     }
		     //하위작업 보고서 여부를 판단하여 체크박스가 체크되면 1 아니면 0
		     if(sub_week_list[idx].checked==true){
		        sub_week_arr.push(1);
		     }else if(sub_week_list[idx].checked==false){
		        sub_week_arr.push(0);
		     }
        }
          else{
            sub_name_arr.push("");
            sub_start_arr.push("");
            sub_end_arr.push("");
            sub_contents_arr.push("999");
        	sub_week_arr.push(3);
        	sub_progress_arr.push(999);

        }
        
     }//End for
     
     var formData={id:jobId, name:name, start_date:start_date, end_date:end_date,work_type:select_work_type,parent_count:parent_count,
               work_detail_type:select_work_detail_type, work_division:select_work_division, week:parent_week_value, privacy_state:select_privacy_state, 
               real_progress:real_progress, contents:contents, comment : comment, 
               sub_name: sub_name_arr, sub_start_date: sub_start_arr, sub_end_date: sub_end_arr, sub_week: sub_week_arr, sub_contents: sub_contents_arr, sub_progress: sub_progress_arr, project_id:selected_Project_title
           }
    $.ajax({
        type: "post",
        url: "/job/modify",
        data: formData,
        async: "true",
        success:function(data){
           if(data==="success"){
              alert("수정이 완료되었습니다.");
               location.href="/job/list";
           }else{
              alert("오류가 발생하였습니다. 다시 시도해주세요");
           }
        }
    });//ajax
}//save

$(document).ready(function(){
	window.onbeforeunload = null;
    $("#remove").click(function(e){
       e.preventDefault();
       window.onbeforeunload = null;
        if(confirm("정말 삭제하시겠습니까 ?") == true){
             alert("삭제 되었습니다.");
         }
         else{
             return ;
         }
         var jobId=document.getElementById('jobId').value;
         var formData={id:jobId}
         $.ajax({
           url: "/job/delete",
           type: "post",
           data: formData,
           success:function(data){
                 if(data==="success"){
                     location.href="/job/list";
                 }else{
                    alert("오류가 발생하였습니다. 다시 시도해주세요");
                 }
              }
         });
      });
    
    
/*    var project_title_length = document.getElementById('project_title_length').value;
    alert("프로젝트 나와서  타이틀 길이: "+project_title_length); */
    
});    

    
</script>