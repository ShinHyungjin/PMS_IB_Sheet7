<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s" %> 
<jsp:include page="./aside.jsp" />

			<div class="subConView">
				<div class="conWrap">
					<div class="sectionCon">
					<!-- 메인 화면  -->
						<div class="tabs-container">
							<ul class="nav nav-tabs">
							   <li><a href="${pageContext.request.contextPath}/admin/check">승인 대기</a></li>
							   <li class="active"><a href="${pageContext.request.contextPath}/admin/user">회원 목록</a></li>
							   <li><a href="${pageContext.request.contextPath}/admin/del">탈퇴 회원</a></li>
							</ul>
				        </div>
				        <div class="membershipWrap">
							<div class="membershipTop">
								<div class="row" style="margin: 0px; padding-bottom: 10px;">
									<div class="col-md-1" style="padding-left: 0px;">
										<select class="form-control" name="selectDepartment" id="selectDepartment">
											<option value="" <c:if test="${department eq null}">selected="selected"</c:if>>전체 부서</option>
											<option value="120" id="120" <c:if test="${department eq '120'}">selected="selected"</c:if>>미정</option>
											<option value="121" id="121" <c:if test="${department eq '121'}">selected="selected"</c:if>>컨설팅사업</option>
											<option value="122" id="122" <c:if test="${department eq '122'}">selected="selected"</c:if>>스마트CNS</option>
											<option value="123" id="123" <c:if test="${department eq '123'}">selected="selected"</c:if>>항공정보</option>
											<option value="124" id="124" <c:if test="${department eq '124'}">selected="selected"</c:if>>항공기술사업</option>
											<option value="125" id="125" <c:if test="${department eq '125'}">selected="selected"</c:if>>SI영업</option>
											<option value="126" id="126" <c:if test="${department eq '126'}">selected="selected"</c:if>>솔루션영업</option>
											<option value="127" id="127" <c:if test="${department eq '127'}">selected="selected"</c:if>>영업지원</option>
											<option value="128" id="128" <c:if test="${department eq '128'}">selected="selected"</c:if>>SW개발사업</option>
											<option value="129" id="129" <c:if test="${department eq '129'}">selected="selected"</c:if>>솔루션사업</option>
											<option value="130" id="130" <c:if test="${department eq '130'}">selected="selected"</c:if>>연구개발1</option>
											<option value="131" id="131" <c:if test="${department eq '131'}">selected="selected"</c:if>>연구개발2</option>
											<option value="132" id="132" <c:if test="${department eq '132'}">selected="selected"</c:if>>경영관리</option>
											<option value="133" id="133" <c:if test="${department eq '133'}">selected="selected"</c:if>>기타</option>
										</select>
									</div>
									<div class="formInput col-md-2" style="padding-left: 0px;">
										<div class="input-group">
											<input type="text" name="userNameText" class="form-control" id="userNameText" placeholder="회원명을 입력해주세요."
											<c:if test="${!empty userNameText}">value="<c:out value="${userNameText}"></c:out>"</c:if>/>
											<span class="input-group-btn">
												<button type="submit" value="검색" id="searching" class="btn btn-info" >검색</button>
											</span>
										</div>
									</div>
								</div>
								<div class="allSelectArea">
									<div class="checkbox-out">
										<input type="checkbox" id="check4" class="chkAll" />
										<label for="check4" class="checkbox">전체선택</label>
									</div>
									<input type="button" onclick="resetSubmit()" class="btn btn-primary" value="비밀번호 초기화" title="초기화 비밀번호  : 1q2w3e4r!!"/>
									<input type="button" onclick="permitionDelectSubmit()" class="btn btn-primary" value="탈퇴" style="margin-left: 10px;"/>
								</div>
							</div>
							<div class="membershipListWrap">
								<c:forEach var="userVO" items="${userVOList}">
									<form id="<c:out value="${userVO.id}"/>" name="<c:out value="${userVO.id}"/>" method="post">
										<div class="membershipList">
											<div class="membershipInfo">
												<div class="membershipDetail">
													<div class="checkbox-out">
														<input type="checkbox" id="check<c:out value="${userVO.id}"/>"/>
				                                        <label for="check<c:out value="${userVO.id}"/>" class="checkbox"></label>
													</div>
													<ul>
														<li>
															<dl>
																<dt>이름</dt>
																<dd>
																	<input type="text" name="username" id="username" class="form-control" disabled="disabled" value="<c:out value="${userVO.name}"/>">
																	<input type="hidden" name="id" id="id" class="form-control" value="<c:out value="${userVO.id}"/>">
																</dd>
															</dl>
														</li>
														<li>
															<dl>
																<dt>아이디</dt>
																<dd>
																	<input type="text" name="id" id="id" class="form-control" disabled="disabled" 
																	value="<c:out value="${userVO.id}"/>"> 
																	<input type="hidden" name="id" id="id" class="form-control" value="<c:out value="${userVO.id}"/>">
																</dd>
															</dl>
														</li>
														<li>
															<dl>
																<dt>권한</dt>
																<dd>
																	<div class="selects" >
																		<select class="form-control" name="authority" id="authority" disabled="disabled">
																			<c:forEach var="authList" items="${userVO.authList}">
																					<option value="ROLE_USER"<c:if test="${authList.authority eq 'ROLE_USER'}">selected="selected"</c:if>>회원</option>
																					<option value="ROLE_MANAGER"<c:if test="${authList.authority eq 'ROLE_MANAGER'}">selected="selected"</c:if>>중간관리자</option>
																					<option value="ROLE_ADMIN"<c:if test="${authList.authority eq 'ROLE_ADMIN'}">selected="selected"</c:if>>관리자</option>
																					<%-- <option value="ROLE_MAMBER"<c:if test="${authList.authority eq 'ROLE_MAMBER'}">selected="selected"</c:if>>승인대기</option> --%>
																			</c:forEach>
																		</select>
																	</div>
																</dd>
															</dl>
														</li>
														<li>
															<dl>
																<dt>직급</dt>
																<dd>
																	<div class="selects">
																		<select class="form-control" name="rank" id="rank" disabled="disabled">
																			<option value="사원"<c:if test="${userVO.rank eq '사원'}">selected="selected"</c:if>>사원</option>
																			<option value="대리"<c:if test="${userVO.rank eq '대리'}">selected="selected"</c:if>>대리</option>
																			<option value="과장"<c:if test="${userVO.rank eq '과장'}">selected="selected"</c:if>>과장</option>
																			<option value="차장"<c:if test="${userVO.rank eq '차장'}">selected="selected"</c:if>>차장</option>
																			<option value="부장"<c:if test="${userVO.rank eq '부장'}">selected="selected"</c:if>>부장</option>
																			<option value="이사" <c:if test="${userVO.rank eq '이사'}">selected="selected"</c:if>>이사</option>
																			<option value="상무" <c:if test="${userVO.rank eq '상무'}">selected="selected"</c:if>>상무</option>
																			<option value="부사장" <c:if test="${userVO.rank eq '부사장'}">selected="selected"</c:if>>부사장</option>
																			<option value="대표" <c:if test="${userVO.rank eq '대표'}">selected="selected"</c:if>>대표</option>
																			<option value="관리자" <c:if test="${userVO.rank eq '관리자'}">selected="selected"</c:if>>관리자</option>
																		</select>
																	</div>
																</dd>
															</dl>
														</li>
														<li>
															<dl>
																<dt>부서</dt>
																<dd>
																	<div class="selects">
																		<select class="form-control" name="department" id="department" disabled="disabled">
																			<option value="120"<c:if test="${userVO.department eq 120}">selected="selected"</c:if>>미정</option>
																			<option value="121"<c:if test="${userVO.department eq 121}">selected="selected"</c:if>>컨설팅사업</option>
																			<option value="122"<c:if test="${userVO.department eq 122}">selected="selected"</c:if>>스마트CNS</option>
																			<option value="123"<c:if test="${userVO.department eq 123}">selected="selected"</c:if>>항공정보</option>
																			<option value="124"<c:if test="${userVO.department eq 124}">selected="selected"</c:if>>항공기술사업</option>
																			<option value="125"<c:if test="${userVO.department eq 125}">selected="selected"</c:if>>SI영업</option>
																			<option value="126"<c:if test="${userVO.department eq 126}">selected="selected"</c:if>>솔루션영업</option>
																			<option value="127"<c:if test="${userVO.department eq 127}">selected="selected"</c:if>>영업지원</option>
																			<option value="128"<c:if test="${userVO.department eq 128}">selected="selected"</c:if>>SW개발사업</option>
																			<option value="129"<c:if test="${userVO.department eq 129}">selected="selected"</c:if>>솔루션사업</option>
																			<option value="130"<c:if test="${userVO.department eq 130}">selected="selected"</c:if>>연구개발1</option>
																			<option value="131"<c:if test="${userVO.department eq 131}">selected="selected"</c:if>>연구개발2</option>
																			<option value="132"<c:if test="${userVO.department eq 132}">selected="selected"</c:if>>경영관리</option>
																			<option value="133"<c:if test="${userVO.department eq 133}">selected="selected"</c:if>>기타</option>
																		</select>
																	</div>
																</dd>
															</dl>
														</li>
													</ul>
												</div>
												<div class="membershipBtnArea">
													<div class="membershipBtn">
														 <button type="button" onclick="onBtnClick('<c:out value="${userVO.id}"/>')" class="btn btn-light">회원정보 수정</button>
		      											 <input type="button" onclick="userInfoSubmit('<c:out value="${userVO.id}"/>')" class="btn btn-info" value="저장"/>
													</div>
												</div>
											</div>
										</div>
									</form>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		<!-- .main-section e -->
	<!-- sectioncon -->
