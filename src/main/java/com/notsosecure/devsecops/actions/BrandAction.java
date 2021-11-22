package com.notsosecure.devsecops.actions;


import java.util.List;

import org.apache.struts2.interceptor.validation.SkipValidation;

import com.notsosecure.devsecops.dao.manager.impl.BrandManager;
import com.notsosecure.devsecops.model.Brand;
import com.opensymphony.xwork2.validator.annotations.RequiredStringValidator;

public class BrandAction extends BaseAction {

    /**
	 * 
	 */
	private static final long serialVersionUID = -7562583984626676495L;
	private String brandId;
    private String brandName;
    BrandManager brandManager = new BrandManager();
    private List<Brand> brands;
    private Brand brand;

    public String addBrand() {
        brand = new Brand();
        brand.setName(brandName);
        brandManager.create(brand);
        brands = brandManager.getAll();
        applicationMap.put("brands", brands);
        return SUCCESS;
    }

    @SkipValidation
    public String delete() {
        brand = brandManager.getEntityByID(Integer.parseInt(brandId));
        if (brand != null) {
            brandManager.delete(brand);
            brands = brandManager.getAll();
            applicationMap.put("brands", brands);
            return SUCCESS;
        }
        return ERROR;
    }

    @SkipValidation
    public String view() {
        brand = brandManager.getEntityByID(Integer.parseInt(brandId));
        if (brand != null) {
            return SUCCESS;
        }
        return ERROR;
    }

    public String update() {
        brand = brandManager.getEntityByID(Integer.parseInt(brandId));
        if (brand != null) {
            brand.setName(brandName);
            brandManager.update(brand);
            brands = brandManager.getAll();
            applicationMap.put("brands", brands);
            return SUCCESS;
        }
        return ERROR;
    }

    public Brand getBrand() {
        return brand;
    }


    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public String getBrandId() {
        return brandId;
    }

    public void setBrandId(String brandId) {
        this.brandId = brandId;
    }

    public String getBrandName() {
        return brandName;
    }
    @RequiredStringValidator(message = "Please input brand name")
    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }
}
