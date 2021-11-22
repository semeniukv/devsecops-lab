package com.notsosecure.devsecops.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import com.notsosecure.devsecops.dao.IUserDAO;
import com.notsosecure.devsecops.model.Users;
import com.notsosecure.devsecops.util.HibernateUtils;

public class UserDAOImpl implements IUserDAO {
    private Session session;

    public UserDAOImpl() {
        session = HibernateUtils.getSessionFactory().openSession();
    }

    public void create(Users users) {
        session.beginTransaction();
        session.save(users);
        session.getTransaction().commit();
    }

    public Users getEntityByID(int id) {
        return null;
    }

    public List<Users> getAll() {
        return null;
    }

    public void update(Users entity) {
    	session.beginTransaction();
    	session.update(entity);
    	session.getTransaction().commit();
    }

    public void delete(Users entity) {

    }

    public Users getUserByEmailAndPassword(String email, String password) {

        return (Users) session.createCriteria(Users.class).add(Restrictions.eq("email", email)).add(Restrictions.eq("password", password)).uniqueResult();


    }
}
