<%@ taglib prefix="s" uri="/struts-tags" %>
<h4>products list</h4>
<table border="solid">
    <tr>
        <th>name</th>
        <th>description</th>
        <th>category name</th>
        <th>brand name</th>
        <th>price</th>
        <th>delete</th>
        <th>edit</th>
    </tr>
    <s:iterator value="products">
        <tr>
            <td><s:property value="name"/></td>
            <td><s:property value="description"/></td>
            <td><s:property value="category.name"/></td>
            <td><s:property value="brand.name"/></td>
            <td><s:property value="price"/></td>
            <td><a href="deleteProduct.action?productId=<s:property value="id"/>">delete</a></td>
            <td><a href="viewProduct.action?productId=<s:property value="id"/>">edit</a></td>
        </tr>
    </s:iterator>
</table>