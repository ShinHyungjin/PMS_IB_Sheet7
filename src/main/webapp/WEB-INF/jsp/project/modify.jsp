<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../project/aside.jsp" />
<fmt:formatNumber value="${project.payment}" var="payment"/>
<!-- 프로젝트 정보 -->
<!-- readonly -->
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
           </div>
               <!-- 메인 화면  -->
               <div class="col-md-6">
                  <div class="form-group">
                      <span class="star01">프로젝트명</span>
                      <span id="project_title-no" style="display: none; color: #d92742; font-weight: bold;">입력해주세요</span>
                     <div class="formInput">
                        <input id="id" type="hidden" value="${project.p_id}">
                        <input id="project_title" type="text" class="form-control" value="${project.project_title}" >
                     </div>
                  </div>
               </div>
               <div class="col-md-3">
                  <div class="form-group">
                       <span class="star01">프로젝트 별칭</span>
                       <span id="project_nickname-no" style="display: none; color: #d92742; font-weight: bold;">입력해주세요</span>
                     <div class="formInput">
                        <input id="project_nickname" type="text" class="form-control" value="${project.project_nickname}" >
                     </div>
                  </div>
               </div>
               <div class="col-md-3">
                  <div class="form-group">
                       <span class="star01">기간</span>
                       <span id="start_date-no" style="display: none; color: #d92742; font-weight: bold;">입력해주세요</span>
                     <div class="formInput">
                        <div id="dateStart" class="dateStart">
                           <div class="input-group input-daterange date">
                              <input id="start_date" type="text" class="form-control" value="${project.start_date==null?'0':project.start_date}" autocomplete="off">
                              <div class="input-group-addon">~</div>
                              <input id="end_date" type="text" class="form-control" value="${project.end_date==null?'0':project.end_date}" autocomplete="off">
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="col-md-3">
                  <div class="form-group">
                      <span class="">담당자</span>
                     <div class="formInput">
                      	<select id="manager" class="form-control"></select>    
                     </div>
                  </div>
               </div>
               <div class="col-md-3">
					<div class="form-group">
						<span class="">주관부서</span>
						<div class="formInput">
						   <select id="team" class="form-control">
					   			<c:choose>
                                      <c:when test="${project.team==121}">
                                      <option value="121" selected>컨설팅사업팀</option>
                                      </c:when>
                                      <c:when test="${project.team==122}">
                                      <option value="122" selected>스마트CNS팀</option>
                                      </c:when>
                                      <c:when test="${project.team==123}">
                                      <option value="123" selected>항공정보팀</option>
                                      </c:when>
                                      <c:when test="${project.team==124}">
                                      <option value="124" selected>항공기술사업팀</option>
                                      </c:when>
                                      <c:when test="${project.team==125}">
                                         <option value="125" selected>SI영업팀</option>
                                      </c:when>
                                      <c:when test="${project.team==126}">
                                      <option value="126" selected>솔루션영업팀</option>
                                      </c:when>
                                      <c:when test="${project.team==127}">
                                      <option value="127" selected>영업지원팀</option>
                                      </c:when>
                                      <c:when test="${project.team==128}">
                                      <option value="128" selected>SW개발사업팀</option>
                                      </c:when>
                                      <c:when test="${project.team==129}">
                                      <option value="129" selected>솔루션사업팀</option>
                                      </c:when>
                                      <c:when test="${project.team==130}">
                                      <option value="130" selected>연구개발1팀</option>
                                      </c:when>
                                      <c:when test="${project.team==131}">
                                      <option value="131" selected>연구개발2팀</option>
                                      </c:when>
                                      <c:when test="${project.team==132}">
                                      <option value="132" selected>경영관리팀</option>
                                      </c:when>
                                      <c:when test="${project.team==133}">
                                      <option value="133" selected>기타</option>
                                      </c:when>
                                      <c:otherwise>
                                      <option value="120" selected>미정</option>
                                      </c:otherwise>
                                      </c:choose>
                                      <option value="">--전략사업본부--</option>
                                      <option value="121">컨설팅사업팀</option>
                                      <option value="122">스마트CNS팀</option>
                                      <option value="123">항공정보팀</option>
                                      <option value="124">항공기술사업팀</option>
                                      <option value="">--영업본부--</option>
                                      <option value="125">SI영업팀</option>
                                      <option value="126">솔루션영업팀</option>
                                      <option value="127">영업지원팀</option>
                                      <option value="">--IT사업본부--</option>
                                      <option value="128">SW개발사업팀</option>
                                      <option value="129">솔루션사업팀</option>
                                      <option value="">--기술연구소--</option>
                                      <option value="130">연구개발1팀</option>
                                      <option value="131">연구개발2팀</option>
                                      <option value="">--경영관리본부--</option>
                                      <option value="132">경영관리팀</option>
                                      <option value="">--기타--</option>
                                      <option value="133">기타</option>
                                      <option value="120">미정</option>
						   </select>	 
						</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="form-group">
							<span class="">계약금액(원, 부가세제외)</span>
							<span id="payment-no" style="display: none; color: #d92742; font-weight: bold;">입력해주세요</span>
							<div class="formInput">
							  	<input class="form-control" type="text" id="payment" onkeyup="addCommas(this)" value="${payment}">
							</div>
						</div>
					</div>
               <div class="col-md-3">
                  <div class="form-group">
                     <span class="star01">단계</span>
                     <div class="formInput">
                       <div class="selects">
                        <select class="form-control" id="state">
                            <option value="110">중단</option>
                            <option value="111">진행전</option>
                            <option value="112">진행중</option>
                            <option value="113">완료</option>
                         </select>
                       </div>
                     </div>
                  </div>
               </div>
               <div class="col-md-12">
                  <div class="form-group form-group-block">
                     <span class="">프로젝트 내용</span>
                     <div class="formInput">
                       <textarea class="form-control" rows="10"  id="context" value="${project.context}" >${project.context}</textarea>
                     </div>
                  </div>
               </div>
               
                  <div class="col-md-12 text-right">
                     <a href="#" class="btn btn-primary" title="저장" onclick="save();"><i class="ti-save"></i> 저장</a>
                  </div>
               
            </div>
         </div>
         <!-- .main-section e -->
      </div>
   <!-- .container-inner e -->
   <input type="hidden" value="<c:out value='${project.manager }'/>" >

