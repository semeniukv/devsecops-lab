package com.notsosecure.devsecops.actions;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.validation.SkipValidation;

import com.notsosecure.devsecops.dao.manager.impl.CategoryManager;
import com.notsosecure.devsecops.model.Category;
import com.opensymphony.xwork2.validator.annotations.RequiredStringValidator;

public class CategoryAction extends BaseAction {
    /**
	 * 
	 */
	private static final long serialVersionUID = -2192361709298088966L;
	private int id;
    private String categoryName;
    private int parentId;
    private Category category;
    Map<Category, List<Category>> categories;
    private List<Category> allCategories;
    CategoryManager categoryManager = new CategoryManager();


    public String addCategory() {
        category = new Category();
        category.setName(categoryName);
        category.setParent_id(parentId);
        categoryManager.create(category);
        categories = categoryManager.getCategories();
        applicationMap.put("categories", categories);
        return SUCCESS;
    }

    @SkipValidation
    public String delete() {
        category = categoryManager.getEntityByID(id);
        if (category != null) {
            categoryManager.delete(category);
            categories = categoryManager.getCategories();
            applicationMap.put("categories", categories);
            return SUCCESS;
        }
        return INPUT;
    }

    @SkipValidation
    public String view() {
        allCategories = categoryManager.getAll();
        category = categoryManager.getEntityByID(id);
        if (category != null)
            return SUCCESS;
        return INPUT;
    }

    public String update() {
        category = categoryManager.getEntityByID(id);
        if (category != null) {
            category.setName(categoryName);
            category.setParent_id(parentId);
            categoryManager.update(category);
            return SUCCESS;
        }
        return INPUT;
    }


    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    @RequiredStringValidator(message = "please input category name")
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public List<Category> getAllCategories() {
        return allCategories;
    }

    public void setAllCategories(List<Category> allCategories) {
        this.allCategories = allCategories;
    }
}
