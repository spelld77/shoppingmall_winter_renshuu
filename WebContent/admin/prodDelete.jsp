<%@page import="shoppingMall.ProductDAO"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pnum = request.getParameter("pnum");
	if(pnum == null || pnum.trim().equals("")){
		response.sendRedirect("prodList.jsp");
		return;
	}//if
	
	String pimage = request.getParameter("pimage");
	String imgPath = application.getRealPath("uploadFile");
	
	File dfile = null;
	
	if(pimage != null){
		dfile = new File(imgPath + "/" + pimage);
		System.out.println("삭제파일: "+dfile);
		if(dfile.exists()){
			if(dfile.delete()) out.println("이미지 파일 삭제 완료");
		}
	}//if
	
	//삭제 비즈니스 로직
	ProductDAO pdao = ProductDAO.getInstance();
	int n = pdao.delProd(pnum.trim());
	
	String msg ="", url = "prodList.jsp";
	if(n >0){
		msg = "상품 삭제 처리가 완료 되었습니다.";
	} else{
		msg = "상품 삭제 실패";
	}
%>   
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script> 
