package com.notsosecure.devsecops.dao.manager.impl;

import java.util.List;

import com.notsosecure.devsecops.dao.IUserDAO;
import com.notsosecure.devsecops.dao.impl.UserDAOImpl;
import com.notsosecure.devsecops.dao.manager.IUserManager;
import com.notsosecure.devsecops.model.Users;

public class UserManager implements IUserManager {

    private IUserDAO userDAO = new UserDAOImpl();

    public void create(Users user) {
        userDAO.create(user);
    }

    public Users getEntityByID(int id) {
        return null;
    }

    public List<Users> getAll() {
        return null;
    }

    public void update(Users entity) {
    	userDAO.update(entity);
    }

    public void delete(Users entity) {

    }

    public Users getUserByEmailAndPassword(String email, String password) {
        return userDAO.getUserByEmailAndPassword(email, password);

    }

}
