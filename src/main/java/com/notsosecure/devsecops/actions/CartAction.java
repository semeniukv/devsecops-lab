package com.notsosecure.devsecops.actions;

import java.util.List;

import com.notsosecure.devsecops.dao.impl.CartManager;
import com.notsosecure.devsecops.model.Cart;
import com.notsosecure.devsecops.model.Products;
import com.notsosecure.devsecops.model.Users;

public class CartAction extends BaseAction {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1717637550857716017L;
	private List<Cart> cartList;
    private String productId;
    private List<Products> products;

    CartManager cartManager = new CartManager();

    @Override
    public String execute() throws Exception {
        Users user = (Users) sessionMap.get(USER_HANDLE);
        products = cartManager.getProductsByUserId(user.getId());
        return SUCCESS;
    }

    public String addToCart() {
    	sessionMap.put("successMessage","");
        Cart cart = new Cart();
        Users user = (Users) sessionMap.get(USER_HANDLE);
        if (user != null) {
            cart.setProduct_id(Integer.parseInt(productId));
            cart.setUser_id(user.getId());
            cartManager.create(cart);
            return SUCCESS;
        }
        return ERROR;
    }

    public String deleteFromCart() {
        Cart cart = cartManager.getEntityByID(Integer.parseInt(productId));

        if (cart != null) {
            cartManager.delete(cart );
            return SUCCESS;
        }
        return ERROR;
    }

    public String getProductId() {
        return productId;
    }

    public void  setProductId(String productId) {
        this.productId = productId;
    }

    public List<Cart> getCartList() {
        return cartList;
    }

    public void setCartList(List<Cart> cartList) {
        this.cartList = cartList;
    }

    public List<Products> getProducts() {
        return products;
    }

    public void setProducts(List<Products> products) {
        this.products = products;
    }
}
