package com.notsosecure.devsecops.model;

import javax.persistence.*;


@Entity
@Table(name = "wishlist")
public class WishProduct {

    @Column
    private int user_id;
    @Id
    @Column
    private int product_id;


    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }


    @Override
    public String toString() {
        return "WishProduct{" +
                "product_id=" + product_id +
                ", user_id=" + user_id +
                '}';
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }
}
