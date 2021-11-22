package com.notsosecure.devsecops.dao.manager;

import com.notsosecure.devsecops.model.Users;

public interface IUserManager extends ManagerGeneric<Users> {

    Users getUserByEmailAndPassword(String email, String password);
}
