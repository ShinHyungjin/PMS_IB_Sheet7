<%@page import="ibs.com.domain.ProjectVO"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/moment.min.js"></script>

<%
   /* 가.ProjectController에서 '/wbs'을 통해 넘겨받는 데이터는
      1. 클릭한 Project의 정보를 갖고있는 ProjectVO(무조건 존재)
      2. 클릭한 Project에 대응되는 WbsJSON(0건 ~ 다량건)
       2.1 0건인 경우는 프로젝트가 생성되고 WBS의 Task가 한번도 생성된적이 없을 때
       2.1 1건이상인 경우는 PM이 편집을 통해 WBS의 Task를 한 번이라도 생성한 경우

      나.Wbs.jsp에서 불가피한 로직
      1. ProjectVO가 가지고있는 state 멤버변수가 int인 코드값이기 때문에 각 코드에 따른 String의 치환 로직이 요구됨
       1.1 로직을 피하는 방법은 여러가지 있을 수 있으나, jdbc의 반환타입을 map으로 하여 ProjectController에서 반환해주는 map에 code에 대응되는 String을 넣어준다면 가능
      2. WbsJSON이 Null인가 아닌가에 따른 Sheet 초기화 및 Search Data 설정
      
   */
   Object wbsjson = null;
   JSONObject jsonObj = null;
   String projectMemberjson = null;
   JSONArray jsonarr = null;
   JSONObject jsonarrObj = null;
   ProjectVO projectVO = null;
   
   projectVO = (ProjectVO) request.getAttribute("projectVO"); 
   
   String state = "";
   String [] memberArr = null;
   
   if(projectVO.getState() == 110) {
      state = "중단";
   } else if(projectVO.getState() == 111) {
      state = "진행전";
   }else if(projectVO.getState() == 112) {
      state = "진행중";
   }else if(projectVO.getState() == 113) {
      state = "완료";
   }
   
   if(request.getAttribute("wbsjson") != null) {
       wbsjson = (Object) request.getAttribute("wbsjson"); 
        jsonObj = (JSONObject)wbsjson;
        jsonarr = (JSONArray)jsonObj.get("DATA");
        jsonarrObj = (JSONObject)jsonarr.get(0);
   }
   
   if(request.getAttribute("project_member") != null) {
      projectMemberjson = (String)request.getAttribute("project_member");
   }
%>
<jsp:include page="./aside.jsp" />

<div class="subConView">
   <div class="conWrap">
      <div class="sectionCon" id="t1">
         <div class="tabs-container">
            <ul class="nav nav-tabs">
               <c:if test="${authWbs != 0 || auth!='ROLE_USER'}">
                  <li class="<c:if test="${menuId == 1}">active</c:if>"><a
                     href="${pageContext.request.contextPath}/project/wbs?id=${project_id}">WBS</a>
                  </li>
               </c:if>
               <c:if test="${authUser != 0 || auth!='ROLE_USER'}">
                  <li class="<c:if test="${menuId == 2}">active</c:if>"><a
                     href="${pageContext.request.contextPath}/project/user?id=${project_id}">참여인력</a>
                  </li>
               </c:if>
               <c:if test="${authInfo != 0 || auth!='ROLE_USER'}">
                  <li class="<c:if test="${menuId == 3}">active</c:if>"><a
                     href="${pageContext.request.contextPath}/project/info?id=${project_id}">프로젝트
                        정보</a></li>
               </c:if>
               <c:if test="${authAuthority != 0 || auth!='ROLE_USER'}">
                  <li class="<c:if test="${menuId == 4}">active</c:if>"><a
                     href="${pageContext.request.contextPath}/project/authority?id=${project_id}">권한</a>
                  </li>
               </c:if>
            </ul>
         </div>
         <div class="projectInfo">
            <h3 class="fl"><%=projectVO.getProject_title()%></h3>
            <ul class="fr">
               <li>
                  <dl>
                     <dt>전체계획</dt>
                     <dd id="projectTotalPlanProgress"></dd>
                  </dl>
               </li>
               <li>
                  <dl>
                     <dt>전체실적</dt>
                     <dd id="projectTotalRealProgress"></dd>
                  </dl>
               </li>
               
               <li>
                  <dl>
                     <dt>프로젝트 기간</dt>
                     <dd><%=projectVO.getStart_date() %>
                        ~
                        <%=projectVO.getEnd_date()%></dd>
                  </dl>
               </li>
               <li>
                  <dl>
                     <dt>진행여부</dt>
                     <dd><%=state%></dd>
                  </dl>
               </li>
            </ul>
         </div>
      </div>

      <div class="clear hidden">
         <table class="ib_basic">
            <tr>
               <th class="tit">보여질레벨</th>
               <td class="r20"><select id="levelCombo" class="selectbox">
                     <option value="0" selected="selected">모두 접기</option>
                     <option value="-1" selected="selected">모두 펼치기</option>
                     <option value="1">1레벨까지</option>
                     <option value="2">2레벨까지</option>
                     <option value="3">3레벨까지</option>
               </select></td>
               <th class="tit">자식레벨</th>
               <td class="r20"><select id="openCombo" class="selectbox"
                  style="Width: 100%">
                     <option value="0" selected="selected">이전상태유지</option>
                     <option value="1">모두 접음</option>
                     <option value="2">모두 펼침</option>
               </select></td>
               <td rowspan="2"><a href="javascript:doEvent('open',0);"
                  class="f2_btn_white btn_sheet">적용</a></td>
            </tr>
            <tr>
               <th class="tit">처리방식</th>
               <td class="r20" colspan="3"><select id="treeActionCombo"
                  onchange="doEvent('act',this.value)" class="selectbox"
                  style="Width: 100%">
                     <option value="0" selected="selected">자식유 삭제불가, 부모=삭제
                        삭제취소불가</option>
                     <option value="1">삭제체크 시 자식까지 삭제체크</option>
               </select></td>
            </tr>

            <tr>
               <th class="tit">트리 체크 기능 사용</th>
               <td class="r20"><input class="checkbox" type="checkbox"
                  id="useTreeChk" onchange="LoadPage()"></td>
            </tr>
         </table>
      </div>
      <input type="hidden" id="filename" class="form-control" value="WBS<%if(jsonarrObj != null){%>(<%=jsonarrObj.get("name")%>)<%}%>" class="inputbox" /> 
      <input type="hidden" id="sheetname" value="<%if(jsonarrObj != null){%><%=jsonarrObj.get("name")%><%}%>" class="inputbox" /> 
      <input type="hidden" class="checkbox" type="checkbox" checked="checked" id="merge" /> 
      <input type="hidden" class="checkbox" type="checkbox" checked="checked" id="design" />
      <div class="buttonGroup">
         <div class="BtnGroupL" style="width:30%;">
                <div class="form-group">
                   <div class="formInput">
                      <form id="actionForm" name="actionForm">
                         <div id="WbsDate" class="WbsDate">
                               <div class="input-group input-daterange row date">
                                     <div class="col-md-3 text-center" style="padding: 0px;">
                                        <label class="control-label" style="font-size: medium; margin-top: 7px;">조회 날짜 </label>
                                   </div>
                                    <div class="col-md-7" style="padding-left: 0px;">
                                       <input autocomplete="off" class="form-control" name="selectWbsDate" id="selectWbsDate"/>
                                  </div>
                               </div>
                         </div>
                      </form>
                   </div>
                </div>
         </div>
      
      <div class="BtnGroupR" id="t2">
         <a data-toggle="modal" href="#helpModal" class="btn btn-info" style="margin-right:12px; font-size:15px;">도움말</a>
         <a href="javascript:doAction('down2excel');" class="btn btn-primary">엑셀 내려받기</a>
         <!-- 2022-05-27 엑셀 업로드 구현 테스트 -->
         <!-- <a href="javascript:doAction('loadExcel');" class="btn btn-primary">엑셀 업로드</a> -->
         <c:if test="${authWbs == 2  || auth!='ROLE_USER'}">
            <a href="javascript:doAction('init')" class="btn btn-primary" title="수정중인 작업 초기화">초기화</a>
            <a href="javascript:doAction('save')" class="btn btn-primary">저장</a>
         </c:if>
      </div>
   </div>
   <br>
   <div class="ib_product" style="height: 600px; margin-bottom:15px;" id="wbsSheetDiv">
      <script type="text/javascript">
         createIBSheet("mySheet", "100%", "100%");
      </script>
   </div>

   <div class="buttonGroup" id="t3">
      <div class="BtnGroupL" style="margin-top: 5px;">
         <c:if test="${authWbs == 2  || auth!='ROLE_USER'}">
            <a href="javascript:doAction('insert')" class="btn btn-success">기본행 추가</a>
            <a href="javascript:doAction('insert2')" class="btn btn-success">하위행 추가</a>
            <a href="javascript:doAction('insert3')" class="btn btn-success">형제행 복사</a>
         </c:if>
      </div>
   </div>

