package com.notsosecure.devsecops.actions;

import java.util.List;
import java.util.Map;

import com.notsosecure.devsecops.dao.manager.impl.CategoryManager;
import com.notsosecure.devsecops.model.Category;

public class AdminAction extends BaseAction {
    /**
	 * 
	 */
	private static final long serialVersionUID = -5350748487824777637L;
	private List<Category> allCategories;
    private Map<Category, List<Category>> categories;
    CategoryManager categoryManager = new CategoryManager();

    @Override
    public String execute() throws Exception {
        categories = categoryManager.getCategories();
        allCategories = categoryManager.getAll();
        return SUCCESS;
    }

    public List<Category> getAllCategories() {
        return allCategories;
    }

    public void setAllCategories(List<Category> allCategories) {
        this.allCategories = allCategories;
    }

    public Map<Category, List<Category>> getCategories() {
        return categories;
    }

    public void setCategories(Map<Category, List<Category>> categories) {
        this.categories = categories;
    }
}
