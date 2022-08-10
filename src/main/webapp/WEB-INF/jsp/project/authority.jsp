<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="./aside.jsp" />   

      <!-- <h2 class="tit-level1">프로젝트 생성</h2> -->
      <%--    <p>권한정보: </p><c:out value="${list}"/>
         <p>현재 로그인:<s:authentication property="principal" /></p> --%>
	<div class="subConView">
	      <div class="conWrap">
	         <div class="sectionCon">
	            <div class="tabs-container">
	               <ul class="nav nav-tabs">
	               		<c:if test="${authWbs != 0 || auth!='ROLE_USER'}">
					   		<li class="<c:if test="${menuId == 1}">active</c:if>">
					     		<a href="${pageContext.request.contextPath}/project/wbs?id=${project_id}">WBS</a>
					     	</li>
			            </c:if>
			            <c:if test="${authUser != 0 || auth!='ROLE_USER'}">
			            	<li class="<c:if test="${menuId == 2}">active</c:if>">
			             		<a href="${pageContext.request.contextPath}/project/user?id=${project_id}">참여인력</a>
			             	</li>
			            </c:if>
			            <c:if test="${authInfo != 0 || auth!='ROLE_USER'}">
			             	<li class="<c:if test="${menuId == 3}">active</c:if>">
			             		<a href="${pageContext.request.contextPath}/project/info?id=${project_id}">프로젝트 정보</a>
			             	</li>
			            </c:if>
			            <c:if test="${authAuthority != 0 || auth!='ROLE_USER'}">
			            	<li class="<c:if test="${menuId == 4}">active</c:if>">
			            		<a href="${pageContext.request.contextPath}/project/authority?id=${project_id}">권한</a>
		            		</li>
			          	</c:if>
	               </ul>
	            </div>

                  <div class="board_top">
                     <div class="listSearch listSearchType01">                        
                        <div class="formInput">
                           <div class="selects">
                              <select class="form-control" id="group" style="width:200px;" onchange= "group(this.value);">
                                 <option value="group">권한 변경 그룹 선택</option>
                                 <option value="1">외부 감독</option>
                                 <option value="2">담당자</option>
                                 <option value="3">참조자</option>
                                 <option value="4">팀원</option>
                                 <option value="5">의사 결정권자</option>
                                 <option value="6">평가 위원장</option>
                                 <option value="7">평가 위원</option>
                              </select>
                           </div>
                        </div>                    
                     </div>
                  </div>

                  <div class="gridArea">
                     <div class="table_type1">
                        <!-- div class="sampleGridArea"></div> -->
                        <table summary="" class="">
                           <caption></caption>
                           <thead>
                              <tr>
                                 <th scope="col">프로젝트 내용</th>
                                 <th scope="col">READ</th>
                                 <th scope="col">UPDATE</th>
                              </tr>                                 
                           </thead>
                           <tbody>   
                              <tr>
                                 <td value="wbs">WBS</td>
                                 <input type="hidden" value="1" name="menu">
                                 <td><input type="checkbox" id="W_Read" name="read" onclick="authorityCheckEvt(this);"/></td>
                                 <td><input type="checkbox" id="W_Update" name="update" onclick="authorityCheckEvt(this);"/></td>
                              </tr>
                              <tr>
                                 <td value="참여인력">참여인력</td> 
                                 <input type="hidden" value="2" name="menu">
                                 <td><input type="checkbox" id="J_Read" name="read" onclick="authorityCheckEvt(this);"></td>
                                 <td><input type="checkbox" id="J_Update" name="update" onclick="authorityCheckEvt(this);"></td>
                              </tr>
                              <tr hidden>
                                 <td value="권한" hidden>권한</td hidden> 
                                 <input type="hidden" value="4" name="menu" hidden>
                                 <td hidden><input type="checkbox" id="A_Read" name="read" onclick="authorityCheckEvt(this);" hidden></td hidden>
                                 <td hidden><input type="checkbox" id="A_Update" name="update" onclick="authorityCheckEvt(this);" hidden></td hidden>
                              </tr hidden>
                              <tr>
                                 <td  value="프로젝트 정보">프로젝트 정보</td> 
                                 <input type="hidden" value="3" name="menu">
                                 <td><input type="checkbox" id="P_Read" name="read" onclick="authorityCheckEvt(this);"></td>
                                 <td><input type="checkbox" id="P_Update" name="update" onclick="authorityCheckEvt(this);"></td>
                              </tr>
                           </tbody>
                        <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
                        </table>
                     </div>
                  </div>
               </div>
               <c:if test="${authAuthority == '2' || auth!='ROLE_USER'}"> 
                  <div class="text-right">
                        <button type="submit" class="btn btn-primary" onclick="save();">저장</button>
                  </div>
               </c:if>  
            </div>
        </div>
         <!-- .main-section e -->
     </div>
      <!-- .container-inner e -->
    </div>

</div>
   <!-- ==============================로그인 시 사용자 아이디 저장============================ -->
   <c:set var="userid" value="${param.userid}" />
   <input type="hidden" value="${userid}" id="userid" />
   <input type="hidden" id="project_id"  value="<c:out value='${project_Id}'/>">

