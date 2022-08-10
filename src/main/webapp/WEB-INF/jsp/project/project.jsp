<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../includes/header.jsp" />
<div id="wrapper">
	<nav class="navbar-default navbar-static-side" role="navigation">
		<div class="sidebar-collapse">
			<ul class="nav metismenu" id="side-menu">
				<li><a href="#"><i class="mnImg02"></i><span class="nav-label">내작업</span><span class="arrow01"></span></a>
					<ul class="nav nav-second-level">
						<li><a href="${pageContext.request.contextPath}/job/list">전체</a></li>
						<li><a href="${pageContext.request.contextPath}/job/before">진행전</a></li>
						<li><a href="${pageContext.request.contextPath}/job/before">진행전  <c:out value="${beforelastCnt}"/></a></li>
						<li><a href="${pageContext.request.contextPath}/job/ing">진행중  <c:out value="${inglastCnt}"/></a></li>
						<li><a href="${pageContext.request.contextPath}/job/end">완료</a></li>
					</ul>
				</li>
				<li><a href="#"><i class="mnImg01"></i> <span class="nav-label">보고서</span><span class="arrow01"></span></a>
					<ul class="nav nav-second-level">
						<li class=""><a href="${pageContext.request.contextPath}/report/team">내부서</a></li>
						<li><a href=${pageContext.request.contextPath}/report/project>프로젝트별</a></li>
					</ul>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/project/list"><i class="mnImg04"></i> <span class="nav-label">프로젝트</span> <span class="arrow01"></span></a>
				</li>
				<s:authorize access="!hasRole('ROLE_USER')">
					<li class="active"><a href="#"><i class="mnImg05"></i> <span class="nav-label">시스템관리</span> <span class="arrow01"></span></a>
						<ul class="nav nav-second-level">
							<s:authorize access="hasRole('ROLE_ADMIN')">
								<li><a href="${pageContext.request.contextPath}/admin/check">사용자 관리</a></li>
							</s:authorize>
							<li class="active"><a href="${pageContext.request.contextPath}/project/project">프로젝트 관리</a></li>
						</ul>
					</li>
				</s:authorize>
			</ul>
		</div>
	</nav>

	<!-- #gnb e -->
	<div id="page-wrapper">
		<h2 class="tit-level1">프로젝트 관리</h2>
		<div class="subConView">
			<!-- 메인 화면  -->
			<div class="conWrap">
				<div class="sectionCon">
					<div class="board_top">
						<div class="row" style="margin: 0px; padding-bottom: 10px;">
							<div class="col-md-1" style="padding-left: 0px;">
							<select class="form-control" name="selectTeam" id="selectTeam">
								<option value="" <c:if test="${team eq null}">selected="selected"</c:if>>전체 부서</option>
								<c:forEach var="common" items="${common}" begin="15" end="29" step="1">
								<c:if test=""></c:if>
									<option value="<c:out value="${common.id}" />" >
										<c:out value="${common.name} " />
									</option>
								</c:forEach>
							</select>
							</div>
							<div class="formInput col-md-2" style="padding-left: 0px;">
								<div class="input-group">
									<input onKeypress="javascript:if(event.keyCode==13) {searchClick()}" type="text" class="form-control" id="project_title" placeholder="프로젝트명을 입력해주세요." style="width: 300px;"> 
									<span class="input-group-btn">
										<button id="search" onclick="searchClick()" class="btn btn-info" >검색</button>
									</span>
								</div>
							</div>
							<!-- 버튼 -->
							<div class="buttonGroup">
								<div class="BtnGroupR">
									<a href="${pageContext.request.contextPath}/project/register" class="btn btn-primary" style="margin-bottom: 10px;">프로젝트 생성</a>
								</div>
							</div>
						</div>
					</div>
					<!-- 버튼 끝 -->
					<div class="ib_product" style="height:700px;">
						<script type="text/javascript">
							createIBSheet("mySheet", "100%", "100%");
						</script>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script> 
  	function searchClick() {
	   	 var team = document.getElementById('selectTeam');
	   	 var selectTeam = team.options[team.selectedIndex].value;
	   	 var project_title = $('#project_title').val();
	        
	        if(selectTeam!="" && project_title!=undefined && project_title!=""){
	       	 	mySheet.DoSearch("/project/sheet/project"+ "?team="+selectTeam+"&project_title="+project_title);
	        }else if(selectTeam!="" && selectTeam!=undefined && project_title==undefined || project_title==""){
	       	 	mySheet.DoSearch("/project/sheet/project"+ "?team="+selectTeam);
	        }else if(selectTeam=="" || selectTeam==undefined && project_title!=undefined && project_title!=""){
	       	 	mySheet.DoSearch("/project/sheet/project"+ "?project_title="+project_title);
	        }else
	        	mySheet.DoSearch("/project/sheet/project");
    }
   
	
	/*Sheet 기본 설정 */
	function LoadPage() {
		mySheet.SetTheme('BLM', 'ModernBlue');
		//아이비시트 초기화
		var initSheet = {};
		mySheet.SetEditable(false);
		
		initSheet.Cfg = {
			SearchMode : smLazyLoad,
			DeferredVScroll : 1,
            SizeMode : 0
		};
		
		initSheet.Cols = [{
			Header : "NO",
			Type : "Int",
			Width : 10,
			SaveName : "p_id",
			Align : "Center",
			Hidden : 1
		}, {
			Header : "프로젝트명",
			Type : "Text",
			SaveName : "project_title",
			MinWidth : 70,
			Align : "Center"
		}, {
			Header : "별칭",
			Type : "Text",
			MinWidth : 30,
			SaveName : "project_nickname",
			Align : "Center"
		}, {
			Header : "내용",
			Type : "Text",
			MinWidth : 100,
			SaveName : "context",
			Wrap : 1,
            MultiLineText : 1
		}, {
			Header : "주관부서",
			Type : "Text",
			Width : 30,
			SaveName : "team",
			Align : "Center"
		}, {
			Header : "담당자",
			Type : "Text",
			Width : 20,
			SaveName : "name",
			Align : "Center"
		}, {
			Header : "계약금액",
			Type : "Int",
			Format : "#,##0",
			Width : 25,
			SaveName : "payment",
			Align : "Center"
		} , {
			Header : "시작일",
			Type : "Date",
			Width : 30,
			SaveName : "start_date",
			Align : "Center"
		}, {
			Header : "종료일",
			Type : "Date",
			Width : 30,
			SaveName : "end_date",
			Align : "Center"
		}, {
			Header : "단계",
			Type : "Text",
			Width : 18,
			SaveName : "state",
			Align : "Center"
		} ];
		
		IBS_InitSheet(mySheet, initSheet);
		mySheet.SetDataLinkMouse("project_title", 1);
		mySheet.SetDataLinkMouse("context", 1);
		mySheet.DoSearch("/project/sheet/project");
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
		if (mySheet.ColSaveName(Col) == "project_title") {
			var project_id = mySheet.GetCellValue(Row,"p_id");
			location.href = `${pageContext.request.contextPath}/project/main?id=`+project_id;
		}  
		else if (mySheet.ColSaveName(Col) == "context") {
			var project_id = mySheet.GetCellValue(Row,"p_id");
			location.href = `${pageContext.request.contextPath}/project/modify?id=`+project_id;
		}
	}
	

	window.addEventListener("onload", LoadPage());
</script>
<jsp:include page="../includes/footer.jsp" />