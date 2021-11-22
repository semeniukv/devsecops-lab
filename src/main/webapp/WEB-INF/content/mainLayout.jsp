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

<tiles:insertAttribute name="slider"/>
<section>
    <div class="container">
        <div class="row">
            <tiles:insertAttribute name="lsb"/>

            <tiles:insertAttribute name="content"/>
        </div>
    </div>
</section>


<footer id="footer">
    <tiles:insertAttribute name="footer"/>
</footer>


</body>
</html>
