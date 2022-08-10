<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="./aside.jsp" />
		
	<h2 class="tit-level1">개인정보 수정</h2>
	<div class="subConView">
		<div class="conWrap">
			<form id="join_form" class="form-horizontal" method="post" action="${pageContext.request.contextPath}/user/get">
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
												<input id="userId" type="text" class="form-control">
											</div>
										</div>										
									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">비밀번호</span></label>
										<div class="col-sm-10">
											<input name="userPw" id="userPw" type="password" class="form-control">
										</div>
									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">비밀번호 확인</span></label>
										<div class="col-sm-10">
											<input id="userPw2" type="password" class="form-control">
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
											<input id="name" type="text" class="form-control" >
										</div>
									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">이메일</span></label>
										<div class="col-sm-10">
											<input id="email" type="text" class="form-control">
										</div>
									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">휴대전화 번호</span></label>
										<div class="col-sm-10">
											<input id="tel" type="text" class="form-control">
										</div>
									</div>	
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label labelTitle"><span class="">부서</span></label>
										<div class="col-sm-10">
											<div class="selects">
												<select class="form-control" name="">
													<option value="" selected="">선택해 주세요</option>
													<option value="">--전략사업본부--</option>
													<option value="1">컨설팅사업팀</option>
													<option value="2">스마트CNS팀</option>
													<option value="3">항공정보팀</option>
													<option value="4">항공기술사업팀</option>
													<option value="">--영업본부--</option>
													<option value="5">SI영업팀</option>
													<option value="6">솔루션영업팀</option>
													<option value="7">영업지원팀</option>
													<option value="">--IT사업본부--</option>
													<option value="8">SW개발사업팀</option>
													<option value="9">솔루션사업팀</option>
													<option value="">--기술연구소--</option>
													<option value="10">연구개발1팀</option>
													<option value="11">연구개발2팀</option>
													<option value="">--경영관리본부--</option>
													<option value="12">경영관리팀</option>
													<option value="">--기타--</option>
													<option value="13">기타</option>
												</select>
											</div>
										</div>
									</div>	
								</div>
							</div>
						</div>
					</div>
					<div class="btnArea text-right">
						<button type="button" class="btn btn-primary" id="save" title="저장">저장</button>
					</div>
				</div>
				</form>
			</div>
		</div>

<jsp:include page="../includes/footer.jsp" />

