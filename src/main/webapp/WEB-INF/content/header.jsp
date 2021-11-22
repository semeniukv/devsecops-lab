<%@ taglib prefix="s" uri="/struts-tags" %>
<div class="header_top"><!--header_top-->
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <div class="contactinfo">
                    <ul class="nav nav-pills">
                        <li><a href="#"><i class="fa fa-phone"></i>&nbsp;+91 911911911911</a></li>
                        <li><a href="#"><i class="fa fa-envelope"></i>&nbsp;training@notsosecure.com</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="social-icons pull-right">
                    <ul class="nav navbar-nav">
                        <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                        <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                        <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                        <li><a href="#"><i class="fa fa-dribbble"></i></a></li>
                        <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!--/header_top-->

<div class="header-middle"><!--header-middle-->
    <div class="container">
        <div class="row">
            <div class="col-sm-4">
                <div class="logo pull-left">
                    <a href="home.action"><img src="images/home/logo.png" alt=""/></a>
                </div>
                <div class="btn-group pull-right">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default dropdown-toggle usa" data-toggle="dropdown">
                            UK
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a href="#">France</a></li>
                            <li><a href="#">Germany</a></li>
                        </ul>
                    </div>

                    <div class="btn-group">
                        <button type="button" class="btn btn-default dropdown-toggle usa" data-toggle="dropdown">
                            Pound
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a href="#">Euro</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="shop-menu pull-right">
                    <ul class="nav navbar-nav">
                        <li><a href="#">Welcome <s:property value="#session.user.name"/> </a></li>
                        <li><a href="accountView.action"><i class="fa fa-user"></i> Account</a></li>
                        <li><a href="viewWishList.action"><i class="fa fa-star"></i>Wishlist</a></li>
                        <li><a href="checkoutView.action"><i class="fa fa-crosshairs"></i> Checkout</a></li>
                        <li><a href="cart.action"><i class="fa fa-shopping-cart"></i> Cart</a></li>
                        <s:if test="%{#session.user == null }">
                            <li><a href="view.action"><i class="fa fa-lock"></i> Login</a></li>
                        </s:if>
                        <s:elseif test="%{#session.user!=null }">
                            <li><a href="logout.action"><i class="fa fa-lock"></i> Log out</a></li>
                        </s:elseif>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<s:if test="%{message!=null}">
 <div class="alert alert-success">
  <strong> <s:property value="message" /> </strong>
</div>
 </s:if>
<!--/header-middle-->
<div class="header-bottom"><!--header-bottom-->
    <div class="container">
        <div class="row">
            <div class="col-sm-9">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                <div class="mainmenu pull-left">
                    <ul class="nav navbar-nav collapse navbar-collapse">
                        <li><a href="home.action" class="active">Home</a></li>
                        <li class="dropdown"><a href="#">Shop<i class="fa fa-angle-down"></i></a>
                            <ul role="menu" class="sub-menu">
                                <li><a href="products.action">Products</a></li>
                                <li><a href="productDetails.action">Product Details</a></li>
                                <li><a href="checkout.action">Checkout</a></li>
                                <li><a href="cart.action">Cart</a></li>
                                <li><a href="view.action">Login</a></li>
                            </ul>
                        </li>
                        <li class="dropdown"><a href="#">Blog<i class="fa fa-angle-down"></i></a>
                            <ul role="menu" class="sub-menu">
                                <li><a href="blog.action">Blog List</a></li>
                                <li><a href="blog-single.html">Blog Single</a></li>
                            </ul>
                        </li>
                        <li><a href="viewContact.action">Contact</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="search_box pull-right">
                    <input type="text" placeholder="Search" onchange="search()" id="search"/>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function search() {
        var name = $("#search").val();
        console.log(name)
        if (name != "") {
            $.ajax({
                url: "search.action",
                async: false,
                method: "Post",
                data: {name: name},
                success: function (result) {
                    console.log(result)
                    $("#products").html(result);

                }
            })
        }
    }
</script>
<!--/header-bottom-->
