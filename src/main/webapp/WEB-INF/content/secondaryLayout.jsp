<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<html>
<head>
    <title><tiles:getAsString name="title"/></title>
    <tiles:insertAttribute name="import"/>
</head>
<body>
<header id="header">
    <tiles:insertAttribute name="header"/>
</header>

<tiles:insertAttribute name="content"/>

<footer id="footer">
    <tiles:insertAttribute name="footer"/>
</footer>

</body>
</html>