<input type="hidden" id="project_state" value="<c:out value='${project.state}'/>">
<input type="hidden" id="project_manager" value="<c:out value='${project.manager}'/>">
<jsp:include page="../includes/footer.jsp" />
<script>

function addCommas(paymentDOM) {
	   // 콤마 빼고 
	   var x = paymentDOM.value;
	   x = x.replace(/,/gi, '');
	   console.log("x : " + x);
	    // 숫자 정규식 확인
	   var regexp = /^[0-9]*$/;

	   if(!regexp.test(x)){ 
	      $(paymentDOM).val(""); 
	      alert("숫자만 입력 가능합니다.");
	   } else {
	      x = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");         
	      $(paymentDOM).val(x);         
	   }
	}


var project_manager = document.getElementById('project_manager').value;
$.ajax({
    
	type: "POST",   
    url: "/user/getAllUserInfo",
    success: function(data){
       //통과, console.log(data);
       window.onbeforeunload = null;
        var manager=document.getElementById('manager');
        
       for(var i =0; i<data.length; i++){
          var option = document.createElement('option');
          //option.createAttribute("data-value");
          if(data[i].id==project_manager){
        	option.text = data[i].name + " " + data[i].rank;
          option.value = data[i].id;
          manager.options.add(option);
          manager.options[i].selected=true;
          }else{
        	 option.text = data[i].name + " " + data[i].rank;
             option.value = data[i].id;
             manager.options.add(option);
          }
           //option.data-value= data[i].name;
       }
    }
    });
    

var project_state = document.getElementById('project_state').value;
//alert(project_state);
var state_length = document.getElementById('state').length;
var manager_length = document.getElementById('manager').length;
var state = document.getElementById('state');
for(var i=0; i<state_length; i++){
    if(state.options[i].value==project_state){
        state.options[i].selected=true;            
    }
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

var fnPro = function() {
	window.onbeforeunload = null;
	var projectname = $("#project_title").val();
	var nickname = $("#project_nickname").val();
	var start = $("#start_date").val();
	var payment = $("#payment").val();
	
	if (projectname.length < 1) {
		$("#project_title-no").css('display', 'inline-block');
		return false;
	} 
	else if (nickname.length < 1) {
		$("#project_title-no").css('display', 'none');
		$("#project_nickname-no").css('display', 'inline-block');
		return false;
	}
	else if (start.length < 1) {
		$("#project_title-no").css('display', 'none');
		$("#project_nickname-no").css('display', 'none');
		$("#start_date-no").css('display', 'inline-block');
		return false;
	} else if(payment.length < 1) {
		$("#project_title-no").css('display', 'none');
		$("#project_nickname-no").css('display', 'none');
		$("#start_date-no").css('display', 'none');
		$("#payment-no").css('display', 'inline-block');
	} else
		$("#payment-no").css('display', 'none');
	return true;
}

function save(){
	window.onbeforeunload = null;
    //1.프로젝트 아이디
    var id=document.getElementById('id').value;
    //alert("프로젝트 아이디: "+id);
    //2.로그인 유저=manager
     var manager=document.getElementById('manager').value;
    //alert("로그인 유저: "+manager);
    //3.프로젝트 이름
    var project_title = document.getElementById('project_title').value;
    //alert("프로젝트 이름: "+project_title);
    
    //4.프로젝트 별칭
    var project_nickname = document.getElementById('project_nickname').value;
    //alert("프로젝트 별칭: "+project_nickname);
    
    //5.시작~종료일
    var start_date = document.getElementById('start_date').value;
    var end_date = document.getElementById('end_date').value;
    //alert("시작~종료일: "+start_date+" ~ "+end_date);
    
    //6.프로젝트 단계
    var state = document.getElementById('state');
    var select_state=state.options[state.selectedIndex].value;
        if(select_state=="" || select_state==null ){
            alert("단계를 선택해주세요!");
            return;
        }

    //7.프로젝트 내용
    var context = document.getElementById('context').value;
    //alert("내용: "+context);
    var team = document.getElementById('team').value;
    console.log("team : " + team);
	
    var commaPayment = document.getElementById('payment').value;
    var payment = commaPayment.replace(/,/gi, '');
    console.log("payment : " + payment);
    
    var formData={p_id:id, manager:manager, project_title:project_title, project_nickname:project_nickname, start_date:start_date, end_date:end_date,
        state:select_state, context:context, team: team, payment: payment
    }
    
    if(fnPro()) {
	    $.ajax({
	        type: "post",
	        url: "/project/modify",
	        data: formData,
	        async: "true",
	        success:function(data){
	           if(data=="success"){
	              alert("수정이 성공했습니다.");
	              location.href="/project/info?id="+id;
	           }else{
	              alert("오류가 발생했습니다.");
	           }
	          
	        }
    	});//ajax
    }
    }//save

</script>