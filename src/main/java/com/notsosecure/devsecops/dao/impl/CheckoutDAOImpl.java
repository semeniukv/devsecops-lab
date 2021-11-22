package com.notsosecure.devsecops.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.notsosecure.devsecops.dao.ICheckoutDAO;
import com.notsosecure.devsecops.model.Checkout;
import com.notsosecure.devsecops.util.HibernateUtils;

public class CheckoutDAOImpl implements ICheckoutDAO {
    private Session session;

    public CheckoutDAOImpl() {
        session = HibernateUtils.getSessionFactory().openSession();
    }

    @Override
    public void create(Checkout checkout) {
        session.beginTransaction();
        session.save(checkout);
        session.getTransaction().commit();
    }

    @Override
    public Checkout getEntityByID(int id) {
        return (Checkout) session.get(Checkout.class,id);
    }

    @Override
    public List<Checkout> getAll() {
        return session.createCriteria(Checkout.class).list();
    }

    @Override
    public void update(Checkout entity) {
        session.beginTransaction();
        session.update(entity);
        session.getTransaction().commit();
    }

    @Override
    public void delete(Checkout entity) {
        session.beginTransaction();
        session.delete(entity);
        session.getTransaction().commit();
    }
}
