package com.notsosecure.devsecops.dao.manager;

import java.util.List;

import com.notsosecure.devsecops.model.Cart;
import com.notsosecure.devsecops.model.Products;

public interface ICartManager extends ManagerGeneric<Cart>{
    List<Products> getProductsByUserId(int id);
}
