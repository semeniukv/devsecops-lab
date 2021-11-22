<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Admin page</title>
    <script src="js/jquery.js"></script>
</head>
<body>
<div id="mainDiv" style="width: 1200px; padding:5%">
    <div id="categoryDiv" style="width: 40%;float: left;border: 1px">
        <s:if test="%{category==null }">
            <div id="addCategory">
                <h4>Add category</h4>
                <s:form action="addCategory" method="POST">
                    <s:textfield name="categoryName" label="Category name"/>
                    <s:select list="%{#application.categories}" label="parent category"
                              headerKey="0" headerValue="------"
                              listKey="key.id" listValue="key.name"/>
                    <s:submit value="add category"/>
                </s:form>
            </div>
        </s:if>
        <s:else>
            <div id="updateCategory">
                <h4>Update category</h4>
                <s:form action="updateCategory" method="POST" validate="true">
                    <s:hidden name="id" value="%{id}"/>
                    <s:textfield name="categoryName" label="Category name" value="%{category.name}"/>
                    <s:select list="%{#application.categories}" label="parent category"
                              headerKey="0" headerValue="------"
                              listKey="key.id" listValue="key.name"/>
                    <s:submit value="update"/>
                </s:form>
            </div>
        </s:else>
        <div id="categoriesList">
            <h4>category list</h4>
            <table border="1">
                <tr>
                    <th width="120">Category name</th>
                    <th width="60">Delete category</th>
                    <th width="60">Update category</th>
                </tr>
                <s:iterator value="#application.categories">
                    <tr>
                        <th width="120"><s:property value="key.name"/></th>
                        <th width="60"><a href="deleteCategory.action?id=<s:property value="key.id"/>">delete</a></th>
                        <th width="60"><a href="viewCategory.action?id=<s:property value="key.id"/>">edit</a></th>
                    </tr>
                </s:iterator>
            </table>
        </div>
    </div>
    <div id="brandDiv" style="width: 40%;float: left">
        <s:if test="%{brand==null }">
            <div id="addBrand">
                <h4>add brand</h4>
                <s:form action="addBrand" method="POST">
                    <s:textfield label="Brand name" name="brandName"/>
                    <s:submit value="Add Brand"/>
                </s:form>
            </div>
        </s:if>
        <s:else>
            <h4>update brand</h4>
            <s:form action="addBrand" method="POST">
                <s:hidden name="brandId" value="%{brand.id}"/>
                <s:textfield label="Brand name" name="brandName" value="%{brand.name}"/>
                <s:submit value="Add Brand"/>
            </s:form>
        </s:else>
        <div id="brandsList">
            <table border="solid">
                <tr>
                    <th width="100">name</th>
                    <th width="50">edit</th>
                    <th width="50">delete</th>
                </tr>
                <s:iterator value="#application.brands">
                    <tr>
                        <td width="100"><s:property value="name"/></td>
                        <td width="50"><a href="viewBrand.action?brandId=<s:property value="id"/> ">edit</a></td>
                        <td width="50"><a href="deleteBrand.action?brandId=<s:property value="id"/> ">delete</a></td>
                    </tr>
                </s:iterator>
            </table>
        </div>
    </div>
    <div id="productDiv" style="float: left; width: 80%">
        <div id="addProduct" style="float: left; width: 35%">
            <s:if test="%{product==null }">
                <h4>Add product</h4>
                <s:set var="categories" value="%{#application.categories}"/>
                <s:form action="addProduct" method="POST" enctype="multipart/form-data">
                    <s:textfield name="name" label="Product`s name"/>
                    <s:textfield name="price" label="Price"/>
                    <s:textarea name="description" label="Product`s descrption" rows="5"/>
                    <s:select list="%{#application.brands}" name="brandId"
                              headerValue="-----" headerKey="0" label="Brand"
                              listKey="id" listValue="name"/>
                    <s:select list="%{#application.categories}" label="Categories" name="categoryId"
                              headerKey="0" headerValue="-----"
                              listKey="key.id" listValue="key.name"/>
