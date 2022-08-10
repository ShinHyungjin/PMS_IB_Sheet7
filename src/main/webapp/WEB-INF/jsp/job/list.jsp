<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s" %> 
<%@ page import = "java.util.Calendar" %>
<jsp:include page="../includes/header.jsp" />

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />  
	
	<div id="wrapper">
		<nav class="navbar-default navbar-static-side" role="navigation">
			<div class="sidebar-collapse">
				<ul class="nav metismenu" id="side-menu">
					<li class="active"><a href="#"><i class="mnImg02"></i><span class="nav-label">내작업</span><span class="arrow01"></span></a>
						<ul class="nav nav-second-level">
							<li class="active"><a href="${pageContext.request.contextPath}/job/list">전체</a></li>
							<li><a href="${pageContext.request.contextPath}/job/before">진행전  <c:out value="${beforelastCnt}" /></a></li>
							<li><a href="${pageContext.request.contextPath}/job/ing">진행중  <c:out value="${inglastCnt}" /></a></li>
							<li><a href="${pageContext.request.contextPath}/job/stop">중단</a></li>
							<li><a href="${pageContext.request.contextPath}/job/end">완료</a></li>
						</ul>
					</li>
					<li><a href="#"><i class="mnImg01"></i> <span class="nav-label">보고서</span><span class="arrow01"></span></a>
						<ul class="nav nav-second-level">
							<li class=""><a href="${pageContext.request.contextPath}/report/team">내부서</a></li>
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
	<%--${project_title}
	${project_nickname}--%></h2> 
	<input type="hidden" value="${project_title }" id="test" />
	<c:set var="project_title" value="${param.project_title}" />
	<c:set var="userid" value="${param.userid}" />
	<input type="hidden" value="${userid}" id="userid" />
	<c:set var="yoon" value="${param.yoon}" />
							 
	<div class="subConView">
		<div class="conWrap">
			<div class="sectionCon">
				<div class="board_top mainSearch">
						<div class="col-md-3"  style="padding-left: 0px;">
							<div class="selects">
								<select class="project_title" name="type" id="project_title" >
								<option value="all" data-value="all" value="전체">전체</option>
								<option value="기타" data-value="기타">기타</option>
								</select>
							</div>
						</div>
						<div class="col-md-2" style="padding-left: 0px;">
							<form id="actionForm" action="job/list" method="get"> 
								<input type="submit" value="검색" id="search"  class="btn btn-info" />
								<input type="hidden" id="title"> 
							</form>	 
						</div>
						<div class="col-md-7 text-right"  style="padding-left: 0px;">
							<a href="${pageContext.request.contextPath}/job/subregister" class="btn btn-info" title=""><i class="ti-plus"></i>&nbsp;&nbsp;새작업</a>
						</div>
					<!-- 버튼 끝 -->
				</div>
				<div class="workStaion">
					<div class="workListArea">
						<div class="workList workBefore col-md-4">
							<div class="workListWrap">
							<!-- ============================ 프로젝트 진행 전인 숫자들 목록 표시 ============================ -->
								<h3>
									진행 전<span><c:out value="${beforeCnt}" /></span>
								</h3>
							<!-- ============================ 프로젝트 진행 전인 숫자들 목록 표시 ============================ -->
							<c:forEach var="before" items="${beforelist}">
							<!-- =========================================== 내용 목록 시작  ===========================================-->	
							<!-- ====================== 진행전 시작 ================================= -->
										<div class="workListDetail">
										<c:choose>
											<c:when test="${before.wbs_id!=0}">
			                                     <div class="station" style="background: #FFFFCC;">
			                                  </c:when>
			                                   <c:when test="${before.wbs_id==0}">
			                                      <div class="station">
			                                  </c:when>
		                                  </c:choose>
											<c:if test="${before.project_id ne 0}"><a href="/project/main?id=<c:out value="${before.project_id}" />" title="프로젝트 이동"> </c:if>
												<div class="cate">
													<c:out value="${before.project.project_nickname eq null ? '기타' : before.project.project_nickname}" />
													<c:out value="${before.project.project_nickname eq null ? '' : before.order_id}" />
			                              			 <c:choose>
														<c:when test="${before.week==1}">
															<i class="far fas fa-star" title="주간보고서 포함"></i>
					                                   </c:when>
					                                   <c:when test="${before.week!=1}">
					                                      <i class="far fa-star" title="주간보고서 미포함"></i>
					                                  </c:when>
				                                  	</c:choose>
												</div>
											</a>
											<a href="/job/submodify?id=<c:out value="${before.id}" />">
											<c:choose>
													<c:when test="${before.real_start_date < today}">
				                                     	<h4 style="color: #FF0000"><c:out value="${before.name}"/><span></span></h4>
				                                   </c:when>
				                                   <c:when test="${before.real_start_date >= today}">
														<h4><c:out value="${before.name}"/><span></span></h4>
												 	</c:when>
			                              	</c:choose>
											(<c:out value="${before.real_start_date}"/>~<c:out value="${before.real_end_date}"/>)
											<div class="ingTxt">
												<fmt:formatNumber value="${before.real_progress*100}" type="number" var="numberType" />
												<span><c:out value="${numberType}"/>%</span>
											</div>
											</a>
										</div>
								</div>
								<!-- ====================== 진행전  종료================================= -->
							</c:forEach>
							</div>
						</div>
						<div class="workList workIng col-md-4">
							<div class="workListWrap">
								<h3>
									진행 중<span><c:out value="${ingCnt}" /></span>
								</h3>
								<c:forEach var="ing" items="${inglist}">
						<!-- ====================== 진행중 시작 ================================= -->
									<div class="workListDetail">
										<c:choose>
											<c:when test="${ing.wbs_id!=0}">
			                                     <div class="station" style="background: #FFFFCC;">
			                                  </c:when>
			                                   <c:when test="${ing.wbs_id==0}">
			                                      <div class="station">
			                                  </c:when>
		                                  </c:choose>
											<c:if test="${ing.project_id ne 0}"><a href="/project/main?id=<c:out value="${ing.project_id}" />" title="프로젝트 이동"> </c:if>
											<div class="cate">
													<c:out value="${ing.project.project_nickname eq null ? '기타' : ing.project.project_nickname}" />
													<c:out value="${ing.project.project_nickname eq null ? '' : ing.order_id}" />
			                              			 <c:choose>
														<c:when test="${ing.week==1}">
															<i class="far fas fa-star" title="주간보고서 포함"></i>
					                                   </c:when>
					                                   <c:when test="${ing.week!=1}">
					                                      <i class="far fa-star" title="주간보고서 미포함"></i>
					                                  </c:when>
				                                  	</c:choose>
												</div>
											</a>
											<a href="/job/submodify?id=<c:out value="${ing.id}" />">
											<c:choose>
													<c:when test="${ing.real_end_date < today}">
				                                     	<h4 style="color: #FF0000"><c:out value="${ing.name}"/><span></span></h4>
				                                   </c:when>
				                                   <c:when test="${ing.real_end_date >= today}">
														<h4><c:out value="${ing.name}"/><span></span></h4>
												 	</c:when>
			                              	</c:choose>
												(<c:out value="${ing.real_start_date}"/>~<c:out value="${ing.real_end_date}"/>)
											<div class="ingTxt">
											<fmt:formatNumber value="${ing.real_progress*100}" type="number" var="numberType" />
											<span><c:out value="${numberType}"/>%</span>
											</div>
											</a>
										</div>
								</div>
						<!-- ====================== 진행중 끝 ================================= -->
						 	  </c:forEach>	 
							  </div>
							</div>

						<div class="workList workEnd col-md-4">
							<div class="workListWrap">
								<h3>
									완료(최근2개월)<span><c:out value="${endCnt}" /></span>
								</h3>
				 				<c:forEach var="end" items="${endlistBefore2Months}"> 
								<!-- ====================== 완료 시작 ================================= -->
								<div class="workListDetail">
										<c:choose>
											<c:when test="${end.wbs_id!=0}">
			                                     <div class="station" style="background: #FFFFCC;">
			                                  </c:when>
			                                   <c:when test="${end.wbs_id==0}">
			                                      <div class="station">
			                                  </c:when>
		                                  </c:choose>
											<c:if test="${end.project_id ne 0}"><a href="/project/main?id=<c:out value="${end.project_id}" />" title="프로젝트명 "> </c:if>
											<div class="cate">
												<c:out value="${end.project.project_nickname eq null ? '기타' : end.project.project_nickname}" /> 
												<c:out value="${end.project.project_nickname eq null ? '' : end.order_id}" />
												<c:choose>
					                                  <c:when test="${end.week==1}">
					                                      <i class="far fas fa-star"  title="주간보고서 포함"></i>
					                                  </c:when>
					                                  <c:when test="${end.week!=1}">
					                                      <i class="far fa-star"></i>
					                                  </c:when>
				                               </c:choose>
											</div>
											</a>
											<a href="/job/submodify?id=<c:out value="${end.id}" />">
											<h4>
												<c:out value="${end.name}" /><span></span>
											</h4>
											(<c:out value="${end.real_start_date}"/>~<c:out value="${end.real_end_date}"/>)
											<div class="ingTxt">
											<fmt:formatNumber value="${end.real_progress*100}" type="number" var="numberType" />
											<span><c:out value="${numberType}"/>%</span>
											</div>
											</a>
										</div>
								</div>
						<!-- ====================== 완료 끝 ================================= -->
								 </c:forEach>	 
								</div>
							</div>
						</div>

					</div>
				</div>

			</div>


		</div>
