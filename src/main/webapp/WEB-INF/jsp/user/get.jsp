<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>

<jsp:include page="../user/aside.jsp" />
	
		<h2 class="tit-level1">개인정보</h2>
		<div class="subConView">
			<div class="conWrap">
				<div class="sectionCon">
					<h2 class="tit-level2">기본정보</h2>
					<div class="writeType02">										
						<div class="row form-horizontal">
							<div class="col-sm-12">
								<div class="viewTable">
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">아이디</span></label>
										<div class="col-sm-10">
											<div class="input-group">
												<input id="userId" type="text" class="form-control" disabled="disabled" value="${myInfo.id}">
											</div>
										</div>										
									</div>
									<%-- <div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">비밀번호</span></label>
										<div class="col-sm-10">
											<input name="userPw" id="userPw" type="password" class="form-control" disabled="disabled">
										</div>
									</div> --%>
									<%-- <div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">비밀번호 확인</span></label>
										<div class="col-sm-10">
											<input id="userPw2" type="password" class="form-control">
										</div>
									</div> --%>
								</div>									
							</div>
						</div>
					</div>
				</div>
				<div class="sectionCon">
					<h2 class="tit-level2">개인정보</h2>
					<div class="writeType02">										
						<div class="row form-horizontal">
							<div class="col-sm-12">
								<div class="viewTable">
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">이름</span></label>
										<div class="col-sm-10">
											<input id="name" type="text" class="form-control" disabled="disabled" value="${myInfo.name}">
										</div>
									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">이메일</span></label>
										<div class="col-sm-10">
											<input id="email" type="text" class="form-control" disabled="disabled" value="${myInfo.email}">
										</div>
									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">휴대전화 번호</span></label>
										<div class="col-sm-10">
											<input id="tel" type="text" class="form-control" disabled="disabled" value="${myInfo.phone}">
										</div>
									</div>	
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">부서</span></label>
										<div class="col-sm-10">
											<div class="selects">
												<select class="form-control" name="" disabled="disabled">
												<c:choose>
													<c:when test="${myInfo.department==121}">
													<option value="121" selected>컨설팅사업팀</option>
													</c:when>
													<c:when test="${myInfo.department==122}">
													<option value="122" selected>스마트CNS팀</option>
													</c:when>
													<c:when test="${myInfo.department==123}">
													<option value="123" v>항공정보팀</option>
													</c:when>
													<c:when test="${myInfo.department==124}">
													<option value="124" v>항공기술사업팀</option>
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
													<option value="131">연구개발2팀</option>
													</c:when>
													<c:when test="${myInfo.department==132}">
													<option value="132">경영관리팀</option>
													</c:when>
													<c:otherwise>
													<option value="120">미정</option>
													</c:otherwise>
													</c:choose>
												</select>
											</div>
										</div>
									</div>	
									<div class="hr-line-dashed"></div>
							<div class="form-group">
								<label class="col-sm-2 control-label labelTitle"><span class="">직급</span></label>
								<div class="col-sm-10">
									<div class="selects">
										<select class="form-control" name="rank" id="rank" disabled="disabled">
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
						<!-- <button class="btn btn-primary" type="submit" id="modify">수정</button> -->
						<a href="${pageContext.request.contextPath}/user/modify?id=${myInfo.id}" class="btn btn-primary">수정</a>
					</div>
				</div>
			</div>
		</div>


<jsp:include page="../includes/footer.jsp" />

<script>







 
</script>