package com.notsosecure.devsecops.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name = "checkout")
public class Checkout {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private int id;

    @ManyToOne
    private Users user;

    @ManyToOne
    private Products product;

    @Column(name = "address")
    private String address;

    @Column(name = "zipcode")
    private String zipCode;

    @Column(name = "mobile")
    private String mobilePhone;

    @Column(name = "message")
    private String message;

    @Column(name = "creditcard")
    private String creditcard;
    
    @Column(name = "ccexpiry")
    private String ccexpiry;
    
    @Column(name = "ccpin")
    private String ccpin;
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    public Products getProduct() {
        return product;
    }

    public void setProduct(Products products) {
        this.product = products;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

	public String getCreditcard() {
		return creditcard;
	}

	public void setCreditcard(String creditcard) {
		this.creditcard = creditcard;
	}

	public String getCcexpiry() {
		return ccexpiry;
	}

	public void setCcexpiry(String ccexpiry) {
		this.ccexpiry = ccexpiry;
	}

	public String getCcpin() {
		return ccpin;
	}

	public void setCcpin(String ccpin) {
		this.ccpin = ccpin;
	}
    
}
