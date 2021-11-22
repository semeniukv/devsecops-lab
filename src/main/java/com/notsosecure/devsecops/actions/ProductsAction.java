package com.notsosecure.devsecops.actions;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.validation.SkipValidation;

import com.notsosecure.devsecops.dao.manager.impl.ProductsManager;
import com.notsosecure.devsecops.model.Brand;
import com.notsosecure.devsecops.model.Category;
import com.notsosecure.devsecops.model.Image;
import com.notsosecure.devsecops.model.Products;
import com.notsosecure.devsecops.util.Validator;

public class ProductsAction extends BaseAction {

    /**
	 * 
	 */
	private static final long serialVersionUID = -6827351834162771021L;
	private String brandId;
    private String productId;
    private String name;
    private double price;
    private double minPrice;
    private double maxPrice;
    private String description;
    private Products product;
    private ArrayList<Products> products;
    private ProductsManager productsManager;
    private String categoryId;

    private File[] main;
    private String[] mainContentType;
    private String[] mainFileName;

    public ProductsAction() {
        productsManager = new ProductsManager();
    }

    @Override
    public void validate() {
        if (Validator.isEmpty(name)) addFieldError("name", "please enter name for product");
        if (Validator.isEmpty(description)) addFieldError("description", "description field is required");
        if (!Validator.isNumber(brandId)) addFieldError("brandId", "invalid value for field brand");
        if (!Validator.isNumber(categoryId)) addFieldError("categoryId", "invalid value for field Category");
    }

    @Override
    @SkipValidation
    public String execute() throws Exception {
        products = (ArrayList<Products>) productsManager.getAll();
        return SUCCESS;
    }

    @SkipValidation
    public String getProductsByCatId() {
        products = (ArrayList<Products>) productsManager.getProductByCatId(Integer.parseInt(categoryId));
        return SUCCESS;
    }

    @SkipValidation
    public String getProductsDetails() {
        product = productsManager.getEntityByID(Integer.parseInt(productId));
        return SUCCESS;
    }

    @SkipValidation
    public String getProductsByBrandId() {

        products = (ArrayList<Products>) productsManager.getProductsByBrandId(Integer.parseInt(brandId));

        return SUCCESS;
    }

    @SkipValidation
    public String search() {
        products = (ArrayList<Products>) productsManager.searchProductsByName(name);
        return SUCCESS;

    }

    @SkipValidation
    public String getProductsByPrice() {
        products = (ArrayList<Products>) productsManager.getProductsByPrice(minPrice, maxPrice);
        return SUCCESS;
    }

    private List<Image> fileupload(Products product) {
    	final String relativeWebPath = File.separator+"upload";
    	ServletContext context = ServletActionContext.getServletContext();
    	String absoluteFilePath = context.getRealPath(relativeWebPath);
    	System.out.println(absoluteFilePath);
        String imageName;
        List<Image> images = new ArrayList<>();
        for (int i = 0; i < main.length; i++) {
            File uploadedFile = main[i];
            String fileName = mainFileName[i];
            imageName = fileName;
            try {
                FileUtils.copyFile(uploadedFile, new File(absoluteFilePath, imageName));
            } catch (IOException ex) {
                System.out.println("Could not copy file " + fileName);
                ex.printStackTrace();
            }
            Image image = new Image();
            image.setImageName(fileName);
            image.setPath(imageName);
            image.setProduct(product);
            images.add(image);
        }
        return images;
    }

    public String addProduct() {
        Products newProduct = new Products();
        List<Image> images = fileupload(newProduct);
        newProduct.setName(name);
        newProduct.setPrice(price);
        Brand brand = new Brand();
        brand.setId(Integer.parseInt(brandId));
        newProduct.setBrand(brand);
        Category category = new Category();
        category.setId(Integer.parseInt(categoryId));
        newProduct.setCategory(category);
        newProduct.setDescription(description);
        newProduct.setImageList(images);
        productsManager.create(newProduct);
        return SUCCESS;
    }

    @SkipValidation
    public String delete() {
        product = productsManager.getEntityByID(Integer.parseInt(productId));
        if (product != null) {
            productsManager.delete(product);
            return SUCCESS;
        }
        return ERROR;
    }

    @SkipValidation
    public String view() {
        product = productsManager.getEntityByID(Integer.parseInt(productId));
        if (product != null) return SUCCESS;
        return ERROR;
    }

    public String update() {
        return SUCCESS;
    }

    public ArrayList<Products> getProducts() {
        return products;
    }

    public void setProducts(ArrayList<Products> products) {
        this.products = products;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public Products getProduct() {
        return product;
    }

    public void setProduct(Products product) {
        this.product = product;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public void setBrandId(String brandId) {
        this.brandId = brandId;
    }

    public String getBrandId() {
        return brandId;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public File[] getMain() {
        return main;
    }

    public void setMain(File[] main) {
        this.main = main;
    }

    public String[] getMainContentType() {
        return mainContentType;
    }

    public void setMainContentType(String[] mainContentType) {
        this.mainContentType = mainContentType;
    }

    public String[] getMainFileName() {
        return mainFileName;
    }

    public void setMainFileName(String[] mainFileName) {
        this.mainFileName = mainFileName;
    }

    public void setMaxPrice(double maxPrice) {
        this.maxPrice = maxPrice;
    }

    public void setMinPrice(double minPrice) {
        this.minPrice = minPrice;
    }

    public double getMaxPrice() {
        return maxPrice;
    }

    public double getMinPrice() {
        return minPrice;
    }
}
