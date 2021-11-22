package com.notsosecure.devsecops.actions;

import java.util.List;

import com.notsosecure.devsecops.dao.manager.impl.WishListManager;
import com.notsosecure.devsecops.model.Products;
import com.notsosecure.devsecops.model.Users;
import com.notsosecure.devsecops.model.WishProduct;

public class WishListAction extends BaseAction {

    /**
	 * 
	 */
	private static final long serialVersionUID = -3849671372104196200L;
	private String productId;
    private WishProduct wishProduct;
    private List<Products> products;

    WishListManager wishListManager = new WishListManager();


    public String addToWishList() {
        Users user = (Users) sessionMap.get(USER_HANDLE);
        int userId = user.getId();
        wishProduct = wishListManager.getEntityByID(Integer.parseInt(productId));
        if (wishProduct != null) return INPUT;
        wishProduct = new WishProduct();
        wishProduct.setProduct_id(Integer.parseInt(productId));
        wishProduct.setUser_id(userId);
        wishListManager.create(wishProduct);
        return SUCCESS;
    }

    public String viewWishList() {
        Users user = (Users) sessionMap.get(USER_HANDLE);
        int userId = user.getId();
        products = wishListManager.getProductsByUserId(userId);
        if (products == null) return ERROR;
        return SUCCESS;
    }

    public String deleteFromWishList() {
        wishProduct = wishListManager.getEntityByID(Integer.parseInt(productId));
        if (wishProduct == null) {
            return ERROR;
        }
        wishListManager.delete(wishProduct);
        return SUCCESS;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public WishProduct getWishProduct() {
        return wishProduct;
    }

    public void setWishProduct(WishProduct wishProduct) {
        this.wishProduct = wishProduct;
    }

    public List<Products> getProducts() {
        return products;
    }

    public void setProducts(List<Products> products) {
        this.products = products;
    }
}
