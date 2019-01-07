<%@page import="java.text.DecimalFormat"%>
<%@page import="shoppingMall.ProductDTO"%>
<%@page import="java.util.Vector"%>
<%@page import="shoppingMall.user.ProdListDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="main_top.jsp" %>
		<!-- Mall 내용 -->
		<td>
			<h3 align="center">쇼핑몰에 오신 것을 환영합니다</h3>
			<% //인기 상품 진열
				DecimalFormat df = new DecimalFormat("#, ###, ###"); // 1000단위로 콤마
			
				ProdListDAO pdao = ProdListDAO.getInstance();
				Vector<ProductDTO> pdtos = pdao.selectByPspec("hit");
				
				if(pdtos == null || pdtos.size() == 0){
					out.println("Hit 상품이 없습니다");
				} else{
			%>
			
			<hr color="red">
			<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;인기 상품</b>
			<hr color="green" width="90%">
			<br>
			<table width="100%" border="1" align="center">
				<tr>
					<%
						int cnt = 0;
						for(ProductDTO pdto : pdtos){
							cnt++;
							String pimage = pdto.getPimage();
							String pnum = pdto.getPnum();
							String pname = pdto.getPname();
							int price = pdto.getPrice();
							int point = pdto.getPoint();
					%>
						<td align="center">
						<a href="">
							<img src="../uploadFile/<%=pimage%>" width="120" height="120" border="0">
						</a>
						<br>
						<%=pname%><br>
						<%=df.format(price)%>원<br>
						[<%=point %>]포인트
						</td>
						<%
						if(cnt%4 == 0){
							out.println("</tr><tr>");
						}//if
						
						}//for
					%>
				</tr>
			</table>
			<%
			}//else 
			%>
			
		</td>
	</tr>

<%@ include file="main_bottom.jsp"%>