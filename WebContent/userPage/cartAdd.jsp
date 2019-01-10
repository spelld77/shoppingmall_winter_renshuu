<%@page import="shoppingMall.user.ProdListDAO"%>
<%@page import="shoppingMall.user.CartBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mallCart" class="shoppingMall.user.CartBean" scope="session"></jsp:useBean>
<%
	String pnum = request.getParameter("pnum");
	String pqty = request.getParameter("pqty");
	String pspec = request.getParameter("pspec");
	
	if(pnum == null || pnum.trim().equals("") || pqty == null || pqty.trim().equals("")){
		response.sendRedirect("main.jsp");
		return;
	}

	pnum = pnum.trim();
	pqty = pqty.trim();
	ProdListDAO pdao = ProdListDAO.getInstance();
	mallCart.addProd(pdao, pnum, pqty, pspec);

%>