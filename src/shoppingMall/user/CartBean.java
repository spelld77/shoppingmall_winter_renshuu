package shoppingMall.user;

import java.util.Vector;

import shoppingMall.ProductDTO;

public class CartBean {
	private Vector<ProductDTO> cartList;
	
	public CartBean() {
		cartList = new Vector<ProductDTO>(3, 1);
	} //기본 생성자
}
