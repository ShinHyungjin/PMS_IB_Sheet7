<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="./aside.jsp" />


<!-- layout css -->

</head>

<body class="gray-bg">


    <div class="middle-box text-center animated bounceInRight">
        <h1>500</h1>
        <h3 class="font-bold">잠시후에 다시 한번 시도해 주시길 부탁드립니다.</h3>

        <div class="error-desc">
            <div class="errorContent">
                <p>동일한 문제가 지속적으로 발생할 경우 <br />TEAMS- IBL 업무관리시스템(PMS)에 문의하여 주시기 바랍니다.</p>
            </div>
            
			<a href="javascript:history.back(-1)" class="btn btn-primary m-t">이전 페이지 이동</a>

        </div>
    </div>


</body>

</html>
