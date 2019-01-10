<%@page import="shoppingMall.user.ProdListDAO"%>
<%@page import="shoppingMall.user.CartBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%//로그인 모듈이 필요함 %>
<jsp:useBean id="mallCart" class="shoppingMall.user.CartBean" scope="session"></jsp:useBean>

<%
	//수정하고자 하는 상품의 번호와 수량을 얻기
	String pnum = request.getParameter("pnum");
	String pqty = request.getParameter("pqty");
	
	if(pnum == null || pqty == null || pnum.trim().equals("") || pqty.trim().equals("")){
%>
		<script>
			alert("잘못들어온 경로입니다");
			history.back();
		</script>
	
<%	
		return;
	}//if END
	try{
		int qty = Integer.parseInt(pqty);
		mallCart.setModify(pnum, pqty);
		response.sendRedirect("cartList.jsp");
	}catch(NumberFormatException e){
		%>
		<script>
			alert("수량을 잘못 입력했습니다");
			history.go(-1);
		</script>
		
		<%
	}
%>