package com.notsosecure.devsecops.model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "product")
public class Products {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private int id;

    @Column
    private String name;
    @Column
    private String description;
    @Column
    private double price;

    @ManyToOne
    private Category category;

    @ManyToOne
    private Brand brand;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "product")
    private List<Image> imageList;


    @Override
    public String toString() {
        return "Products{" +
                ", id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                '}';
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public List<Image> getImageList() {
        return imageList;
    }
    public void setImageList(List<Image> imageList) {
        this.imageList = imageList;
    }
}
