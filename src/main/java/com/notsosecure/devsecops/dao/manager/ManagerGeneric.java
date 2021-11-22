package com.notsosecure.devsecops.dao.manager;

import java.util.List;

public interface ManagerGeneric<E> {

    void create(E e);

    E getEntityByID(int id);

    List<E> getAll();

    void update(E entity);

    void delete(E entity);

}