<!-- toTop start -->
<div id="gototop">go to top
<form name="actionForm">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>      
</div>
<!--// toTop end -->

</body>
</html>

<script>
function authorityCheckEvt(checkBox) {
    var checkBoxName = checkBox.name;
    var checkBoxId = checkBox.id;
    var checkBoxIndex = checkBoxId.split("_")[0];
    var isChecked = checkBox.checked;

    switch (checkBoxName) {
      case "read":
        if (!isChecked) {
          var updateCheckBox = document.getElementById(checkBoxIndex + "_Update");
          updateCheckBox.checked = false;
        }
        break;
      case "update":
        if (isChecked) {
          var readCheckBox = document.getElementById(checkBoxIndex + "_Read");
          readCheckBox.checked = true;
        }
        break;
    }
  }


$(document).ready(function() {
   var authList="<c:out value='${list}'/>";
   var userid=$("#userid").val();
   //var project_id = document.getElementById('project_id').value;
   //alert("현재 프로젝트 id"+project_id);
   /* alert("로그인?: "+userid); */
   console.log("출력좀: "+authList);
   
    $.ajax({
       type: "POST",   
       url: "/job/myjob",
       data : {userid : userid},
       success: function(data){
          if(data!=null){
             //alert("일단 값은 들어왔어");
             myjob=data;
          }
          for(var i =0; i<data.length; i++){
            // alert(data[i].PROJECT_TITLE+":"+data[i].PROJECT_NICKNAME);
            // $("#project_nickname").append("<option value="+data[i].PROJECT_NICKNAME+">"+data[i].PROJECT_NICKNAME+"</option>");
          }
       }
    });
});

//==========================체킹된 권한처리 컨트롤러로 넘기는    부분=============================================
 function save(){
   if($("[id=group] > option:selected").val()=='group'){
      alert("적용할 그룹을 선택해주세요.");
      return;
   }
     
   //선택된 그룹=========================================================

   //1.적용 대상 그룹
   var selectOption = document.getElementById('group');
   var group=selectOption.options[selectOption.selectedIndex].value;
   
   //alert("선택된 그룹이 value 값은: "+group);
   //2.읽기 권한
   var read = document.getElementsByName('read');
   var read_Arr = new Array();
   //3.수정권한   
   var update = document.getElementsByName('update');
   var update_Arr =  new Array();
   //4.메뉴
   var menu = document.getElementsByName('menu');
   var menu_Arr =  new Array();
   
   //alert("체크박스 길이는?: "+read.length);

   
   for(var i=0; i<read.length; i++){
      if(read[i].checked===true){
         read[i].value=1;
      }else if(read[i].checked===false){
         read[i].value=0;
      }
      read_Arr.push(read[i].value);
   }
   
   for(var i=0; i<update.length; i++){
      if(update[i].checked===true){
         update[i].value=1;
      }else if(update[i].checked===false){
         update[i].value=0;
      }
      update_Arr.push(update[i].value);
   }
   
   for(var i=0; i<menu.length; i++){
   
      menu_Arr.push(menu[i].value);
   }
   
  
   
   //alert("읽기 배열은?: "+read_Arr);
   //alert("수정 배열은?: "+update_Arr);
   //alert("프로젝트 id: "+project_id);
   var project_id = <c:out value='${project_Id}' />
   var formData = {"group":group , "read":read_Arr, "update":update_Arr, "menu":menu_Arr,"project_id":project_id }
   
    $.ajax({
      url:"/project/save1",
      type: "post",
      data: formData,
      success: function(data){
         //alert(data.data);
         if(data.data=="success"){
            alert("등록이 완료되었습니다.");
         }else{
            alert("오류가 발생하였습니다. 다시 시도해주세요!");
         }
      }
      
   }); 
   //선택된 그룹=========================================================
   
   //alert(selectOption);

   

   
}//권한처리 끝================================================ 

function group(value){
   //alert("선택된 그룹은? :"+value);
   var project_id = <c:out value='${project_Id}' />
   //alert("프로젝트: "+project_id);
   var formData = {group : value, project_id : project_id}
   $.ajax({
      url: "/project/showMyAuth",
      type: "post",
      data: formData,
      success : function(data){
         //alert("길이: "+data.data.length);
         //alert("내용:"+data.data)
         /* alert("데이터테스트: "+data.data[0].permission_check+data.data[1].permission_check
               +data.data[2].permission_check+data.data[3].permission_check); */
         var read_=document.getElementsByName("read");
            //alert("읽기 길이: "+ read_.length);
         var update_=document.getElementsByName("update");
         
         if(data.data!=undefined && data.data.length!=0 && data.data!=""){
         for(var i=0; i<data.data.length; i++){
            if(data.data[i].permission_check=="1"){
               read_[i].checked=true;
               update_[i].checked=false;
            }else if(data.data[i].permission_check=="2"){
               read_[i].checked=true;
               update_[i].checked=true;
            }
         }
         }else{
            for(var i=0; i<read_.length; i++){
               read_[i].checked=false;
               update_[i].checked=false;
            }
         }
      }   
   });
}
   
</script>

<script src="../resources/js/lib/loadAnimation.js">
</script>





ㄴ