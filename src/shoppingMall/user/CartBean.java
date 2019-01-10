package shoppingMall.user;

import java.util.Vector;

import shoppingMall.ProductDTO;

public class CartBean {
	private Vector<ProductDTO> cartList;
	
	public CartBean() {
		cartList = new Vector<ProductDTO>(3, 1);
	} //기본 생성자
	
	//** 장바구니에 상품을 추가하는 모듈 **//
	public void addProd(ProdListDAO pdao, String pnum, String pqty, String pspec) {
		//장바구니에 있는 경우(수량만 추가)
		
		int addPqty = Integer.parseInt(pqty.trim()); //추가할 수량
		
		for(ProductDTO pd : cartList) {
				if(pnum.equals(pd.getPnum())){ //상품번호가 장바구니에 있을 때
					pd.setPqty(pd.getPqty() + addPqty);
				}//if
		}//for
		
		//장바구니에 추가할 상품이 없는 경우 (새로 추가하는 경우)
		ProductDTO pdto = pdao.getProduct(pnum, pspec);//상품 번호로 해시테이블 정보를 가져온다
		if(pdto != null) {
			pdto.setPqty(addPqty);//수량
			cartList.add(pdto);//장바구니에 상품 추가
		}
	}//addProd()
	
	//장바구니에 있는 모든 상품 리스트를 가져오는 모듈
	public Vector<ProductDTO> getAllProducts(){
		return cartList;
	}//getAllProducts()
}
