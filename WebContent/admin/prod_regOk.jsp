<%@page import="java.io.File"%>
<%@page import="shoppingMall.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!-- 
파일업로드 라이브러리 다운로드
.http://www.servletes.com
업로드 파일 저장하기 위한 폴더생성(webcontent밑에)

 -->

<%
	request.setCharacterEncoding("UTF-8");
	String msg = "", url = "";

	//String uploadPath = request.getSession().getServletContext().getRealPath("uploadFile"); //저장될 곳
	String uploadPath = application.getRealPath("uploadFile"); //저장될 곳

	int maxSize = 1024 * 1024 * 10; //10MB
	String filename = "";
	String originFile = "";
	MultipartRequest multi = null;
	try {
		multi = new MultipartRequest(request, uploadPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());

		ProductDAO pdao = ProductDAO.getInstance();
		int n = pdao.registerProduct(multi);

		if (n > 0) {
			msg = "상품 등록 완료되었습니다";
			url = "prodList.jsp";
		} else {
			msg = "상품 등록 실패했습니다";
			url = "prod_input.jsp";
			//업로드되었다면 이미지 삭제
			String dName = multi.getFilesystemName("pimage"); //업로드된 파일 이름
			if (dName != null) { //업로드된 파일이름 있을 때
				File dFile = new File(uploadPath + "/" + dName);
				if (dFile.exists()) { //업로드된 파일 존재하면
					dFile.delete();
				}
			}
		}
	} catch (Exception e) {
		msg = "이미지 파일 업로드 실패";
		url = "prod_input.jsp";
		e.printStackTrace();	
		
		//업로드되었다면 이미지 삭제
		String dName = multi.getFilesystemName("pimage"); //업로드된 파일 이름
		if (dName != null) {//업로드된 파일이름 있을 때
			File dFile = new File(uploadPath + "/" + dName);
			if (dFile.exists()) {
				dFile.delete();
			}
		}
		

	}
%>
<script>
 	alert("<%=msg%>");
 	location.href="<%=url%>";
</script>
