<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<head>

<title>IB Leaders</title>
<meta name="title" content="IB Leaders" />
<meta name="Author" content="IB Leaders" />
<meta name="description" content="IB Leaders" />
<meta name="keywords" content="IB Leaders" />
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1"/>
<meta name='viewport' content='initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0,width=device-width'>

<link rel="apple-touch-icon" sizes="57x57" href="../resources/img_app/favicon/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="../resources/img_app/favicon/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="../resources/img_app/favicon/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="../resources/img_app/favicon/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="../resources/img_app/favicon/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="../resources/img_app/favicon/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="../resources/img_app/favicon/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="../resources/img_app/favicon/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="../resources/img_app/favicon/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192"  href="resources/img_app/favicon/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="../resources/img_app/favicon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="../resources/img_app/favicon/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="../resources/img_app/favicon/favicon-16x16.png">
<link rel="manifest" href="resources/img_app/favicon/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="../resources/img_app/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">


<!-- layout css -->
<link rel="stylesheet" type="text/css" href="../resources/css/layout.css">

</head>

<script type="text/javascript">
window.onload=function(){
	alert("<c:out value="${msg}"></c:out>");
	console.log("<c:out value="${msg}"></c:out>");
	location.href="/user/login";
}
</script>

</html>
