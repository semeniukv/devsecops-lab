package com.notsosecure.devsecops.dao;

import java.util.List;

public interface GenericDAO<E> {

    void create(E e);

    E getEntityByID(int id);

    List<E> getAll();

    void update(E entity);

    void delete(E entity);

}
