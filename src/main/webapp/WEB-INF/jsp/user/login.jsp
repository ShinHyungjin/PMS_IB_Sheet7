<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<link rel="icon" type="image/png" sizes="192x192" href="../resources/img_app/favicon/android-icon-192x192.png">
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

<script type="text/javascript" charset="utf-8" src="/resources/js/modernizr.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/resources/js/platform.js"></script>
<script type="text/javascript" charset="utf-8" src="/resources/js/mobile-detect.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/resources/js/mobile-detect-modernizr.js"></script>

<!-- Data picker -->
<script type="text/javascript" language="javascript" src="/resources/js/plugins/datapicker/bootstrap-datepicker.js"></script>
<script type="text/javascript" language="javascript" src="/resources/js/jquery.mCustomScrollbar.concat.min.js"></script>
<script type="text/javascript" language="javascript" src="/resources/js/jquery.metisMenu.js"></script>

<script type="text/javascript" language="javascript" src="/resources/js/ui.js"></script>

<!-- jsTree -->
<script type="text/javascript" language="javascript" src="/resources/js/plugins/jsTree/jstree.min.js"></script>

<!-- TouchSpin -->
<script type="text/javascript" language="javascript" src="/resources/js/plugins/touchspin/jquery.bootstrap-touchspin.js"></script>

<!-- confirm -->
<script type="text/javascript" language="javascript" src="/resources/js/plugins/sweetalert/sweetalert.min.js"></script>



<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/resources/css/layout.css">


 

</head>



<script>

$(document).ready(function(){
	/*  $("#validateForm").validate({
		 rules: {
			 loginid: {
				 아이디를 입력해주세요
			 },
			 loginpassword: {
				비밀번호를 입력해주세요
			 }
		 }
	 }); */
});
 
var loginUser='<s:authentication property="principal"/>';
console.log("현재 로그인 한 유저는? " +loginUser);
 
</script>


<body class="gray-bg01">

<div class="wrapper">
	<div class="brandNameArea">
		<h1 class="brandName">IB Leaders</h1>
	</div>
	<div class="row nopadding mainLogin white-bg">	
		<div class="">
			<div class="col-lg-7">
				<div class="loginVisual">
					<h3>IB Leaders</h3>
					<ul>
						<li>(주)아이비리더스 업무관리시스템입니다. </li>
					</ul>
				</div>
			</div>
			<div class="col-lg-5">
				<div class="loginArea">
					<form name=""role="form" action="/login" method="post" class="form-horizontal" id="validateForm">
					<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />  --%>
					<div class="mainRightArea">
						<h2 class="loginTitle">LOGIN</h2>
						<h3>IB Leaders 로그인</h3>
		
						<div class="loginInput">						
							<div class="loginInputArea">
								<div class="form-group">
									<input class="form-control input-radius" id="loginid" name="username" placeholder="Id">
								</div>
								<div class="form-group">
									<input type="password" class="form-control input-radius" id="loginpassword" name="password" placeholder="Password">
								</div>						
							</div>
							<div class="form-group">
								<div class="col-lg-12">
										<!-- <input name="remember-me" type="checkbox" style="margin: 0px;"> 로그인 저장 -->
									<!-- <input  type="checkbox" id="check1" checked="checked" /><label for="check1" class="checkbox">아이디 저장</label> -->
								</div>
							</div>
							<div class="form-group">
								<div class="">
									<button class="btn btn-primary btn-block btn-md" type="submit" id="login">로그인</button>
								</div>
							</div>
							<div class="form-group">
								<div class="m-t-md text-right">
									<a href="#" data-toggle="modal" data-target="#membershipReg">회원가입</a>
								</div>
							</div>
							<div>
								<p style="color: blue;">※ 공지사항 ※</p>
								<p>1. '가입 승인' 및  '프로젝트 생성 및 관리 권한(PM 또는 PL 등)'이 필요한 경우</p>
								<p>2. 기타 문의 사항 있는 경우(사용설명, 오류사항 등)</p>
								<p style="color: red;">☞  TEAMS > IBL업무관리시스템(PMS) > '질문 및 답변' 게시판에 요청해 주세요.</p>
							</div>
						</div>
					</div>
					</form>
				</div>
			</div>
		</div>		
	</div>
	<div class="loginFooter">
		2021© IB Leaders
	</div>
