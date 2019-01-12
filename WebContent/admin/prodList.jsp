<%@page import="java.util.ArrayList"%>
<%@page import="shoppingMall.ProductDAO"%>
<%@page import="shoppingMall.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../ad_top.jsp" %>

<script>
	//삭제할지 묻는다
	function checkDel(pnum, pimage){
		var isDel = window.confirm("삭제 하시겠습니까?");
		if(isDel) location.href = "prodDelete.jsp?pnum=" + pnum +"&pimage=" + pimage;
	}
</script>

<br><br>
<hr width="500" color="red">
<h3>상품 리스트</h3>
<hr width="500" color="red">



<table width="800"  border= "0" class="outLine" style="margin:auto;">
	<tr class="m3">
		<th>번호</th>
		<th>카테고리 코드</th>
		<th>상품명</th>
		<th>이미지</th>
		<th>가격</th>
		<th>제조사</th>
		<th>수량</th>
		<th>수정/삭제</th>
		
	</tr>
<%
	ProductDAO pdao = ProductDAO.getInstance();
	ArrayList<ProductDTO> pdtos = pdao.productAll();
	
	if(pdtos == null || pdtos.size()==0){
		out.println("<tr><td colspan='8'>");
		out.println("상품 데이터가 없습니다");
		out.println("</td></tr></table>");
		return;
	}//if end
	
	for(ProductDTO pdto : pdtos){
	
%>
	<tr>
		<td><%=pdto.getPnum()%></td>
		<td><%=pdto.getPcategory_fk() %></td>
		<td><%=pdto.getPname()%></td>
		<td>
			<%
				String imgPath = request.getContextPath() + "/uploadFile/"+pdto.getPimage();
			%>
			<img src = "<%=imgPath%>" border="0" width="50" height="50">
		</td>
		<td><%=pdto.getPrice() %></td>
		<td><%=pdto.getPcompany() %></td>
		<td><%=pdto.getPqty() %></td>
		<td>
			<a href="prodUpdate.jsp?pnum=<%=pdto.getPnum()%>">수정</a>
			<a href="javascript:checkDel('<%=pdto.getPnum()%>','<%=pdto.getPimage()%>')">삭제</a>
		</td>
	</tr>
<%
	} //for
%>	
</table>

<style>
	td{text-align:center;}
</style>
	

<%@ include file="../ad_bottom.jsp" %>