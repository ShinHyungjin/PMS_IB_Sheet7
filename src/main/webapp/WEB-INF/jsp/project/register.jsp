<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../includes/header.jsp" />

<!--프로젝트 생성 -->
<div id="wrapper">
	<nav class="navbar-default navbar-static-side" role="navigation">
		<div class="sidebar-collapse">
			<ul class="nav metismenu" id="side-menu">
				<li><a href="#"><i class="mnImg02"></i><span class="nav-label">내작업</span><span class="arrow01"></span></a>
					<ul class="nav nav-second-level">
						<li><a href="${pageContext.request.contextPath}/job/list">전체</a></li>
						<li><a href="${pageContext.request.contextPath}/job/before">진행전</a></li>
						<li><a href="${pageContext.request.contextPath}/job/ing">진행중</a></li>
						<li><a href="${pageContext.request.contextPath}/job/stop">중단</a></li>
						<li><a href="${pageContext.request.contextPath}/job/end">완료</a></li>
					</ul>
				</li>
				<li><a href="#"><i class="mnImg01"></i> <span class="nav-label">보고서</span><span class="arrow01"></span></a>
					<ul class="nav nav-second-level">
						<li><a href="${pageContext.request.contextPath}/report/team">내부서</a></li>
						<li><a href=${pageContext.request.contextPath}/report/project>프로젝트별</a></li>
					</ul>
				</li>
				<li class="active"><a href="${pageContext.request.contextPath}/project/list"><i class="mnImg04"></i> <span class="nav-label">프로젝트</span> <span class="arrow01"></span></a>
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
	
	<div id="page-wrapper">
	<h2 class="tit-level1">프로젝트 생성</h2>
		<!-- #gnb e -->
			<div class="subConView">
					<!-- 메인 화면  -->
					<div class="col-md-6">
						<div class="form-group">
							 <span class="star01">프로젝트명</span>
							 <span id="project_title-no" style="display: none; color: #d92742; font-weight: bold;">입력해주세요</span>
							<div class="formInput">
								<input id="project_title" type="text" class="form-control" >
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="form-group">
							  <span class="star01">프로젝트 별칭</span>
							  <span id="project_nickname-no" style="display: none; color: #d92742; font-weight: bold;">입력해주세요</span>
							<div class="formInput">
							  <input id="project_nickname" type="text" class="form-control">
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
	                              <input id="start_date" type="text" class="form-control" autocomplete="off">
	                              <div class="input-group-addon">~</div>
	                              <input id="end_date" type="text" class="form-control" autocomplete="off">
	                           </div>
	                        </div>
	                     </div>
	                  </div>
	               </div>
	               <div class="col-md-3">
						<div class="form-group">
							<span class="">담당자</span>
							<div class="formInput">
							   <select id="manager" class="form-control">
							   </select>	 
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="form-group">
							<span class="">주관부서</span>
							<div class="formInput">
							   <select id="team" class="form-control">
						   			<option value="120">미정</option>
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
							   </select>	 
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="form-group">
							<span class="">계약금액(원, 부가세제외)</span>
							<span id="payment-no" style="display: none; color: #d92742; font-weight: bold;">입력해주세요</span>
							<div class="formInput">
							  	<input class="form-control" type="text" id="payment" onkeyup="addCommas(this)" placeholder="0">
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="form-group">
							<span class="">단계</span>
							<div class="formInput">
                              <div class="selects">
                                 <select class="form-control" id="state">
                                    <option value="111">진행전</option>
                                    <option value="112">진행중</option>
                                    <option value="113">완료</option>
                                    <option value="110">중단</option>
                                 </select>
                              </div>
                           </div>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group form-group-block">
							<span class="">프로젝트 내용</span>
							<div class="formInput">
							  <textarea class="form-control" rows="10" id="context" value="프로젝트 내용을 입력해주세요." ></textarea>
							</div>
						</div>
					</div>
					<div class="col-md-12 btnArea text-right">
						<button type="submit" id="save" class="btn btn-primary mr-3">저장</button>
				</div>
			</div>
			<!-- .main-section e -->
		</div>
	<!-- .main-section e -->
</div>
<!-- .container-inner e -->
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


$(document).ready(function(){
 window.onbeforeunload = null;
 var userid='<s:authentication property="principal.username"/>';
 //alert("로그인: "+userid);
 var myjob; 
	 $.ajax({
	 type: "POST",	
	 url: "/job/myjob",
	 data : {userid : userid},
	 success: function(data){
		 if(data!=null){
			 myjob=data;
		 }
		 console.log(myjob);
		 for(var i =0; i<data.length; i++){
			 $("#project_list").append("<li id=project_id value="+data[i].PROJECT_ID+" data-value="+data[i].PROJECT_TITLE+"><a href=\"${pageContext.request.contextPath}/project/main?id="+data[i].PROJECT_ID+"\">"+data[i].PROJECT_TITLE+"</li>");
		 }
	 }
	 });
	 
	 $.ajax({
		 type: "POST",	
		 url: "/user/getAllUserInfo",
		 success: function(data){
			 console.log(data);
			 
			  var manager=document.getElementById('manager');
			  
			 for(var i =0; i<data.length; i++){
				 var option = document.createElement('option');
				 //option.createAttribute("data-value");
				 option.text = data[i].name + " " + data[i].rank;
				 option.value = data[i].id;
			     //option.data-value= data[i].name;

				 manager.options.add(option);
			 }
		 }
		 });
 	});   

	/*프로젝트명, 기간 유효성검사*/
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
	

	$('#project_title').focusout(fnPro);
	$('#project_nickname').focusout(fnPro);
	$('#start_date').focusout(fnPro);
	$('#payment').focusout(fnPro);
	
		var save=document.getElementById('save');
		save.addEventListener("click", function(event){
			event.preventDefault();
			var project_title = document.getElementById('project_title').value;
			var project_nickname = document.getElementById('project_nickname').value;
			var start_date = document.getElementById('start_date').value;
			var end_date = document.getElementById('end_date').value;
			var context = document.getElementById('context').value;
			var state = document.getElementById('state').value;
			var manager = document.getElementById('manager').value;
			var team = document.getElementById('team').value;
			var commaPayment = document.getElementById('payment').value;
		    var payment = commaPayment.replace(/,/gi, '');
		    console.log("payment : " + payment);
			
			
			var formData={project_title: project_title, project_nickname: project_nickname,
					start_date: start_date, end_date: end_date, context: context, state: state, manager: manager, team:team, payment:payment}
			
			if(fnPro()) {
				$.ajax({
					url: "/project/register",
					type: "post",
					data: formData,
					success: function(data){
						if(data==='success'){
							alert("등록이 완료되었습니다.");
							location.href="/project/project";
						}else{
							alert("오류가 발생하였습니다. 다시 시도해주세요");
							return;
						}
					}
				});
			}
		});
		
		
</script>