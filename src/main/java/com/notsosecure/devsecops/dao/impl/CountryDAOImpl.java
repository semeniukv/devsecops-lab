package com.notsosecure.devsecops.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.notsosecure.devsecops.dao.ICountryDAO;
import com.notsosecure.devsecops.model.Country;
import com.notsosecure.devsecops.util.HibernateUtils;

public class CountryDAOImpl implements ICountryDAO {
    Session session = HibernateUtils.getSessionFactory().openSession();

    @Override
    public void create(Country country) {

    }

    @Override
    public Country getEntityByID(int id) {
        return (Country) session.get(Country.class, id);
    }

    @Override
    public List<Country> getAll() {
        return session.createCriteria(Country.class).list();
    }

    @Override
    public void update(Country entity) {

    }

    @Override
    public void delete(Country entity) {

    }
}
