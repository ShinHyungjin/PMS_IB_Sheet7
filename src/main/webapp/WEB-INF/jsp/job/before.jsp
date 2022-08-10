<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../includes/header.jsp" />
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />  

	<div id="wrapper">
		<nav class="navbar-default navbar-static-side" role="navigation">
			<div class="sidebar-collapse">
				<ul class="nav metismenu" id="side-menu">
					<li class="active"><a href="#"><i class="mnImg02"></i><span class="nav-label">내작업</span><span class="arrow01"></span></a>
						<ul class="nav nav-second-level">
							<li><a href="${pageContext.request.contextPath}/job/list">전체</a></li>
							<li class="active"><a href="${pageContext.request.contextPath}/job/before">진행전<c:out value="${beforelastCnt}" /></a></li>
							<li><a href="${pageContext.request.contextPath}/job/ing">진행중  <c:out value="${inglastCnt}"/></a></li>
							<li><a href="${pageContext.request.contextPath}/job/stop">중단</a></li>
							<li><a href="${pageContext.request.contextPath}/job/end">완료</a></li>
						</ul>
					</li>
					<li><a href="#"><i class="mnImg01"></i> <span class="nav-label">보고서</span><span class="arrow01"></span></a>
						<ul class="nav nav-second-level">
							<li class=""><a href="${pageContext.request.contextPath}/report/team">내부서</a></li>
							<li><a href="${pageContext.request.contextPath}/report/project">프로젝트별</a></li>
						</ul>
					</li> 
					<li><a href="${pageContext.request.contextPath}/project/list"><i class="mnImg04"></i> <span class="nav-label">프로젝트</span> <span class="arrow01"></span></a>
					</li>
					<s:authorize access="!hasRole('ROLE_USER')">
					<li><a href="#"><i class="mnImg05"></i> <span class="nav-label">시스템관리</span> <span class="arrow01"></span></a>
						<ul class="nav nav-second-level">
							<s:authorize access="hasRole('ROLE_ADMIN')">
								<li><a href="${pageContext.request.contextPath}/admin/check">사용자 관리</a></li>
							</s:authorize>
							<li><a href="${pageContext.request.contextPath}/project/project">프로젝트 관리</a></li>
						</ul>
					</li>
				</s:authorize>
				</ul>
			</div>
		</nav>
		<!-- #gnb e -->
		<div id="page-wrapper">
			<div class="subConView">
				<div class="conWrap">
					<div class="sectionCon">
						<div class="board_top mainSearch">
								<!--프로젝트 선택-->
							<div class="col-md-3"  style="padding-left: 0px;">
								<div class="selects">
									<select class="form-control" id="project_title" name="">
										<option value="전체" data-value="all">전체</option>
										<option value="기타" data-value="기타">기타</option>
									</select>
								</div>
							</div>
							<div class="col-md-1" style="padding-left: 0px;">
								<input type="submit" value="검색" id="search"  class="btn btn-info" />
							</div>
							<div class="col-md-8 text-right"  style="padding-left: 0px;">
								<a href="${pageContext.request.contextPath}/job/subregister" class="btn btn-info" title=""><i class="ti-plus"></i>&nbsp;&nbsp;새작업</a>
							</div>
						</div>
						
						
						<div class="myWork">
							<div class="myWorkWrap grid" style="position: relative;">
								<c:forEach var="before" items="${beforelist}">
									<c:choose>
										<c:when test="${before.wbs_id!=0}">
	                                     	<div class="myWorkList grid-item" style="background: #FFFFCC;">
	                                   </c:when>
	                                  <%--  <c:when test="${before.wbs_id!=0 && before.real_start_date < today}">
	                                     	<div class="myWorkList grid-item" style="background: #FFFFCC;border: 1px solid #FF6464;">
	                                   </c:when>
	                                  <c:when test="${before.wbs_id==0 && before.real_start_date < today}">
											<div class="myWorkList grid-item" style="border: 1px solid #FF6464;">
										</c:when> --%>
										<c:otherwise>
											<div class="myWorkList grid-item">
										</c:otherwise>
                                  	</c:choose>
									<c:if test="${before.project_id ne 0}"><a href="/project/main?id=<c:out value="${before.project_id}" />" title="프로젝트 이동"> </c:if>
										<div class="cate">
											<c:out value="${before.project.project_nickname eq null ? '기타' : before.project.project_nickname}" />
											<c:out value="${before.project.project_nickname eq null ? '' : before.order_id}" />
											 <c:choose>
				                                  <c:when test="${before.week==1}">
				                                      <i class="fas fa-star"  title="주간보고서 포함"></i>
				                                  </c:when>
				                                   <c:when test="${before.week!=1}">
				                                      <i class="far fa-star"  title="주간보고서 미포함"></i>
				                                  </c:when>
			                               </c:choose>
										</div>
									</a>
									<div class="myWorkListTit">
										<a href="/job/submodify?id=<c:out value="${before.id}"/>">
											<%-- <h4>
											<c:out value="${before.name}" />(하위: <c:out value="${before.sub_cnt}" />개)<span></span>
											</h4> --%>
											<c:choose>
													<c:when test="${before.real_start_date < today}">
				                                     	<h4 style="color: #FF0000" title="작업명(하위작업 개수)"><c:out value="${before.name}"/>(<c:out value="${before.sub_cnt}" />)<span></span></h4>
				                                   </c:when>
				                                   <c:when test="${before.real_start_date >= today}">
														<h4 title="작업명(하위작업 개수)"><c:out value="${before.name}"/>(<c:out value="${before.sub_cnt}" />)<span></span></h4>
												 	</c:when>
			                              	</c:choose>
											<fmt:formatNumber value="${before.real_progress*100}" type="number" var="numberType" />
											<p><c:out value="${numberType}"/>%</p>
										</a>
									</div>
									<div style="margin-top: 5px;">
										(<c:out value="${before.real_start_date!=undefined? before.real_start_date : before.start_date }"/>)~(<c:out value="${before.real_end_date!=undefined? before.real_end_date : before.end_date}"/>)
									</div>
								</div>
								<!--myWorkWrap end  -->
							  </c:forEach>	
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- .main-section e -->

		</div>
		<!-- .container-inner e -->

	</div>

