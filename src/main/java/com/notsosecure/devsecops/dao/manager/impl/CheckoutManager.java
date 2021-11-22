package com.notsosecure.devsecops.dao.manager.impl;

import java.util.List;

import com.notsosecure.devsecops.dao.ICheckoutDAO;
import com.notsosecure.devsecops.dao.impl.CheckoutDAOImpl;
import com.notsosecure.devsecops.dao.manager.ICheckoutManager;
import com.notsosecure.devsecops.model.Checkout;

public class CheckoutManager implements ICheckoutManager {
    private ICheckoutDAO checkoutDAO;

    public CheckoutManager(){
        checkoutDAO= new CheckoutDAOImpl();

    }

    @Override
    public void create(Checkout checkout) {
        checkoutDAO.create(checkout);
    }

    @Override
    public Checkout getEntityByID(int id) {
        return checkoutDAO.getEntityByID(id);
    }

    @Override
    public List<Checkout> getAll() {
        return checkoutDAO.getAll();
    }

    @Override
    public void update(Checkout entity) {
        checkoutDAO.update(entity);
    }

    @Override
    public void delete(Checkout entity) {
        checkoutDAO.delete(entity);
    }
}
