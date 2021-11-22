package com.notsosecure.devsecops.dao;

import java.util.List;

import com.notsosecure.devsecops.model.Cart;

public interface ICartDAO extends GenericDAO<Cart> {
    List<Cart> getProductsFromCart(int id);
    
    
}