<%--                     <s:doubleselect list="%{#application.categories}" label="Categories" name="categoryId" --%>
<%--                                     headerKey="0" headerValue="-----" --%>
<%--                                     listKey="key" listValue="key.name" --%>
<%--                                     doubleList="#categories[categoryId]" doubleName="subcategoryId" doubleListValue="value.name" doubleListKey="value.id"/> --%>
                    <s:file label="main picture" name="main" multiple="multiple"/>
                    <s:submit value="Add Product"/>
                </s:form>
            </s:if>
            <s:else>
                <h4>Update product</h4>
                <s:form action="addProduct" method="POST" enctype="multipart/form-data">
                    <s:hidden name="productId" value="%{product.id}"/>
                    <s:textfield name="name" label="Product`s name" value="%{product.name}"/>
                    <s:textfield name="price" label="Price" value="%{product.price}"/>
                    <s:textarea name="description" label="Product`s description" rows="5"
                                value="%{product.description}"/>
                    <s:select list="%{#application.brands}" name="brandId"
                              headerValue="-----" headerKey="0" label="Brand"
                              listKey="id" listValue="name"/>
                    <s:select list="%{#application.categories}" label="Categories" name="categoryId"
                              headerKey="0" headerValue="-----"
                              listKey="key.id" listValue="key.name"/>
                    <s:file label="main picture" name="main" multiple="multiple"/>
                    <s:submit value="Add Product"/>
                </s:form>
            </s:else>
        </div>
        <div id="categoryListDiv" style="float: left; width: 35%">
            <h4>Categories list</h4>
            <s:iterator value="#application.categories">
                <div class="accordion"><a
                        href="productsById.action?categoryId=<s:property value="key.id"/> "><s:property
                        value="key.name"/></a></div>
                <div class="panel">

                    <ul>
                        <s:iterator value="value">
                            <li onclick="getProducts(<s:property value="id"/>)">
                                <s:property value="name"/>
                            </li>
                        </s:iterator>
                    </ul>

                </div>
            </s:iterator>
            <style>

                div.accordion {
                    background-color: #eee;
                    color: #444;
                    cursor: pointer;
                    padding: 8px;
                    width: 70%;
                    text-align: left;
                    border: none;
                    outline: none;
                    transition: 0.4s;
                    height: 30px;
                }

                div.accordion.active, div.accordion:hover {
                    background-color: #ddd;
                }

                div.panel {
                    padding: 0 18px;
                    background-color: white;
                    max-height: 0;
                    overflow: hidden;
                    transition: 0.6s ease-in-out;
                    opacity: 0;
                }

                div.panel.show {
                    opacity: 1;
                    max-height: 500px; /* Whatever you like, as long as its more than the height of the content (on all screen sizes) */
                }

                /*icons*/

                div.accordion:after {
                    content: '\02795'; /* Unicode character for "plus" sign (+) */
                    font-size: 13px;
                    color: #777;
                    float: right;
                    margin-left: 5px;
                }

                div.accordion.active:after {
                    content: "\2796"; /* Unicode character for "minus" sign (-) */
                }
            </style>

            <script>
                var acc = document.getElementsByClassName("accordion");
                var i;

                for (i = 0; i < acc.length; i++) {
                    acc[i].onclick = function () {
                        this.classList.toggle("active");
                        this.nextElementSibling.classList.toggle("show");
                    }
                }
            </script>
            <script>
                function getProducts(id) {
                    $.ajax({
                        url: "productsByIdAdmin.action?categoryId=" + id,
                        success: function (result) {
                            $("#productsList").html(result)

                        },
                        error: function () {
                            $("#productsList").html("error")
                        }
                    })
                }
            </script>
        </div>
        <div id="productsList" style="float: left; width: 30%">

        </div>
    </div>

</div>
</body>
</html>
