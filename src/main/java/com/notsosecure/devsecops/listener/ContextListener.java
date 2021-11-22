package com.notsosecure.devsecops.listener;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.notsosecure.devsecops.dao.manager.impl.BrandManager;
import com.notsosecure.devsecops.dao.manager.impl.CategoryManager;
import com.notsosecure.devsecops.dao.manager.impl.CountryManager;
import com.notsosecure.devsecops.model.Brand;
import com.notsosecure.devsecops.model.Category;
import com.notsosecure.devsecops.model.Country;

public class ContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        CountryManager countryManager = new CountryManager();
        BrandManager brandManager = new BrandManager();
        CategoryManager categoryManager = new CategoryManager();

        List<Country> countries = countryManager.getAll();
        ArrayList<Brand> brands = (ArrayList<Brand>) brandManager.getAll();
        Map<Category, List<Category>> categories = categoryManager.getCategories();
        System.out.println(categories);
        ServletContext servletContext = servletContextEvent.getServletContext();
        servletContext.setAttribute("categories", categories);
        servletContext.setAttribute("brands", brands);
        servletContext.setAttribute("countries", countries);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
