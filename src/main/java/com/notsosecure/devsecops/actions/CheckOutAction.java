package com.notsosecure.devsecops.actions;

public class CheckOutAction extends BaseAction {
    /**
	 * 
	 */
	private static final long serialVersionUID = -3264388473010827844L;
	private String creditcard;
    private String ccexpiry;
    private String ccpin;
    private String address;
    private String zipCode;
    private String mobilePhone;
    private String message;

    private String productId;

    @Override
    public String execute() throws Exception {
//    	Users user = (Users)sessionMap.get(USER_HANDLE) ;
//    	Checkout checkout = new Checkout();
//        IProductsManager productsManager= new ProductsManager();
//        ICheckoutManager checkoutManager= new CheckoutManager();
//        checkout.setUser(user);
//        checkout.setProduct(productsManager.getEntityByID(Integer.parseInt(productId)));
//        checkout.setAddress(address);
//        checkout.setZipCode(zipCode);
//        checkout.setMobilePhone(mobilePhone);
//        checkout.setMessage(message);
//        checkout.setCreditcard(creditcard);
//        checkout.setCcexpiry(ccexpiry);
//        checkout.setCcpin(ccpin);
//        checkoutManager.create(checkout);
    	message="Your Order has been placed !";
        return SUCCESS;
    }

    public String view() {

        return SUCCESS;
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

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

}
