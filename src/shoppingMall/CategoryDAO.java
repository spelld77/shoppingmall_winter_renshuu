package shoppingMall;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CategoryDAO {
	private static CategoryDAO insCatDAO = new CategoryDAO();
	
	private CategoryDAO(){
		
	}
	
	public static CategoryDAO getInstance() {
		return insCatDAO;
	}
	
	public int insertCat(String code, String cname) {
		int n = 0;
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO category VALUES(category_seq.NEXTVAL, ?, ?)";
		try {
			dbconn = getConnection();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, code);
			pstmt.setString(2, cname);
			n = pstmt.executeUpdate();
			return n;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(dbconn != null) dbconn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}			
		}
		return n;
	} //insertCat
	
	//*****카테고리 목록 가져오기  *****//
	public ArrayList<CategoryDTO> categoryAll() throws SQLException{
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			dbconn = getConnection();
			String sql = "SELECT * FROM category ORDER BY cnum desc";//카테고리를 최신순으로
			pstmt = dbconn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			ArrayList<CategoryDTO> cdtos = new ArrayList<CategoryDTO>();//카테고리를 묶기 위해서
			while(rs.next()) {
				String cnum = rs.getString("cnum");
				String code = rs.getString("code");
				String cname = rs.getString("cname");
				
				CategoryDTO cdto = new CategoryDTO(cnum, code, cname);
				cdtos.add(cdto);
				
			}//while end
			return cdtos;
			
		} finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(dbconn != null) dbconn.close();
		}
	}//categoryAll
	
	public int categoryDelete(String cnum) throws SQLException{
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		
		try {
			dbconn = getConnection();
			String sql = "DELETE FROM category WHERE cnum = ?";
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, cnum);
			int n = pstmt.executeUpdate();
			return n;
		} finally {
			if(pstmt != null) pstmt.close();
			if(dbconn != null) dbconn.close();
		}
	}
	
	private Connection getConnection() {
		Context ctx = null;
		DataSource dataSource = null;
		Connection dbconn = null;
		
		try {
			ctx = new InitialContext();
			dataSource  = (DataSource)ctx.lookup("java:/comp/env/jdbc/myoracle");
			dbconn = dataSource.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dbconn;
		
	}//getConnection
	
	
}
