<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>

<jsp:include page="../project/aside.jsp" />
<fmt:formatNumber value="${project.payment}" var="payment"/>
<div class="subConView">
  	 <div class="conWrap">
      	<div class="sectionCon">
         	<div class="tabs-container">
	            <ul class="nav nav-tabs">
		          	<c:if test="${authWbs != 0 || auth!='ROLE_USER'}">
				   		<li class="<c:if test="${menuId == 1}">active</c:if>">
				     		<a href="${pageContext.request.contextPath}/project/wbs?id=${project_id}">WBS</a>
				     	</li>
		            </c:if>
		            <c:if test="${authUser != 0 || auth!='ROLE_USER'}">
		            	<li class="<c:if test="${menuId == 2}">active</c:if>">
		             		<a href="${pageContext.request.contextPath}/project/user?id=${project_id}">참여인력</a>
		             	</li>
		            </c:if>
		            <c:if test="${authInfo != 0 || auth!='ROLE_USER'}">
		             	<li class="<c:if test="${menuId == 3}">active</c:if>">
		             		<a href="${pageContext.request.contextPath}/project/info?id=${project_id}">프로젝트 정보</a>
		             	</li>
		            </c:if>
		            <c:if test="${authAuthority != 0 || auth!='ROLE_USER'}">
		            	<li class="<c:if test="${menuId == 4}">active</c:if>">
		            		<a href="${pageContext.request.contextPath}/project/authority?id=${project_id}">권한</a>
	            		</li>
		          	</c:if>
	            </ul>
	         </div>

					<!-- 메인 화면  -->
					<div class="col-md-6">
						<div class="form-group">
							 <span class="star01">프로젝트명</span>
							<div class="formInput">
								<input id="projectname" type="text" class="form-control" value="${project.project_title}" readonly="readonly">
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="form-group">
							  <span class="star01">프로젝트 별칭</span>
							<div class="formInput">
							  <input id="title" type="text" class="form-control" value="${project.project_nickname}" readonly="readonly">
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="form-group">
							<span class="star01">기간</span>
							<div class="formInput">
								<div id="dateStart" class="dateStart">
									<div class="input-group input-daterange date">
									    <input id="start_date" type="text" class="form-control" value="${project.start_date==null?'0':project.start_date}" readonly="readonly">
										<div class="input-group-addon">~</div>
									    <input id="end_date" type="text" class="form-control" value="${project.end_date==null?'0':project.end_date}" readonly="readonly">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="form-group">
							<span class="">담당자</span>
							<div class="formInput">
							   <input id="title" type="text" class="form-control" value="${project.name} ${project.rank}" readonly="readonly">
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="form-group">
							<span class="">주관부서</span>
							<div class="formInput">
							   <select id="team" class="form-control" disabled="disabled">
						   			<c:choose>
                                       <c:when test="${project.team==121}">
                                       <option value="121" selected>컨설팅사업팀</option>
                                       </c:when>
                                       <c:when test="${project.team==122}">
                                       <option value="122" selected>스마트CNS팀</option>
                                       </c:when>
                                       <c:when test="${project.team==123}">
                                       <option value="123" selected>항공정보팀</option>
                                       </c:when>
                                       <c:when test="${project.team==124}">
                                       <option value="124" selected>항공기술사업팀</option>
                                       </c:when>
                                       <c:when test="${project.team==125}">
                                          <option value="125" selected>SI영업팀</option>
                                       </c:when>
                                       <c:when test="${project.team==126}">
                                       <option value="126" selected>솔루션영업팀</option>
                                       </c:when>
                                       <c:when test="${project.team==127}">
                                       <option value="127" selected>영업지원팀</option>
                                       </c:when>
                                       <c:when test="${project.team==128}">
                                       <option value="128" selected>SW개발사업팀</option>
                                       </c:when>
                                       <c:when test="${project.team==129}">
                                       <option value="129" selected>솔루션사업팀</option>
                                       </c:when>
                                       <c:when test="${project.team==130}">
                                       <option value="130" selected>연구개발1팀</option>
                                       </c:when>
                                       <c:when test="${project.team==131}">
                                       <option value="131" selected>연구개발2팀</option>
                                       </c:when>
                                       <c:when test="${project.team==132}">
                                       <option value="132" selected>경영관리팀</option>
                                       </c:when>
                                       <c:when test="${project.team==133}">
                                       <option value="133" selected>기타</option>
                                       </c:when>
                                       <c:otherwise>
                                       <option value="120" selected>미정</option>
                                       </c:otherwise>
                                       </c:choose>
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
							<div class="formInput">
							  <input id="payment" type="text" class="form-control" value="${payment}" readonly="readonly">
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="form-group">
							<span class="star01">단계</span>
							<div class="formInput">
							<c:choose>
                                <c:when test="${project.state==110}">
                                <input type="text" class="form-control"  value="중단" readonly="readonly">
                                </c:when>
                                <c:when test="${project.state==111}">
                                <input type="text" class="form-control"  value="진행전" readonly="readonly">
                                </c:when>
                                <c:when test="${project.state==112}">
                                <input type="text" class="form-control"  value="진행중" readonly="readonly">
                                </c:when>
                                <c:when test="${project.state==113}">
                                <input type="text" class="form-control"  value="완료" readonly="readonly">
                                </c:when>
                            </c:choose>
							</div>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group form-group-block">
							<span class="">프로젝트 내용</span>
							<div class="formInput">
							  <textarea class="form-control" rows="15" value="${project.context}" readonly="readonly">${project.context}</textarea>
							</div>
						</div>
					</div>
					<c:if test="${authInfo == '2' || auth!='ROLE_USER'}"> 
						<div class="col-md-12 text-right">
							<a href="${pageContext.request.contextPath}/project/modify?id=${project.p_id}"><button type="button" class="btn btn-primary mr-3">수정</button></a>
						</div>
					</c:if>
				</div>
			</div>
			<!-- .main-section e -->
		</div>
	<!-- .container-inner e -->

<jsp:include page="../includes/footer.jsp" />
