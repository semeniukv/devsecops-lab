package com.notsosecure.devsecops.model;

import javax.persistence.*;

@Entity
@Table(name = "images")
public class Image {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private int id;
    @Column(name = "name")
    private String imageName;
    @Column(name = "path")
    private String path;

    @ManyToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH}, fetch = FetchType.EAGER)
    @JoinColumn(name = "product_id")
    private Products product;

    public Image() {
    }

    public Image(String imageName, String path, Products product) {
        this.imageName = imageName;
        this.path = path;
        this.product = product;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Products getProduct() {
        return product;
    }

    public void setProduct(Products product) {
        this.product = product;
    }

    @Override
    public String toString() {
        return "Image{" +
                "id=" + id +
                ", imageName='" + imageName + '\'' +
                ", path='" + path + '\'' +
                ", product=" + product +
                '}';
    }
}
