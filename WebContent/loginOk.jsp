<%@page import="shoppingMall.AdminDAO, shoppingMall.AdminDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	AdminDAO adao = AdminDAO.getInstance();
	int chkNum = adao.adminCheck(id, pw);
	
	if(chkNum == -1){
%>
<script type="text/javascript">
	alert("관리자만 접속할 수 있습니다...");
	history.go(-1);
</script>
<%
	}else if(chkNum == 0){

%>
<script type="text/javascript">
	alert("비밀번호가 일치하지 않습니다...");
	history.go(-1);
</script>
<%
	} else if(chkNum == 1){
		AdminDTO adto = adao.getAdmin(id);
		
		String name = adto.getName();
		session.setAttribute("id", id);
		session.setAttribute("name", name);
		session.setAttribute("valid", "yes");
		response.sendRedirect("ad_main.jsp");
	}
%>
