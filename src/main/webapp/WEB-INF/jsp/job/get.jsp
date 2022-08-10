<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s" %>
<jsp:include page="./aside.jsp" />

<!--작업 상세내용 읽기 -->
<!--readonly-->
<h2 class="tit-level1">작업 조회</h2>
<form id="actionForm" action="/job/delete" method="post">
   <div class="subConView">
      <!-- 메인 화면  -->
               <div class="col-md-2">
               <div class="form-group">
                  <label class="control-label"><label class="star01">프로젝트명</label></label>
                  <div class="formInput">
                     <div class="selects">
                        <select class="form-control" name="" readonly >
                           <option value="" selected="" >${job.project.project_title!=null?job.project.project_title:'기타'}</option>
                        </select>
                     </div>
                  </div>
               </div>
            </div>
            <div class="col-md-2">
                     <div class="form-group">
                        <label class="control-label"><label class="star01">단계</label></label>
                        <div class="formInput">
                           <div class="selects">
                              <select class="form-control" name="" id="privacy_state" readonly="readonly">
                                 <c:choose>
                                     <c:when test="${job.privacy_state=='110'}">
                                     <option value="110" selected>중단</option>
                                     </c:when>
                                     <c:when test="${job.privacy_state=='111'}">
                                     <option value="111" selected>진행전</option>
                                     </c:when>
                                     <c:when test="${job.privacy_state=='112'}">
                                     <option value="112" selected>진행중</option>
                                     </c:when>
                                     <c:when test="${job.privacy_state=='113'}">
                                     <option value="113" selected>완료</option>
                                     </c:when>
                                 </c:choose>
                                 <option value="111">진행전</option>
                                 <option value="112">진행중</option>
                                 <option value="113">완료</option>
                                
                              </select>
                           </div>
                        </div>
                     </div>
                  </div>
               <div class="col-md-4">
                  <div class="form-group">
                     <label class="control-label"><label class="star01">작업명</label></label>
                     <div class="formInput">
                          <input type="text" class="form-control" value="<c:out value='${job.name}'/>" readonly="readonly">
                          <input type="hidden" class="form-control" name="jobId" id="jobId" value="<c:out value='${job.id}'/>" >
                     </div> 
                  </div>
               </div>
               <div class="col-md-4">
                  <div class="form-group">
                     <label class="control-label"><label class="star01">기간</label></label>
                     <div class="formInput">
                        <div id="dateStart" class="dateStart">
                           <div class="input-group input-daterange date">
                              <input type="text" class="form-control" value="<c:out value='${job.start_date}'/>" disabled>
                              <div class="input-group-addon">~</div>
                              <input type="text" class="form-control" value="<c:out value='${job.end_date}'/>" disabled>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="col-md-1">
                  <div class="form-group">
                     <div class="formInput">
                        <div class="checkbox-out text-center">
                     <label class="control-label mt-1"><label class="">보고서</label></label>
                           <div class="formInput">
                              <div class="checkbox-out">
                                  <input  type="checkbox" id="check1" checked="checked" /> <label for="check1" class="checkbox" id="parent_week"></label> 
                              </div>                                 
                           </div>   
                        </div>
                     </div>
                  </div>
               </div>
               
               <div class="col-md-3">
                  <div class="form-group">
                     <label class="control-label"><label class="star01">업무 종류</label></label>
                     <div class="formInput">
                        <div class="selects">
                           <select class="form-control" name="" readonly="readonly">
                              <option value="" selected="" disabled="disabled"><c:out value="${job.work_type eq null ? '기타' : job.work_type }" /></option>
                              
                           </select>
                        </div>
                     </div>
                  </div>
               </div>
               
               <div class="col-md-4">
                  <div class="form-group">
                     <label class="control-label"><label class="star01">상세 업무</label></label>
                     <div class="formInput">
                        <div class="selects">
                           <select class="form-control" name="" readonly="readonly">
                              <option value="" selected="" disabled="disabled"><c:out value="${job.work_detail_type eq null ? '기타' : job.work_detail_type }" /></option>
                              
                           </select>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="col-md-4">
                  <div class="form-group">
                     <label class="control-label"><label class="star01">업무 구분</label></label>
                     <div class="formInput">
                        <div class="selects">
                           <select class="form-control" name="" readonly="readonly">
                              <option value="" selected="" disabled="disabled"><c:out value="${job.work_division eq null ? '기타' : job.work_division }" /></option>
                              
                           </select>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="col-md-12">
               			<h2 class="tit-level2 fl" style="margin-top: 6px;">하위작업</h2>
                     	<div class="BtnGroupR">
							<a href="${pageContext.request.contextPath}/job/subregister" class="btn btn-info" title=""><i class="ti-plus"></i>&nbsp;&nbsp;하위작업 추가</a>
						</div>
					</div>
               <div class="subjob">
                       <div class="col-md-7 text-center">하위작업명</div>
                       <div class="col-md-3 text-center">시작일 ~ 종료일</div>
                       <div class="col-md-1 text-center">보고서</div>
                       <div class="col-md-1 text-center">완료</div>
                           
                            <div class="col-md-7">
                               <input type="text" class="form-control" value="${sub.name}" readonly="readonly">
                            </div>
                            <div class="col-md-3">
                               <div class="input-group input-daterange date">
		                           <input type="text" class="form-control" value="<c:out value='${sub.start_date}'/>" disabled>
		                              <div class="input-group-addon">~</div>
		                           <input type="text" class="form-control" value="<c:out value='${sub.end_date}'/>" disabled>
	                           </div>
                            </div> 
                            <div class="col-md-1 text-center">
                                <!-- 주간보고서  체크 -->
                                <input  type="checkbox" id="sub_ch" checked="checked" />
                            </div>
                             <div class="col-md-1 text-center">
                                <!-- 완료 체크 -->
                                   	<input  type="checkbox" id="end_ch" />
                            </div>
                         
               </div>
               <div class="col-md-12" style="margin-top: 10px;">
                  <div class="form-group form-group-block">
                     <label class="control-label"><label class="">작업 내용</label></label>
                     <div class="formInput">
                        <textarea class="form-control" value="<c:out value='${job.contents}'/>" rows="10" readonly><c:out value='${job.contents}'/></textarea>
                     </div>
                  </div>
               </div>
               <div class="btnArea text-right">
                  <div class="col-md-1">
                  		<div class="input-group unit">
                       		<fmt:formatNumber value="${job.real_progress*100}" type="number" var="numberType" />
                         	 <input type="text" class="form-control" id="real_progress"  value="<c:out value="${numberType}"/>" disabled >
                       		 <span class="input-group-addon">%</span>
						</div>	
                  </div>
                  <div class="col-md-11">
                     <a href="${pageContext.request.contextPath}/job/modify?id=<c:out value='${job.id}'/>" class="btn btn-primary" title="수정"><i class="fa fa-edit"></i>수정</a>
                     <!-- 내 작업이 (기타값이면)==내가 임의로 만든 것이라면 -->      
                      <c:if test="${job.project_id eq 0}"> 
                        <button type="submit" id="remove" title="삭제" class="btn btn-primary">삭제</button>
                     </c:if>    <!-- 내 작업이 (기타값이면)==내가 임의로 만든 것이라면 -->   
               </div>
            </div>
         </div>
      </div>
</form>
         <!-- .main-section e -->

      <!-- .container-inner e -->

<jsp:include page="../includes/footer.jsp" />
<script>
$("#remove").click(function(e){
   e.preventDefault();
   var actionForm=$("#actionForm");
   var check = confirm("정말 해당 내용을 삭제하시겠습니까?");
   if(check==true){
      actionForm.submit();
   }else{
      return;
   }
});

</script>