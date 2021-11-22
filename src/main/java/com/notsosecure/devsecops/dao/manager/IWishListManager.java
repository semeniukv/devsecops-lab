package com.notsosecure.devsecops.dao.manager;

import java.util.List;

import com.notsosecure.devsecops.model.Products;
import com.notsosecure.devsecops.model.WishProduct;

public interface IWishListManager extends ManagerGeneric<WishProduct> {
    List<Products> getProductsByUserId(int userId);
}
