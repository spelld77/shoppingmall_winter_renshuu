<%@page import="shoppingMall.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!-- 
파일업로드 라이브러리 다운로드
.http://www.servletes.com
업로드 파일 저장하기 위한 폴더생성(webcontent밑에)

 -->
 
 <%
 	request.setCharacterEncoding("UTF-8");
 	String msg = "", url="";
 	
 	String uploadPath = request.getSession().getServletContext().getRealPath("uploadFile"); //저장될 곳
 	int maxSize = 1024 * 1024 * 10; //10MB
 	String filename = "";
 	String originFile="";
 	try{
	 	MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	 	
	 	ProductDAO pdao = ProductDAO.getInstance();
	 	int n = pdao.registerProduct(multi);
	 	
	 	if(n>0){
	 		msg = "상품 등록 완료되었습니다";
	 		url = "prodList.jsp";
	 	} else{
	 		msg = "상품 등록 실패했습니다";
	 		url = "prod_input.jsp";
	 	}
 	}catch(Exception e){
 		msg = "이미지 파일 업로드 실패";
 		url = "prod_input.jsp";
 		e.printStackTrace();
 	}
 %>
 <script>
 	alert("<%=msg%>");
 	location.href="<%=url%>";
 </script>
 