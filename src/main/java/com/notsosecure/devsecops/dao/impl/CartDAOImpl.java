package com.notsosecure.devsecops.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import com.notsosecure.devsecops.dao.ICartDAO;
import com.notsosecure.devsecops.model.Cart;
import com.notsosecure.devsecops.util.HibernateUtils;

public class CartDAOImpl implements ICartDAO {

    Session session = HibernateUtils.getSessionFactory().openSession();

    @Override
    public void create(Cart cart) {
        session.beginTransaction();
        session.save(cart);
        session.getTransaction().commit();
    }

    @Override
    public Cart getEntityByID(int id) {
        return (Cart) session.get(Cart.class,id);
    }

    @Override
    public List<Cart> getAll() {
        return session.createCriteria(Cart.class).list();
    }

    @Override
    public void update(Cart entity) {

    }

    @Override
    public void delete(Cart entity) {
        session.beginTransaction();
        session.delete(entity);
        session.getTransaction().commit();
    }

    @Override
    public List<Cart> getProductsFromCart(int id) {
        return session.createCriteria(Cart.class).add(Restrictions.eq("user_id", id)).list();
    }
}
