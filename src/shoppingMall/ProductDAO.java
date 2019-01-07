package shoppingMall;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;

public class ProductDAO {
	private static ProductDAO insPDAO = new ProductDAO();
	
	private ProductDAO() {
		
	}
	public static ProductDAO getInstance() {
		return insPDAO;
	}
	
	//상품 등록 모듈
	public int registerProduct(MultipartRequest multi) throws SQLException{
		Connection dbconn = null;
		PreparedStatement pstmt = null;
				
		try {
			dbconn = getConnection();
			String sql = "INSERT INTO product2 VALUES(product_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			
			pstmt = dbconn.prepareStatement(sql);
			
			String pname = multi.getParameter("pname");
			String pcategory_fk = multi.getParameter("pcategory_fk");
			String pcompany = multi.getParameter("pcompany");
			String pimage = multi.getFilesystemName("pimage");
			String pqty =multi.getParameter("pqty");
			String price = multi.getParameter("price");
			String pspec = multi.getParameter("pspec");
			String pcontents = multi.getParameter("pcontents");
			String point = multi.getParameter("point");
			
			pstmt.setString(1, pname);
			pstmt.setString(2, pcategory_fk);
			pstmt.setString(3, pcompany);
			pstmt.setString(4, pimage);
			pstmt.setString(5, pqty);
			pstmt.setString(6, price);
			pstmt.setString(7, pspec);
			pstmt.setString(8, pcontents);
			pstmt.setString(9, point);
			
			int n = pstmt.executeUpdate();
			return n;
			
		} finally {
			if(pstmt != null) pstmt.close();
			if(dbconn != null) dbconn.close();
		}
	}//registerProduct
	
	//상품번호로 특정 상품 정보 가져오기
	public ProductDTO selectProduct(String pnum) throws SQLException{
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM product2 WHERE pnum = ?";
		try {
			dbconn = getConnection();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, pnum);
			rs = pstmt.executeQuery();
			ArrayList<ProductDTO> pdtos = this.makeArrayList(rs);
			ProductDTO pdto = null;
			if(pdtos != null && pdtos.size() != 0) {
				pdto = pdtos.get(0);
			}
			return pdto;
		} finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(dbconn != null) dbconn.close();
		}
	}//selectProduct
	
	//모든 상품리스트를 가져온다
	public ArrayList<ProductDTO> productAll() throws SQLException{
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM product2 ORDER BY pnum DESC";
		
		try {
			dbconn = getConnection();
			pstmt = dbconn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			ArrayList<ProductDTO> pdto = makeArrayList(rs);
			return pdto;
		} finally {
			
		}
	}//productAll
	
	public ArrayList<ProductDTO> makeArrayList(ResultSet rs) throws SQLException{
		ArrayList<ProductDTO> pdtos = new ArrayList<ProductDTO>();
		
		while(rs.next()) {
			String pnum = rs.getString(1);
			String pname = rs.getString(2);
			String pcategory_fk = rs.getString(3);
			String pcompany = rs.getString(4);
			String pimage = rs.getString(5);
			int pqty = rs.getInt(6);
			int price = rs.getInt(7);
			String pspec = rs.getString(8);
			String pcontents = rs.getString(9);
			int point = rs.getInt(10);
			Date d = rs.getDate(11);
			String pinputDate = d.toString();
			
			ProductDTO pdto = new ProductDTO(pnum, pname, pcategory_fk, pcompany, pimage, pqty, price, pspec, pcontents, point, pinputDate, 0, 0);
			pdtos.add(pdto);
		}//while end
		return pdtos;
	} //makeArrayList
	
	//상품 정보를 수정하는 로직
	public int updateProd(MultipartRequest multi) throws SQLException{
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		
		String pname = multi.getParameter("pname");
		String pcategory_fk = multi.getParameter("pcategory_fk");
		String pcompany = multi.getParameter("pcompany");
		String pimageNew = multi.getFilesystemName("pimageNew");
		//pimageNew가 null인 경우는 이미지는 그대로 (수정안했음)
		if(pimageNew == null) {
			pimageNew = multi.getFilesystemName("pimageOld");
		}
		String pqty = multi.getParameter("pqty");
		String price = multi.getParameter("price");
		String pspec = multi.getParameter("pspec");
		String pcontents = multi.getParameter("pcontents");
		String point = multi.getParameter("point");
		String pnum = multi.getParameter("pnum");
		
		String sql = "UPDATE product2 SET "
				+ "pname = ?, pcategory_fk = ?, pcompany = ?,"
				+ "pimage = ?, pqty = ?, price = ?,"
				+ "pspec = ?, pcontents =?, point=?,"
				+ "pinputDate = sysdate "
				+ "WHERE pnum = ?";
		
		try {
			dbconn = getConnection();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, pname);
			pstmt.setString(2, pcategory_fk);
			pstmt.setString(3, pcompany);
			pstmt.setString(4, pimageNew);
			pstmt.setInt(5, Integer.parseInt(pqty));
			pstmt.setInt(6, Integer.parseInt(price));
			pstmt.setString(7, pspec);
			pstmt.setString(8, pcontents);
			pstmt.setInt(9, Integer.parseInt(point));
			pstmt.setInt(10, Integer.parseInt(pnum));
			
			return pstmt.executeUpdate();
		} finally {
			if(pstmt != null) pstmt.close();
			if(dbconn != null) dbconn.close();
		}
		
	}//updateProd
	
	//Connection Pool에서 커넥션 얻기
	private Connection getConnection() {
		Context ctx = null;
		DataSource ds = null;
		Connection dbconn = null;
		
		try {
			ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/myoracle");
			dbconn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dbconn;
	}
}