</div>
</div>
<div class="modal inmodal fade" id="membershipReg" tabindex="-1" role="dialog" aria-hidden="true">
   <div class="modal-dialog modal-lg">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">
               <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
            </button>
            <h4 class="modal-title">담당자 검색</h4>
         </div>
         <div class="modal-body">
            <div class="sectionCon">
               <h2 class="tit-level2">담당자 목록</h2>
               <div class="writeType02">
                  <div class="row form-horizontal">
                     <div class="col-sm-12">
                        <div class="viewTable">
                           <div class="form-group">
                              <div class="col-sm-12">
                                 <div class="input-group">
                                    <%
                                            if(projectMemberjson != null) {
                                             String project_member = projectMemberjson;
                                             memberArr = project_member.split(",");
                                             for(int i=-1; i<memberArr.length; i++) {
                                       %>
                                    <%if(i==-1) { %>
                                    <div class="checkbox-out">
                                       <input type="checkbox" id="checkAll" class="chkAll" /> <label
                                          for="checkAll" class="checkbox">전체선택</label>
                                    </div>
                                    <%} else { %>
                                    <div class="checkbox-out">
                                       <input type="checkbox" id="check<%=i%>"
                                          value="<%=memberArr[i]%>" /> <label for="check<%=i%>"
                                          class="checkbox"><%=memberArr[i]%></label>
                                    </div>
                                    <%} %>
                                    <%}} %>
                                 </div>
                              </div>
                           </div>
                           <div class="hr-line-dashed"></div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>

         </div>
         <div class="modal-footer">
            <button class="btn btn-primary btn-outline" data-dismiss="modal"
               type="button" id="rowValue" onclick="projectMemberSave(this.value)"
               value="">저장</button>
         </div>
      </div>
   </div>
</div>

<div class="modal inmodal fade" id="helpModal" tabindex="-1" role="dialog" aria-hidden="true">
   <div class="modal-dialog modal-lg">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">
               <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
            </button>
            <h4 class="modal-title">WBS 사용 가이드</h4>
         </div>
         <div class="modal-body">
         <h4>화면구성</h4><br>
            <h5>1. Tab 영역</h5>
            <span style="font-size:15px;">
                - 화면 상단에 위치하는 Tab은 사용자의 권한에 따라 보여지거나 사용이 가능한 정도가 상이합니다.<br>
                - 제공되는 Tab의 종류는 WBS, 참여인력, 프로젝트 정보, 권한 총 4가지 이며 권한에 따라 해당 프로젝트의 탭 내용들을 변경 할 수 있습니다.<br><br>
             </span>
             <h5>2. 프로젝트 정보 영역</h5>
             <span style="font-size:15px;">
                - Tab 하단의 프로젝트 영역은 해당 프로젝트의 기본정보를 표출하는 부분으로, 프로젝트명 / 진행정도 / 기간 / 진행여부를 표현합니다.<br>
                - 진행정도는 프로젝트 영역 왼쪽 하단의 '조회날짜'를 통해 선택된 날짜를 통해 해당 프로젝트의 과거/미래시를 보여줄 수 있습니다.<br><br>
            </span>
            <h5>3. IB Sheet7 영역</h5>
             <span style="font-size:15px;">
                - 시트 내의 데이터를 핸들링 하는 영역으로, 기준일을 설정하는 조회날짜, 시트 내의 데이터를 엑셀로 다운받는 엑셀 내려받기 등 여러 버튼들을 통해 시트 내용을 편집 및 조회 할 수 있습니다.<br>
                - 시트 내의 데이터는 Task의 기본 정보를 기입하며, 필수 입력값으로는 작업명, 시작일, 종료일 총 3가지입니다. 단, 하위 Task가 존재하는 상위 Task는 작업명만이 필수값으로 요구됩니다.<br><br><br>
            </span>
            <h4>시트편집</h4><br>
            <h6> ** WBS 편집은 해당 프로젝트가 '진행중' 또는 '진행전'인 경우에만 가능합니다.</h6><br>
            <h5>1. 버튼 기능</h5>
            <span style="font-size:15px;">
               - 조회 날짜 : 달력을 통해 WBS 전체 조회 기준일을 변경합니다. 선택된 날짜를 통해 시트내의 Task별 계획률과 프로젝트의 계획률이 다시 계산되어 표현합니다.<br>
                - 엑셀 내려받기 : 화면에 표출된 시트 내용을 엑셀 파일로 다운로드 합니다.<br>
                - 초기화 : 시트내에서 편집한 내용들을 모두 초기화하여 처음 페이지에 진입 했었던 화면처럼 시트 내용을 다시 조회합니다.<br>
                - 저장 : 시트내에서 편집한 내용들을 서버로 전송하여 저장하고 저장된 내용을 다시 조회합니다.<br>
                - 시트내의 참여자 검색 버튼 : 해당 프로젝트에 참여중인 구성원들중 Task를 할당할 담당자를 선택할 수 있습니다.<br>
                - 기본행 추가 : 최상위 Task인 Level이 0인 새로운 Task 행을 시트 가장 하단에 추가합니다.<br>
                - 하위행 추가 : 현재 선택된 행에 새로운 하위 Task를 선택된 행의 가장 하단으로 추가합니다.<br>
                - 형제행 복사 : 현재 선택된 행과 같은 Level의 새로운 Task를 바로 아래에 추가합니다.<br><br>
             </span>
             <h5>2. Task 이동 및 복사 기능</h5>
            <span style="font-size:15px;">
                  - 드래그&드랍 : 시트 내에 표현된 Task들의 이동은 마우스 왼쪽 클릭을 통한 드래그&드랍으로 위치 변경이 가능합니다<br>
                  - 행이동 : 특정 Task의 위치를 이동시킬때는 아래의 규칙이 적용되니 유의하시기 바랍니다.<br>
                   &nbsp;&nbsp;1. 같은 Level에서의 이동은 이동대상의 위치에 따라 위, 아래로 이동하며 상위 Task 바로 아래에 위치한다면 가장 하단으로, <br>&nbsp;&nbsp;&nbsp;그 외에는 한칸 위로 이동합니다.<br>
                   &nbsp;&nbsp;2. 다른 Level에서의 이동은 드랍한 위치의 Task의 최하단으로 이동합니다.<br>
                  - 행복사 : 특정 Task와 유사하거나 비슷한 정보를 가진 행을 추가하고 싶을때는 '행복사' 기능을 통해 특정 Task들의 정보와 같은 행을 추가 할 수 있습니다.<br>
                   &nbsp;&nbsp;1. 복사위치는 상관없으며, 드래그 한 대상을 Ctrl 키를 누른채 드랍하면 해당 위치의 하단으로 동일한 내용의 행으로 복사할 수 있습니다.<br><br>
             </span>
             <span style="font-size:17px; color:red; font-style:bold;">
                   ** 드래그&드랍 기능은 이미 저장된 내용들의 한해서 사용 가능하며(새롭게 추가하거나 삭제한 행이 있다면 저장 후 이용) <br>
                   하위 Task가 존재하는 상위 Task는 행이동과 행복사는 하위 Task와 함께 적용됩니다. **<br><br>
             </span>
         </div>
      </div>
   </div>
</div>

<script language="javascript">

var Text = document.getElementsByTagName("Text");
for (var i = 0; i < Text.length; i++) {
   Text[i].onchange = function (evt) {
    if (typeof window.onbeforeunload !== "function") {
      window.onbeforeunload = function () {
        return "변경사항을 무시하고 이동하시겠습니까?";
      };
    }
  };
}

//담당자 설정 모달화면에서 전체선택 클릭 시 다른 체크박스의 체크, 언체크를 표현한다
$(".chkAll").click(function() {
   if ($(".chkAll").prop("checked")) { //만약 전체 동의하기 체크박스가 체크된상태일경우 
      $("input[type=checkbox]").prop("checked", true); //해당화면의 모든 checkbox들을 체크해준다. 
   } else { // 전체 동의하기 체크박스가 해제된 경우 
      $("input[type=checkbox]").prop("checked", false); //해당화면의 모든 checkbox들의 체크를 해제시킨다.
   }
});

//담당자 설정 모달화면에서 저장버튼 클릭시 호출되어 담당자의 이름과 ID를 배열로 저장하여 WBS Task에 적용한다
function projectMemberSave(Row) {
   var projectMemberList = new Array();   //모달로 지정한 담당자의 이름
   var projectMemberIdList = new Array(); //모달로 지정한 담당자의 ID
   var obj = {};
   <%if(projectMemberjson != null) {
         for(int i=0; i<memberArr.length; i++) { %>
            var CheckBox = $('#check<%=i%>').prop("checked");
            if(CheckBox == true) {
               projectMemberList.push("<%=memberArr[i].substring(0, memberArr[i].indexOf('('))%>");
               projectMemberIdList.push("<%=memberArr[i].substring(memberArr[i].indexOf('(') +1, memberArr[i].indexOf(')'))%>");
            }
   <%}}%>
   obj = {
         "projectMemberList" : projectMemberList,
         "projectMemberIdList" : projectMemberIdList
   };
   
   getProjectMember(projectMemberList, projectMemberIdList, Row);
}

//넘겨받은 담당자 이름과 ID 배열을 WBS Task에 SetCellValue 해준다
function getProjectMember(projectMemberList, projectMemberIdList, Row) {
   var member = '';
   var memberId = '';
   
   if(projectMemberList.length == 0) {
      mySheet.SetCellValue(Row, "manager", member);
      mySheet.SetCellValue(Row, "manager_id", memberId);
   } else {
      for(var i=0; i<projectMemberList.length; i++) {
         if(i != projectMemberList.length-1) {
            member += projectMemberList[i] + ",";
            memberId += projectMemberIdList[i] + ",";
         } else {
            member += projectMemberList[i];
            memberId += projectMemberIdList[i];
         }
      }
      mySheet.SetCellValue(Row, "manager", member);
      mySheet.SetCellValue(Row, "manager_id", memberId);
      mySheet.SetCellEditable(Row, "total_real_progress", 0);
    }
}

