<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table width="700" align="center" border="1">
<!--  메이 내비게이터 -->
	<tr>
		<td colspan="2">
			<a href="#">쇼핑몰 HOME</a>
			<a href="#">로그인</a>
			<a href="<%=request.getContextPath()%>/adminLogin.jsp">관리자</a>
		</td>
	</tr>
	<tr>
		<td>
			<!-- 카테고리 목록 -->
			<table width="100%" border="1">
			
			</table>
		</td>
	