<%@page import="java.util.ArrayList"%>
<%@page import="shoppingMall.CategoryDAO"%>
<%@page import="shoppingMall.CategoryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../ad_top.jsp" %>

<%

%>

<h3>카테고리 리스트</h3>
<table class="outLine" width="600" style="margin:auto;" >
	<tr class="m1">
		<th>번호</th>
		<th>코드</th>
		<th>카테고리명</th>
		<th>삭제</th>
	</tr>
<%
	CategoryDAO cdao = CategoryDAO.getInstance(); 
	ArrayList<CategoryDTO> cdtos = cdao.categoryAll(); //categories
	if(cdtos == null || cdtos.size()==0){
		out.println("<tr><td colspan='4'>등록된 카테고리가 없습니다</td></tr>");
	} else{//when exist categories	
		for(int i=0; i<cdtos.size(); i++){
			CategoryDTO cdto = cdtos.get(i);
	

%>		<!-- 데이터 베이스로부터 가져온 리스트 내용 -->
		<tr class="m2">
			<td><%=cdto.getCnum() %></td>
			<td><%=cdto.getCode() %></td>
			<td><%=cdto.getCname() %></td>
			<td><a href="catDelete.jsp?cnum=<%=cdto.getCnum()%>">삭제</a></td>
		</tr>
	
<%
		}//for End 
	}
%>
</table>

<%@ include file="../ad_bottom.jsp" %>