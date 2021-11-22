package com.notsosecure.devsecops.dao.impl;

import java.util.ArrayList;
import java.util.List;

import com.notsosecure.devsecops.dao.ICartDAO;
import com.notsosecure.devsecops.dao.manager.ICartManager;
import com.notsosecure.devsecops.dao.manager.impl.ProductsManager;
import com.notsosecure.devsecops.model.Cart;
import com.notsosecure.devsecops.model.Products;

public class CartManager implements ICartManager {

    ICartDAO cartDAO = new CartDAOImpl();

    @Override
    public void create(Cart cart) {
        cartDAO.create(cart);
    }

    @Override
    public Cart getEntityByID(int id) {
        return cartDAO.getEntityByID(id);
    }

    @Override
    public List<Cart> getAll() {
        return cartDAO.getAll();
    }

    @Override
    public void update(Cart entity) {

    }

    @Override
    public void delete(Cart entity) {
        cartDAO.delete(entity);
    }

    @Override
    public List<Products> getProductsByUserId(int id) {
        List<Cart> cartProducts = cartDAO.getProductsFromCart(id);
        ProductsManager productsManager = new ProductsManager();
        List<Products> products = new ArrayList<>();
        for (Cart cart : cartProducts) {
            Products product = productsManager.getEntityByID(cart.getProduct_id());
            products.add(product);
        }
        return products;
    }
}
