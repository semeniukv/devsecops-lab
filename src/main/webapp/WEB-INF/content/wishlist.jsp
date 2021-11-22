<%@ taglib prefix="s" uri="/struts-tags" %>
<section id="cart_items">
    <div class="container">
        <div class="breadcrumbs">
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li class="active">Shopping Cart</li>
            </ol>
        </div>
        <div class="table-responsive cart_info">
            <table class="table table-condensed">
                <thead>
                <tr class="cart_menu">
                    <td class="image">Item</td>
                    <td class="description"></td>
                    <td class="price">Price</td>
                    <td class="quantity">Quantity</td>
                    <td class="total">Total</td>
                    <td></td>
                </tr>
                </thead>
                <tbody>
                <s:iterator value="products">

                    <tr>
                        <td class="cart_product">
                            <a href=""><img src="images/cart/one.png" alt=""></a>
                        </td>
                        <td class="cart_description">
                            <h4><a href=""><s:property value="description"/> </a></h4>
                            <p>Web ID: <s:property value="id"/></p>
                        </td>
                        <td class="cart_price">
                            <p>$<s:property value="price"/></p>
                        </td>
                        <td class="cart_quantity">
                            <div class="cart_quantity_button">
                                <a class="cart_quantity_up" href=""> + </a>
                                <input class="cart_quantity_input" type="text" name="quantity" value="1"
                                       autocomplete="off"
                                       size="2">
                                <a class="cart_quantity_down" href=""> - </a>
                            </div>
                        </td>
                        <td class="cart_total">
                            <p class="cart_total_price">$59</p>
                        </td>
                        <td class="cart_delete">
                            <a class="cart_quantity_delete"
                               href="deleteFromWishList?productId=<s:property value="id"/>"><i class="fa fa-times"></i></a>
                        </td>
                    </tr>
                </s:iterator>

                </tbody>
            </table>
        </div>
    </div>
</section>
<!--/#cart_items-->