<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>

<% 
      Object projectMemberjson = null;
      JSONObject jsonObj = null;
      JSONArray jsonarr = null;
      JSONObject jsonarrObj = null;
      
       projectMemberjson = (Object) request.getAttribute("projectMemberjson"); 
      jsonObj = (JSONObject)projectMemberjson;
      jsonarr = (JSONArray)jsonObj.get("DATA");
      jsonarrObj = (JSONObject)jsonarr.get(0);
%>
<jsp:include page="../project/aside.jsp" />

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
                 <div class="BtnGroupR" style="margin-bottom: 10px;">
                      <c:if test="${authUser == 2 || auth!='ROLE_USER'}"> 
                          <a href="${pageContext.request.contextPath}/project/useradd?id=<c:out value="${getProjectId }"/>" class="btn btn-primary" >참여인력 추가</a>
                         <a href="javascript:doAction('save')" class="btn btn-primary">저장</a>
                     </c:if>
                </div>
           </div>
            <div class="ib_product" style="height:700px;">
               <script type="text/javascript">
                  createIBSheet("mySheet", "100%", "100%");
               </script>
           </div>
    </div>
</div>
      
<input type="hidden" id="getProjectId" value='<c:out value="${getProjectId }"/>'>
      <script language="javascript">
         function mySheet_OnSaveEnd(code, msg) {
             if(code >= 0) {
                 //alert("저장 성공 \tCode : " + code +"\tmsg : " + msg);  // 저장 성공 메시지
                 location.href ="/project/user?id="+${getProjectId }
             } else {
                 //alert("저장 실패 \tCode : " + code +"\tmsg : " + msg); // 저장 실패 메시지
                    }
         }
         var json = <%=projectMemberjson%>;
         var list = new Array();
         var total = new Object();
         var project_id=document.getElementById('getProjectId').value;
         /*Sheet 기본 설정 */
         function LoadPage() {
            mySheet.SetTheme('BLM', 'ModernBlue');
            console.log(json);
            
            
         if(json != null) {   
             for(var i=0; i<json.DATA.length; i++) {
                  var data = new Object();
                  var pm = json.DATA[i];
                  data.user_name = pm.user_name+"("+pm.user_id+")"; //이름
                  data.group_id = pm.group_id; //역할
                  data.rank = pm.rank; //직급
                  data.department_name = pm.department_name; //부서
                     data.project_id=project_id;
                  list.push(data);
                  }
               total.DATA = list;
            } else {
                  {data:[]};
               }
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
               Align : "Center"

            }, {
               Header : "프로젝트 직책",
                   Type : "Combo",
                   ComboText :"외부감독자|담당자|참조자|팀원|의사결정권자|평가위원장|평가위원",
                    ComboCode : "1|2|3|4|5|6|7",
                   MinWidth : 40,
                   Width : 40,
                   Wrap : 1,
                   MultiLineText : 1,
                   SaveName : "group_id",
                   Align : "Center",
            }, {
               Header : "직급",
               Type : "Text",
               MinWidth : 30,
               Width : 40,
               SaveName : "rank",
               Align : "Center"
            }, {
               Header : "부서",
               Type : "Text",
               MinWidth : 40,
               Width : 40,
               SaveName : "department_name",
               Align : "Center"
            },{
               Header : "상태",
               Type : "Status",
               MinWidth : 40,
               Width : 40,
               SaveName : "Status",
               Align : "Center",
               Hidden : 1
                },
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

            IBS_InitSheet(mySheet, initSheet);

            mySheet.SetTreeCheckActionMode(1);

            doAction('search');
         }

         function mySheet_OnSearchEnd(cd, msg) {
            
          for (var i = 0; i <= mySheet.LastRow(); i++) {
             var value = mySheet.GetCellValue(i, "group_id");
             if (value == 1) {
                mySheet.SetCellValue(i, "group_id", "외부감독");
             }
             if (value == 2) {
                mySheet.SetCellValue(i, "group_id", "담당자");
                mySheet.SetRowEditable(i, 0);
             } 
             if (value == 3) {
                    mySheet.SetCellValue(i, "group_id", "참조자");
                }
             if (value == 4) {
                    mySheet.SetCellValue(i, "group_id", "팀원");
                }
             if (value == 5) {
                    mySheet.SetCellValue(i, "group_id", "의사결정권자");
                }
             if (value == 6) {
                    mySheet.SetCellValue(i, "group_id", "평가위원장");
                } 
             if (value == 7) {
                    mySheet.SetCellValue(i,"group_id", "평가위원");
                } 
            }
      }

         
          /*
          for (var i = 1; i <= mySheet.LastRow(); i++) {
                if(mySheet.GetCellEditable(i, 2, 2)) {
                   mySheet.SetCellEditable(false);
                }
             }
          
           
          
          
          function mySheet_OnSelectCell(OldRow, OldCol, NewRow, NewCol,isDelete) {
                if(NewRow==1 && NewCol==0){
                  // alert("책임자 삭제는 불가합니다.");
                   return;
                }
            }
          */
            
      
         /*Sheet 각종 처리*/
         function doAction(sAction) {
            switch (sAction) {
            case "search": //조회
               if(json != null) {
                    mySheet.LoadSearchData(total);
                  } else {
                     mySheet.LoadSearchData("{data:[]}");
                  }
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