<input type="hidden" value="${state}" id="temp_department">
<script>
	$(".chkAll").click(function() {
		if ($(".chkAll").prop("checked")) { //만약 전체 동의하기 체크박스가 체크된상태일경우 
			$("input[type=checkbox]").prop("checked", true); //해당화면의 모든 checkbox들을 체크해준다. 
		} else { // 전체 동의하기 체크박스가 해제된 경우 
			$("input[type=checkbox]").prop("checked", false); //해당화면의 모든 checkbox들의 체크를 해제시킨다.
		}
	});


	$(document).ready(function(){
	 var userid='<s:authentication property="principal.username"/>';
     //alert("로그인: "+userid);
     var myjob; 
 	 
     var goSearch = document.getElementById('searching');
     
     goSearch.addEventListener('click', function(e){
    	 e.preventDefault();
    	 var resultUrl="";
    	 var department = document.getElementById('selectDepartment');
    	 
    	 var seletDepartment = department.options[department.selectedIndex].value;
         var userName = document.getElementById('userNameText').value;
         //alert("선택된 부서: "+seletDepartment);
         //alert("선택된 이름: "+userName);
         
         if(seletDepartment!="" && userName!=undefined && userName!=""){
        	 //alert("부서+유저 검색");
        	 resultUrl = "?department="+seletDepartment+"&name="+userName;
         }else if(seletDepartment!="" && seletDepartment!=undefined && userName==undefined || userName==""){
        	 //alert("부서 검색");
        	 resultUrl = "?department="+seletDepartment;
         }else if(seletDepartment=="" || seletDepartment==undefined && userName!=undefined && userName!=""){
        	 //alert("유저 검색");
        	 resultUrl = "?name="+userName;
         }else if(seletDepartment=="" && userName==undefined || userName==""){
        	 //alert("전체 검색");
        	 resultUrl = resultUrl;
         }
         location.href=resultUrl;
         
    	 });
     
	 });
	
	function userInfoSubmit(userId){
		var check = $("#"+userId + " [name=authority]").is(":disabled");
		if(check) {
			alert("수정이 비활성화 되어있습니다.");
			return;
		}
		
		var id = $("#" + userId + " [name=id]").val();
		var authority = $("#" + userId + " [name=authority]").val();
		var rank = $("#" + userId + " [name=rank]").val();
		var department = $("#" + userId + " [name=department]").val();
		
		$.ajax({
			url : "/admin/userUpdate",
			type : "post",
			data :{
      	        id : id,
      	      	authority : authority,
      	      	rank : rank,
      	        department: department
      	    },
			success : function(data) {
				alert("수정이 완료되었습니다.");
				 $("#" + userId + " [name=authority]").attr("disabled", true);
			    $("#" + userId + " [name=rank]").attr("disabled", true);
			    $("#" + userId + " [name=department]").attr("disabled", true);
			},error : function(xhr, status) {
				alert("수정에 실패하였습니다 : " + xhr + "  그리고 " + status);
			}
		});
	}
	
	function onBtnClick(frmId) {    
	    $("#" + frmId + " [name=authority]").attr("disabled", false);
	    $("#" + frmId + " [name=rank]").attr("disabled", false);
	    $("#" + frmId + " [name=department]").attr("disabled", false);
	  }
	
	
	function permitionDelectSubmit() {
		var userIdList = new Array();
		var obj = {};
		<c:forEach items="${userVOList}" var="item">
			var userCheckBox = $('#check'+'${item.id}').prop("checked");
			if(userCheckBox == true) {
				userIdList.push("${item.id}");
			}
		</c:forEach>
		
		 if(confirm("정말 탈퇴 시키겠습니까 ?") == true){
             //alert("탈퇴 되었습니다.");
         }
         else{
             return ;
         }
		
		obj = {
				"userIdList" : userIdList
		};
		
		for(var i=0; i<userIdList.length; i++) {
			console.log(userIdList[i]);
		}
		
		if(userIdList.length == 0) {
			alert("탈퇴 할 사용자가 지정되지 않았습니다!");			
		} else {
			$.ajax({
				url : "/admin/permitionDelect",
				type : "post",
				data : obj,
				success : function(data) {
					alert("회원 탈퇴가 완료되었습니다.");
					location.href="/admin/del";
				},
				error : function(xhr, status) {
					alert("삭제 실패 : " + xhr + "  그리고 " + status);
				}
			});
		}
		
	}
	
	function resetSubmit() {
		var userIdList = new Array();
		var obj = {};
		<c:forEach items="${userVOList}" var="item">
			var userCheckBox = $('#check'+'${item.id}').prop("checked");
			if(userCheckBox == true) {
				userIdList.push("${item.id}");
			}
		</c:forEach>
		
		 if(confirm("비밀번호를 초기화 시키겠습니까 ?") == true){
             alert("초기화 되었습니다.");
         }
         else{
             return ;
         }
		
		obj = {
				"userIdList" : userIdList
		};
		
		for(var i=0; i<userIdList.length; i++) {
			console.log(userIdList[i]);
		}
		
		if(userIdList.length == 0) {
			alert("사용자가 지정되지 않았습니다!");			
		} else {
			$.ajax({
				url : "/admin/resetSubmit",
				type : "post",
				data : obj,
				success : function(data) {
					location.href="/admin/user";
				},
				error : function(xhr, status) {
					alert("초기화 실패 : " + xhr + "  그리고 " + status);
				}
			});
		}
	}

		
	</script>
<jsp:include page="../includes/footer.jsp" />		