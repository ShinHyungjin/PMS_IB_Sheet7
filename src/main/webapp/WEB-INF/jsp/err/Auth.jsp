<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="./aside.jsp" />


<!-- layout css -->

    <div class="middle-box text-center animated bounceInRight">
       	<br />
       	<br />
       	<br />
       	<br />
       	<br />
       	<br />
        <h1>AUTH</h1>
        <h3 class="font-bold">접근권한이 없습니다.</h3>

        <div class="error-desc">
            <div class="errorContent">
                <p>담당자가 접근권한을 부여하지 않았습니다. <br />해당 프로젝트 담당자에게 문의해주세요.</p>
            </div>
            
			<a href="javascript:history.back(-1)" class="btn btn-primary m-t">이전 페이지 이동</a>

        </div>
    </div>
<jsp:include page="../includes/footer.jsp" />