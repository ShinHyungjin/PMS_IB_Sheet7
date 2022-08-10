<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="../includes/header.jsp" />
<div id="wrapper">
	<nav class="navbar-default navbar-static-side" role="navigation">
		<div class="sidebar-collapse">
			<ul class="nav metismenu" id="side-menu">
				<li><a href="#"><i class="mnImg02"></i><span
						class="nav-label">내작업</span><span class="arrow01"></span></a>
					<ul class="nav nav-second-level">
						<li><a href="${pageContext.request.contextPath}/job/list">전체</a></li>
						<li><a href="${pageContext.request.contextPath}/job/before">진행전
								<c:out value="${beforelastCnt}" />
						</a></li>
						<li><a href="${pageContext.request.contextPath}/job/ing">진행중
								<c:out value="${inglastCnt}" />
						</a></li>
						<li><a href="${pageContext.request.contextPath}/job/stop">중단</a></li>
						<li><a href="${pageContext.request.contextPath}/job/end">완료</a></li>
					</ul></li>
				<li><a href="#"><i class="mnImg01"></i> <span
						class="nav-label">보고서</span><span class="arrow01"></span></a>
					<ul class="nav nav-second-level">
						<li class=""><a
							href="${pageContext.request.contextPath}/report/team">내부서</a></li>
						<li><a href=${pageContext.request.contextPath}/report/project>프로젝트별</a></li>
					</ul></li>
				<li class="active"><a
					href="${pageContext.request.contextPath}/project/list"><i
						class="mnImg04"></i> <span class="nav-label">프로젝트</span> <span
						class="arrow01"></span></a></li>
				<s:authorize access="!hasRole('ROLE_USER')">
					<li><a href="#"><i class="mnImg05"></i> <span
							class="nav-label">시스템관리</span> <span class="arrow01"></span></a>
						<ul class="nav nav-second-level">
							<s:authorize access="hasRole('ROLE_ADMIN')">
								<li><a
									href="${pageContext.request.contextPath}/admin/check">사용자
										관리</a></li>
							</s:authorize>
							<li><a
								href="${pageContext.request.contextPath}/project/project">프로젝트
									관리</a></li>
						</ul></li>
				</s:authorize>
			</ul>
		</div>
	</nav>
	<!-- #gnb e -->
	<div id="page-wrapper">
		<h2 class="tit-level1">프로젝트 목록</h2>
		<div class="subConView">
			<!-- 메인 화면  -->
			<div class="conWrap">
				<div class="sectionCon">
					<div class="board_top">
						<div class="col-md-1" style="padding-left: 0px;">
							<div class="selects">
								<select onchange="onBtnClick()" class="state" name="selectState"
									id="selectState">
									<option value="0">전체</option>
									<option value="111">진행전</option>
									<option value="112" selected="selected">진행중</option>
									<option value="113">완료</option>
									<option value="110">중단</option>
								</select>
							</div>
						</div>
						<!-- <div class="col-md-1" style="padding-left: 0px;">
							<input type="submit" value="검색" id="searching" class="btn btn-info" />
						</div> -->
						<!-- 버튼 -->
						<s:authorize access="!hasRole('ROLE_USER')">
							<div class="buttonGroup">
								<div class="BtnGroupR">
									<a href="${pageContext.request.contextPath}/project/register"
										class="btn btn-primary" style="margin-bottom: 10px;">프로젝트
										생성</a>
								</div>
							</div>
						</s:authorize>
					</div>
					<!-- 버튼 끝 -->
					<div class="ib_product" style="height: 750px;">
						<script type="text/javascript">
								createIBSheet("mySheet", "100%", "100%");
							</script>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<input type="hidden" value="${state}" id="temp_state">
