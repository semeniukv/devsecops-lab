<%@ taglib prefix="s" uri="/struts-tags" %>
<div class="col-sm-9 padding-right" id="products">
    <div class="features_items"><!--features_items-->
        <h2 class="title text-center">Featured Items</h2>
        <s:iterator value="products">
            <div class="col-sm-4">
                <div class="product-image-wrapper">
                    <div class="single-products">
                        <div class="productinfo text-center">
                            <s:set var="image" value="imageList[0]"/>
                            <img width="100" height="200" src="showImage.action?imageId=<s:property value="#image.path"/>" alt=""/>
                            <h2>$<s:property value="price"/></h2>
                            <p><s:property value="description"/></p>
                            <a href="addToCart.action?productId=<s:property value="id"/>" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
                        </div>
                        <div class="product-overlay">
                            <div class="overlay-content">
                                <h2>$<s:property value="price"/></h2>
                                <p><s:property value="description"/></p>
                                <a href="addToCart.action?productId=<s:property value="id"/>"  class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>
                                Add to cart</a>
                            </div>
                        </div>
                    </div>
                    <div class="choose">
                        <ul class="nav nav-pills nav-justified">
                            <li><a href="addToWhishList.action?productId=<s:property value="id"/>"><i
                                    class="fa fa-plus-square"></i>Add to wishlist</a></li>
                            <li><a href="#"><i class="fa fa-plus-square"></i>Add to compare</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <!--features_items-->
        </s:iterator>
    </div>
</div>