<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>

	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>

<script type="text/javascript" language="javascript" src="../resources/js/jquery-2.1.1.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ibsheetinfo.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ibsheet.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/product/sheet/ibleaders.js"></script>


<div class="ib_product" style="height:500px;width:100%;">
	<script type="text/javascript"> createIBSheet("popupSheet","100%","100%");</script>
</div>

<script>
var loginUser='<s:authentication property="principal"/>';
console.log("현재 로그인 한 유저는? " +loginUser);

function LoadPage(){
	//sheet 초기화
	for(var i=0; i<10; i++) {
         var data = new Object();
         data.name = "신형진";
         data.department = 120;
         list.push(data);
         }
      total.DATA = list;
	
	var initData = {};
	initData.Cfg = {SearchMode:smLazyLoad, Page:30,MouseHoverMode:2};
	initData.Cols = [
		{Header:"이름",Type:"Text", SaveName:"name", Width:80, Align:"Center",Edit:0},
		{Header:"부서",Type:"Int", SaveName:"department", Width:80, Align:"Center",Edit:0}
	];
	initData.HeaderMode  = {ColMove:1};
	IBS_InitSheet(popupSheet,initData);
	
	popupSheet.LoadSearchData(total);
	//데이터 조회
}

//조회 완료 이벤트
function popupSheet_OnSearchEnd(code,msg){

}

//더블 클릭 이벤트 (주의:모바일에서는 동작하지 않음)
function popupSheet_OnDblClick(Row, Col, Value, CellX, CellY, CellW, CellH) { 
	//더블클릭한 행의 데이터를 json 형식으로 추출
	var rowData = popupSheet.GetRowData(Row);			
	//어미 창의 시트에 세팅
	parent.setData(rowData);
	//현재 창을 감춘다.
	parent.showAndHide(0);
}
window.addEventListener("onload", LoadPage()); 
</script>