</div>
<!-- 규정-->
<%-- <form id="join_form" class="form-horizontal" method="post" action="${pageContext.request.contextPath}/user/join"> --%>
	<div class="modal inmodal fade" id="membershipReg" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title">회원가입</h4>
				</div>
				<div class="modal-body">											
					<div class="sectionCon">
						<h2 class="tit-level2">기본정보 입력</h2>
						<div class="writeType02">										
							<div class="row form-horizontal">
								<div class="col-sm-12">
									<div class="viewTable">
										<div class="form-group">
											<label class="col-sm-2 control-label labelTitle"><span class="">아이디</span></label>
											<div class="col-sm-10">
												<div class="input-group">
													<input id="id" name="username" type="text" class="form-control" placeholder="ex) hong1" onchange="idcheck()">
													<span class="input-group-btn">
														<button id="idck" type="button" class="btn btn-default">중복확인</button>
													</span>
												</div>
												<span id="id-no" style="display: none; color: #d92742; font-weight: bold;">4 ~10 자리의 영문 또는 영문+숫자 를 입력해주세요.</span>
											</div>		
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label labelTitle"><span class="">비밀번호</span></label>
											<div class="col-sm-10">
												<input name="password" id="password" type="password" class="form-control" placeholder="ex) a12345">
												<span id="pass" style="display: none; color: #d92742; font-weight: bold; ">6 ~ 15 자리의 영문, 숫자를 혼합하여 입력해주세요. (특수문자 제외)</span>
												<span id="success" style="display: none;">사용가능한 비밀번호 입니다.</span>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label labelTitle"><span class="">비밀번호 확인</span></label>
											<div class="col-sm-10">
												<input id="password2" type="password" class="form-control">
												<span id="alert-success" style="display: none;">비밀번호가 일치합니다.</span>
												<span id="alert-danger" style="display: none; color: #d92742; font-weight: bold; ">비밀번호가 일치하지 않습니다.</span>
											</div>
										</div>									
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="sectionCon">
						<h2 class="tit-level2">개인정보 입력</h2>
						<div class="writeType02">										
							<div class="row form-horizontal">
								<div class="col-sm-12">
									<div class="viewTable">
										<div class="form-group">
											<label class="col-sm-2 control-label labelTitle"><span class="">이름</span></label>
											<div class="col-sm-10">
												<input id="name" name="name" type="text" class="form-control" placeholder="ex) 홍길동" >
												<span id="name-no" style="display: none; color: #d92742; font-weight: bold;">정확한 이름을 입력해주세요.</span>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label labelTitle"><span class="">이메일</span></label>
											<div class="col-sm-4">
												<input id="email" name="email" type="text" class="form-control" placeholder="ex) hong1@ibleaders.co.kr">
												<span id="email-no" style="display: none; color: #d92742; font-weight: bold;">잘못된 이메일 주소입니다.</span>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label labelTitle"><span class="">휴대전화 번호</span></label>
											<div class="col-sm-10">
												<input id="phone" name="phone" type="text" class="form-control" placeholder="ex) 01012341234">
												<span id="tel-no" style="display: none; color: #d92742; font-weight: bold;">정확한 전화번호를 입력해주세요.</span>
											</div>
										</div>	
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label labelTitle"><span class="">부서</span></label>
											<div class="col-sm-10">
												<div class="selects">
													<select class="form-control" name="department" id="department">
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
													<span id="depart-no" style="display: none; color: #d92742; font-weight: bold;">부서를 선택해주세요.</span>
												</div>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label labelTitle"><span class="">직급</span></label>
											<div class="col-sm-10">
												<div class="selects">
													<select class="form-control" name="rank" id="rank">
														<option value="사원">사원</option>
														<option value="대리">대리</option>
														<option value="과장">과장</option>
														<option value="차장">차장</option>
														<option value="부장">부장</option>
														<option value="이사">이사</option>
														<option value="상무">상무</option>
														<option value="부사장">부사장</option>
														<option value="대표">대표</option>
													</select>
													<span id="rank-no" style="display: none; color: #d92742; font-weight: bold;">직급을 선택해주세요.</span>
												</div>
											</div>
										</div>	
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer" >
					<button class="btn btn-primary btn-outline" data-dismiss="modal" type="submit" id="signUp">가입하기</button>
				</div>
			</div>
		</div>
	</div>

