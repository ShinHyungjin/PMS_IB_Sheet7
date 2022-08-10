<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../includes/header.jsp" />

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
				<li><a href="#"><i class="mnImg01"></i> <span class="nav-label">보고서</span><span class="arrow01"></span></a>
					<ul class="nav nav-second-level">
						<li class=""><a href="${pageContext.request.contextPath}/report/team">내부서</a></li>
						<li><a href="${pageContext.request.contextPath}/report/project">프로젝트별</a></li>
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
	</div>
	<!-- #gnb e -->
	<script>
	$(document).ready(function(){
		//컨트롤러에 저장된 project ID를 받는다
		var projectId;
	 	$.ajax({
			 type: "POST",	
			 url: "/project/getProjectId",
			 success: function(data){
				 projectId = data;
				 }
	 	 });
	 	
	 	//컨트롤러에서 로그인한 사용자가 소속된 프로젝트 리스트를 가져온다
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
			 	console.log(myjob);
			 	for(var i =0; i<data.length; i++){
			 		if(data[i].PROJECT_ID == projectId ) {
				 		$("#project_list").append("<li class=\"active\" id=project_id value="+data[i].PROJECT_ID+" data-value="+data[i].PROJECT_TITLE+"><a href=\"${pageContext.request.contextPath}/project/main?id="+data[i].PROJECT_ID+"\">"+data[i].PROJECT_TITLE+"</li>");			 			
			 		} else {
			 			$("#project_list").append("<li id=project_id value="+data[i].PROJECT_ID+" data-value="+data[i].PROJECT_TITLE+"><a href=\"${pageContext.request.contextPath}/project/main?id="+data[i].PROJECT_ID+"\">"+data [i].PROJECT_TITLE+"</li>");			 			
			 		}
			 	}
		 	}
 	 	});
	 });
	</script>
	
	<div id="page-wrapper">
