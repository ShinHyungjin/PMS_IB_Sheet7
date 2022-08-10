<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s" %> 

<%
   Object weekReportDeptJson = null; 
   JSONObject calendarDate = (JSONObject) request.getAttribute("calendarDate");
   JSONObject jsonObj = null; 
   JSONArray jsonarr = null; 
   JSONObject jsonarrObj = null; 

   if(request.getAttribute("weekReportDeptJson") != null) {
      weekReportDeptJson = (Object) request.getAttribute("weekReportDeptJson");
      jsonObj = (JSONObject)weekReportDeptJson;
      jsonarr = (JSONArray)jsonObj.get("DATA");
      jsonarrObj = (JSONObject)jsonarr.get(0);
   }
%>

<jsp:include page="../includes/header.jsp" />   
<c:set var="jobjson" value="${param.jobjson.DATA}" />
<input type="hidden" value="<c:out value="${jobjson.this_friday}"/>">
<div id="wrapper">
    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav metismenu" id="side-menu">
                <li><a href="#"><i class="mnImg02"></i><span class="nav-label">내작업</span><span class="arrow01"></span></a>
                    <ul class="nav nav-second-level">
                        <li><a href="${pageContext.request.contextPath}/job/list">전체</a></li>
                        <li><a href="${pageContext.request.contextPath}/job/before">진행전  <c:out value="${beforelastCnt}" /></a></li>
						<li><a href="${pageContext.request.contextPath}/job/ing">진행중  <c:out value="${inglastCnt}" /></a></li>
                        <li><a href="${pageContext.request.contextPath}/job/stop">중단</a></li>
                        <li><a href="${pageContext.request.contextPath}/job/end">완료</a></li>
                    </ul>
                </li>
                <li class="active"><a href="#"><i class="mnImg01"></i> <span class="nav-label">보고서</span><span class="arrow01"></span></a>
                    <ul class="nav nav-second-level">
                        <li class="active"><a href="${pageContext.request.contextPath}/report/team">내부서</a></li>
                        <li><a href="${pageContext.request.contextPath}/report/project">프로젝트별</a></li>
                    </ul>
                </li>
                <li><a href="${pageContext.request.contextPath}/project/list"><i class="mnImg04"></i> <span class="nav-label">프로젝트</span> <span class="arrow01"></span></a>
            </li>
                <s:authorize access="!hasRole('ROLE_USER')">
               <li><a href="#"><i class="mnImg05"></i> <span class="nav-label">시스템관리</span> <span class="arrow01"></span></a>
                  <ul class="nav nav-second-level">
                     <s:authorize access="hasRole('ROLE_ADMIN')">
                        <li><a href="${pageContext.request.contextPath}/admin/check">사용자 관리</a></li>
                     </s:authorize>
                     <li><a href="${pageContext.request.contextPath}/project/project">프로젝트 관리</a></li>
                  </ul>
               </li>
            </s:authorize>
            </ul>
        </div>
    </nav>
    <!-- #gnb e -->
    <div id="page-wrapper">
        <div class="subConView">
            <div class="conWrap">
                <div class="projectInfo">
                   <div class="form-inline form-group">
                     <div class="col-sm-10">
                         <input type="hidden" id="filename" class="form-control" value="주간보고서_<%if(jsonarrObj != null){%><%=jsonarrObj.get("department")%><%}%>" size="25" class="inputbox" />
                          <input type="hidden" id="sheetname" value="<%=calendarDate.get("calendarDate")%>" size="15" class="inputbox" />
                        <input type="hidden" class="checkbox" type="checkbox" checked="checked" id="merge" />
                        <input type="hidden" class="checkbox" type="checkbox" checked="checked" id="design" />
                     </div>
                        <label style="float:left; font-size:20pt;">주간업무보고서 - 부서별 <%if(jsonarrObj != null){%> (<%=jsonarrObj.get("department")%>)<%}%></label>
                        <a href="javascript:doAction('down2excel');" class="btn btn-primary" style="float:right;">엑셀 내려받기</a>
                 </div>
               </div>
                    <s:authorize access="isAuthenticated()">
                       <s:authentication property="principal.username" var="user" />
                    </s:authorize>
                    <div class="col-md-3">
                        <div class="form-group"> 
                           <div class="formInput">
                              <form id="actionForm" name="actionForm">
                                 <div id="weekDate" class="weekDate">
                                    <div class="input-group input-daterange row date">
                                       <div class="col-md-3 text-center" style="padding: 0px;">
                                          <label class="control-label" style="font-size: medium; margin-top: 7px;">조회 날짜 </label>
                                       </div>
                                       <div class="col-md-9" style="padding-left: 0px;">
                                            <input autocomplete="off" class="form-control" name="weekReportDate" id="weekReportDate" value="<%=calendarDate.get("calendarDate")%>" readOnly>
                                         </div>
                                    </div>
                                 </div>
                              </form>
                           </div>
                        </div>
                     </div>
                     
                     
                     
                   <div class="ib_product" style="height:650px;">
                   <!-- <div style="width:calc(100% - 20px); height:calc(100% - 300px);"> -->
                       <script type="text/javascript"> createIBSheet("mySheet", "100%", "100%"); </script>
                   </div>
               </div>
           </div>
       </div>
   </div>
   <!-- ------------------------------------모달창--------------------------------------------------------------- --> 
   <div class="modal inmodal fade" id="jobModal" tabindex="-1" role="dialog" aria-hidden="true">
         <div class="modal-dialog modal-lg">
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                     <h4 class="modal-title">작업 조회</h4>
                  <input type="hidden" id="job_id" name="job_id" value="" />
               </div>
               <div class="modal-body">
                  <div class="subConView" id="subConView">
                        <div class="col-md-4">
                             <div class="form-group">
                                    <label class="control-label"><label class="star01">작업명</label></label>
                                    <div class="formInput">
                                       <input type="text" name="job_name" class="form-control" id="job_name" readonly="readonly"/>
                                    </div>
                              </div>
                         </div>
                        <div class="col-md-4">
                        <div class="form-group">
                           <label class="control-label"><label class="star01">실제 진행 날짜</label></label>
                           <div class="formInput">
                              <div id="dateStart" class="dateStart">
                                 <div class="input-group input-daterange date" readonly>
                                      <input class="form-control" name="start_date" id="start_date" value="<c:out value='${job.real_start_date}'/>" readOnly >
                                      <div class="input-group-addon"> ~ </div>
                                      <input class="form-control" name="end_date" value="<c:out value='${job.real_end_date}'/>" id="end_date"  readOnly>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="col-md-2">
                        <div class="form-group">
                           <label class="control-label"><label class="">단계</label></label>
                           <div class="formInput">
                              <div class="selects">
                        		 <input type="text" class="form-control" id="privacy_state" readOnly >
                        		 <c:out value='${job.private_state}' default =''/>
                              </div>
                           </div>
                        </div>
                     </div>
                     
                     <div class="col-md-2">
                        <div class="form-group">
                           <label class="control-label"><label class="">진행률</label></label>
                           <div class="formInput">
                             <div class="input-group unit">
	                             <input type="text" class="form-control" id="this_week_performence"   readOnly >
	                             <span class="input-group-addon">%</span>
                        	</div>   
                           </div>
                  		</div>
                     </div>
                     
                <div class="col-md-4">
                             <div class="form-group">
                                    <label class="control-label"><label class="star01">관련 프로젝트</label></label>
                                    <div class="formInput">
                                       <input type="text"  class="form-control" id="project_id" readonly="readonly"/>
                                    </div>
                              </div>
                         </div>
                     
                  		<div class="col-md-2">
                             <div class="form-group">
                                    <label class="control-label"><label class="star01">업무종류</label></label>
                                    <div class="formInput">
                                       <input type="text" class="form-control" id="work_type" readonly="readonly"/>
                                    </div>
                              </div>
                         </div>
                     
                 		 <div class="col-md-2">
                             <div class="form-group">
                                    <label class="control-label"><label class="star01">상세 업무</label></label>
                                    <div class="formInput">
                                       <input type="text" class="form-control" id="work_detail_type" readonly="readonly"/>
                                    </div>
                              </div>
                         </div>
                     
                  		<div class="col-md-2">
                             <div class="form-group">
                                    <label class="control-label"><label class="star01">업무 구분</label></label>
                                    <div class="formInput">
                                       <input type="text" class="form-control" id="work_division" readonly="readonly"/>
                                    </div>
                              </div>
                         </div>
                     
                         
                         <div class="col-md-12" style="margin-top: 10px;">
                              <div class="form-group form-group-block">
                                  <label class="control-label"><label class="">작업 내용</label></label>
                                  <div class="formInput">
                                     <textarea class="form-control" rows="8" name="contents" id="contents" readonly="readonly" placeholder="등록한 내용이 없습니다.">
                                     <c:out value='${job.comment}' default =''/>
		                    	 	</textarea>
                                  </div>
                              </div>
                         </div>
                         <div class="col-md-12" style="margin-top: 10px;">
                              <div class="form-group form-group-block">
                                  <label class="control-label"><label class="">비고</label></label>
                                  <div class="formInput">
                                  <textarea class="form-control" rows="3" name="comment" id="comment" readonly="readonly" placeholder="등록한 내용이 없습니다."><c:out value='${job.comment}'/></textarea>
                                  </div>
                              </div>
                         </div>
                         
                         <div class="sub_list">
                         
                         
                         </div>
                    <!-- 하위작업 나와야 하는 부분 --> 
                             
                     </div>
                  </div>
               </div>
            </div>
         </div>
   <script>
   document.querySelector('input').addEventListener('keypress',(e)=>{
	   if(e.keyCode===13){
		   e.preventDefault();
		   document.querySelector('input').blur();
	   }
   })
      var json = <%=weekReportDeptJson%>;
      var list = new Array();
      var total = new Object();
      var childArr = new Array();
      var childMap = new Map();

      /*Sheet 기본 설정 */
      function LoadPage() {
    	  mySheet.SetScrollInfoPosition("none");
    	  
         mySheet.SetTheme('BLM', 'ModernBlue');
         var userid='<s:authentication property="principal.username"/>';
            var myjob; 
            $.ajax({
              type: "POST",   
              url: "/job/myjob",
              data : {userid : userid},
              success: function(data){
                 if(data!=null){
                    myjob=data;
                 }
                 //console.log(myjob);
                 for(var i =0; i<data.length; i++){
                    $("#project_list").append("<li id=project_id value="+data[i].PROJECT_ID+" data-value="+data[i].PROJECT_TITLE+"><a href=\"${pageContext.request.contextPath}/project/wbs?id="+data[i].PROJECT_ID+"\">"+data[i].PROJECT_TITLE+"</li>");
                 }
              }
            });
           var formData = ("#actionForm");
           $(formData).attr("action","/report/team");
           $(formData).attr("method","post");
           $("#weekDate .input-group.date").datepicker({
              endDate : new Date()
           });
           $('#weekDate .input-group.date').datepicker().on("changeDate", function (e) {
              var date = new Date();
              date = e.date;
              //console.log(date);
              //console.log("Date: "+date.getDate()+
              //          "/"+(date.getMonth()+1)+
               //         "/"+date.getFullYear());
              $(formData).submit();
              
              /*
              $.ajax({
                 type:"post",
                  url: "/report/team",
                  data : {date : date},
                  success: function(data){
                     console.log(data);
                  }, error : function(xhr, status) {
                       console.log("실패 : " + xhr + "\t" + status);
                       }
              });
              */
           });
            
      
           
            if(json != null) {
                 for (var i = 0; i < json.DATA.length; i++) {
                      var data = new Object();
                      var job = json.DATA[i];
                      if(job.job_id !== 0){
                      for(var j=0; j < json.DATA.length; j++) {
                         if(j == i) {
                            continue;
                         }
                         var searchChild = json.DATA[j];
                         if(job.job_id == searchChild.parent) {
                            //console.log(searchChild.job_name + " 이 "+ job.job_name + " 의= 하위자식");
                            job.job_name = job.job_name + "\n"+"  ㄴ " + searchChild.job_name+"("+searchChild.start_date+")~("+searchChild.end_date+")"; 
                            job.child_id += searchChild.job_id+",";
                            job.this_week_performence=job.this_week_performence;
                           // childMap.set("sub_name",  searchChild.job_name);
                            //childMap.set("sub_content",searchChild.job.contents);
                            //childMap.set("sub_conmment",searchChild.job.comment);
                         }
                      }
                     // childArr.push(childMap);
                      }
                      if(job.parent == 0) {
                      //console.log("job name : " + job.job_name);
                     // console.log("job user_id : " + job.user_id);
                      //console.log("금주실적: "+ job.this_week_performence);
            data.user_id = job.user_id; //유저이름이 나와야 함으로 사실 db값에서는 manager값을 as user_id로
            data.project_id = job.project_id; // DB에서는 PROJECT 테이블의 PROJECT_TITLE 값이다.
            data.work_type = job.work_type;
            data.work_detail_type = job.work_detail_type;
            data.work_division = job.work_division;
            data.work_contents = job.job_name;
            data.start_date = job.start_date;
            data.end_date = job.end_date;
            data.this_week_plan = job.this_week_plan;
            data.this_week_performence = job.this_week_performence;
            data.next_week_plan = job.next_week_plan;
            data.comment = job.comment;
            data.job_id = job.job_id;
            //data.this_week_monday = job.this_week_monday;
            //data.this_week_saturday = job.this_week_saturday;
            //data.next_week_monday = job.next_week_monday;
            //data.next_week_saturday = job.next_week_saturday;
            //data.child_id = job.child_id;
            list.push(data);
            //console.log("data_ID : " + data.work_contents);
          }
         }
         total.DATA = list;
         
         } else {
        		mySheet.LoadSearchData("{data:[]}");
         }
         //아이비시트 초기화
         var initSheet = {};
         mySheet.SetEditable(false);
         
         
         initSheet.Cfg = {
            SelectionSummary : "EmptyCell|DelRow",
            SearchMode : smLazyLoad,
            //MergeSheet : msHeaderOnly,
            PrevColumnMergeMode : 0,
            SizeMode : 1
         };

         initSheet.Cols = [ {
            Header : "수행자",
            ColMerge : 1,
            Type : "Text",
            SaveName : "user_id",
            Align : "Center",
            MinWidth : 40,
            Width : 50
         }, {
            Header : "프로젝트",
            ColMerge : 1,
            Type : "Text",
            MinWidth : 100,
            SaveName : "project_id",
            Wrap : 1,
            MultiLineText : 1,
            Align : "Center"
         }, {
            Header : "업무종류",
            ColMerge : 1,
            Type : "Text",
            MinWidth : 40,
            Width : 50,
            SaveName : "work_type",
            Align : "Center"
         }, {
            Header : "상세업무",
            ColMerge : 1,
            Type : "Text",
            MinWidth : 40,
            Width : 50,
            SaveName : "work_detail_type",
            Align : "Center"
         }, {
            Header : "업무구분",
            ColMerge : 1,
            Type : "Text",
            MinWidth : 40,
            Width : 50,
            SaveName : "work_division",
            Align : "Center"
         }, {
            Header : "업무 수행 내역 상세",
            ColMerge : 0,
            Type : "Text",
            MinWidth : 250,
            Wrap : 1,
            MultiLineText : 1,
            SaveName : "work_contents",
            Wrap : 1,
            MultiLineText : 1
         }, {
            Header : "시작일",
            ColMerge : 0,
            Type : "Date",
            MinWidth : 80,
            SaveName : "start_date",
            Format : "Ymd",
            Align : "Center"
         }, {
            Header : "종료일",
            ColMerge : 0,
            Type : "Date",
            MinWidth : 80,
            SaveName : "end_date",
            Format : "Ymd",
            Align : "Center"
         }, {
            Header : "금주계획",
            ColMerge : 0,
            Type : "Float",
            MinWidth : 40,
            Width : 50,
            SaveName : "this_week_plan",
            Format : "#,##0.#%",
            Align : "Center"
         }, {
            Header : "금주실적",
            ColMerge : 0,
            Type : "Float",
            MinWidth : 40,
            Width : 50,
            SaveName : "this_week_performence",
            Format : "#,##0.#%",
            Align : "Center"
         }, {
            Header : "차주계획",
            ColMerge : 0,
            Type : "Float",
            MinWidth : 40,
            Width : 50,
            SaveName : "next_week_plan",
            Format : "#,##0.#%",
            Align : "Center"
         }, {
            Header : "비고",
            ColMerge : 0,
            Type : "Text",
            MinWidth : 90,
            Width : 100,
            SaveName : "comment",
            Wrap : 1,
            MultiLineText : 1,
            Align : "Center"
         }, {
            Header : "ID",
             ColMerge : 1,
             Type : "Int",
             MinWidth : 20,
             Width : 20,
             SaveName : "job_id",
             Wrap : 1,
             MultiLineText : 1,
             Align : "Center",
             Hidden : 1
         }];
         IBS_InitSheet(mySheet, initSheet);

         mergeChg('msHeaderOnly + msPrevColumnMerge');

         //doAction('search');
      }
		var yoonArrTemp = new Array();
      // '업무 수행 내역 상세' 클릭 시 Modal 띄우기 기능
      function mySheet_OnClick(Row, Col, Value, CellX, CellY, CellW, CellH) {
      //console.log("클릭됨");         
         if(Col == mySheet.SaveNameCol("work_contents") && mySheet.GetCellValue(Row, "job_id") != "") {
            var sheetValue = mySheet.GetCellValue(Row, "job_id");
            
            //console.log("Job ID : " + mySheet.GetCellValue(Row, "job_id") + "   sheetValue : " + sheetValue);
            
      	  if(<%=weekReportDeptJson%> != null) {
             var test = <%=weekReportDeptJson%>;
            for(var i=0; i<test.DATA.length; i++) {
				var a = new Object();
				var testdata = json.DATA[i];
			    var searchChild = json.DATA[i];
				
				if(sheetValue == testdata.job_id) {
              	  //console.log(childArr);
					testdataArr = testdata.job_name.split('ㄴ');
					//console.log("부모테스트: "+ testdata.job_id);
					document.getElementById('job_name').value = testdataArr[0];
					if(testdata.contents == undefined){
						 document.getElementById('contents').value = '';
					}else{
						 document.getElementById('contents').value = testdata.contents;
					}
					
		            document.getElementById('comment').value = testdata.comment;
		            //console.log("단계테스트~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+testdata.privacy_state);
		            if(testdata.privacy_state===110){
		            	   document.getElementById('privacy_state').value ='중단' ;
		            }else if(testdata.privacy_state===111){
		            	document.getElementById('privacy_state').value = '진행전' ;
		            }else if(testdata.privacy_state===112){
		            	document.getElementById('privacy_state').value = '진행중' ;
		            }else if(testdata.privacy_state===113){
		            	document.getElementById('privacy_state').value = '완료' ;
		            }
		            
		
		            document.getElementById('project_id').value = testdata.project_id;
		           document.getElementById('work_type').value = testdata.work_type;
		            document.getElementById('work_detail_type').value = testdata.work_detail_type;
		            document.getElementById('work_division').value = testdata.work_division;
		            document.getElementById('start_date').value = testdata.start_date;
		            document.getElementById('end_date').value = testdata.end_date;
		            document.getElementById('this_week_performence').value = testdata.this_week_performence*100; 
		           	//console.log(testdata.job_id);
		                $.ajax({
				        	type: 'post',
				        	url: '/job/getMySubJobList',
				        	data: {id:testdata.job_id },
				        	success: function(data){
				        		//console.log(data.length);
				        		var subForm="";
				        		var sub_list = document.getElementsByClassName("sub_list")[0];
				        		sub_list.innerHTML="";
				        	 	for(var i=0; i<data.length; i++){
				        			//console.log(data[i].name);
				        			
				        			sub_list.innerHTML="";
				        			subForm += "<div class='for_subjob'>";  
						            subForm += "  <div class='col-md-6'>";
						            subForm += "  <label class='control-label'><label class=''>하위작업명</label></label>";
						            subForm += "   <label><span id=></span></label>";
						            subForm += "     <div class='form-group'>";
						            subForm += "        <div class='formInput'>";
						            subForm += "       	 <input type='text' name='sub_project' readonly='readonly' class='form-control' id='sub_name("+i+")' value='"+data[i].name+"'  placeholder='등록된 내용이 없습니다.'/>";
						            subForm += "        </div>";
						            subForm += "     </div>";
						            subForm += "  </div>";
						            
						            
						            subForm += "  <div class='col-md-4'>";
						            subForm += "    <label class='control-label'><label class='star01'>하위작업 기간</label></label>";
						            subForm += "    <div class='form-group'>";
						            subForm += "       <div class='formInput'>";
						            subForm += "         <div id='dateStart' class='dateStart'>";
						            subForm += "            <div class='input-group input-daterange date'>";
						            subForm += "                <input class='form-control date' name='sub_start_date' id='sub_start_date' value='"+data[i].real_start_date+"' readOnly >";
						            subForm += "                <div class='input-group-addon'> ~ </div>";
						            subForm += "                  <input class='form-control date'  name='sub_end_date' id='sub_end_date' value='"+data[i].real_end_date+"' readOnly >";
						            subForm += "            </div>";
						            subForm += "         </div>";
						            subForm += "       </div>";
						            subForm += "    </div>";
						            subForm += "  </div>";	
                               
						            subForm += "   <div class='col-md-2'>";
						            subForm += "    <div class='form-group'>";
						            subForm += "       <label class='control-label'><label class=''>진행률</label></label>";
						            subForm += "          <div class='formInput text-center'>";
						            subForm += "            <div class='input-group unit'>";
						            
						            
						            subForm += "         		<input type='text' class='form-control' id='sub_real_progress' name='sub_real_progress' value='"+data[i].real_progress*100+"' readOnly/>";
						            subForm += "                 <span class='input-group-addon'>%</span>";
						            subForm += "         </div>";
						            subForm += "      </div>";
						            subForm += "    </div>";
						            subForm += "   </div>";
						            
						            
						            
						            
						            subForm += "  <div class='col-md-12 '>";
						            subForm += "   <label class='control-label'><label class=''>하위작업 내용</label></label>";
						            subForm += "   <label><span id='contents_counter'></span></label>";
						            subForm += "   <div class='form-group form-group-block'>";
						            subForm += "    <div class='formInput'>";
						            subForm += "       	<textarea class='form-control'  rows='4' name='sub_contents' placeholder='등록된 내용이 없습니다.' readonly='readonly' id='sub_contents("+i+")'>"+data[i].contents+"</textarea>";
						            subForm += "    </div>";
						            subForm += "   </div>";
						            subForm += "  </div>";
						            subForm += "</div>";  
						            
						            sub_list.innerHTML += subForm;
				        		} 
				        		var subConView=document.getElementById("subConView");
				        		//console.log("서브 돔:"+subConView.nextSibling);
				        		
				        	}
				        });
		            
		            break;
				}
            }
            $("#jobModal").modal("show");
         }else {
			  return;
		  }
           
      }
 
  
         }
            
      

      //머지 영역 교체 (머지는 조회 중에 이루어짐으로 재 조회 한다.)
      function mergeChg(str) {
         mySheet.SetMergeSheet(eval(str));
         doAction('search');
      }
      
      //doAction의 search가 되고 나서 진행되는 함수==>최종 결과값은 mySheet_OnSearchEnd가 끝나고나서 사용자에게 보여진다
      function mySheet_OnSearchEnd(cd, msg) { 
    	  for(var i=1; i <= mySheet.LastRow(); i++) {
    		  //console.log("Row : " + i);
    		  

    		  //mySheet.SetRowSumable(1, 0);
    	/* 	  mySheet.GetCellValue(1,"this_week_performence");
    		  console.log("실적?: "+mySheet.GetCellValue(i,"this_week_performence"));
    		  console.log("시작?: "+mySheet.GetCellValue(i,"start_date"));
    		  console.log("종료?: "+mySheet.GetCellValue(i,"end_date"));
    		  
    		  //GetCellValue 는 무조건 String 값으로 가져온다.
    		  console.log("이번주 월요일: "+mySheet.GetCellValue(i,"this_week_monday"));
    		  console.log("다음주 토요일: "+mySheet.GetCellValue(i,"next_week_saturday"));
    		  var test1 = createStringToDate(mySheet.GetCellValue(i,"this_week_monday"));
    		  var test2 = createStringToDate(mySheet.GetCellValue(i,"next_week_saturday"));
    		  console.log(test1+" "+test2);
    		  console.log(test1>test2);
    		  if( 	  createStringToDate(mySheet.GetCellValue(i,"this_week_saturday")) < createStringToDate(mySheet.GetCellValue(i,"end_date")) ){
    			  mySheet.SetRowSumable(i, 0);
    		  } */
    		  
    	  }
    	  
    	 // mySheet.SetRowSumable(1, 0);
    	
      }

      /*Sheet 각종 처리*/
      function doAction(sAction) {
         //mySheet.ShowFilterRow();
         
         switch (sAction) {
         case "search": //조회
         if(json != null) {
            //console.log(total);
            mySheet.LoadSearchData(total);
            //console.log("시작 행: "+mySheet.GetDataFirstRow());
           	//console.log("종료행 "+mySheet.GetDataLastRow());
           	
            
            // 소계 설정
            mySheet.ShowSubSum([ {
               "StdCol" : "user_id",
               "SumCols" : "this_week_plan|next_week_plan|this_week_performence",
               //"AvgCols" : "this_week_performence",
               "CaptionCol" : 0,
               "Position" : "bottom",
               "CaptionText" : "%col"
            } ]); 
            break;
         }else {
            mySheet.LoadSearchData("{data:[]}");
         }
         case "reload":
            //조회 데이터 삭제
            mySheet.RemoveAll();
            break;
         case "down2excel":
            if(json != null) {
            //엑셀 다운로드
            var filename = $("#filename").val();
            var sheetname = $("#sheetname").val();
            //var merge = $("#merge").is(":checked") ? 1 : 0;
           // var design = $("#design").is(":checked") ? 1 : 0;
            var t = new Date();
            var DandT = t.getFullYear() + "-" + AddZero(t.getMonth() + 1)
                  + "-" + AddZero(t.getDate()) + " "
                  + AddZero(t.getHours()) + ":" + AddZero(t.getMinutes());

            //상단 타이틀 부분
            //var title = "[기술연구소 연구개발 1팀]";
            //title += "\r\n\r\n\r\n||||||||출력시간 : " + DandT + "\r\n";
            var title = "||||||||출력시간 : " + DandT + "\r\n\n\n";
            //상단 타이틀에 대한 머지 영역 지정 (시작 row,시작 col, 병합할 row개수, 병합할 열 개수)
            //var userMG = "0,0,3,12 3,8,2,4";
            var userMG = "0,8,2,4";
            var params = {
               FileName : filename,
               SheetName : sheetname,
               Merge : 1,
               SheetDesign : 1,
               TitleText : title,
               UserMerge : userMG,
               DownSum : 0,
               ComboValidation : 1,
               CheckBoxOnValue : "Y",
               CheckBoxOffValue : "N",
               ExtendParamMethod :"POST",
               Mode : 2
            };
            mySheet.Down2Excel(params);
            break;
         }
         }
      }
      function AddZero(str) {
         if ((str + "").length == 1) {
            return "0" + str;
         }
         return str;
      }
   window.addEventListener("onload", LoadPage());
   
   //String to Date 함수
   function createStringToDate(value){
	   //console.log(value);
	   var yyyy = value.substr(0,4);
	   //console.log("yyyy"+yyyy);
	   var mm =  value.substr(4,2);
	   //console.log("mm"+mm);
	   var dd = value.substr(6,2);
	   //console.log("dd"+dd);
	   return new Date(yyyy,mm,dd);
   }
</script>

<jsp:include page="../includes/footer.jsp" />