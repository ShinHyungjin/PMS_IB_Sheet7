<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ibleaders.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/common.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ibsheetinfo.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ibsheet.js"></script>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="title" content="IB Leaders" />
<meta name="Author" content="IB Leaders" />
<meta name="keywords" content="IB Leaders" />

<meta property="og:type" content="website">
<meta property="og:title" content="IB Leaders">
<meta property="og:url" content="http://www.url.co.kr/">
<meta property="og:image" content="">
<meta property="og:description" content="IB Leaders 업무관리" />


<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
<meta name='viewport'
	content='initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0,width=device-width'>

<link rel="apple-touch-icon" sizes="57x57" href="${pageContext.request.contextPath}/img_app/favicon/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="${pageContext.request.contextPath}img_app/favicon/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="${pageContext.request.contextPath}/img_app/favicon/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/img_app/favicon/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="${pageContext.request.contextPath}/img_app/favicon/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="${pageContext.request.contextPath}/img_app/favicon/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="${pageContext.request.contextPath}/img_app/favicon/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="${pageContext.request.contextPath}/img_app/favicon/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/img_app/favicon/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192"  href="${pageContext.request.contextPath}/img_app/favicon/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/img_app/favicon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="${pageContext.request.contextPath}/img_app/favicon/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/img_app/favicon/favicon-16x16.png">
<link rel="manifest" href="../resources/img_app/favicon/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="../resources/img_app/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">

<!-- 
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="icon" href="/favicon.ico" type="image/x-icon"> -->

<script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/js/html5.js"></script>
<!-- Main scripts -->
<script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/js/jquery-2.1.1.js"></script>
<script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>

<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/js/modernizr.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/js/platform.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/js/mobile-detect.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/js/mobile-detect-modernizr.js"></script>

<!-- Data picker -->
<script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/js/plugins/datapicker/bootstrap-datepicker.js"></script>
<script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/js/jquery.mCustomScrollbar.concat.min.js"></script>
<script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/js/jquery.metisMenu.js"></script>

<script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/js/ui.js"></script>

<!-- Clock picker -->
<script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/js/plugins/clockpicker/clockpicker.js"></script>

<!-- confirm -->
<script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/js/plugins/sweetalert/sweetalert.min.js"></script>

<!-- jsTree -->
<script src="${pageContext.request.contextPath}/js/plugins/jsTree/jstree.min.js"></script>


<link rel="apple-touch-icon"
	href="${pageContext.request.contextPath}/resources/img_app/favicon/apple-icon-57x57.png">
<link rel="apple-touch-icon"
	href="${pageContext.request.contextPath}/resources/img_app/favicon/apple-icon-60x60.png">
<link rel="apple-touch-icon"
	href="${pageContext.request.contextPath}/resources/img_app/favicon/apple-icon-72x72.png">
<link rel="apple-touch-icon"
	href="${pageContext.request.contextPath}/resources/img_app/favicon/apple-icon-76x76.png">
<link rel="apple-touch-icon"
	href="${pageContext.request.contextPath}/resources/img_app/favicon/apple-icon-114x114.png">
<link rel="apple-touch-icon"
	href="${pageContext.request.contextPath}/resources/img_app/favicon/apple-icon-120x120.png">
<link rel="apple-touch-icon"
	href="${pageContext.request.contextPath}/resources/img_app/favicon/apple-icon-144x144.png">
<link rel="apple-touch-icon"
	href="${pageContext.request.contextPath}/resources/img_app/favicon/apple-icon-152x152.png">
<link rel="apple-touch-icon"
	href="${pageContext.request.contextPath}/resources/img_app/favicon/apple-icon-180x180.png">
<link rel="icon" type="image/png"
	href="${pageContext.request.contextPath}/resources/img_app/favicon/android-icon-192x192.png">
<link rel="icon" type="image/png"
	href="${pageContext.request.contextPath}/resources/img_app/favicon/favicon-32x32.png">
<link rel="icon" type="image/png"
	href="${pageContext.request.contextPath}/resources/img_app/favicon/favicon-96x96.png">
<link rel="icon" type="image/png"
	href="${pageContext.request.contextPath}/resources/img_app/favicon/favicon-16x16.png">
<link rel="manifest"
	href="${pageContext.request.contextPath}/resources/img_app/favicon/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage"
	content="${pageContext.request.contextPath}/resources/img_app/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/html5.js"></script>
<!-- Main scripts -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-2.1.1.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>

<script type="text/javascript" charset="utf-8"
	src="${pageContext.request.contextPath}/resources/js/modernizr.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${pageContext.request.contextPath}/resources/js/platform.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${pageContext.request.contextPath}/resources/js/mobile-detect.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${pageContext.request.contextPath}/resources/js/mobile-detect-modernizr.js"></script>

<!-- Data picker -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/plugins/datapicker/bootstrap-datepicker.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery.mCustomScrollbar.concat.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery.metisMenu.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/ui.js"></script>

<!-- jsTree -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/plugins/jsTree/jstree.min.js"></script>
<!-- TouchSpin -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/plugins/touchspin/jquery.bootstrap-touchspin.js"></script>
<!-- confirm -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/plugins/sweetalert/sweetalert.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ib.util.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ib.common.js"></script>

<!-- layout css -->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/common/css/style.css" /> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">




</head>

<body>
	<!-- global loading -->
	<div class="data-load">
		<img class="load-out" src="${pageContext.request.contextPath}/resources/img_app/load_img_out.png" alt=""> 
		<img class="load-in" src="${pageContext.request.contextPath}/resources/img_app/load_img_inner.png" alt="">
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
									<span>line</span> <span>line</span> <span>line</span>
								</div>
							</a>
						</div>
						<h1 class="brand">
							<a href="${pageContext.request.contextPath}/job/list"><span>IB Leaders</span></a>
						</h1>
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

		<!--//search_rm-->
		<!-- HEADER END -->
		 <!-- <form id="actionForm"></form> -->
		 <script>
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
						 
					 }else{
						 alert("오류가 발생하였습니다. 다시 시도해주세요!");
					 }
				
					 
				 }
			 	 
			 });   
		 });  
		 </script>
