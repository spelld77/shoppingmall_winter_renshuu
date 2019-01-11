<%@page import="shoppingMall.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//사용자로부터 입력 가져오기
request.setCharacterEncoding("UTF-8");
String code = request.getParameter("code");
String cname = request.getParameter("cname");

//유효성 검사
if(code == null || cname == null || code.trim().equals("") || cname.trim().equals("")){
	response.sendRedirect("cat_input.jsp");
}

//비즈니스 로직(DAO) 수행
CategoryDAO cdao = CategoryDAO.getInstance();
int n = cdao.insertCat(code.trim(), cname.trim());//try category insertion
String msg = "", url="";
if(n > 0){
	msg = "카테고리 등록 되었습니다...";
	url = "catList.jsp";
} else{
	msg = "카테고리 등록 실패했습니다...";
	url = "cat_input.jsp";
}
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>