<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

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
<div class="">
	<form id="join_form" class="form-horizontal" method="post" action="${pageContext.request.contextPath}/user/join">
		<div class="col-md-3"></div>
		<div class="col-md-6">
			<div class="brandNameArea">
				<h1 class="brandName">IB Leaders</h1>
				<h3 class="text-center mb-4">회원가입</h3>
			</div>
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
												<input id="id" name="username" type="text" class="form-control" placeholder="ex) hong1">
												<span class="input-group-btn">
													<button id="idck" type="button" class="btn btn-default">중복확인</button>
												</span>
											</div>
											<span id="id-no" style="display: none; color: #d92742; font-weight: bold;">4 ~10 자리의 영문, 숫자를 혼합하여 입력해주세요.</span>
										</div>										
									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">비밀번호</span></label>
										<div class="col-sm-10">
											<input name="password" id="password" type="password" class="form-control" placeholder="ex) a12345">
											<span id="pass" style="display: none; color: #d92742; font-weight: bold; ">6 ~ 15 자리의 영문, 숫자를 혼합하여 입력해주세요.</span>
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
				<div class="sectionCon">
					<h2 class="tit-level2">개인정보 입력</h2>
					<div class="writeType02">										
						<div class="row form-horizontal">
							<div class="col-sm-12">
								<div class="viewTable">
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">이름</span></label>
										<div class="col-sm-10">
											<input id="name" type="text" class="form-control" placeholder="ex) 홍길동" >
											<span id="name-no" style="display: none; color: #d92742; font-weight: bold;">정확한 이름을 입력해주세요.</span>
										</div>
									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">이메일</span></label>
										<div class="col-sm-10">
											<input id="email" type="text" class="form-control" placeholder="ex) hong1@ibleaders.co.kr">
											<span id="email-no" style="display: none; color: #d92742; font-weight: bold;">잘못된 이메일 주소입니다.</span>
										</div>
									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">휴대전화 번호</span></label>
										<div class="col-sm-10">
											<input id="phone" type="text" class="form-control" placeholder="ex) 01012341234">
											<span id="tel-no" style="display: none; color: #d92742; font-weight: bold;">정확한 전화번호를 입력해주세요.</span>
										</div>
									</div>	
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">부서</span></label>
										<div class="col-sm-10">
											<div class="selects">
												<select class="form-control" name="">
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
								</div>
							</div>
						</div>
					</div>
					<div class="row">
					<div class="col-md-3"></div>
						<div class="col-md-6">
							<button class="btn btn-primary btn-block" id="signUp">가입하기 </button>
						</div>
					</div>
					<div class="col-md-3"></div>	
				</div>
			</div>
		</div>
		<div class="col-md-3"></div>
	</form>
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
	                if(id.length < 4 || id.length > 10){
	        		    $("#id-no").css('display', 'inline-block');
	    		        return false;
	    		    }
	    		    else if(id.search(/\s/) != -1){
	        		    $("#id-no").css('display', 'inline-block');
	    		        return false;
	    		    }else if(num < 0 || eng < 0){
	        		    $("#id-no").css('display', 'inline-block');
	    		        return false;
	    		    } else if (data.cnt > 0) { //아이디가 존재
	                	 alert("중복 아이디가 존재합니다.");
	                } else { 
	                	alert("사용가능한 아이디입니다.");
	                    //아이디가 중복하지 않으면  idck = 1 
	                    idck = 1;
	                }
	            },
	            error : function(error) {  
	                alert("error : " + error);
	            }
	        });
	    });
	   
	   
	   // 아이디 유효성 포커스
	   var fnId = function () {
		    var id = $("#id").val();
		    var num = id.search(/[0-9]/g);
		    var eng = id.search(/[a-z]/ig);
		   
		    if(id.length < 4 || id.length > 10){
    		    $("#id-no").css('display', 'inline-block');
		        return false;
		    }
		    else if(id.search(/\s/) != -1){
    		    $("#id-no").css('display', 'inline-block');
		        return false;
		    }
		    else if(num < 0 || eng < 0){
    		    $("#id-no").css('display', 'inline-block');
		        return false;
		    }
		    $("#id-no").css('display', 'none');
		    return true;
		}   

      
		//비밀번호 유효성검사
		var fnPw = function () {
		    var pw = $("#password").val();
		    var num = pw.search(/[0-9]/g);
		    var eng = pw.search(/[a-z]/ig);
		   
		    if(pw.length < 6 || pw.length > 15){
		        $("#pass").css('display', 'inline-block');
		        $("#success").css('display', 'none');
		        return false;
		    }
		    else if(pw.search(/\s/) != -1){
		        $("#pass").css('display', 'inline-block');
		        $("#success").css('display', 'none');
		        return false;
		    }
		    else if(num < 0 || eng < 0){
		        $("#pass").css('display', 'inline-block');
		        $("#success").css('display', 'none');
		        return false;
		    }
		    $("#pass").css('display', 'none');
		    $("#success").css('display', 'inline-block');
		    return true;
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
		   
		    if(namech.test($('#name').val())){
		    	$("#name-no").css('display', 'none'); 	
		        return true;
		    } 
		    $("#name-no").css('display', 'inline-block');
		    return false;
		}
   		
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
		}
      
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
		
		
		$("#signUp").click(function() {
			event.preventDefault();
			if(fnPw() && fnPw2() && fnId() && fnName() && fnTel() && fnEmail()) {
		        if(idck==0){
		            alert('아이디 중복체크를 해주세요.');
		            return false;
		        } 
		         alert("회원가입을 축하합니다.");
				 $("#join_form").submit();
				}
			})

</script>