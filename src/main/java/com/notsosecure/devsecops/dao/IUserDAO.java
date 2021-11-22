package com.notsosecure.devsecops.dao;

import com.notsosecure.devsecops.model.Users;

public interface IUserDAO extends GenericDAO<Users> {

    Users getUserByEmailAndPassword(String email, String password);

}
