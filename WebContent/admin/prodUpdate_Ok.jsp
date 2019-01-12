<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shoppingMall.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String uploadPath = application.getRealPath("uploadFile");
	int maxSize = 1024 * 1024 * 10; //10MB
	String encoding = "UTF-8";
	String msg = "", url = "";
	 
	ProductDAO pdao = ProductDAO.getInstance();
	
	try{
		
		MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		//새로운 이미지로 변경하면, 원래 이미지 삭제
		if(multi.getFilesystemName("pimageNew") != null){ //새로운 이미지로 바꿨다면
			String imgFolder = application.getRealPath("uploadFile");//이미지가 저장된 폴더
			String oldImg = multi.getParameter("pimageOld"); //변경전 이미지파일 이름
			File dFile = new File(imgFolder + "/" + oldImg);
			if(dFile.exists()){
				dFile.delete();
			}
			
		}
		
		int n = pdao.updateProd(multi);
		if(n > 0){
			msg = "상품 정보가 수정 완료 되었습니다";
			url = "prodList.jsp";
			
		} else{
			msg = "상품 정보 수정 처리가 되지 않았습니다";
			url = "prodList.jsp";
		}
	}catch(IOException e){
		msg = "파일 업로드 실패";
		url = "prodList.jsp";
	}catch(NumberFormatException e){
		msg = "상품 수량, 가격은 숫자로 입력하세요";
		url = "prodList.jsp";
	}
	
%>
<script>
alert("<%=msg%>");
	location.href = "<%=url%>";
</script>