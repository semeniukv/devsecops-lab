package com.notsosecure.devsecops.actions;

import java.util.ArrayList;

import com.notsosecure.devsecops.dao.manager.impl.ProductsManager;
import com.notsosecure.devsecops.model.Products;

public class HomeAction extends BaseAction {

    /**
	 * 
	 */
	private static final long serialVersionUID = -392700917707638793L;

	private ArrayList<Products> products;

    private ProductsManager productsManager;
    private String message ;
    
    public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public HomeAction() {
        productsManager = new ProductsManager();

    }

    @Override
    public String execute() throws Exception {
        products = (ArrayList<Products>) productsManager.getAll();
        return SUCCESS;
    }

    public ArrayList<Products> getProducts() {
        return products;
    }

    public void setProducts(ArrayList<Products> products) {
        this.products = products;
    }


}
