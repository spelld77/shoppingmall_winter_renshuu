package shoppingMall;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AdminDAO {
	public static final int ADMIN_NONEXISTENT = 0; 	
	public static final int ADMIN_EXIST = 1; 	
	public static final int ADMIN_LOGIN_PW_FAIL = 0; 	
	public static final int ADMIN_LOGIN_SUCCESS = 1; 	
	public static final int ADMIN_LOGIN_NOT = -1; //No registered
	
	private static AdminDAO insAdmin = new AdminDAO();
	
	private AdminDAO() {
		
	}
	
	public static AdminDAO getInstance() {
		return insAdmin;
	}
	
	private Connection getConnection() {
		Context initContext = null;
		DataSource dataSource = null;
		Connection dbconn = null;
		
		try {
			initContext = new InitialContext();
			dataSource = (DataSource)initContext.lookup("java:comp/env/jdbc/myoracle");
			dbconn = dataSource.getConnection();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dbconn;
	}
	
	public int adminCheck(String id, String pwd) {
		int n = 0;
		String dbPw; //real password
		
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		String sql = "SELECT password from admin WHERE id = ?";
		
		try {
			dbconn = getConnection();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbPw = rs.getString("password");
//				System.out.println("dbpw:" + dbPw);
//				System.out.println("pwd:" + pwd);
				if(dbPw.equals("pwd")) { //compare real password and user input
					n = AdminDAO.ADMIN_LOGIN_SUCCESS; 
				} else {
					n = AdminDAO.ADMIN_LOGIN_PW_FAIL; // Wrong password
				}
			} else { 
				n = AdminDAO.ADMIN_LOGIN_NOT; //No registered
			}
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null)pstmt.close();
				if(dbconn != null) dbconn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return n;
 	
	} //adminCheck
	
	public AdminDTO getAdmin(String id) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM admin WHERE id = ?";
		AdminDTO adto = null;
		
		try {
			dbconn = getConnection();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
//			System.out.println("before rs.next");
			if(rs.next()) {
//				System.out.println("in next");
				adto = new AdminDTO();
				adto.setId(rs.getString("id"));
				adto.setPw(rs.getString("password"));
				adto.setName(rs.getString("name"));
				adto.setEmail("email");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(dbconn != null) dbconn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return adto;
	} //getAdmin
}
