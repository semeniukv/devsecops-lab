package com.notsosecure.devsecops.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import com.notsosecure.devsecops.dao.IWhishListDAO;
import com.notsosecure.devsecops.model.WishProduct;
import com.notsosecure.devsecops.util.HibernateUtils;

public class WishListDAOImpl implements IWhishListDAO {
    Session session = HibernateUtils.getSessionFactory().openSession();

    @Override
    public void create(WishProduct wishProduct) {
        session.beginTransaction();
        session.save(wishProduct);
        session.getTransaction().commit();
    }

    @Override
    public WishProduct getEntityByID(int id) {
        return (WishProduct) session.createCriteria(WishProduct.class).add(Restrictions.eq("product_id", id)).uniqueResult();
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
        session.beginTransaction();
        session.delete(entity);
        session.getTransaction().commit();
    }

    @Override
    public List<WishProduct> getProductsFromWishList(int userId) {
        return session.createCriteria(WishProduct.class).add(Restrictions.eq("user_id", userId)).list();
    }
}
