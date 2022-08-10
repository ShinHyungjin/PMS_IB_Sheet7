<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<title>IB Leaders</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="title" content="IB Leaders" />
<meta name="Author" content="IB Leaders" />
<meta name="keywords" content="IB Leaders" />

<meta property="og:type" content="website">
<meta property="og:title" content="IB Leaders">
<meta property="og:url" content="http://www.url.co.kr/">
<!-- <meta property="og:image" content=""> -->
<meta property="og:description" content="IB Leaders 업무관리"/>


<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1"/>
<meta name='viewport' content='initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0,width=device-width'>

<link rel="apple-touch-icon" sizes="57x57" href="../resources/img_app/favicon/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="../resources/img_app/favicon/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="../resources/img_app/favicon/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="../resources/img_app/favicon/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="../resources/img_app/favicon/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="../resources/img_app/favicon/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="../resources/img_app/favicon/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="../resources/img_app/favicon/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="../resources/img_app/favicon/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192"  href="../resources/img_app/favicon/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="../resources/img_app/favicon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="../resources/img_app/favicon/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="../resources/img_app/favicon/favicon-16x16.png">
<link rel="manifest" href="../resources/img_app/favicon/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="../resources/img_app/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">


<script type="text/javascript" language="javascript" src="../resources/js/html5.js"></script>
<!-- Main scripts -->
<script type="text/javascript" language="javascript" src="../resources/js/jquery-2.1.1.js"></script>
<script type="text/javascript" language="javascript" src="../resources/js/bootstrap.js"></script>

<script type="text/javascript" charset="utf-8" src="../resources/js/modernizr.min.js"></script>
<script type="text/javascript" charset="utf-8" src="../resources/js/platform.js"></script>
<script type="text/javascript" charset="utf-8" src="../resources/js/mobile-detect.min.js"></script>
<script type="text/javascript" charset="utf-8" src="../resources/js/mobile-detect-modernizr.js"></script>

<!-- Data picker -->
<script type="text/javascript" language="javascript" src="../resources/js/plugins/datapicker/bootstrap-datepicker.js"></script>
<script type="text/javascript" language="javascript" src="../resources/js/jquery.mCustomScrollbar.concat.min.js"></script>
<script type="text/javascript" language="javascript" src="../resources/js/jquery.metisMenu.js"></script>

<script type="text/javascript" language="javascript" src="../resources/js/ui.js"></script>

<!-- jsTree -->
<script type="text/javascript" language="javascript" src="../resources/js/plugins/jsTree/jstree.min.js"></script>

<!-- TouchSpin -->
<script type="text/javascript" language="javascript" src="../resources/js/plugins/touchspin/jquery.bootstrap-touchspin.js"></script>

<!-- confirm -->
<script type="text/javascript" language="javascript" src="../resources/js/plugins/sweetalert/sweetalert.min.js"></script>


<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ib.util.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ib.common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ibsheetinfo.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ibsheet.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ibleaders.js"></script>

<!-- layout css -->
<link rel="stylesheet" type="text/css" href="../resources/css/layout.css">

</head>

<body>


<!-- global loading -->
<div class="data-load">
	<img class="load-out" src="../resources/img_app/load_img_out.png" alt="">
	<img class="load-in" src="../resources/img_app/load_img_inner.png" alt="">
</div>



<!-- wrap start -->
<div id="WRAP">
	<header id="header" class="opaque fixed sub_header">
		<div class="header-anim">
			<div class="header-container">				
				<div class="header-inner">
					<div class="util-cont">
						<a href="#" class="hamburger navbar-minimalize">
							<div class="hamburger-detail">
								<span>line</span>
								<span>line</span>
								<span>line</span>
							</div>
						</a>
					</div>
					<h1 class="brand"><a href="${pageContext.request.contextPath}/job/list"><span>IB Leaders</span></a></h1>
					<div class="utils">
						<ul class="menu">							
							<li class="toggle-menu"><a href="#" class="btn-toggle-menu"><span></span></a></li>
						</ul>
					</div>
				</div>				
			</div>
			<div class="logoutArea">
						<div class="username">
						
