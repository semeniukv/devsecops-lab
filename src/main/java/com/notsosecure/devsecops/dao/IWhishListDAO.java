package com.notsosecure.devsecops.dao;

import java.util.List;

import com.notsosecure.devsecops.model.WishProduct;

public interface IWhishListDAO extends GenericDAO<WishProduct> {
    List<WishProduct> getProductsFromWishList(int userId);
}
