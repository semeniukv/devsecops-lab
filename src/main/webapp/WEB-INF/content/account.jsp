<%@ taglib prefix="s" uri="/struts-tags" %>
<section id="cart_items">
    <div class="container">
        <div class="breadcrumbs">
            <ol class="breadcrumb">
                <li><a href="home.action">Home</a></li>
                <li class="active">Account Update</li>
            </ol>
        </div><!--/breadcrums-->

        <div class="shopper-informations">
            <div class="row">
                <div class="col-sm-12 clearfix">
                    <div class="bill-to">
                        <p>Account Details</p>
                        <div class="form-one">
                            <form action="accountUpdate.action" method="post">
                                <s:textfield name="email" placeholder="Email*" />
                                <s:textfield name="name" placeholder="Name *" />
                                <s:password name="password" placeholder="Password *" />
                                <input type="submit" class="btn btn-primary" value="Update"/>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section> <!--/#cart_items-->