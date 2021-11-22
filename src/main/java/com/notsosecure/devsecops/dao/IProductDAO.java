package com.notsosecure.devsecops.dao;

import java.util.List;

import com.notsosecure.devsecops.model.Products;

public interface IProductDAO extends GenericDAO<Products> {
    List<Products> getProductByCatId(int id);

    List<Products> getProductsByBrandId(int id);

    List<Products> searchProductsByName(String name);

    List<Products> getProductsByPrice(double minPrice, double maxPrice);
}
