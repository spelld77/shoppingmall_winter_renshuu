<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String pnum = request.getParameter("pnum");
	String pqty = request.getParameter("pqty");
	String pspec = request.getParameter("pspec");
	
	if(pnum == null || pnum.trim().equals("") || pqty == null || pqty.trim().equals("")){
		response.sendRedirect("main.jsp");
		return;
	}
	
	

%>