<script>

		
    //아이디 중복체크 - 버튼 팝업     
	   var idck = 0;
	   $("#idck").click(function() {
	        //userid 를 param.
	        var id =  $("#id").val(); //     
		    var num = id.search(/[0-9]/g);
		    var eng = id.search(/[a-z]/ig);
		    /*var csrf = '${_csrf.headerName}';
			var csrfToken = "${_csrf.token}"; */
			$(document).ajaxSend(function(e, xhr) {
				/* xhr.setRequestHeader(csrf, csrfToken); */
			})
	        $.ajax({
	            async: true,
	            type : 'POST',
	            data : JSON.stringify({id:id}), //객체로 파라미터
	            url : "idcheck",
	            dataType : "json",
	            contentType: "application/json; charset=UTF-8", 
    		    
	            success : function(data) {
	            	console.log(data);
	            	 var id = $("#id").val();
	     		    var idch = RegExp(/^(?!(?:[0-9]+)$)([a-zA-Z]|[0-9a-zA-Z]){4,10}$/);
	     		    
	            	if(idch.test($('#id').val())){
	            		if (data.cnt > 0) { //아이디가 존재
		                	 alert("중복 아이디가 존재합니다.");
		                } else { 
		                	alert("사용가능한 아이디입니다.");
		                    //아이디가 중복하지 않으면  idck = 1 
		                    idck = 1;
		                }
	            		$("#id-no").css('display', 'none'); 	
	      		        return true;
	      		    } 
	      		    $("#id-no").css('display', 'inline-block');
	      		    return false;
	            },
	            error : function(error) {  
	                alert("error : " + error);
	            }
	        });
	    });
	   
	   //중복값 초기화 
	   function idcheck() {
		   idck = 0;
	   }
	   
	   // 아이디 유효성 포커스
	   var fnId = function () {
		    var id = $("#id").val();
		    var eng = id.search(/[a-z]/ig);
		    var idch = RegExp(/^(?!(?:[0-9]+)$)([a-zA-Z]|[0-9a-zA-Z]){4,10}$/);
		    console.log(id);
		    
		    if(idch.test($('#id').val())){
		    	$("#id-no").css('display', 'none'); 	
		        return true;
		    } 
		    $("#id-no").css('display', 'inline-block');
		    return false;
		}   

      
		//비밀번호 유효성검사
		var fnPw = function () {
		    var pw = $("#password").val();
		    var num = pw.search(/[0-9]/g);
		    var eng = pw.search(/[a-z]/ig);
		    var passch = RegExp(/^(?!(?:[0-9]+)$)([a-zA-Z]|[0-9a-zA-Z]){6,15}$/);
		    
		    if(passch.test($('#password').val())){
		    	$("#pass").css('display', 'none');
			    $("#success").css('display', 'inline-block');
		        return true;
		    } 
		    $("#pass").css('display', 'inline-block');
	        $("#success").css('display', 'none');
		    return false;
		}
		

      //비밀번호 확인
      var fnPw2 = function (){ 
          var pw = $("#password").val();
          var pw2 = $("#password2").val();
          
          if (pw != "" || pw2 != "") {
              if (pw == pw2) {
            	  $("#alert-success").css('display', 'inline-block');
                  $("#alert-danger").css('display', 'none');
                  return true;
              } else {
            	  $("#alert-success").css('display', 'none');
                  $("#alert-danger").css('display', 'inline-block'); 
                  return false;
              }
          }
       };

      
   	 	// 이름 유효성 포커스
	   var fnName = function() {
		    var name = $("#name").val();
		    var namech = RegExp(/^[가-힣]{2,5}$/);
		    console.log( $("#name").val());
		    if(namech.test($('#name').val())){
		    	$("#name-no").css('display', 'none'); 	
		        return true;
		    } 
		    $("#name-no").css('display', 'inline-block');
		    return false;
		};
   		
	   //이메일 유효성
	   var fnEmail = function() {
		    var email = $("#email").val();
	        var emailch = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
		   
		    if(emailch.test($('#email').val())){
		    	$("#email-no").css('display', 'none'); 	
		        return true;
		    } 
		    $("#email-no").css('display', 'inline-block');
		    return false;
		};
      
      //전화번호 유효성
      var fnTel = function () {
    	  var tel = $("#phone").val();
    	  var num = tel.search(/[0-9]/g);
    	  
		    if(tel.length < 10 || tel.length > 12){
		    	$("#tel-no").css('display', 'inline-block');
		        return false;
		    }else if(num < 0){
		    	$("#tel-no").css('display', 'inline-block');
		    	return false;
		    }
		    $("#tel-no").css('display', 'none');
		    return true;
      	};
      	
      	//부서 유효성
      	var fnDepart = function () {
      		var depart = $("#department").val();
      		
      		if($("#department").val() == "") {
      			$("#depart-no").css('display', 'inline-block');
      		 	 return false;
      		}
      		 $("#depart-no").css('display', 'none');
      		 return true;
      	}
      	
      //부서 유효성
      	var fnRank = function () {
      		var depart = $("#rank").val();
      		
      		if($("#rank").val() == "") {
      			$("#rank-no").css('display', 'inline-block');
      		 	 return false;
      		}
      		 $("#rank-no").css('display', 'none');
      		 return true;
      	}
      

    	//아이디 유효성
		$('#id').focusout(fnId);
		//비밀번호 유효성
		$('#password').focusout(fnPw);
		//비밀번호 확인
		$('#password2').focusout(fnPw2);
		//이름 
		$('#name').focusout(fnName);
		//전화번호 유효성
		$('#phone').focusout(fnTel);
		//이메일 유효성
		$('#email').focusout(fnEmail);
		//부서 유효성
		$('#department').focusout(fnDepart);
		//직급 유효성
		$('#rank').focusout(fnRank);
		

		
		 $("#signUp").click(function(e) {
		        e.preventDefault();
		        
		        var id = $("#id").val();     
			    var password = $("#password").val();
			    var name= $("#name").val();
			    var email = $("#email").val();
			    var phone = $("#phone").val();
			    var depart = $("#department").val();
			    var department = Number.parseInt(depart);
			    var rank = $("#rank").val();
			    console.log(department);
			   
			   
				/*  $(document).ajaxSend(function(e, xhr) {
					 xhr.setRequestHeader(csrf, csrfToken); 
				})  */
				
			    if(idck===0){
		            alert('아이디 중복체크를 해주세요.');
		            e.stopPropagation();
		            return;
		        }
				
				if(fnPw() && fnPw2() && fnId() && fnName() && fnTel() && fnEmail() &&fnDepart() &&fnRank()) {
					$.ajax({
			            async: true,
			            type : 'POST',
			            data : JSON.stringify ({
			            //객체로 파라미터
			            	id:id, 
			            	password:password, 
			            	name:name, 
			            	email:email, 
			            	phone:phone,
			            	department:department,
			            	rank:rank
			            }),
			            url : "/user/join",
			            dataType : "json",
			            contentType: "application/json; charset=UTF-8", 
			            
			            success : function(data) {
			            	idck = 0;
			            	console.log(data);
			            	$("#id").val("");
			            	$("#password").val("");
			            	$("#password2").val("");
			            	$("#name").val("");
			            	$("#email").val("");
			            	$("#phone").val("");
			            	$("#department").val("");
			            	$("#rank").val("");
			    			alert("가입 요청이 전송되었습니다.");
			    			return;
			           	},
			            error : function(error) {  
			           		alert("회원가입을 다시 시도해주세요.");
			           		e.stopPropagation();
				            return;
		            	}
					});
				} else {
					 e.stopPropagation();
		            return;
				}
			});	   
</script>