<script language="javascript">
	$(document).ready(function(){
		 var userid='<s:authentication property="principal.username"/>';
	     //alert("로그인: "+userid);
	 });
		
		/*Sheet 기본 설정 */
		function LoadPage() {
				mySheet.SetTheme('BLM', 'ModernBlue');
				//아이비시트 초기화
				var initSheet = {};
				mySheet.SetEditable(false);

				initSheet.Cfg = {
					SearchMode : smLazyLoad,
					DeferredVScroll : 1,
		            SizeMode : 1
				};

				initSheet.Cols = [{
					Header : "NO",
					Type : "Int",
					Width : 10,
					SaveName : "ID",
					Align : "Center",
					Hidden : 1
				}, {
					Header : "프로젝트명",
					Type : "Text",
					SaveName : "PROJECT_TITLE",
					MinWidth : 70,
					Align : "Center"
				}, {
					Header : "별칭",
					Type : "Text",
					MinWidth : 30,
					SaveName : "PROJECT_NICKNAME",
					Align : "Center"
				}, {
					Header : "내용",
					Type : "Text",
					MinWidth : 100,
					SaveName : "CONTEXT",
					Wrap : 1,
		            MultiLineText : 1
				}, {
					Header : "주관부서",
					Type : "Text",
					Width : 30,
					SaveName : "TEAM",
					Align : "Center"
				}, {
					Header : "담당자",
					Type : "Text",
					Width : 20,
					SaveName : "NAME",
					Align : "Center"
				}, {
					Header : "계약금액",
					Type : "Int",
					Format : "#,##0",
					Width : 25,
					SaveName : "PAYMENT",
					Align : "Center"
				}, {
					Header : "시작일",
					Type : "Date",
					Width : 30,
					SaveName : "START_DATE",
					Align : "Center"
				}, {
					Header : "종료일",
					Type : "Date",
					Width : 30,
					SaveName : "END_DATE",
					Align : "Center"
				}, {
					Header : "단계",
					Type : "Text",
					Width : 18,
					SaveName : "STATE",
					Align : "Center"
				}  ];
				
				IBS_InitSheet(mySheet, initSheet);
				mySheet.SetDataLinkMouse("PROJECT_TITLE", 1);
				<s:authorize access="!hasRole('ROLE_USER')">
				mySheet.SetDataLinkMouse("CONTEXT", 1);
				</s:authorize> 
				mySheet.DoSearch("/project/sheet/list");
			}
		
			function onBtnClick() {
				var state = $('#selectState').val();
				var param = 'state=' + state
			
		        mySheet.DoSearch("/project/sheet/list?" + param);
		    }

			function mySheet_OnSearchEnd(cd, msg) {

				 for (var i = 0; i <= mySheet.LastRow(); i++) {
					for (var j = 0; j <= mySheet.LastCol(); j++) {
						var value = mySheet.GetCellValue(i, j);
						if (value == "110") {
							mySheet.SetCellValue(i,j,"중단");
						} else if (value == "111") {
							mySheet.SetCellValue(i,j,"진행전");
						} else if (value == "112") {
							mySheet.SetCellValue(i,j,"진행중");
						} else if (value == "113") {
							mySheet.SetCellValue(i,j,"완료");
						} else if (value == "120") {
							mySheet.SetCellValue(i,j,"미정");
						} else if (value == "121") {
							mySheet.SetCellValue(i,j,"컨설팅 사업팀");
						} else if (value == "122") {
							mySheet.SetCellValue(i,j,"스마트CNS팀");
						} else if (value == "123") {
							mySheet.SetCellValue(i,j,"항공정보팀");
						} else if (value == "124") {
							mySheet.SetCellValue(i,j,"항공기술사업팀");
						} else if (value == "125") {
							mySheet.SetCellValue(i,j,"SI영업팀");
						} else if (value == "126") {
							mySheet.SetCellValue(i,j,"솔루션영업팀");
						} else if (value == "127") {
							mySheet.SetCellValue(i,j,"영업지원팀");
						} else if (value == "128") {
							mySheet.SetCellValue(i,j,"SW개발사업팀");
						} else if (value == "129") {
							mySheet.SetCellValue(i,j,"솔루션사업팀");
						} else if (value == "130") {
							mySheet.SetCellValue(i,j,"연구개발1팀");
						} else if (value == "131") {
							mySheet.SetCellValue(i,j,"연구개발2팀");
						} else if (value == "132") {
							mySheet.SetCellValue(i,j,"경영관리본부");
						} else if (value == "133") {
							mySheet.SetCellValue(i,j,"기타");
						} 
					}
				}
			}

			function mySheet_OnClick(Row, Col, Value, CellX, CellY, CellW, CellH) {
				
				if (mySheet.ColSaveName(Col) == "PROJECT_TITLE") {
					var project_id = mySheet.GetCellValue(Row,"ID");
					location.href = `${pageContext.request.contextPath}/project/main?id=`+project_id;
				}
				<s:authorize access="!hasRole('ROLE_USER')">
				else if (mySheet.ColSaveName(Col) == "CONTEXT") {
					var project_id = mySheet.GetCellValue(Row,"ID");
					location.href = `${pageContext.request.contextPath}/project/modify?id=`+project_id;
				}
				</s:authorize> 
			}

			window.addEventListener("onload", LoadPage());
			
			
</script>
<jsp:include page="../includes/footer.jsp" />