package shoppingMall.user;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Hashtable;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import shoppingMall.ProductDTO;

public class ProdListDAO {
	private static ProdListDAO insProdDAO = new ProdListDAO();
	private Vector<ProductDTO> pdtos;
	private Vector<ProductDTO> pdtos2;
	Hashtable<String, Vector<ProductDTO>> hashTable = new Hashtable<String, Vector<ProductDTO>>();
	
	private ProdListDAO(){	
		pdtos = new Vector<ProductDTO>(3, 2);
		pdtos2 = new Vector<ProductDTO>(3,2);
	}
	
	public static ProdListDAO getInstance() {
		return insProdDAO;
	}
	
	//상품 사양별로 상품목록 가져오는 비즈니스 로직	
	public Vector<ProductDTO> selectByPspec(String pspec) throws SQLException{
		Connection dbconn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM product2 WHERE pspec = ?";
		try {
			dbconn = getConnection();
			ps = dbconn.prepareStatement(sql);
			ps.setString(1, pspec);
			rs = ps.executeQuery();
			pdtos =  this.makeVector(rs);
			//상품사양별로 목록을 해시테이블에 저장
			hashTable.put(pspec, pdtos);
			return pdtos;
		} finally {
			if(rs != null) rs.close();
			if(ps != null) ps.close();
			if(dbconn != null) dbconn.close();
		}
	}//selectByPspec()
	
	//#######카테고리별로 상품 리스트 가져오기#######
	public Vector<ProductDTO> selectByCat(String category_fk) throws SQLException{
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECt * FROM product2 WHERE pcategory_fk = ?";
		
		try {
			dbconn = getConnection();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, category_fk);
			rs = pstmt.executeQuery();
			
			pdtos2 = this.makeVector(rs);
			
			hashTable.put(category_fk, pdtos2);
			return pdtos2;
			
		} finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(dbconn != null) dbconn.close();
		}
	}//selectByCat()
	
	public Vector<ProductDTO> makeVector(ResultSet rs) throws SQLException{
		Vector<ProductDTO> v = new Vector<ProductDTO>();
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
			String pinputDate = d.toString(); //날짜 문자열
			
			ProductDTO pdto = new ProductDTO(pnum, pname, pcategory_fk, pcompany, pimage, pqty,
					price, pspec, pcontents, point, pinputDate, 0, 0);
			v.add(pdto);
		}//while
		return v;
	}//makeVector()
	
	//#######상품 번호로 상품 정보 가져오기#######
	public Vector<ProductDTO> selectByPnum(String pnum) throws Exception{
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM product2 WHERE pnum = ?";
		
		try {
			dbconn = getConnection();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, pnum);
			rs = pstmt.executeQuery();
			Vector<ProductDTO> v = this.makeVector(rs);
			return v;
		} finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(dbconn != null) dbconn.close();
		}
	}//selectByPnum()
	
	private Connection getConnection() {
		Context ctx = null;
		DataSource dataSource = null;
		Connection dbconn = null;
		
		try {
			ctx = new InitialContext();
			dataSource = (DataSource)ctx.lookup("java:/comp/env/jdbc/myoracle");
			dbconn = dataSource.getConnection();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return dbconn;
	}
}