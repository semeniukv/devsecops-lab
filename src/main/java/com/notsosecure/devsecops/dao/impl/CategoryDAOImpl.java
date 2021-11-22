package com.notsosecure.devsecops.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import com.notsosecure.devsecops.dao.ICategoryDAO;
import com.notsosecure.devsecops.model.Category;
import com.notsosecure.devsecops.util.HibernateUtils;

public class CategoryDAOImpl implements ICategoryDAO {
    Session session = HibernateUtils.getSessionFactory().openSession();

    public void create(Category category) {
        session.beginTransaction();
        session.save(category);
        session.getTransaction().commit();
    }

    public Category getEntityByID(int id) {
        return (Category) session.get(Category.class, id);
    }

    public List<Category> getAll() {
        return session.createCriteria(Category.class).list();
    }

    public void update(Category entity) {
        session.beginTransaction();
        session.update(entity);
        session.getTransaction().commit();
    }

    public void delete(Category entity) {
        session.beginTransaction();
        session.delete(entity);
        session.getTransaction().commit();
    }

    public List<Category> getCategoriesByParentId(int id) {
        return (List<Category>) session.createCriteria(Category.class).add(Restrictions.eq("parent_id", id)).list();
    }
}