<input type="hidden" id="selectedTitle" value="${selectedTitle}" />		
<jsp:include page="../includes/footer.jsp" />

<!-- .container-inner e -->
<script>
 $(document).ready(function(){
//==============POST 형식엔 자동으로 CSRF 토큰이 들어간다. 시작=======================================
/* 	 var csrf = '${_csrf.headerName}';
     var csrfToken = "${_csrf.token}";
     
     $(document).ajaxSend(function(e, xhr) {
         xhr.setRequestHeader(csrf, csrfToken);
     }); */
//==============POST 형식엔 자동으로 CSRF 토큰이 들어간다. 끝=========================================   
		   
	
	
//==============job list 들어왔을 때 바로 셀렉트 박스 디폴트 값 가져온다. 시작===========================	   
     var userid='<s:authentication property="principal.username"/>';
     //alert("로그인: "+userid);
     var myjob; 
 	 $.ajax({
		 type: "POST",	
		 url: "/job/myjob",
		 data : {userid : userid},
		 success: function(data){
			 if(data!=null){
				// alert("일단 값은 들어왔어");
				 myjob=data;
			 }else{
				 alert("오류가 발생하였습니다. 다시 시도해주세요!");
			 }
		
			 
			 for(var i =0; i<data.length; i++){
				// alert(data[i].PROJECT_TITLE+":"+data[i].PROJECT_NICKNAME);
				 $("#project_title").append("<option id="+"selectTitle("+i+")"+" value="+data[i].PROJECT_NICKNAME+" data-value="+data[i].PROJECT_NICKNAME+">"+data[i].PROJECT_TITLE+"</option>");
				 $("#project_list").append("<li id=project_id value="+data[i].PROJECT_ID+" data-value="+data[i].PROJECT_TITLE+"><a href=\"${pageContext.request.contextPath}/project/main?id="+data[i].PROJECT_ID+"\">"+data[i].PROJECT_TITLE+"</li>");

				// $("#project_nickname").append("<option value="+data[i].PROJECT_NICKNAME+">"+data[i].PROJECT_NICKNAME+"</option>");
			 }
			 
		      for(var i =0; i<data.length+2; i++){
		        	 var selectedTitle = document.getElementById('selectedTitle').value;
		        	 //alert(selectedTitle);
		        	 var project_title = document.getElementById('project_title');
		        	 //alert("test: "+project_title.options[0].innerHTML);
		        	 if(project_title.options[i].innerHTML === selectedTitle){
		        		 //alert(project_title.options[i].innerHTML);
		        		 project_title.options[i].selected=true;
		        		 break;
			        	 }
		             } 
			 
			 
			 
		 }
	 	 
	 });   
 	 
 	 console.log("밖으로 꺼냄:"+myjob);
 	//==============job list 들어왔을 때 바로 셀렉트 박스 디폴트 값 가져온다. 끝=========================
     
	 
//첫번째 셀렉트 박스 눌렀을때 나오는 내용 시작===========================================================
/*  	 $("#project_title").on("click",function(e){
		alert(userid);
		// alert(userid);
	
 	 $.ajax({
			 type: "post",	
			 url: "/job/myjob",
			 data : {userid : userid},
			 success: function(data){
				 if(data!=null){
					// alert("일단 값은 들어왔어");
				 }
				 
				 
				 for(var i =0; i<data.length; i++){
					 //alert(data[i].
+":"+data[i].PROJECT_NICKNAME);
					 $("#project_title").append("<option value="+data[i].PROJECT_TITLE+">"+data[i].PROJECT_TITLE+"</option>");
				 }
			 }
		 });  
	 });   */
	//첫번째 셀렉트 박스 눌렀을때 나오는 내용 완료=========================================================	 

/* 

*/

//첫번째 셀렉트 박스 눌렀을때 두번째 셀렉트 박스 자동으로 기입 시작===========================================
$("#project_title").on("click",function(e){
	e.preventDefault();
	//var test = $(this).val();
	var test= $(this).find(':selected').attr('data-value');
	//alert("나오니?:"+test);
	$("#project_nickname").empty();
	$("#project_nickname").append("<option>"+test+"</option>");	
	
});//첫번째 셀렉트 박스 눌렀을때 두번째 셀렉트 박스 자동으로 기입 끝=========================================
	

var url ="";
$("#search").on("click",function(e){
	e.preventDefault();
	
	var actionForm=("#actionForm");
	var project_title = document.getElementById('project_title');
	var select_project_title=project_title.options[project_title.selectedIndex].text; //선택된 프로젝트 명
	var userid='<s:authentication property="principal.username"/>'; //로그인 유저
	$('input[id=title]').attr('value',select_project_title);
	var test=$("#title").val();
	//alert("선택된 셀렉트 벨류: "+select_project_title);
	//alert("담겼니? "+test);
	var check="전체";
	if(test==="전체"){
		url=url+"?title="+test;
	}else{
		url=url+"?title="+test
	}
	
	location.href = url;
	
/* 	 $.ajax({
		 type: "post",	
		 url: "/job/list",
		 data : {project_title:select_project_title,userid:userid}

	 });  */
	
	
/* 	
	var actionForm=$("#actionForm");	
	actionForm.submit(); */
	
	
});
	
	
}); //==============document.ready 끝=================================================================
 
 

 
</script>





