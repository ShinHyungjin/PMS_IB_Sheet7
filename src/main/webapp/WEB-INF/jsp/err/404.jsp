<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="./aside.jsp" />


<!-- layout css -->

</head>

<body class="gray-bg">

    <div class="middle-box text-center animated bounceInRight">
        <h1>404</h1>
        <h3 class="font-bold">요청하신 페이지를 찾을 수 없습니다.</h3>

        <div class="error-desc">
            <div class="errorContent">
                <p>페이지의 주소가 잘못 입력되었거나,<br />
                	주소가 변경 혹은 삭제되어 요청하신 페이지를 찾을 수 없습니다.</p>
                <p>관련 문의사항은 <b>TEAMS - IBL 업무관리시스템(PMS)에 알려주시면<br />
				친절하게 안내해 드리겠습니다.</p>
            </div>
            
			<a href="javascript:history.back(-1)" class="btn btn-primary m-t">이전 페이지 이동</a>

        </div>
    </div>


</body>

</html>
