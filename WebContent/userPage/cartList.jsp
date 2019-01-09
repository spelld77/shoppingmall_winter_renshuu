<%@page import="java.text.DecimalFormat"%>
<%@page import="shoppingMall.ProductDTO"%>
<%@page import="java.util.Vector"%>
<%@page import="shoppingMall.user.ProdListDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="main_top.jsp" %>
	<!-- 장바구니 리스트 -->
	
	<table width="100%" cellpadding="0" cellspacing="0" border="1" align="center">
		<tr class="m3">
			<td colspan="6" align="center" style="text-align:center;">
				<h3>장바구니 보기</h3>
			</td>
		</tr>
		<tr class="m1">
			<th width="10%">번호</th>
			<th width="20%">상품명</th>
			<th width="10%">수량</th>
			<th width="20%">단가</th>
			<th width="20%">합계</th>
			<th width="20%">삭제</th>
		</tr>
		<tr>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center"></td>
		</tr>
		
		<!-- 장바구니 총액 계산 -->
	</table>

<%@ include file="main_bottom.jsp"%>