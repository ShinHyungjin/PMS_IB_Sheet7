<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<jsp:include page="../user/aside.jsp" />
     <%--  <form id="join_form" class="form-horizontal" method="post" action="${pageContext.request.contextPath}/user/modify"> --%>
   <h2 class="tit-level1">개인정보 수정</h2>
   <div class="subConView">
      <div class="conWrap">
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
                                    <input id="id" type="text" class="form-control" value="${myInfo.id}" readonly>
                                 </div>
                              </div>                              
                           </div>
                           <div class="hr-line-dashed"></div>
                           <div class="form-group">
                              <label class="col-sm-2 control-label labelTitle"><span class="">비밀번호</span></label>
                              <div class="col-sm-10">
                                 <input name="password" id="password" type="password" class="form-control">
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
                                 <input id="name" type="text" class="form-control" readonly value="${myInfo.name}">
                              </div>
                           </div>
                           <div class="hr-line-dashed"></div>
                           <div class="form-group">
                              <label class="col-sm-2 control-label labelTitle"><span class="">이메일</span></label>
                              <div class="col-sm-10">
                                 <input id="email" type="text" class="form-control" value="${myInfo.email}">
                                 <span id="email-no" style="display: none; color: #d92742; font-weight: bold;">잘못된 이메일 주소입니다.</span>
                              </div>
                           </div>
                           <div class="hr-line-dashed"></div>
                           <div class="form-group">
                              <label class="col-sm-2 control-label labelTitle"><span class="">휴대전화 번호</span></label>
                              <div class="col-sm-10">
                                 <input id="phone" type="text" class="form-control" value="${myInfo.phone}">
                                 <span id="tel-no" style="display: none; color: #d92742; font-weight: bold;">정확한 전화번호를 입력해주세요.</span>
                              </div>
                           </div>   
                           <div class="hr-line-dashed"></div>
                           <div class="form-group">
                              <label class="col-sm-2 control-label labelTitle"><span class="">부서</span></label>
                              <div class="col-sm-10">
                                 <div class="selects">
                                    <select class="form-control" name="department" id="department">
                                       <c:choose>
                                       <c:when test="${myInfo.department==121}">
                                       <option value="121" selected>컨설팅사업팀</option>
                                       </c:when>
                                       <c:when test="${myInfo.department==122}">
                                       <option value="122" selected>스마트CNS팀</option>
                                       </c:when>
                                       <c:when test="${myInfo.department==123}">
                                       <option value="123" selected>항공정보팀</option>
                                       </c:when>
                                       <c:when test="${myInfo.department==124}">
                                       <option value="124" selected>항공기술사업팀</option>
                                       </c:when>
                                       <c:when test="${myInfo.department==125}">
                                          <option value="125" selected>SI영업팀</option>
                                       </c:when>
                                       <c:when test="${myInfo.department==126}">
                                       <option value="126" selected>솔루션영업팀</option>
                                       </c:when>
                                       <c:when test="${myInfo.department==127}">
                                       <option value="127" selected>영업지원팀</option>
                                       </c:when>
                                       <c:when test="${myInfo.department==128}">
                                       <option value="128" selected>SW개발사업팀</option>
                                       </c:when>
                                       <c:when test="${myInfo.department==129}">
                                       <option value="129" selected>솔루션사업팀</option>
                                       </c:when>
                                       <c:when test="${myInfo.department==130}">
                                       <option value="130" selected>연구개발1팀</option>
                                       </c:when>
                                       <c:when test="${myInfo.department==131}">
                                       <option value="131" selected>연구개발2팀</option>
                                       </c:when>
                                       <c:when test="${myInfo.department==132}">
                                       <option value="132" selected>경영관리팀</option>
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
                           <div class="hr-line-dashed"></div>
							<div class="form-group">
								<label class="col-sm-2 control-label labelTitle"><span class="">직급</span></label>
								<div class="col-sm-10">
									<div class="selects">
										<select class="form-control" name="rank" id="rank">
											<c:choose>
		                                       <c:when test="${myInfo.rank=='사원'}">
		                                       	<option value="사원" selected>사원</option>
		                                       </c:when>
		                                       <c:when test="${myInfo.rank=='대리'}">
		                                       	<option value="대리" selected>대리</option>
		                                       </c:when>
		                                       <c:when test="${myInfo.rank=='과장'}">
		                                       	<option value="과장" selected>과장</option>
		                                       </c:when>
		                                       <c:when test="${myInfo.rank=='차장'}">
		                                       	<option value="차장" selected>차장</option>
		                                       </c:when>
		                                       <c:when test="${myInfo.rank=='부장'}">
		                                       	<option value="부장" selected>부장</option>
		                                       </c:when>
		                                       <c:when test="${myInfo.rank=='이사'}">
		                                       	<option value="이사" selected>이사</option>
		                                       </c:when>
		                                       <c:when test="${myInfo.rank=='상무'}">
		                                       	<option value="상무" selected>상무</option>
		                                       </c:when>
		                                       <c:when test="${myInfo.rank=='부사장'}">
		                                       	<option value="부사장" selected>부사장</option>
		                                       </c:when>
		                                       <c:when test="${myInfo.rank=='대표'}">
		                                       	<option value="대표" selected>사장</option>
		                                       </c:when>
		                                    </c:choose>
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
									</div>
								</div>
							</div>		   
                        </div>
                     </div>
                  </div>
               </div>
               <div class="btnArea text-right">
                  <button class="btn btn-primary" type="submit" id="modify">저장</button>
                  <%-- <a href="${pageContext.request.contextPath}/user/modify?id=${myInfo.id}" class="btn btn-primary">수정</a> --%>
               </div>
            </div>
         </div>
          
         </div>
      </div>
<!--   </form> -->
<jsp:include page="../includes/footer.jsp" />

<script>

window.onbeforeunload = function() {
    return "변경사항을 무시하고 이동하시겠습니까?";
  };

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
    	
      //비밀번호 유효성
      $('#password').focusout(fnPw);
      //비밀번호 확인
      $('#password2').focusout(fnPw2);
      //전화번호 유효성
      $('#phone').focusout(fnTel);
      //이메일 유효성
      $('#email').focusout(fnEmail);
	  //부서 유효성
	  $('#department').focusout(fnDepart);
      
		
       $("#modify").click(function(e) {
           e.preventDefault();
           window.onbeforeunload = null;
          var id = $("#id").val();
          var password = $("#password").val();
          var name = $("#name").val();
          var email = $("#email").val();
          var phone = $("#phone").val();
          var depart = $("#department").val();
		  var department = Number.parseInt(depart);
		  var rank = $("#rank").val();
		  console.log(department);
         
         if(fnPw() && fnPw2() && fnTel() && fnEmail() &&fnDepart()) {
            $.ajax({
 				  contentType:"application/json",           
                  type : 'POST',
                  dataType:"json",
                  data : 
                	  JSON.stringify ({
                	        id : id,
                	        password : password,
                	        email : email,
                	        phone : phone,
                	        department: department,
                	        rank:rank
                	    }),
                  
                  url : "/user/modify",
                  success : function(data) {
                     if(data.data=="success"){
                   alert("개인정보 수정이 완료되었습니다. 다시 로그인 해주세요.");
                   location.href="/user/login";
                     }else{
                    	  alert("다시 시도해주세요");
                    	  return;
                     }
                    } 
	            });
	         }
	       });
   

</script>