<!-- 유저정보로 가는곳========================================================================================================================== -->						
							<a id="move" href="/user/get?id=<s:authentication property="principal.username"/>" title="개인정보 수정">							
							<p id="userid"></p>
							</a>
						</div>
					<ul>
						<!-- <form id="actionForm">
						<li>
							<a title="로그아웃" id="logout" onClick="Logout()">
								<p class="topLogout">로그아웃</p>
						</a></li>
						</form> -->
						<li>
						<form method="post" action="${pageContext.request.contextPath}/user/logout" >
							<button style="background-color: transparent !important;"><p class="topLogout"></p></button>
					   </form>
					   </li>
					</ul>
				</div>
			</div>
		</header>	
	<aside id="mobileNav">
		<div class="mobile-nav">
			<div class="mobile-nav-header">
				<h2 class="brand"><a href="${pageContext.request.contextPath}/job/list"></a></h2>
				<!-- 뒤로가기 버튼  -->
				<a href="#" class="btn-toggle-menu active" title="">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 22 22">
					<path fill-rule="evenodd"  fill="#ffffff" d="M22.008,20.949 L20.960,21.996 L11.004,12.050 L1.048,21.996 L0.082,21.031 L10.038,11.085 L-0.000,1.058 L1.048,0.011 L11.086,10.038 L21.042,0.093 L22.008,1.058 L12.052,11.003 L22.008,20.949 Z"/>
				</svg>
				</a>
				<form method="post" action="${pageContext.request.contextPath}/user/logout" >
					<button style="background-color: transparent !important;"><a class="mlogoutIco"></a></button>
			   </form>
			</div>
			<div class="mobile-nav-body">
				<div class="mobileInfo">
					<div class="mobileLang">
						<ul>
							<li><a id="move2" href="/user/get?id=<s:authentication property="principal.username"/>">개인정보 수정</a></li>
						</ul>
					</div>
				</div>
				
				<ul class="gnb">
					<li>
						<div class="first-menu">
							<a href="javascript:;"><span>내작업</span></a>
						</div>
						<ul class="sub-menu">
							<li><a href="${pageContext.request.contextPath}/job/list">전체</a></li>
							<li><a href="${pageContext.request.contextPath}/job/before">진행전</a></li>
							<li><a href="${pageContext.request.contextPath}/job/ing">진행중</a></li>
							<li><a href="${pageContext.request.contextPath}/job/stop">중단</a></li>
							<li><a href="${pageContext.request.contextPath}/job/end">완료</a></li>
						</ul>
					</li>
					<li>
						<div class="first-menu " >
							<a href="javascript:;"><span>보고서</span></a>
						</div>
						<ul class="sub-menu">
							<li><a href="${pageContext.request.contextPath}/report/team">내부서</a></li>
							<li><a href="${pageContext.request.contextPath}/report/project">프로젝트별</a></li>
						</ul>
					</li>
					<li>
						<div class="first-menu" >
							<a href="javascript:;"><span>프로젝트</span></a>
						</div>
							<ul class="sub-menu">
								<li><a href="${pageContext.request.contextPath}/project/list"><span>목록</span></a></li>
							</ul>
					</li>
					<s:authorize access="!hasRole('ROLE_USER')">
						<li>
							<div class="first-menu " >
								<a href="javascript:;"><span>시스템 관리</span></a>
							</div>
							<ul class="sub-menu">
								<s:authorize access="hasRole('ROLE_ADMIN')">
									<li><a href="${pageContext.request.contextPath}/admin/check">사용자 관리</a></li>
								</s:authorize>
								<li><a href="${pageContext.request.contextPath}/project/project">프로젝트 관리</a></li>
							</ul>
						</li>
					</s:authorize>
				</ul>

			</div>
		</div>		
	</aside>

	<!--//search_rm-->
	<!-- HEADER END -->

	</header>
		<%
		 	String strReFerer = request.getHeader("referer");
		 	if(strReFerer == null) {
		 %>
		 <script>
		 alert("정상적인 경로를 통해 다시 시도해 주세요.");
		 document.location.href="javascript:history.back(-1)";
		 </script>
		 <%
			 return ;
			 }
		 %>

		<!--//search_rm-->
		<!-- HEADER END -->
		 <!-- <form id="actionForm"></form> -->
		 <script>
		 //history.replaceState({}, null, location.pathname);
	
		 
		 $(document).ready(function(){
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
						 $("#project_list2").append("<li value="+data[i].PROJECT_ID+" data-value="+data[i].PROJECT_TITLE+"><a href=\"${pageContext.request.contextPath}/project/main?id="+data[i].PROJECT_ID+"\">"+data[i].PROJECT_TITLE+"</li>");
					 }
				 }
		 	 });
			 }); 
		 
		 
 	 	 $(document).ready(function(){
			 var id;
		 	 $.ajax({
				 type: "POST",	
				 url: "/includes/header",
				 contentType : "application/json",
				 success: function(data){
					 if(data!=null){
						// alert("일단 값은 들어왔어");
						 //alert("로그인?: "+data.name);
						 id=data.name;
						 document.getElementById('userid').textContent=data.name;
						 $('move').prop('href','/user/get?id='+data.name);
						 $('move2').prop('href','/user/get?id='+data.name);
						 
					 }else{
						 alert("오류가 발생하였습니다. 다시 시도해주세요!");
					 }
				
					 
				 }
			 	 
			 });   
		 });  
 	 	
 	
		 </script>
