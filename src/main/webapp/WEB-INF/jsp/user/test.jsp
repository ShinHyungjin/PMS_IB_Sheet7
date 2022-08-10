<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<!-- 아이비시트 필수파일존재
<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ib.util.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ib.common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ibsheetinfo.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ibsheet.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ibleaders.js"></script>
 -->
<jsp:include page="../project/aside.jsp" />

      <div class="subConView">
         <div class="conWrap">
            <div class="sectionCon">
               <div class="tabs-container">
                  <ul class="nav nav-tabs" id="project_tab">
                     <!-- 버튼 -->
                     <div class="buttonGroup">
                        
                     </div>
                  </ul>
               </div>
               <div class="BtnGroupR" style="margin-bottom: 10px;">
                  <a href="${pageContext.request.contextPath}/project/useradd?id=<c:out value="${getProjectId }"/>" class="btn btn-primary" >참여인력 추가</a>
                  <a href="javascript:doAction('save')" class="btn btn-primary">저장</a>
               </div>
            </div>
            <div class="ib_product" style="height:600px;">
               <script type="text/javascript">
                  createIBSheet("mySheet", "100%", "100%");
               </script>
            </div>
         </div>
      </div>
   <input type="hidden" id="projectMemberjson" value='<c:out value="${projectMemberjson}"/>'>
   <input type="hidden" id="getProjectId" value='<c:out value="${getProjectId }"/>'>
   </body>
   </html>
   <script language="javascript">
	 $(document).ready(function(){
			//컨트롤러에 저장된 project ID를 받는다
			 var projectId;
			 var s = `<s:authorize access="hasRole('ROLE_ADMIN')">`;
			 var send = `</s:authorize>`;
			 	$.ajax({
					 type: "POST",	
					 url: "/project/getProjectId",
					 success: function(data){
							console.log("getProjectId : " + data);
							$("#project_tab").append("<li><a href=\"${pageContext.request.contextPath}/project/wbs?id="+data+"\">WBS</a></li>");
							$("#project_tab").append("<li class=\"active\"><a href=\"${pageContext.request.contextPath}/project/user?id="+data+"\">참여인력</a></li>");
							$("#project_tab").append("<li><a href=\"${pageContext.request.contextPath}/project/info?id="+data+"\">프로젝트 정보</a></li>"+s);
							$("#project_tab").append("<li><a href=\"${pageContext.request.contextPath}/project/authority?id="+data+"\">권한</a></li>"+send);
						}
			 	 });
			});
   //1. 서버에서 가져온 부서 정보 List<Map> 형태로 JsonArray 배열에 담겨있음 ==>IBSHEET에 넘겨줄꺼임

   //2. 서버에서 가져온 1의 데이터들을 IBSHEET를 로드하는 함수에 적용시켜준다.
   var list = new Array();
   var total = new Object();
   
   //ajax로 project ID를 넘겨서 컨트롤러가 이를 필요한 JSP에게 다시 넘겨준다
   var json = document.getElementById('projectMemberjson').value;
   var test1= new Object();
   alert("정규식 전에 데이터: "+json);
   var json1=json.replace(/&#034;/g,'"')
   var arr_json = new Array();
   //arr_json = json1.get("DATA");
   //test1=json1.get(0);
   //alert(test1);
   alert("서버에서 html 공백 특수문자 제거하고: "+json1);
   var test2 = JSON.stringify(json1);
   alert(test2.length); //183
   alert(JSON.parse(json1));
   var test3 = JSON.parse(json1);
   alert("객체 길이가 뽑힌다? "+test3);
   
   alert("뽑아보자: "+test3.DATA[0].group_id);
   alert("뽑아보자: "+test3.DATA[1].group_id);
   alert("길이: "+test3.DATA.length);
   function LoadPage() {
              /*Sheet 기본 설정 */
             for(var i=0; i<test3.DATA.length; i++) {
                     var data = new Object();
                     var pm = test3.DATA[i];
                     data.user_name = pm.user_name; //이름
                     data.group_id = pm.group_id; //역할
                     data.rank = pm.rank; //직급
                     data.department_name = pm.department_name; //부서
                     list.push(data);
                     }
                  total.DATA = list;
                  
                  
          // 또 다른 Object 객체를 사용하지 않는다면 DATA:[] 가 생략됨... 꼭 필요
                  //아이비시트 초기화
                    var initSheet = {};

                    initSheet.Cfg = {
                        SearchMode : smLazyLoad,
                        DeferredVScroll : 1
                    };

                    initSheet.Cols = [ 
                     {
                       Header:"제외",
                       Type:"DelCheck",
                       SaveName:"DELCHECK",
                       MinWidth:10,
                       Width:10
                     },{
                        Header : "성명",
                        Type : "Text",
                        SaveName : "user_name",
                        MinWidth : 40,
                        Align : "Center",
                        Edit : 0

                    }, {
                        Header : "프로젝트 참여자",
                          Type : "Combo",
                          ComboText :"외부감독자|책임자|참조자|팀원|의자결정권자|평가위원장|평가위원",
                          ComboCode : "1|2|3|4|5|6|7",
                          MinWidth : 40,
                          Width : 40,
                          Wrap : 1,
                          MultiLineText : 1,
                          SaveName : "group_id",
                          Align : "Center"
                    }, {
                        Header : "직급",
                        Type : "Text",
                        MinWidth : 30,
                        Width : 40,
                        SaveName : "rank",
                        Align : "Center",
                        Edit : 0
                    }, {
                        Header : "부서",
                        Type : "Text",
                        MinWidth : 40,
                        Width : 40,
                        SaveName : "department_name",
                        Align : "Center",
                        Edit : 0
                        
                    },{
                        Header : "상태",
                        Type : "Status",
                        MinWidth : 40,
                        Width : 40,
                        SaveName : "Status",
                        Align : "Center",
                        Hidden : 1
                    } ,
                    {
                        Header : "프로젝트번호",
                        Type : "Text",
                        MinWidth : 40,
                        Width : 40,
                        SaveName : "project_id",
                        Align : "Center",
                        Hidden : 1
                    }
                    
                    ];
					
                    //초기화=> EX)내가 어떤 컬럼을 편집중이다가 초기화 버튼을 누르면 처음 서버에서 받은 상태의 IBSHEET로 돌아간다.
                    IBS_InitSheet(mySheet, initSheet);

                    mySheet.SetTreeCheckActionMode(1);

                    doAction('search');
                    
                    mySheet.SetEditable(1);

                }

                function mySheet_OnSearchEnd(cd, msg) {
                    mySheet.SetCellBackColor(0, 0, "99CCFF");
                    mySheet.SetCellFontColor(0, 0, "black");

                    mySheet.SetCellBackColor(0, 1, "99CCFF");
                    mySheet.SetCellFontColor(0, 1, "black");

                    mySheet.SetCellBackColor(0, 2, "99CCFF");
                    mySheet.SetCellFontColor(0, 2, "black");

                    mySheet.SetCellBackColor(0, 3, "99CCFF");
                    mySheet.SetCellFontColor(0, 3, "black");
                    
                    mySheet.SetCellBackColor(0, 4, "99CCFF");
                    mySheet.SetCellFontColor(0, 4, "black");
                    
                 for (var i = 1; i <= mySheet.LastRow(); i++) {
                     var value = mySheet.GetCellValue(i, "group_id");
                     if (value == 1) {
                         mySheet.SetCellValue(i, "group_id", "외부감독");
                     }
                     if (value == 2) {
                         mySheet.SetCellValue(i, "group_id", "책임자");
                     }
                     if (value == 3) {
                         mySheet.SetCellValue(i, "group_id", "참조자");
                     }
                     if (value == 4) {
                         mySheet.SetCellValue(i, "group_id", "팀원");
                     }
                     if (value == 5) {
                         mySheet.SetCellValue(i, "group_id", "의자결정권자");
                     }
                     if (value == 6) {
                         mySheet.SetCellValue(i, "group_id", "평가위원장");
                     } 
                     if (value == 7) {
                         mySheet.SetCellValue(i,"group_id", "평가위원");
                     } 
                 }
                }
                
                /*Sheet 각종 처리*/
                function doAction(sAction) {
                    switch (sAction) {
                    case "search": //조회
                        mySheet.LoadSearchData(total);
                        break;
                    case "save": //저장
                    console.log("저장");
                        //저장 시 트랜잭션 변화가 있는 데이터 전부를 보내기 위해 Param 속성을 이용하여 시트의 변화있는 전체 데이터를 전소
                        var data = JSON.stringify(mySheet.GetSaveJson());
                        mySheet.DoSave("/project/usersave",{
                            "Param" : data,
                            "UrlEncode" : 0
                            });
                       console.log(data);
                    break;
                    }
                }
                window.addEventListener("onload", LoadPage());
            </script>
            
    <jsp:include page="../includes/footer.jsp" />