package com.notsosecure.devsecops.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "apps_countries")
public class Country {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private int id;
    @Column(name = "country_code")
    private String countryCode;

    @Column(name = "country_name")
    private String countryName;

    public String getCountryCode() {
        return countryCode;
    }

    public String getCountryName() {
        return countryName;
    }

    public void setCountryName(String countryName) {
        this.countryName = countryName;
    }

    public int getId() {
        return id;
    }

    @Override
    public String toString() {
        return "Country{" +
                "countryCode='" + countryCode + '\'' +
                ", id=" + id +
                ", countryName='" + countryName + '\'' +
                '}';
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }
}