//WBS DatePicker의 기본 세팅 - 오늘날짜 하이라이트 부여
$("#WbsDate .input-group.date").datepicker({
   "todayBtn": "linked",
   "todayHighlight" : true
   });
   
//DatePicker의 날짜를 클릭하면 해당 날짜가 자동정렬 함수의 매개변수로서 계획 및  ManDay를 자동계산해준다
$("#WbsDate .input-group.date").datepicker().on("changeDate", function (e) {
   var date = new Date();
   date = e.date;
   setOrderIdSort(date);
});
//페이지 초기 진입 시 '조회날짜'에 오늘날짜 기입
$("#selectWbsDate").value = new Date();
   var json = <%=wbsjson%>;
   var projectState = <%=projectVO.getState()%>;
   var list = new Array();
   var total = new Object();
   var projectId;
   document.getElementById('selectWbsDate').value = wbsDate(new Date());
   
   function LoadPage() {

     //IB Sheet 테마 적용
      mySheet.SetTheme('BLM', 'ModernBlue');
     
      //ajax로 project ID를 넘겨서 컨트롤러가 이를 필요한 JSP에게 다시 넘겨준다
         projectId = <c:out value="${projectVO.p_id}"/>;
       $.ajax({
          type: "POST",   
          url: "/project/sendProjectId",
          data : {projectId : projectId},
          success: function(data){
             }
          });
       
       //가져온 WBS 데이터를 시트에 Load해주기 위해 JSON 데이터로 SaveNames에 매핑시킨다(ib.common.js 또는 XML excu 등을 이용해서도 가능하다)
       if(json != null) {
         for(var i=0; i<json.DATA.length; i++) {
           var data = new Object();
             var wbs = json.DATA[i];
           data.id = wbs.id;
            data.order_id = wbs.order_id;
            data.row_index = wbs.row_index;
            data.level = wbs.deep;
            data.project_id = wbs.project_id;
            data.name = wbs.name;
            data.start_date = wbs.start_date;
            data.end_date = wbs.end_date;
            data.total_one_md = wbs.total_one_md;
            data.plan_one_md = wbs.plan_one_md;
            data.total_date = wbs.total_date;
            data.plan_date = wbs.plan_date;
            data.manager = wbs.manager;
            data.real_start_date = wbs.real_start_date;
            data.real_end_date = wbs.real_end_date;
            data.report = wbs.report;
            data.plan_progress = wbs.plan_progress;
            data.total_real_progress = wbs.total_real_progress;
            data.manager_id = wbs.manager_id;
            list.push(data);
            }
         total.DATA = list;
      }
      
      // 또 다른 Object 객체를 사용하지 않는다면 DATA:[] 가 생략됨... 꼭 필요
      //아이비시트 초기화
      var initSheet = {};
      
      //프로젝트의 상태가 '중단', '완료' 상태일때는 WBS의 수정이 불가능하므로, 이에따른 Cfg 설정도 수정이 가능할 때와 상이하다(DragMode 사용 가능 여부)
      var cfg = {};
      
      if(json != null && ( projectState == 110 || projectState == 113) ) {
         cfg = {
              SearchMode : smLazyLoad,
               ChildPage : 5,
               AutoFitColWidth: "search|resize|init|colhidden|rowtransaction",
               DeferredVScroll : 1,
               UseJsonTreeLevel : 1,
               FrozenCol : 1,
               SelectionSummary : "EmptyCell|DelRow"
             };
      } else {
         cfg = {
                SearchMode : smLazyLoad,
                ChildPage : 5,
                AutoFitColWidth: "search|resize|init|colhidden|rowtransaction",
                DeferredVScroll : 1,
                UseJsonTreeLevel : 1,
                DragMode : 1,
                FrozenCol : 1,
                SelectionSummary : "EmptyCell|DelRow"
              };
      }
      initSheet.Cfg = cfg;
      initSheet.Cols = [ 
      {
         Header:"삭제",
         Type:"DelCheck",
         SaveName:"DELCHECK",
         MinWidth:53,
      }, {
         Header : "WBS ID",
         Type : "Text",
         SaveName : "order_id",
         Align : "Center",
         MinWidth : 40
      }, {
         Header : "작업명",
         Type : "Text",
         MinWidth : 300,
         SaveName : "name",
         Align : "Left",
         TreeCol : 1,
         LevelSaveName : "treelevel",
         Wrap : 1,
         MultiLineText : 1,
         TreeCheck : 1
      }, {
         Header : "시작일",
         Type : "Date",
         MinWidth : 110,
         SaveName : "start_date",
         Format : "Ymd",
         Align : "Center"
      }, {
         Header : "완료일",
         Type : "Date",
         MinWidth : 110,
         SaveName : "end_date",
         Format : "Ymd",
         Align : "Center"
      }, {
         Header : "총 작업량(M/D)",
         Type : "Float",
         MinWidth : 90,
         SaveName : "total_one_md",
         PointCount : 1,
         Align : "Center"
      }, {
         Header : "계획 작업",
         Type : "Float",
         MinWidth : 80,
         SaveName : "plan_one_md",
         PointCount : 1,
         Align : "Center",
         Transaction : 0
      }, {
         Header : "총 기간",
         Type : "Float",
         MinWidth : 70,
         SaveName : "total_date",
         PointCount : 1,
         Align : "Center"
      }, {
         Header : "계획 기간",
         Type : "Float",
         MinWidth : 70,
         SaveName : "plan_date",
         PointCount : 1,
         Align : "Center",
         Transaction : 0
      }, {
         Header : "담당자",
         Type : "Text",
         MinWidth : 140,
         SaveName : "manager",
         Wrap : 1,
         MultiLineText : 1,
         Align : "Center"
      },{
           Header : "참여자",
           Type : "Button",
           MinWidth : 70,
           SaveName : "project_member",
           Align : "Center",
           DefaultValue : "검색",
           Transaction : 0
        }, {
         Header : "실제시작일",
         Type : "Date",
         MinWidth : 105,
         SaveName : "real_start_date",
         Format : "Ymd",
         Align : "Center"
      }, {
         Header : "실제완료일",
         Type : "Date",
         MinWidth : 105,
         SaveName : "real_end_date",
         Format : "Ymd",
         Align : "Center"
      }, {
         Header : "산출물",
         Type : "Text",
         MinWidth : 150,
         SaveName : "report",
         Wrap : 1,
         MultiLineText : 1,
         Align : "Center"
      }, {
         Header : "계획",
         Type : "Float",
         MinWidth : 70,
         SaveName : "plan_progress",
         Align : "Center",
         Format : "#,##0.#%",
         Transaction : 0
      }, {
         Header : "실적",
         Type : "Float",
         MinWidth : 70,
         SaveName : "total_real_progress",
         Align : "Center",
         Format : "#,##0.#%"
      }, {
          Header:"상태",
          Type:"Status", 
          Align:"Center", 
          SaveName:"status",
          MinWidth : 60,
          Hidden:1
       }, {
         Header:"PROJECT ID",
         Type:"Int",
         SaveName:"project_id",
         Hidden : 1
      }, {
         Header:"담당자 ID",
         Type : "Text",
         MinWidth : 90,
          Wrap : 1,
          MultiLineText : 1,
          Align : "Center",
         SaveName:"manager_id",
          Hidden : 1
      },{
          Header:"DB ID",
          Type:"Int",
          SaveName:"id",
          Hidden:1
       },{
          Header:"RowIndex",
           Type:"Int",
           SaveName:"row_index",
           Hidden:1
       },{
         Header:"부모",
         Type : "Text",
         MinWidth : 40,
          Wrap : 1,
          MultiLineText : 1,
          Align : "Center",
         SaveName:"parent",
         Transaction : 0,
          Hidden : 1
      }];
      
      
      // WBS Sheet 높이 적용 계산작업
      var topContentsHeight = 0;

      var t1 = document.getElementById("t1");
      var t2 = document.getElementById("t2");
      var t3 = document.getElementById("t3");
      
      topContentsHeight += t1.scrollHeight;
      topContentsHeight += t2.scrollHeight;
      topContentsHeight += t3.scrollHeight;

      document.getElementById("wbsSheetDiv").style.height = (window.innerHeight - (topContentsHeight+170)) + "px";
      
      IBS_InitSheet(mySheet, initSheet);
      
      //트리컬럼 체크박스 사용시 어미/자식 간의 연관 체크기능 사용
      mySheet.SetTreeCheckActionMode(1);

      if (this.setIBEvents) {
         this.setIBEvents();
      }
      doAction('search');
   }
   function mySheet_OnSearchEnd(cd, msg) {
      mySheet.SetColEditable("order_id",0);
      mySheet.SetColEditable("total_one_md",0);
      mySheet.SetColEditable("plan_one_md",0);
      mySheet.SetColEditable("total_date",0);
      mySheet.SetColEditable("plan_date",0);
      mySheet.SetColEditable("real_start_date",0);
      mySheet.SetColEditable("real_end_date",0);
      mySheet.SetColEditable("plan_progress",0);
     // mySheet.SetColEditable("total_real_progress",0);
      mySheet.SetColEditable("manager",0);
      
      //자식노드가 있는 행은 시작일,종료일,담당자의 입력,수정이 불가능하다
      
      for(var i=1; i<=mySheet.LastRow(); i++) {
         if(mySheet.IsHaveChild(i)) {
            mySheet.SetCellEditable(i, 3, 0); 
            mySheet.SetCellEditable(i, 4, 0);
            mySheet.SetCellEditable(i, 9, 0); 
            mySheet.SetCellEditable(i, 10, 0);
         }
      }
      if(json != null && ( projectState == 110 || projectState == 113) ) {
         mySheet.SetEditable(0);
      }
      setOrderIdSort(null);
   }
   
   //Save 이벤트가 끝나면 자동 호출
   function mySheet_OnSaveEnd(code, msg) {
       if(code >= 0) {
           alert("저장 성공");  // 저장 성공 메시지
           mySheet.DoSearch("/project/wbs" , "projectId="+projectId);
           //location.href ="/project/wbs?id="+<c:out value="${projectVO.p_id}"/>;
           
       } else {
           alert("저장 실패"); // 저장 실패 메시지
       }
   }
   
 //담당자 검색에서 새로운 담당자 추가, 기존 담당자 삭제시 동작하는 부분 (project_member 헤더의 Type이 Combo일때 사용)
 //WBS 시트내에서 컬럼 데이터 변화에 따른 기능들은 해당 함수내에서 처리한다 ex)담당자를 추가/삭제, 시작일/종료일 변경 등
   function mySheet_OnChange(Row, Col, Value, OldValue, RaiseFlag) {
      if(Col == mySheet.SaveNameCol("start_date")) {
         if(mySheet.GetCellValue(Row, "end_date") == "" || mySheet.GetCellValue(Row, "end_date") ==null) {
            mySheet.SetCellValue(Row,"end_date", Value, 0);
         }
      }
      
      if(Col == mySheet.SaveNameCol("project_member") && Value == "전체삭제") {
         mySheet.SetCellValue(Row,"manager","");
         return ;
      }
      if(Col == mySheet.SaveNameCol("manager") && Value == "") {
          mySheet.SetCellValue(Row,"manager","");
          if(mySheet.GetChildNodeCount(Row) == 0) {
             mySheet.SetCellEditable(Row, "total_real_progress", 1);
          }
          return ;
       }
      //Sheet의 실적은 Float타입이며 DB 저장시 1.0 = 100% 이므로, 사용자가 기입하는 데이터인 정수를 1/100으로 매핑해야한다
      if(Col == mySheet.SaveNameCol("total_real_progress")) {
         mySheet.SetCellValue(Row, "total_real_progress", parseFloat(Value * 0.01).toFixed(3), 0);
         console.log("total_real_progress : " + parseFloat(Value * 0.01).toFixed(3));
      }
      
      if(Col == mySheet.SaveNameCol("project_member") && mySheet.GetCellValue(Row,"manager").indexOf(Value) == -1) {
         if(mySheet.GetCellValue(Row,"manager") == "" || mySheet.GetCellValue(Row,"manager") == null) {
            mySheet.SetCellValue(Row,"manager",mySheet.GetCellValue(Row,"manager")+Value);
         }  else {
            mySheet.SetCellValue(Row,"manager",mySheet.GetCellValue(Row,"manager")+","+Value);            
         }
      } else if(Col == mySheet.SaveNameCol("project_member") && mySheet.GetCellValue(Row,"manager").indexOf(Value) != -1 && Value != "") {
         var manager = mySheet.GetCellValue(Row,"manager");
         manager = manager.replace(","+Value, "");
         manager = manager.replace(Value+",", "");
         manager = manager.replace(Value, "");
         mySheet.SetCellValue(Row,"manager",manager);
      }
   }
   
   //트리 아이콘(+,-)클릭 시 동작하는 부분
   function doEvent(obj, val) {
      switch (obj) {
      case "open":
         val = parseInt(val);
         var openlevel = parseInt($("#levelCombo").val());
         var childopen = parseInt($("#openCombo").val());
         //레벨별 트리 접기/펼침
         mySheet.ShowLEVEL(openlevel, childopen);
         break;

      case "act":
         val = parseInt(val);
         //어미노드삭제 체크시 하위노드 체크 여부
         mySheet.SetTreeActionMode(val);
         break;
      }
   }
   var check = true; // 행이동 가능여부 체크
   
   //이동하려는 행들의 상태를 점검하여 Insert 및 Delete 행들이 포함되어있다면 이동을 못하게 한다
   function statusCheck(FromSheet, startRow, Count) {
      for(var i=startRow; i<startRow+Count; i++) {
         if(FromSheet.GetCellValue(i, "status") == "I" || FromSheet.GetCellValue(i, "status") == "D") {
            alert("이동하려는 데이터들중 새롭게 추가되거나 삭제하려는 행이 포함되어있습니다!");
            check = false;
            return;
         } else {
            if(FromSheet.GetChildNodeCount(i) > 0) {
               statusCheck(FromSheet, i+1, FromSheet.GetChildNodeCount(i));
            }
         }
      }
   }
   
   /* Ctrl 키 누른채 Drag&Drop 시 복사 기능을 위한 전역변수 설정
      * 1. Drag&Drop시 먼저 드래그 대상을 왼쪽 마우스로 클릭하여 드래그 한다
      * 2. Drop할 때 Ctrl키를 누른채 마우스 왼쪽에서 손을 뗀다(=Ctrl 누른채 드랍 시킨다)
    * 3. Drag 대상 행들이 복사된다
      */
   function mySheet_OnKeyDown(r, c, k, s){ 
      if(s === 2){
         _ibsUtil["tmpFlg"] = 1;
      }else {
         _ibsUtil["tmpFlg"] = 0;
      }
   } 
    
   function mySheet_OnKeyUp(r, c, k, s){ 
      if(s === 2){
         _ibsUtil["tmpFlg"] = 1;
      }else {
         _ibsUtil["tmpFlg"] = 0;
      }
   } 


   //행의 드래그&드랍 시 동작하는 부분
   function setIBEvents() {
      window["mySheet_OnDropEnd"] = function(FromSheet, FromRow, ToSheet, ToRow, X, Y, Type) {
         $(document).ready(function() {
             var map = new Map(); //map에는 이동하려는 행들의 행 인덱스와, json으로 행 데이터가 저장된다
             check = true; // 행이동 가능여부 체크
             
            var tolevel = ToSheet.GetRowData(ToRow).treelevel; //드랍한 위치의 Task TreeLevel
            var fromlevel = ToSheet.GetRowData(FromRow).treelevel; //드래그한 Task의 TreeLevel
            var maxlevel = -1; // 자기자신의 하위 작업들 중 트리레벨이 증가하는 자식의 카운팅을 위한 최대트리레벨 저장 변수
            var count = 1; // 자식의 트리레벨이 증가함에 따라 개수 증가를 위한 변수
            var lastchildid = parseInt(ToSheet.GetRowData((ToSheet.LastRow())).order_id.charAt(0)) + 1; //Task의 OrderId
            var lvl = ToSheet.GetRowLevel(ToRow); // treelevel을 달리 저장하는 방법 (나중에 안쓰인다면 위 tolevel 만으로도 사용할 수 있다)
            
         /*
            WBS의 드래그&드롭 이벤트 
            1.이동이 안되는 경우를 먼저 체크
              - 이동하려는 데이터들중 상태가 'Insert' 또는 'Delete'인 행이 존재
              - 드롭지점의 트리레벨이 4레벨
              - 드롭지점의 행이 자기자신(=이동대상)과 같음 
              - 드롭지점의 행이 0행 이하(=헤더)
              - 드롭지점의 행의 상태가 'Delete'인 삭제상태
              - 자기자신의 하위 작업들의 트리레벨 합이 드롭지점의 트리레벨과 합했을 때 4를 초과
             2.이동이 되는 경우
               - 위 조건을 모두 만족했기 때문에 아래 두가지 경우만 주의 (Sheet에서의 특정 행의 이동(=복사)는 삭제+삽입이 동시에 이루어지는 형태)
               - 드랍한 위치의 Task와 드래그한 Task의 부모/자식 관계
               - 드랍한 위치의 Task의 자식 존재 유무
         */
         
         // 1.이동이 안되는 경우
         // - 이동하려는 행의 상태가 'Insert' 또는 'Delete'인 행이 존재
         if(FromSheet.GetCellValue(FromRow, "status") == "I" || FromSheet.GetCellValue(FromRow, "status") == "D") {
              alert("이동하려는 데이터중 새롭게 추가되거나 삭제하려는 행이 포함되어있습니다!");
              return;
        }
        
         // - 이동하려는 행들의 상태가 'Insert' 또는 'Delete'인 행이 존재 (최대 자식 깊이가 4까지 가능하므로 4중 반복문이 아닌 재귀로..)
         if(FromSheet.GetChildNodeCount(FromRow) > 0) {
            statusCheck(FromSheet, FromRow+1, FromSheet.GetChildNodeCount(FromRow));
         } 
         
         // 위 두가지 모두 패스했다면 드래그 한 Task에겐 문제가 없고 드랍한 위치의 문제를 검증한다
         if(check) {
           // - 드롭지점의 트리레벨이 4레벨
            if(ToSheet.GetRowData(ToRow).treelevel == 4) {
               alert("행 이동 불가 : 최대 허용 트리레벨을 초과 할 수 없습니다");
               return;
            }
            // - 드롭지점의 행이 자기자신(=이동대상)과 같음 
            if(ToRow == FromRow) {
               alert("행 이동 불가 : 현재 위치와 같습니다");
               return;
            }
            // - 드롭지점의 행이 1행 이하(=헤더 또는 프로젝트 이름 행)
            if(ToRow <= 0) {
               alert("행 이동 불가 : 시트 범위를 벗어났거나 프로젝트 행과 같을 수 없습니다");
               return;
            }
            // - 드롭지점의 행의 상태가 'Delete'인 삭제상태
            if(ToSheet.GetRowData(ToRow).status == "D") {
               alert("행 이동 불가 : 삭제 할 행에는 이동 할 수 없습니다");
               return;
            }
         
            // - 자기자신의 하위 작업들의 트리레벨 합이 드롭지점의 트리레벨과 합했을 때 5를 초과
            map.set(FromRow, FromSheet.GetRowData(FromRow));
            // 이동하려는 행의 다음 행부터(=자식 행 부터) 시트 끝까지 순회하며 트리레벨이 더 높고, WBS ID가 같은 종류인경우 증가시킴
            for (var i = FromRow+1; i <= ToSheet.LastRow(); i++) {
               var nextlevel = ToSheet.GetRowData(i).treelevel;
               if((fromlevel-nextlevel) <= -1 && ToSheet.GetRowData(i).order_id.charAt(0) == ToSheet.GetRowData(FromRow).order_id.charAt(0)) {
                  map.set(i, ToSheet.GetRowData(i));
                  if(maxlevel < nextlevel) {
                     count++;
                     maxlevel = nextlevel;
                  }
               } else
                  break;
            }
            // 최종적으로 '드롭지점 행의 트리레벨' + '이동하려는 행의 트리 개수의 합'이 6을 넘으면 OverDepth..
            if(tolevel+count >= 5) {
               alert("행 이동 불가 : 최대 허용 트리레벨을 초과 할 수 없습니다(자식 레벨 포함)");
               return;
            }
         }
         
         //2. 이동이 가능
         //이동하고자 하는 행이 시트의 마지막 행인가? 그렇다면 WBS ID에 그냥 .1을 더해준다
         if(ToRow == ToSheet.LastRow()) {
            lastchildid = ToSheet.GetRowData(ToRow).order_id + ".1";
            lastchildrow = ToRow;
         }
         //드롭 지점의 다음행부터 끝까지 순회하되, 드롭지점의 트리 레벨이 다음행의 트리레벨보다 크거나 같고(=하위작업이 없다!) 이번행이 다음행의 차이가 1이면..(=바로 다음행이다!) 
         //그냥 WBS ID에 .1을 더해준다
         for (var i = ToRow+1; i <= ToSheet.LastRow(); i++) {
            //JSON Data의 WBS ID의 SavaName은 ID 상위작업의 자식은 3.1, 3.1.1 과 같이 '.'으로 구분가능
            var nextlevel = ToSheet.GetRowData(i).treelevel;
         
            //드롭 지점의 트리레벨이 다음행의 트리레벨과 같거나 크고 그 위치가 바로 첫번째면(=바로 다음행) 자식노드가 없다고 판단되기에 드롭행의 order_id에 .1을 추가하여 자식노드로 삽입
            if(tolevel >= nextlevel && (ToRow - i) == -1) {
               lastchildid = ToSheet.GetRowData(ToRow).order_id + ".1";
               lastchildrow = ToRow;
               break;
            } else 
               //자식이 있는 작업에 대한 WBS ID와 ROW를 구한다 (드롭지점 레벨과 순회하는 행들의 레벨차가 1이고, 서로의 order_id의 첫번째가 같다면 자식노드)
               if((tolevel-nextlevel) == -1 && ToSheet.GetRowData(i).order_id.charAt(0) == ToSheet.GetRowData(ToRow).order_id.charAt(0)) {
                  var lastwbsid = parseInt((ToSheet.GetRowData(i).order_id).charAt(ToSheet.GetRowData(i).order_id.length-1))+1;
                  lastchildid = ToSheet.GetRowData(i).order_id.substr(0, ToSheet.GetRowData(i).order_id.length-2) + "." + String(lastwbsid);
                  lastchildrow = i;
               }
         }
         
         var rowArray = new Array(); //map의 행 인덱스를 뽑아와 RowDelete에 이용
         var rowJsonArray = new Array(); //map의 json데이터를 뽑아와 SetRowData에 이용
         
         for(let key of map.keys()) {
            rowArray.push(key);
         }
         for(let value of map.values()) {
            rowJsonArray.push(value);
         }
         var rowJsonArrayCopy = JSON.parse(JSON.stringify(rowJsonArray)); //아래의 반복문에서 rowJsonArray값이(=이동대상 행들의 json 데이터)변하므로, 비교할 때 필요한 변하기 전의 값을 저장
         
         /* 이동 대상들을 삭제/삽입 하기 전에 드랍 위치의 Task가 자식을 갖고있다면 현재 행의 위치와 드랍 위치의 Task와의 관계에 따라 이동Row 계산식이 달리 적용된다
          * 1. 드랍 위치 Task가 자식을 갖고있다면
          *  1.1. 그 Task가 내 부모인가?
          *        ㄴ 현재 나의 바로 위에 위치하는가? --> 현재 나와, 내 자식들을 모두 해당 Task의 가장 밑단으로 붙이겠다
          *      ㄴ 현재 나의 바로 위가 아닌가? --> 현재 나와, 내 자식들을 현재 행보다 한 칸 위로 붙이겠다 --> 내 위에 자식이 하나뿐이다 = 바로 2칸위로, 내 위에 자식이 많다 = 내 바로 위 자식에 붙인다
          *     1.2 그 Task가 내 부모가 아닌가?
          *        ㄴ 현재 나와, 내 자식들을 그 Task가 가진 자식들 중 가장 밑단으로 붙이겠다
          * 2. 드랍 위치 Task가 자식을 안갖고있다면
          *      ㄴ 현재 나와 내 자식들을 그 Task 바로 밑단에 붙이겠다
          */
         if(FromSheet.GetChildNodeCount(ToRow) > 0) {
            if(FromSheet.GetParentRow(FromRow) == ToRow && FromRow - ToRow != 1) {
               //console.log("부모로 이동하며 바로 아래행이 아님");
               if(ToRow+1 == FromRow-1) {
                  lastchildrow = FromRow-2;
               } else {
                  for(var w = ToRow+1; w <= FromRow-1; w++) {
                      if(FromSheet.GetParentRow(w) == ToRow) {
                         lastchildrow = w-1;
                      }
                   } 
               }
               //lastchildrow = FromRow-2;
            } else if(FromSheet.GetParentRow(FromRow) == ToRow && FromRow - ToRow == 1) {
               var last = FromSheet.GetChildRows(ToRow).split('|');
               var lastindex = last[last.length-1];
               lastchildrow = parseInt(lastindex) - rowArray.length; 
            }else if(FromSheet.GetParentRow(FromRow) != ToRow) {
               var last = FromSheet.GetChildRows(ToRow).split('|');
               var lastindex = last[last.length-1];
               
               // 이동하려는 행의 인덱스가 내 부모의 부모라면 그 트리의 최하단에 붙어야 하므로 행 위치를 다시 계산
               if(FromSheet.GetParentRow(FromSheet.GetParentRow(FromRow)) == ToRow) {
                  lastchildrow = parseInt(lastindex) - rowArray.length;
               } else {
                  if(FromRow > ToRow) {
                      lastchildrow = parseInt(lastindex);
                   } else {
                    lastchildrow = parseInt(lastindex) - rowArray.length;
                   }
               }
               //console.log("부모로 이동하는건 아님 ")
            } 
         } else {
            if(FromRow > ToRow) {
               lastchildrow = parseInt(ToRow);
            }else {
               lastchildrow = parseInt(ToRow) - rowArray.length;
            }
               
             lastchildid = parseInt(ToSheet.GetRowData((ToSheet.LastRow())).order_id) + 1;
         }  
         
          //이동 대상들을 모두 제거한다
          if(!_ibsUtil["tmpFlg"]){
             for(var i=rowArray.length-1; i>=0; i--) {
                FromSheet.RowDelete(rowArray[i]);
                }
         } else {
            lastchildrow = ToRow;
            lastchildid = parseInt(ToSheet.GetRowData((ToSheet.LastRow())).order_id) + 1;
         }
         
         //map에 저장된 이동대상 행들의 json 데이터를 반복하며 level과 order_id를 계산하여 SetRowData로 Add 한다
         for(var i = 0; i < rowArray.length; i++) {
            var rowjson = rowJsonArray[i];
            rowjson.order_id = lastchildid;
            rowjson.Level = lvl+1;
            rowjson.total_real_progress *= 100;
            ToSheet.SetRowData(lastchildrow + 1, rowjson, {
               "Add" : 1,
               "Level" : lvl+1
            });
            if(!_ibsUtil["tmpFlg"]){
               ToSheet.SetCellValue(lastchildrow + 1, "status", "U");
            } else {
               ToSheet.SetCellValue(lastchildrow + 1, "status", "I");
            }
            if(i != rowArray.length-1) {
               if(rowJsonArrayCopy[i].treelevel < rowJsonArray[i+1].treelevel) {
                  lvl++;
                  lastchildid = lastchildid + ".1";
               } else if(rowJsonArrayCopy[i].treelevel == rowJsonArray[i+1].treelevel) {
                  lastchildid = parseInt(String(lastchildid).charAt(lastchildid.length-1))+1;
               } else if(rowJsonArrayCopy[i].treelevel > rowJsonArray[i+1].treelevel) {
                  lvl--;
                  for(var j = 0; j < b.length-1; j++) {
                     if(rowJsonArrayCopy[j].treelevel == rowJsonArray[i+1].treelevel) {
                        lastchildid = parseInt((rowJsonArray[i+1].id).charAt(lastchildid.length-1))+1;
                     }
                  }
               }
               lastchildrow++;
            }
         }
         
         /*
         //해당 행의 JSON에 ID를 방금 구한 ID로 대체하고 행을 추가한다(마지막 자식의 행+1, 데이터, 드롭지점 레벨+1)
         rowjson.ID = lastchildid;
         alert(lastchildid + "\t" + lastchildrow);
         //원본 데이터 삭제
         ToSheet.SetRowData(lastchildrow + 1, rowjson, {
            "Add" : 1,
            "Level" : lvl + 1
         });
         FromSheet.RowDelete(posRow);
         */
         
         //드래그 & 드랍은 절대 Insert 상태로 전환되어서는 안된다(가끔 SetRowData시 트랜잭션을 통한 Status가 'I'로 되는 현상 방지)
         /*
         for(var i=0; i<=FromSheet.LastRow(); i++) {
            if(FromSheet.GetCellValue(i,"status") == "I") {
               FromSheet.SetCellValue(i, "status", "U");
            }
         }
         */
            setOrderIdSort(null);
         });
      };
   }

   var startMinDate = ''; // 상위작업의 하위작업들 중 가장 빠른 시작일
   var endMaxDate = ''; // 상위작업의 하위작업들 중 가장 늦은 종료일
   var totalDate = 0.0; // 상위작업의 하위작업들의 totalDate 총 합
   var planDate = 0.0; // 상위작업의 하위작업들의 planDate 총 합
   var totalOneMd = 0.0; // 상위작업의 하위작업들의 totalOneMd 총 합
   var planOneMd = 0.0; // 상위작업의 하위작업들의 planOneMd 총 합
   var totalRealProgress = 0.0; // 상위작업의 하위작업들의 totalRealProgress 평균
   var flag = true; // WBS Task중 날짜 기입이 안되있는지 체크하는 boolean 변수
   
   //start_date 와 end_date의 실제 date를 반환받는 함수
   function StringtoDate(date_str)
   {
       var yyyyMMdd = String(date_str);
       var sYear = yyyyMMdd.substring(0,4);
       var sMonth = yyyyMMdd.substring(4,6);
       var sDate = yyyyMMdd.substring(6,8);

       return new Date(Number(sYear), Number(sMonth)-1, Number(sDate));
   }
   
   //WBS 페이지 진입 시 '조회날짜'에 오늘날짜 기입
   function wbsDate(date) {
      var year = date.getFullYear();              //yyyy
       var month = (1 + date.getMonth());          //M
       month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
       var day = date.getDate();                   //d
       day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
       return  year + '-' + month + '-' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
   }
   
   //WBS의 시작일과 종료일 컬럼에 SetCellValue를 위해서 Date를 다시 String으로 바꿔주는 함수
   function DateToString(date){
       var year = date.getFullYear();              //yyyy
       var month = (1 + date.getMonth());          //M
       month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
       var day = date.getDate();                   //d
       day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
       return  year + '' + month + '' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
   }
  
  //날짜 미입력 컬럼이 있는지 체크 후 Task들의 ID를 정렬한다(1.요구사항 분석, 1.1.요구사항 정의서 작성... 등)
   function setOrderIdSort(wbsDate) {
      flag = true;
      for(var j=1; j <= mySheet.LastRow(); j++) {
         if(mySheet.GetCellValue(j, "start_date") == "" || mySheet.GetCellValue(j, "end_date") == "") {
            if(mySheet.GetChildNodeCount(j) == 0) {
               flag = false; 
            }
         }
         if(!flag) {
            alert("정확한 날짜를 기입해주세요!");
            return;
         }
      }
      
      var orderId = 1;
      for (var i = 1; i <= mySheet.LastRow(); i++) {
         var nowLevel = mySheet.GetRowData(i).treelevel;
         var nextLevel = mySheet.GetRowData(i+1).treelevel;
         
         mySheet.SetCellValue(i, "order_id", orderId);
         mySheet.SetCellValue(i, "row_index", i);
         
         //현재 행이 다음 행보다 레벨이 더 크다 = 마지막 자식 행이다
         if(nowLevel > nextLevel) {
            for(var j = 1; j < i; j++) {
               if(mySheet.GetRowData(j).treelevel == nextLevel && nextLevel != 0) {
                  var lastwbsid = parseInt((mySheet.GetRowData(j).order_id).charAt(mySheet.GetRowData(j).order_id.length-1))+1;
                     var lastchildid = mySheet.GetRowData(j).order_id.substr(0, mySheet.GetRowData(j).order_id.length-2) + "." + String(lastwbsid);
                  orderId = lastchildid;
               } else if(mySheet.GetRowData(j).treelevel == nextLevel && nextLevel == 0) {
                  var lastwbsid = parseInt((mySheet.GetRowData(j).order_id))+1;
                  orderId = lastwbsid;
               }
            }
         } 
         //현재 행과 다음행의 레벨이 같다 = 같은 자식 또는 부모 행이다
         else if(nowLevel == nextLevel) {
            if(nextLevel != 0) {
               var lastwbsid = parseInt((mySheet.GetRowData(i).order_id).substr(mySheet.GetRowData(i).order_id.lastIndexOf('.')+1))+1;
                  var lastchildid = mySheet.GetRowData(i).order_id.substr(0, mySheet.GetRowData(i).order_id.lastIndexOf('.')+1) + String(lastwbsid);
               orderId = lastchildid;   
            } else {
               var lastwbsid = parseInt((mySheet.GetRowData(i).order_id))+1;
               orderId = lastwbsid;
            }
         } 
         //현재 행이 다음 행보다 레벨이 더 작다 = 현재 행의 자식 행이다
         else if(nowLevel < nextLevel) {
            var lastchildid = mySheet.GetRowData(i).order_id + ".1";
            orderId = lastchildid;
         }
         
      }
      setDateSort(wbsDate);
   }
   
     //Task들의 ID를 정렬한 후, 상위/하위 Task 관계간의 ManDay ~ 실적 등을 계산하여 상위 작업의 컬럼에 계산값을 적용한다 
   function setDateSort(wbsDate) {
      totalDate = 0.0;
      planDate = 0.0;
      totalOneMd = 0.0;
      planOneMd = 0.0;
      totalRealProgress = 0.0;
      
     //역순으로 조회해야 하위~상위 단계로 순회가 가능하고, 이를 계산한 값들을 상위에 적용한다
     for(var i=mySheet.LastRow(); i > 0; i--) {
        var count1 = 0; //TotalDate를 계산한 주말을 제외한 작업일
        var count2 = 0; //PlanDate를 계산한 주말을 제외한 작업일
        var date1 = StringtoDate(mySheet.GetCellValue(i, "start_date")); //시작일 String을 Date로 변환
        var date2 = StringtoDate(mySheet.GetCellValue(i, "end_date")); //종료일 String을 Date로 변환
        
        if(wbsDate == null) {
           var toDate = StringtoDate(DateToString(new Date())); //오늘날짜를 yyyyMMdd 형태로 만들고 다시 Date로 변환
        } else {
           var toDate = StringtoDate(DateToString(wbsDate)); //오늘날짜를 yyyyMMdd 형태로 만들고 다시 Date로 변환
        }

        //TotalDate를 계산
        while(true) {  
            var temp_date = date1;
            if(temp_date.getTime() > date2.getTime()) {
                break;
            } else {
                var tmp = temp_date.getDay();
                if(tmp == 0 || tmp == 6) {
                    // Date의 day가 0은 일요일, 6을 토요일 이기 때문에 작업량 계산에서 제외
                } else {
                    // 1~5 사이는 평일이므로 작업량 계산에 포함
                    count1++;         
                }
                // 날짜를 하루씩 증가
                temp_date.setDate(date1.getDate() + 1); 
            }
        }
        // 시작일 String을 다시 초기화
        date1 = StringtoDate(mySheet.GetCellValue(i, "start_date"));
        
        //PlanDate를 계산
        while(true) {  
            var temp_date = date1;
            if(temp_date.getTime() > toDate.getTime()) {
                break;
            } else {
                var tmp = temp_date.getDay();
                if(tmp == 0 || tmp == 6) {
                    // 주말
                } else {
                    // 평일
                    count2++;         
                }
                temp_date.setDate(date1.getDate() + 1); 
            }
        }
        
        //계획작업량(=PlanDate)가 실제작업량(=TotalDate) 보다 크다면..(=이미 끝난 작업인데 오늘날짜와 비교하다보니 작업 n일차가 크게 계산된다) 100%로 계산될 수 있도록 식제 작업량과 같게 설정
        if(count1 <= count2) {
           count2 = count1;
        }
        //삭제된 Task에 대한 계산은 제외한다
        if(mySheet.GetCellValue(i, "status") == 'D') {
           continue;
        }
        
        //만약 자식 노드가 있는 Task라면 하위 자식 노드들의 ManDay 및 실적을 총합하여 기입한다
        if(mySheet.GetChildNodeCount(i) > 0) {
           var totalRatioRealProgress = 0;
           for(var j = i+1; j <= mySheet.GetLastChildRow(i); j++) {
              //자식들중 첫번 째 자식의 시작일, 종료일을 기준으로 가장빠른 시작일, 가장 늦는 종료일을 구한다
              if(i+1 == j) {
                 startMinDate = StringtoDate(mySheet.GetCellValue(j, "start_date"));
                 endMaxDate = StringtoDate(mySheet.GetCellValue(j, "end_date"));
              }
              //순회 구간이 첫번째 자식~마지막 자식 이므로 중간중간 포함되어있는 자식의 자식은 계산에서 배제시켜야한다 즉, 자식의 Parent가 현재 Row인 i와 같다면 직접적인 자식이다
              if(mySheet.GetParentRow(j) == i) {
                 var thisStartDate = StringtoDate(mySheet.GetCellValue(j, "start_date"));
                 var thisEndDate = StringtoDate(mySheet.GetCellValue(j, "end_date"));
                 
                 if(startMinDate >= thisStartDate) {
                    startMinDate = thisStartDate;
                 }
                 if(endMaxDate <= thisEndDate) {
                    endMaxDate = thisEndDate;
                 }
                 
                 totalDate += parseFloat(mySheet.GetCellValue(j, "total_date"));
                 planDate += parseFloat(mySheet.GetCellValue(j, "plan_date"));
                 totalOneMd += parseFloat(mySheet.GetCellValue(j, "total_one_md"));
                 planOneMd += parseFloat(mySheet.GetCellValue(j, "plan_one_md"));  
                 totalRealProgress += parseFloat(mySheet.GetCellValue(j, "total_real_progress"));  
              }
           }
           
           //모든 자식들을 순회해서 TotalDate가 계산되었으므로, 비중에 따른 실적 계산을 수행한다
           for(var j = i+1; j <= mySheet.GetLastChildRow(i); j++) {
              //순회 구간이 첫번째 자식~마지막 자식 이므로 중간중간 포함되어있는 자식의 자식은 계산에서 배제시켜야한다 즉, 자식의 Parent가 현재 Row인 i와 같다면 직접적인 자식이다
              if(mySheet.GetParentRow(j) == i) {
                 //각 자식들의 실적 비율은 (자신의 작업량 / 자식들의 작업량 합계) * (자신의 실적) 으로 계산할 수 있다.
                 totalRatioRealProgress += (parseFloat(mySheet.GetCellValue(j, "total_date"))/totalDate) * (parseFloat(mySheet.GetCellValue(j, "total_real_progress")));
              }
           }
         //직접적인 자식들을 순회하여 계산된 데이터를 부모 Task에 기입한다
              mySheet.SetCellValue(i, "start_date", DateToString(startMinDate),0); //onChange 이벤트를 막기위해 마지막 파라미터로 0 추가(안막으면 endDate가 onChange에 의해 강제로 바뀐다)
              mySheet.SetCellValue(i, "end_date", DateToString(endMaxDate),0); //onChange 이벤트를 막기위해 마지막 파라미터로 0 추가
              mySheet.SetCellValue(i, "manager", ""); //상위작업은 담당자가 없다
              mySheet.SetCellValue(i, "manager_id", ""); //상위작업은 담당자가 없다
              mySheet.SetCellValue(i, "total_date", totalDate); //하위작업들의 totalDate 합계 적용
              mySheet.SetCellValue(i, "plan_date", planDate); //하위작업들의 planDate 합계 적용
              mySheet.SetCellValue(i, "total_one_md", totalOneMd); //하위작업들의 totalOneMd 합계 적용
              mySheet.SetCellValue(i, "plan_one_md", planOneMd); //하위작업들의 planOneMd 합계 적용
              mySheet.SetCellValue(i, "parent", "Y"); //부모 Task임을 명시하여 컨트롤러의 분기처리를 해결한다(컨트롤러에선 시트의 부모/자식 관계 판단이 까다롭기 때문)
              mySheet.SetCellValue(i, "plan_progress", parseFloat(planDate/totalDate)); //Task의 계획률
              mySheet.SetCellValue(i, "total_real_progress", parseFloat(totalRatioRealProgress), 0); //하위작업들의 실적의 평균
              mySheet.SetCellEditable(i, "total_real_progress", 0);
              
              startMinDate = null;
              endMaxDate = null;
           }
           //자식이 없다면.. 자기 자신만 계산하며, 담당자 수만큼의 TotalDate, PlanDate를 기입한다
           else {
              if(mySheet.GetCellValue(i, "manager_id") == null || mySheet.GetCellValue(i, "manager_id") ==  '') {
                 mySheet.SetCellValue(i, "total_date", count1);
                 mySheet.SetCellValue(i, "total_one_md", count1);
                 mySheet.SetCellValue(i, "plan_date", count2);
                 mySheet.SetCellValue(i, "plan_one_md", count2);
                 mySheet.SetCellEditable(i, "total_real_progress", 1);
              } 
              else {
                 var managerIdarr = (mySheet.GetCellValue(i, "manager_id").valueOf()).split(',');
                 mySheet.SetCellValue(i, "total_date", count1*managerIdarr.length);
                 mySheet.SetCellValue(i, "total_one_md", count1);
                 mySheet.SetCellValue(i, "plan_date", count2*managerIdarr.length);
                 mySheet.SetCellValue(i, "plan_one_md", count2);
                 mySheet.SetCellEditable(i, "total_real_progress", 0);
              }
              mySheet.SetCellValue(i, "plan_progress", parseFloat(count2/count1));
           }
        
       //계획 대비 실적에 따른 컬럼 색상부여 
       /* 1. 계획보다 실적이 높다 = 더 빠른 작업속도
       *    - 그 차이가 10% 미만이다 = 연한 연두색
       *    - 그 차이가 10% 이상이다 = 진한 연두색
       *  2. 실적보다 계획이 높다 = 늦은 작업속도
       *    - 그 차이가 10% 미만이다 = 주황색
       *    - 그 차이가 10% 이상이다 = 빨강색
       *  3. 계획과 실적이 같다 = 계획대로 되고있다 = 하늘색
       *  4. 실적이 100%다 = 이미 완료된 작업이다 = 진한 초록색
       */
       
		var planProgress = parseFloat(mySheet.GetCellValue(i, "plan_progress")).toFixed(2);
        var realProgress = parseFloat(mySheet.GetCellValue(i, "total_real_progress")).toFixed(2);
         
        if(planProgress < realProgress) {
            if( (realProgress - planProgress) < 0.1 ) {
               mySheet.SetCellBackColor(i, "total_real_progress", "CCFF66");
                 mySheet.SetCellFontColor(i, "total_real_progress", "000000");
            } else {
               mySheet.SetCellBackColor(i, "total_real_progress", "00FF00");
                 mySheet.SetCellFontColor(i, "total_real_progress", "000000");
            }
         } else if(planProgress > realProgress) {
            if( (planProgress - realProgress) < 0.1 ) {
               mySheet.SetCellBackColor(i, "total_real_progress", "FF9933");
                 mySheet.SetCellFontColor(i, "total_real_progress", "FFFFFF");
            } else {
               mySheet.SetCellBackColor(i, "total_real_progress", "FF3333");
                 mySheet.SetCellFontColor(i, "total_real_progress", "FFFFFF");
            }
         } else if(planProgress == realProgress) {
            if(realProgress != 1.0) {
                mySheet.SetCellBackColor(i, "total_real_progress", "0099FF");
                 mySheet.SetCellFontColor(i, "total_real_progress", "000000");
             }   
         }
         if(realProgress == 1.0) {
            mySheet.SetCellBackColor(i, "total_real_progress", "009900");
             mySheet.SetCellFontColor(i, "total_real_progress", "000000");
         }
         
        // 하나의 행에 대한 ManDay, 색상부여가 끝났으니 계산값을 다시 초기화
        totalDate = 0.0;
        planDate = 0.0;
        totalOneMd = 0.0;
        planOneMd = 0.0;
        totalRealProgress = 0.0;
     }
     projectProgress();     
   }
     
     //시트의 레벨이 0인 행들의 계획 및 실적의 평균을 구하여 페이지 상단에 프로젝트 진척률을 보여준다
     function projectProgress() {
        var projectTotalPlanProgress = document.getElementById('projectTotalPlanProgress');
        var projectTotalRealProgress = document.getElementById('projectTotalRealProgress');
        var planTotal = 0;
        var realTotal = 0;
        var totalDate = 0;
        var planDate = 0;
        var checkCount = 0;

        // 2022-05-25 전체실적 사전작업 : 총기간 sum 계산
        for(var i=1; i<=mySheet.LastRow(); i++) {
            if(mySheet.GetRowData(i).treelevel == 0) {
            	totalDate += parseFloat(mySheet.GetCellValue(i, "total_date"));
            	planDate += parseFloat(mySheet.GetCellValue(i, "plan_date"));
            }
         }
        
        projectTotalPlanProgress.innerText = ((parseFloat(planDate/totalDate))*100).toFixed(1) + "%";
        
        for(var i=1; i<=mySheet.LastRow(); i++) {
            if(mySheet.GetRowData(i).treelevel == 0) {
            	realTotal += parseFloat(mySheet.GetCellValue(i, "total_date")) / totalDate * parseFloat(mySheet.GetCellValue(i, "total_real_progress"));
            }
         }
        
        projectTotalRealProgress.innerText = ((parseFloat(realTotal))*100).toFixed(1) + "%";
        
        
        /*
        // 2022-05-25 WBS전체계획, 전체실적 계산식 수정
        for(var i=1; i<=mySheet.LastRow(); i++) {
           if(mySheet.GetRowData(i).treelevel == 0) {
              planTotal += parseFloat(mySheet.GetCellValue(i, "plan_progress"));
              realTotal += parseFloat(mySheet.GetCellValue(i, "total_real_progress"));
              checkCount++;
           }
        }
        if(mySheet.LastRow() > 0) {
           projectTotalPlanProgress.innerText = ((parseFloat(planTotal/checkCount))*100).toFixed(1) + "%";
           projectTotalRealProgress.innerText = ((parseFloat(realTotal/checkCount))*100).toFixed(1) + "%";
        } else {
           projectTotalPlanProgress.innerText = "0%";
           projectTotalRealProgress.innerText = "0%";
        }
        */
     }
     
  
   /*Sheet 각종 처리
   * DB에 변경을 가하는 CRUD에 해당하는 기능들은 프로젝트가 '진행전', '진행중' 일 때만 가능하다
   */
   function doAction(sAction) {
      switch (sAction) {
      // 지금까지 작업한 내용을 초기화하고 처음 WBS 데이터로 셋팅한다(=불러왔던 WBS 데이터)
      case "init" : 
          if(( projectState == 111 || projectState == 112) ) {
            if(confirm("시트 내용을 초기화 하시겠습니까? \n초기화시, 저장하기 전에 작성한 내용은 모두 사라지며 저장하기 전의 상태로 돌아갑니다.")){
               doAction("search");   
            }
             break;
          } else {
            break;
          }
       break;
      //해당 프로젝트의 WBS를 조회한다
      case "search":
      if(json != null) {
          mySheet.LoadSearchData(total);
      } else {
         mySheet.LoadSearchData("{data:[]}");
      }
         /*
        //ib.comm.js 를 이용하여 IB Sheet7에 JSON 데이터 매핑하는 기능
         var param = {url:"/project/wbs"
             ,sheet:mySheet
             ,mapping:{mySheet:"mySheet"}};
         ib.comm.search( param );
         */
         break;
         //해당 WBS의 변경사항들을 서버로 전송하여 저장한다
      case "save":
         if(( projectState == 111 || projectState == 112)) {
            setOrderIdSort(null);
                
            if(flag == true) {
               //저장 시 트랜잭션 변화가 있는 데이터 전부를 보내기 위해 Param 속성을 이용하여 시트의 변화있는 전체 데이터를 전송
               
               var data = JSON.stringify(mySheet.GetSaveJson());
               mySheet.DoSave("/project/sendwbssheet",{
                    "Param" : encodeURIComponent(data),
                    "UrlEncode" : 0
                 });
               
            break;
         } else {
            break;
         }
         }
         break;
         //새로운 행을 기본 레벨인 '0' 인 행들중에 가장 마지막 행 다음으로 추가한다
      case "insert":
         if(projectState == 110 || projectState == 113) {
             break;
          } else {
               //신규행 추가
               //기본행 추가시 Level이 0인 가장 하단의 OrderID에서 1을 증가시켜야함..
               var insertOrderId = 1;
               if(mySheet.LastRow() <= 0) {
                  insertOrderId = 1;
               } else {
                  for(var i=1; i<=mySheet.LastRow(); i++) {
                     if(mySheet.GetRowData(i).treelevel == 0) {
                        insertOrderId = parseInt(mySheet.GetRowData(mySheet.LastRow()).order_id) +1;
                     }
                  }
               }
               var data = {
                  order_id : insertOrderId,
                  Level : 0,
                  week : 1,
                  project_id : <c:out value="${projectVO.p_id}"/>
               };
               mySheet.SetRowData(mySheet.LastRow()+1, data, {
                  "Add" : 1,
                  "Level" : data.Level
               });
            break;
          }
         //포커싱된 행의 하위 행으로 새로운 행을 추가한다 
      case "insert2":
         if(projectState == 110 || projectState == 113 || mySheet.LastRow() <= 0) {
             break;
          } else {
               //하위행 추가
               var selectRow = mySheet.FRow;
               var last = '';
               var lastindex = '';
               if(selectRow.Level == 4) {
                  alert("하위행 추가 불가 : 삽입 하려는 행의 트리레벨이 최대레벨 입니다");
                  break;
               } else if(selectRow.ibidx <= 0) {
                  alert("하위행 추가 불가 : 시트 범위를 벗어났습니다");
                  break;
               }else {
                  var id = "";
                  if(selectRow.childNodes.length == 0) {
                     id = selectRow.C2 + ".1";
                     lastindex = selectRow.ibidx;
                  } else {
                        var count = selectRow.childNodes.length+1
                        id = selectRow.C2 + "." + count;
                        last = mySheet.GetChildRows(selectRow.ibidx).split('|');
                        lastindex = last[last.length-1];
                  }
                  var insertRow = {
                        order_id : id,
                        Level : (parseInt(selectRow.Level) + 1),
                        week : 1,
                        project_id : mySheet.GetRowData(1).project_id
                  };
                  mySheet.SetRowData(++lastindex, insertRow, {
                        "Add" : 1,
                        "Level" : insertRow.Level
                  });
               }
            break;
          }
         //포커싱된 행의 레벨과 같은 행으로 새로운 행을 추가한다
      case "insert3":
          if(projectState == 110 || projectState == 113 || mySheet.LastRow() <= 0) {
              break;
           } else {
                //하위행 복사
                var selectRow = mySheet.FRow;
                var id = '';
                if(selectRow.ibidx <= 0) {
                   alert("하위행 복사 불가 : 시트 범위를 벗어났습니다");
                   break;
                }else {
                   if(selectRow.Level >= 1) {
                      var lastwbsid = parseInt((String(selectRow.C2)).substr((String(selectRow.C2)).lastIndexOf('.')+1))+1;
                       var lastchildid = (String(selectRow.C2)).substr(0, (String(selectRow.C2)).lastIndexOf('.')+1) + String(lastwbsid);   
                   } else {
                      var lastchildid = parseInt(selectRow.C2)+1;
                   }
                   
                   id = lastchildid;
                 
                   var insertRow = {
                         order_id : id,
                         Level : selectRow.Level,
                         week : 1,
                         project_id : mySheet.GetRowData(1).project_id
                   };
                   mySheet.SetRowData(mySheet.GetSelectRow()+count, insertRow, {
                         "Add" : 1,
                         "Level" : insertRow.Level
                   });
                }
             break;
           }
          //WBS 데이터를 엑셀 형태의 파일로 저장한다
      case "down2excel":
         if(json != null) {
         var filename = $("#filename").val();
         var sheetname = $("#sheetname").val();

         var params = {
            FileName : filename+".xlsx",
            SheetName : sheetname,
            //TreeLevel : 1,
            Merge : 1,
            SheetDesign : 1,
            DownSum : 0,
            ComboValidation : 1,
            DownTreeHide : 1,
            CheckBoxOnValue : "Y",
            CheckBoxOffValue : "N",
            ExtendParamMethod :"POST",
            AutoSizeColumn : 1,
            Mode : 2
         };
         mySheet.Down2Excel(params);
         break;
      }
      case "moveup" :
         moveup();
         break;
      case "moveinsertup" :
         moveinsertup();
         break;
      case "movedown" :
         movedown();
         break;
      case "moveinsertdown" :
         moveinsertdown();
         break;
      //2022-05-27 엑셀 업로드 구현 테스트
      /* 
      case "loadExcel" :
    	  var params = {
              "Mode": "NoHeaderMatch",
              "WorkSheetNo":"2",
              "StartRow": "2",
              "FileExt": "xls|xlsx|xltx|xlsm"
          };
          mySheet.LoadExcel(params);
          break; 
       */
         }
      }
   
   //담당자 검색 버튼 클릭 시 모달창에 해당 프로젝트 참여자들 목록이 나오고, 이미 선택된 담당자들을 미리 Check 해준다
   function mySheet_OnButtonClick(Row, Col) {
     $("input[type=checkbox]").prop("checked", false); //해당화면의 모든 checkbox들의 체크를 해제시킨다.
      
     $("#membershipReg").modal("show");
      document.getElementById('rowValue').value = Row;

      var projectMember = "<%=projectMemberjson%>";
      var wbsManager = mySheet.GetCellValue(Row, "manager_id");

      //프로젝트 참여자들이 있을때만 체크박스 체크 로직이 실행된다
      if(projectMember != null || projectMember != "" || projectMember != "null") {
         var projectMemberarr = projectMember.split(',');
         var wbsManagerId = wbsManager.split(',');
         for(var i=0; i<wbsManagerId.length; i++) {
            var memberId = "("+wbsManagerId[i]+")";
            for(var j=0; j<projectMemberarr.length; j++) {
               var checkBoxMemberFull = String(document.getElementById('check'+j).value);
               var checkBoxMemberId = checkBoxMemberFull.substr(checkBoxMemberFull.indexOf('('), checkBoxMemberFull.indexOf(')'));;
               
               if(checkBoxMemberId == memberId) {
                  document.getElementById('check'+j).checked = true;
               }
            }
         }
      }
     }
   window.addEventListener("onload", LoadPage()); 
</script>

<jsp:include page="../includes/footer.jsp" />