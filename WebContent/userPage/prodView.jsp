<%@page import="java.text.DecimalFormat"%>
<%@page import="shoppingMall.ProductDTO"%>
<%@page import="java.util.Vector"%>
<%@page import="shoppingMall.user.ProdListDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="main_top.jsp" %>
	<!-- 제품 상세보기 페이지 -->
	<%
		String pnum = request.getParameter("pnum");
		String pspec = request.getParameter("pspec");
		
		if(pnum == null || pnum.trim().equals("") || pspec==null || pspec.trim().equals("")){
			response.sendRedirect("main.jsp");
			return;
		}
		
		ProdListDAO lidao = ProdListDAO.getInstance();
		Vector<ProductDTO> pdtos = lidao.selectByPnum(pnum.trim());
		
		ProductDTO pdto = pdtos.get(0);
		
		if(pdto == null){
			out.println(pnum+"에 해당하는 상품이 없습니다");
			return;
		}
	%>
	
	<br><br>
	<table width="500" border="0" class="outLine">
		<tr class="m1">
			<td colspan="2">
				<b>[<%=pdto.getPname() %>]</b> 상품 상세 정보
			</td>
		</tr>
		<tr>
			<td align="center">
				<img src="../uploadFile/<%=pdto.getPimage()%>" width="200" height="200">
			</td>
			<td class="m2">
				<form name="frm" method="post">
					<input type="hidden" name="pspec" value="<%=pspec%>">
					상품번호 : <%=pnum %><br>
					상품이름 : <%=pdto.getPname() %><br>
					상품가격 : <%=pdto.getPrice() %>원<br>
					상품포인트 : [<%=pdto.getPoint() %>] point<br>
					상품 수량 : <input type="text" name="pqty" size="2" value="1">개<br><br>
					
					<!-- 장바구니 담기 -->
					<table border="0" width="90%" align="center">
						<tr>
							<!-- 장바구니 담기 버튼 -->
							<td>
								<a href="javascript:goCart('<%=pnum%>')">
									<img src="../uploadFile/btn_cart(1).png	" border="0">
								</a>
							</td>
							<!-- 장바구니 담기 버튼 end -->
							<!-- 구매하기 버튼 -->
							<td>
								<a href="#">
									<img src="../uploadFile/btn_buy.png" border="0">
								</a>
							</td>
							<!-- 구매하기  버튼 end -->
						</tr>
					</table>
				</form>
			</td>
		</tr>
		<!-- 상품 상세 내용 -->
		<tr>
			<td colspan="2" width="250" valign="top">
				<br>
				<b>상품소개</b><br>
				<%=pdto.getPcontents() %>
			</td>
		</tr>
	</table>
	<script>
		function goCart(pnum){
			document.frm.action = "/shoppingMall/userPage/cartAdd.jsp?pnum=" + pnum;
			document.frm.submit();
		}//goCart()
		
	</script>

<%@ include file="main_bottom.jsp"%>