package com.notsosecure.devsecops.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.notsosecure.devsecops.dao.IBrandDAO;
import com.notsosecure.devsecops.model.Brand;
import com.notsosecure.devsecops.util.HibernateUtils;

public class BrandDAOImpl implements IBrandDAO {

    Session session = HibernateUtils.getSessionFactory().openSession();

    public void create(Brand brand) {
        session.beginTransaction();
        session.save(brand);
        session.getTransaction().commit();
    }

    public Brand getEntityByID(int id) {
        return (Brand) session.get(Brand.class, id);
    }

    @SuppressWarnings("unchecked")
	public List<Brand> getAll() {
        return session.createCriteria(Brand.class).list();
    }

    public void update(Brand entity) {
        session.beginTransaction();
        session.update(entity);
        session.getTransaction().commit();
    }

    public void delete(Brand entity) {
        session.beginTransaction();
        session.delete(entity);
        session.getTransaction().commit();
    }
}
