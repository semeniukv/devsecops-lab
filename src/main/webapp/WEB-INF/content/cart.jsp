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
                    <td></td>
                    <td class="price">Description</td>
                    <td class="price">Price</td>
                    <td class="quantity">Quantity</td>
                    <td class="total">Total</td>
                    <td></td>
                </tr>
                </thead>

                <s:iterator value="products">
                    <tr>
                        <td class="cart_product" width="20%">
                         <s:set var="image" value="imageList[0]"/>
                            <img width="75" height="125" src="showImage.action?imageId=<s:property value="#image.path"/>" alt=""/>
                        </td>
                        <td></td>
                        <td class="cart_description">
                            <h5><a href=""><s:property value="name"/> </a></h5>
                            <p>Web ID: <s:property value="id"/></p>
                        </td>
                        <td class="cart_price">
                            <p>$<s:property value="price"/></p>
                        </td>
                         <td class="cart_quantity">
                             <div class="cart_quantity_button">
                                 <input id="count_<s:property value="id"/>" class="cart_quantity_input" type="number" min="1" name="quantity" value="1"
                                        autocomplete="off" size="2" onchange="increase(<s:property value="price"/>,<s:property value="id"/>)"/>
                                 <input id="productId" name="productId" type="hidden" value="<s:property value="id"/>">
                             </div>
                         </td>
                          <td class="cart_total">
                              <input id="total_<s:property value="id"/>" type="text" value="" readonly="true" />
                          </td>
                        <td class="cart_delete" style="margin-left: 15px">
                            <a class="cart_quantity_delete"
                               href="deleteCart.action?productId=<s:property value="id"/> "><i class="fa fa-times"></i></a>
                        </td>
                    </tr>
                </s:iterator>

            </table>
        </div>
    </div>
</section>

<!--/#cart_items-->

<section id="do_action">
    <div class="container">       
        <div class="row">
            <div class="col-sm-4">
                <div class="signup-form"><!--sign up form-->
                    <h2>Order Details </h2>
                    <form action="checkout.action" method="post">
                        <s:textfield name="creditcard" placeholder="Credit Card"/>
                        <s:textfield name="ccexpiry" placeholder="Credit Card Expiry"/>
                        <s:password name="ccpin" placeholder="Pin"/>
                        <s:textarea name="address" placeholder="Address"/>
                        <br/>
                        <br/>
                        <button type="submit" class="btn btn-default">Order</button>
                    </form>
                </div><!--/sign up form-->
            </div>
        </div>
    </div>
</section>
