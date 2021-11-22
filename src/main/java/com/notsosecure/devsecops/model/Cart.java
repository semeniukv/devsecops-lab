package com.notsosecure.devsecops.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "cart")
public class Cart {
    @Id
    @Column
    private int product_id;


    @Column
    private int user_id;

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "product_id=" + product_id +
                ", user_id=" + user_id +
                '}';
    }
}
