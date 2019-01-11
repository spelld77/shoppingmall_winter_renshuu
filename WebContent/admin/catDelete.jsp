<%@page import="shoppingMall.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String cnum = request.getParameter("cnum");
	String pimage = request.getParameter("pimage");//삭제할 파일 이름
	if(cnum == null || cnum.trim().equals("")){
		response.sendRedirect("catList.jsp");
		return;
	}
	
	//categoryDAO의 비즈니스 로직을 수행
	CategoryDAO cdao = CategoryDAO.getInstance();
	int n = cdao.categoryDelete(cnum);
	
	String msg = "", url="catList.jsp";
	if(n > 0){
		msg = "카테고리 삭제 완료 되었습니다";
	} else{
		msg = "카테고리 삭제 실패";
	}
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>