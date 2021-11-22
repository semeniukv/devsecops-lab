package com.notsosecure.devsecops.dao.manager.impl;

import java.util.ArrayList;
import java.util.List;

import com.notsosecure.devsecops.dao.impl.ProductsDAOImpl;
import com.notsosecure.devsecops.dao.impl.WishListDAOImpl;
import com.notsosecure.devsecops.dao.manager.IWishListManager;
import com.notsosecure.devsecops.model.Products;
import com.notsosecure.devsecops.model.WishProduct;

public class WishListManager implements IWishListManager {

    private WishListDAOImpl wishListDAO;
    private ProductsDAOImpl productsDAO;

    public WishListManager() {
        wishListDAO = new WishListDAOImpl();
        productsDAO = new ProductsDAOImpl();
    }

    @Override
    public void create(WishProduct wishProduct) {
        wishListDAO.create(wishProduct);
    }

    @Override
    public WishProduct getEntityByID(int id) {
        return wishListDAO.getEntityByID(id);
    }

    @Override
    public List<WishProduct> getAll() {
        return null;
    }

    @Override
    public void update(WishProduct entity) {

    }

    @Override
    public void delete(WishProduct entity) {

        wishListDAO.delete(entity);
    }

    @Override
    public List<Products> getProductsByUserId(int userId) {
        List<WishProduct> wishProducts = wishListDAO.getProductsFromWishList(userId);
        System.out.println(wishProducts);
        ProductsManager productsManager = new ProductsManager();
        List<Products> products = new ArrayList<>();
        for (WishProduct wishProduct : wishProducts) {
            Products product = productsManager.getEntityByID(wishProduct.getProduct_id());
            products.add(product);
        }
        return products;
    }
}