</div>
<input type="hidden" id="selectedTitle" value="${selectedTitle}" />		


<script type="text/javascript" language="javascript"
	src="${pageContext.request.contextPath}/resources/js/plugins/masonary/masonry.pkgd.min.js"></script>

<script>
	$(window).load(function() {

		$('.grid').masonry({
			// options
			itemSelector : '.grid-item',
			columnWidth : 300,
			gutter : 25
		});

	});
</script>

<jsp:include page="../includes/footer.jsp" />
<script>
$(document).ready(function(){
	var userid='<s:authentication property="principal.username"/>';
	//alert("로그인 유저는?: "+userid);
    var myjob; 
	 $.ajax({
		 type: "POST",	
		 url: "/job/myjob",
		 data : {userid : userid},
		 success: function(data){
			 if(data!=null){
				// alert("일단 값은 들어왔어");
				 myjob=data;
			 }else{
				 alert("오류가 발생하였습니다. 다시 시도해주세요!");
			 }
			 for(var i =0; i<data.length; i++){
				 $("#project_title").append("<option id="+"selectTitle("+i+")"+" value="+data[i].PROJECT_NICKNAME+" data-value="+data[i].PROJECT_NICKNAME+">"+data[i].PROJECT_TITLE+"</option>");
				 $("#project_list").append("<li id=project_id value="+data[i].PROJECT_ID+" data-value="+data[i].PROJECT_TITLE+"><a href=\"${pageContext.request.contextPath}/project/main?id="+data[i].PROJECT_ID+"\">"+data[i].PROJECT_TITLE+"</li>");
			 }
			 
		     for(var i =0; i<data.length+2; i++){
	        	 var selectedTitle = document.getElementById('selectedTitle').value;
	        	 //alert(selectedTitle);
	        	 var project_title = document.getElementById('project_title');
	        	 //alert("test: "+project_title.options[0].innerHTML);
	        	 if(project_title.options[i].innerHTML === selectedTitle){
	        		 //alert(project_title.options[i].innerHTML);
	        		 project_title.options[i].selected=true;
	        		 break;
		        	 }
	             } 
			 
		 }
	 });   
	 
	//첫번째 셀렉트 박스 눌렀을때 두번째 셀렉트 박스 자동으로 기입 시작===========================================
	 $("#project_title").on("click",function(e){
	 	e.preventDefault();
	 	//var test = $(this).val();
	 	var test= $(this).find(':selected').attr('data-value');
	 	//alert("나오니?:"+test);
	 	$("#project_nickname").empty();
	 	$("#project_nickname").append("<option>"+test+"</option>");	
	 	
	 });//첫번째 셀렉트 박스 눌렀을때 두번째 셀렉트 박스 자동으로 기입 끝=========================================
		 
	    //=============================================검색처리 로직===========================================================
     var url ="";
     $("#search").on("click",function(e){
         e.preventDefault();
         var actionForm=("#actionForm");
         var project_title = document.getElementById('project_title');
         var select_project_title=project_title.options[project_title.selectedIndex].text; //선택된 프로젝트 명
         var userid='<s:authentication property="principal.username"/>'; //로그인 유저
         $('input[id=title]').attr('value',select_project_title);
         var test=$("#title").val();
         //alert("선택된 셀렉트 벨류: "+select_project_title);
         //alert("담겼니? "+select_project_title);
         var check="전체";
         if(test==="전체"){
             url=url;
         }else{
             url=url+"?title="+select_project_title
         }
         
         location.href = url;

         
     }); 
});


</script>

