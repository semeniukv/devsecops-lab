package com.notsosecure.devsecops.dao.manager.impl;

import java.util.List;

import com.notsosecure.devsecops.dao.impl.BrandDAOImpl;
import com.notsosecure.devsecops.dao.manager.IBrandManager;
import com.notsosecure.devsecops.model.Brand;

public class BrandManager implements IBrandManager {

    BrandDAOImpl brandDAO;

    public BrandManager() {
        brandDAO = new BrandDAOImpl();
    }


    public void create(Brand brand) {
        brandDAO.create(brand);
    }

    public Brand getEntityByID(int id) {
        return brandDAO.getEntityByID(id);
    }

    public List<Brand> getAll() {
        return brandDAO.getAll();
    }

    public void update(Brand entity) {
        brandDAO.update(entity);
    }

    public void delete(Brand entity) {
brandDAO.delete(entity);
    }
}
