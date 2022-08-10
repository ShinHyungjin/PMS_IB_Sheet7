<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- <div id="gototop">go to top
<form name="actionForm">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>		
</div> --%>

<script>
/* function Logout(){​​​​​​​
	var form=$('#actionForm');
    var check=confirm("정말 로그아웃 하시겠습니까?");
   
    if(check==true){​​​​​​​
    form.attr("action","/user/logout");
    form.attr("method","post");
    form.submit();
    }​​​​​​​
}  */

$(document).ready(function() {
	$('.dateStart .input-group.date').datepicker({
		todayBtn: "linked"
	});
	$('.dateEnd .input-group.date').datepicker({
		todayBtn: "linked"
	});

	/*
	$('.weekDate .input-group.date').datepicker({
		todayBtn: "linked",
		todayHighlight:true,
		onSelect: function(d,i){
			console.log("선택됨 : " + d);
			}
	});
	*/

	$('#conFirmDelete').click(function () {
		swal({
			title: "등록하시겠습니까?",
			text: "확인버튼 클릭후 저장됩니다.",
			type: "info",
			showCancelButton: true,
			confirmButtonText: "확인",
			closeOnConfirm: false
		}, function () {
			swal("Suceess", "등록이 완료되었습니다.", "success");
		});
	});
	 
});
</script>


<script src="${pageContext.request.contextPath}/resources/js/lib/loadAnimation.js"></script>


</body>
</html>
