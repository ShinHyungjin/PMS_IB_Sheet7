<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<jsp:include page="./aside.jsp" />

<div class="subConView">
	<div class="conWrap">
		<div class="sectionCon">
			<div class="tabs-container">
                     <ul class="nav nav-tabs">
                     <c:if test="${authWbs != 0 || auth!='ROLE_USER'}">
                           <li class="<c:if test="${menuId == 1}">active</c:if>">
                             <a href="${pageContext.request.contextPath}/project/wbs?id=${project_Id}">WBS</a>
                          </li>
                        </c:if>
                        <c:if test="${authUser != 0 || auth!='ROLE_USER'}">
                           <li class="<c:if test="${menuId == 2}">active</c:if>">
                               <a href="${pageContext.request.contextPath}/project/user?id=${project_Id}">참여인력</a>
                            </li>
                        </c:if>
                        <c:if test="${authInfo != 0 || auth!='ROLE_USER'}">
                            <li class="<c:if test="${menuId == 3}">active</c:if>">
                               <a href="${pageContext.request.contextPath}/project/info?id=${project_Id}">프로젝트 정보</a>
                            </li>
                        </c:if>
                        <c:if test="${authAuthority != 0 || auth!='ROLE_USER'}">
                           <li class="<c:if test="${menuId == 4}">active</c:if>">
                              <a href="${pageContext.request.contextPath}/project/authority?id=${project_Id}">권한</a>
                           </li>
                         </c:if>
                     </ul>
              	 </div>
			<!-- 메인 화면  -->
			<div class="membershipWrap">
				<div class="membershipTop">
					<div class="row" style="margin: 0px; padding-bottom: 10px;">
						<div class="col-md-1"  style="padding-left: 0px;">
							<select class="form-control" name="selectDepartment" id="selectDepartment">
								<option value="" <c:if test="${department eq null}">selected="selected"</c:if>>전체 부서</option>
								<option value="120" <c:if test="${department eq '120'}">selected="selected"</c:if>>미정</option>
								<option value="121" <c:if test="${department eq '121'}">selected="selected"</c:if>>컨설팅사업</option>
								<option value="122" <c:if test="${department eq '122'}">selected="selected"</c:if>>스마트CNS</option>
								<option value="123" <c:if test="${department eq '123'}">selected="selected"</c:if>>항공정보</option>
								<option value="124" <c:if test="${department eq '124'}">selected="selected"</c:if>>항공기술사업</option>
								<option value="125" <c:if test="${department eq '125'}">selected="selected"</c:if>>SI영업</option>
								<option value="126" <c:if test="${department eq '126'}">selected="selected"</c:if>>솔루션영업</option>
								<option value="127" <c:if test="${department eq '127'}">selected="selected"</c:if>>영업지원</option>
								<option value="128" <c:if test="${department eq '128'}">selected="selected"</c:if>>SW개발사업</option>
								<option value="129" <c:if test="${department eq '129'}">selected="selected"</c:if>>솔루션사업</option>
								<option value="130" <c:if test="${department eq '130'}">selected="selected"</c:if>>연구개발1</option>
								<option value="131" <c:if test="${department eq '131'}">selected="selected"</c:if>>연구개발2</option>
								<option value="132" <c:if test="${department eq '132'}">selected="selected"</c:if>>경영관리</option>
								<option value="133" <c:if test="${department eq '133'}">selected="selected"</c:if>>기타</option>
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
						<input type="button" onclick="permitionSaveSubmit()" class="btn btn-primary" value="추가"/>
					</div>
				</div>
				<div class="membershipListWrap">
					<form id="checkForm" name="checkForm" method="post">
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
														<input type="text" name="username" id="username" class="form-control" disabled="disabled" 
														value="<c:out value="${userVO.name}"/>"> 
													</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>아이디</dt>
													<dd>
														<input type="text" name="id" id="id" class="form-control" disabled="disabled" 
														value="<c:out value="${userVO.id}"/>"> 
													</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>직급</dt>
													<dd>
														<div class="selects">
															<select class="form-control" name="rank" id="rank" disabled="disabled">
																<option value="" <c:if test="${userVO.rank eq '' || empty userVO.rank}">selected="selected"</c:if>>미정</option>
																<option value="대표" <c:if test="${userVO.rank eq '대표'}">selected="selected"</c:if>>대표</option>
																<option value="부사장" <c:if test="${userVO.rank eq '부사장'}">selected="selected"</c:if>>부사장</option>
																<option value="상무" <c:if test="${userVO.rank eq '상무'}">selected="selected"</c:if>>상무</option>
																<option value="이사" <c:if test="${userVO.rank eq '이사'}">selected="selected"</c:if>>이사</option>
																<option value="부장"<c:if test="${userVO.rank eq '부장'}">selected="selected"</c:if>>부장</option>
																<option value="차장"<c:if test="${userVO.rank eq '차장'}">selected="selected"</c:if>>차장</option>
																<option value="과장"<c:if test="${userVO.rank eq '과장'}">selected="selected"</c:if>>과장</option>
																<option value="대리"<c:if test="${userVO.rank eq '대리'}">selected="selected"</c:if>>대리</option>
																<option value="사원"<c:if test="${userVO.rank eq '사원'}">selected="selected"</c:if>>사원</option>
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
																<option value="0">--미정--</option>
																<option value="120" <c:if test="${userVO.department eq 120}">selected="selected"</c:if>>미정</option>
																<option value="0">--전략사업본부--</option>
																<option value="121"<c:if test="${userVO.department eq 121}">selected="selected"</c:if>>컨설팅사업</option>
																<option value="122"<c:if test="${userVO.department eq 122}">selected="selected"</c:if>>스마트CNS</option>
																<option value="123"<c:if test="${userVO.department eq 123}">selected="selected"</c:if>>항공정보</option>
																<option value="124"<c:if test="${userVO.department eq 124}">selected="selected"</c:if>>항공기술사업</option>
																<option value="0">--영업본부--</option>
																<option value="125"<c:if test="${userVO.department eq 125}">selected="selected"</c:if>>SI영업</option>
																<option value="126"<c:if test="${userVO.department eq 126}">selected="selected"</c:if>>솔루션영업</option>
																<option value="127"<c:if test="${userVO.department eq 127}">selected="selected"</c:if>>영업지원</option>
																<option value="0">--IT사업본부--</option>
																<option value="128"<c:if test="${userVO.department eq 128}">selected="selected"</c:if>>SW개발사업</option>
																<option value="129"<c:if test="${userVO.department eq 129}">selected="selected"</c:if>>솔루션사업</option>
																<option value="0">--기술연구소--</option>
																<option value="130"<c:if test="${userVO.department eq 130}">selected="selected"</c:if>>연구개발1</option>
																<option value="131"<c:if test="${userVO.department eq 131}">selected="selected"</c:if>>연구개발2</option>
																<option value="0">--경영관리본부--</option>
																<option value="132"<c:if test="${userVO.department eq 132}">selected="selected"</c:if>>경영관리</option>
																<option value="0">--기타--</option>
																<option value="133"<c:if test="${userVO.department eq 133}">selected="selected"</c:if>>기타</option>
															</select>
														</div>
													</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>이메일</dt>
													<dd>
														<input type="text" name="email" id="email" class="form-control" disabled="disabled" value="<c:out value="${userVO.email}"/>"> 
														<input type="hidden" name="id" id="id" class="form-control" value="<c:out value="${userVO.id}"/>">
													</dd>
												</dl>
											</li>
										</ul>
									</div>
								</div>
							</div>
						 </form>
					</c:forEach>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	/* 전체 승인 */
	$(".chkAll").click(function() {
		if ($(".chkAll").prop("checked")) { //만약 전체 동의하기 체크박스가 체크된상태일경우 
			$("input[type=checkbox]").prop("checked", true); //해당화면의 모든 checkbox들을 체크해준다. 
			
		} else { // 전체 동의하기 체크박스가 해제된 경우 
			$("input[type=checkbox]").prop("checked", false); //해당화면의 모든 checkbox들의 체크를 해제시킨다.
		}
	});

	$(document).ready(function() {
			
		
		
			var userid = '<s:authentication property="principal.username"/>';
			//alert("로그인: "+userid);
			var myjob;

			var departmentSearchUrl = "";
            var userSearchUrl="/project/useradd";
            var project_Id=<c:out value='${project_Id}'/>;
            //alert("프로젝트 아이디: "+project_Id);
            
	/* 		$("#departmentsearch").on("click",function(e) {
				e.preventDefault();
	            var project_Id=<c:out value='${project_Id}'/>;
                //alert(project_Id);
				var departmentForm = ("#departmentForm");
                var userSearchUrl = "/project/useradd";
                var selectDepartment = document.getElementById('selectDepartment');
                var department = selectDepartment.options[selectDepartment.selectedIndex].value;
                //alert(department);
                var username = document.getElementById('userNameText').value;
                if (username === undefined || username === "" ) {
                    location.href = userSearchUrl+"?id="+project_Id+"&department="+department;
                }else {
                        location.href = userSearchUrl + "?username=" + username+"&?id="+project_Id+"&?department="+department;
                    }
				});

				var userSearchUrl = "";
				$("#usersearch").on("click",function(e) {
                    var project_Id=document.getElementById('project_Id').value;
					e.preventDefault();
					var userForm = ("#usernameForm");
					$(userForm).attr("action","/project/usernamesearch2");
					$(userForm).attr("method", "post");
					var username = document.getElementById('userNameText').value;
					if (username == "") {
						userSearchUrl = userSearchUrl;
					} else {
						userSearchUrl = userSearchUrl + "?username=" + username;
					}
					$(userForm).submit();
				}); */
				
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
					        	 resultUrl = "?department="+seletDepartment+"&name="+userName+"&id="+<c:out value='${project_Id}'/>;
					         }else if(seletDepartment!="" && seletDepartment!=undefined && userName==undefined || userName==""){
					        	 //alert("부서 검색");
					        	 resultUrl = "?department="+seletDepartment+"&id="+<c:out value='${project_Id}'/>;
					         }else if(seletDepartment=="" || seletDepartment==undefined && userName!=undefined && userName!=""){
					        	 //alert("유저 검색");
					        	 resultUrl = "?name="+userName+"&id="+<c:out value='${project_Id}'/>;
					         }else if(seletDepartment=="" && userName==undefined || userName==""){
					        	 //alert("전체 검색");
					        	 resultUrl = "?id="+<c:out value='${project_Id}'/>;
					         }
					         location.href=resultUrl;
					     });
				
			});

	function permitionSaveSubmit() {
		var userIdList = new Array();
		var obj = {};
		<c:forEach items="${userVOList}" var="item">
			var userCheckBox = $('#check'+'${item.id}').prop("checked");
			if(userCheckBox == true) {
				userIdList.push("${item.id}");
			}
		</c:forEach>
		  
		//alert(userIdList);
		obj = {
				"userIdList" : userIdList,
				"project_Id" : <c:out value='${project_Id}'/>
		};
		
		for(var i=0; i<userIdList.length; i++) {
			console.log(userIdList[i]);
		}
		
		if(userIdList.length == 0) {
			alert("추가 할 사용자가 지정되지 않았습니다!");			
		} else {
			$.ajax({
				url : "/project/permitionSave",
				type : "post",
				data : obj,
				success : function(data) {
					alert("참여인력 추가가 완료되었습니다.");
					location.href="/project/user?id="+ <c:out value='${project_Id}'/>;
				},
				error : function(xhr, status) {
					alert("추가 실패 : " + xhr + "  그리고 " + status);
				}
			});
		}
		
	}
	
</script>
<jsp:include page="../includes/footer.jsp" />
