<%@page import="shoppingMall.CategoryDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shoppingMall.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../ad_top.jsp" %>
<%
	CategoryDAO cdao = CategoryDAO.getInstance();
	
%>
<h3>상품 등록 페이지</h3>
<form action="prod_regOk.jsp" method="post" name="prodFrm" >
	<table style="margin:auto;" border="0" class="outLine">
		<tr>
			<th class="m3">카테고리</th>
			<td align="left">
				<select name="pcategory">
				<%
					ArrayList<CategoryDTO> cdtos = cdao.categoryAll();
					if(cdtos == null || cdtos.size() ==0){
				%>
						<option value="">카테고리 없음</option>
				<% 		
					} else{
						for(CategoryDTO cdto : cdtos){
							String cname = cdto.getCname();
							String code = cdto.getCode();
						%>
						<option value="<%=code%>">
							<%=cname%>[<%=code%>]
						</option>
						<%	
							
						} //for문
					}
				%>
					
				</select>
			</td>
		</tr>
		<tr>
			<th class="m3">상품명</th>
			<td align="left">
				<input type="text" name="pname">
			</td>		
		</tr>
		<tr>
			<th class="m3">제조회사</th>
			<td align="left">
				<input type="text" name="pcompany">
			</td>
		</tr>
		<tr>
			<th class="m3">상품이미지</th>
			<td align="left">
			<!-- 이미지 파일을 지정하여 업로드 -->
				<input type="file" name="pimage">
			</td>
		</tr>
		<tr>
			<th class="m3">상품 수량</th>
			<td align="left">
				<input type="text" name="pqty" maxlength="8">
			</td>
		</tr>
		<tr>
			<th class="m3">상품가격</th>
			<td align="left">
				<input type="text" name="price" maxlength="8">
			</td>
		</tr>
		<tr>
			<th class="m3">상품사양</th>
			<td align="left">
				<select name="pspec">
					<option value="none" selected>일반</option>
					<option value="hit">인기</option>
					<option value="new">최신</option>
					<option value="recommend">추천</option>
				</select>
			</td>
		</tr>
		<tr>
			<th class="m3">상품소개</th>
			<td align="left">
				<textarea name="pcontents" rows="5" cols="50"></textarea>
			</td>
		</tr>
		<tr>
			<th class="m3">상품포인트</th>
			<td align="left">
				<input type="text" name="point">
			</td>
		</tr>
		<tr>
		<td colspan="2" class="m1" align="center">
			<input type="submit"  value="상품등록">
			<input type="reset" value="취소">
		</td>
		</tr>
	</table>
</form>
	

<%@ include file="../ad_bottom.jsp" %>