<%@page import="shoppingMall.user.ProdListDAO"%>
<%@page import="shoppingMall.user.CartBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%//로그인 모듈이 필요함 %>
<jsp:useBean id="mallCart" class="shoppingMall.user.CartBean" scope="session"></jsp:useBean>

<%
	//삭제하고자 하는 상품의 번호 얻기
	String pnum = request.getParameter("pnum");
	
	if(pnum == null || pnum.trim().equals("")){
%>
		<script>
			alert("잘못들어온 경로입니다");
			history.back();
		</script>
	
<%	
		return;
	}//if END
	mallCart.delProd(pnum.trim());
	response.sendRedirect("cartList.jsp");
	
%>