package com.notsosecure.devsecops.dao.manager.impl;

import java.util.List;

import com.notsosecure.devsecops.dao.impl.CountryDAOImpl;
import com.notsosecure.devsecops.dao.manager.ICountryManager;
import com.notsosecure.devsecops.model.Country;

public class CountryManager implements ICountryManager {
    CountryDAOImpl countryDAO = new CountryDAOImpl();

    @Override
    public void create(Country country) {

    }

    @Override
    public Country getEntityByID(int id) {
        return countryDAO.getEntityByID(id);
    }

    @Override
    public List<Country> getAll() {
        return countryDAO.getAll();
    }

    @Override
    public void update(Country entity) {

    }

    @Override
    public void delete(Country entity) {

    }
}
