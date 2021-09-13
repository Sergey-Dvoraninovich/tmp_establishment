<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="locale" />

<c:set var="disable"><fmt:message key="admin.dishes.disable" /></c:set>
<c:set var="make_available"><fmt:message key="admin.dishes.make_available" /></c:set>
<c:set var="edit"><fmt:message key="edit" /></c:set>
<c:set var="more_information"><fmt:message key="more_information" /></c:set>
<c:set var="create_dish_message"><fmt:message key="admin.dishes.create_dish"/></c:set>

<html>
<head>
    <title><fmt:message key="admin.dishes.title" /></title>
</head>
<body>
<jsp:include page="../../shared/header.jsp" />
<div class="workspace">
    <div class="workspace-flex-container">
    <c:forEach var="dish" items="${sessionScope.dishes}">
        <div class="flex-block">
            <div class="block-item">
                <h3>${dish.name}</h3>
            </div>
            <div class="block-item">
                <img class="dish-picture"
                     src="../../../images/${dish.photo}"
                     onerror="this.src='../../../images/default_dish.png';">
            </div>
            <div id="description" class="block-item">
                <div class="row-item-flexbox">
                    <a>${dish.calories} <fmt:message key="admin.dishes.calories"/></a>
                </div>
                <div class="row-item-flexbox">
                    <a>${dish.amountGrams} <fmt:message key="admin.dishes.grams"/></a>
                </div>
                <div class="row-item-flexbox">
                    <a>${dish.price} <fmt:message key="admin.dishes.BYN"/></a>
                </div>
            </div>
            <c:if test="${dish.isAvailable}">
                <c:url value="/ApiController?command=disable_dish" var="disable_dish_command"/>
                <form action="${disable_dish_command}" method="post">
                    <input type="hidden" name="dish_id" value="${dish.id}">
                    <input type="submit" value="${disable}">
                </form>
            </c:if>
            <c:if test="${not dish.isAvailable}">
                <c:url value="/ApiController?command=make_dish_available" var="make_dish_available_command"/>
                <form action="${make_dish_available_command}" method="post">
                    <input type="hidden" name="dish_id" value="${dish.id}">
                    <input type="submit" value="${make_available}">
                </form>
            </c:if>
            <c:url value="/ApiController?command=go_to_edit_dish&id=${dish.id}" var="go_to_edit_dish_command"/>
            <form action="${go_to_edit_dish_command}" method="post">
                <input type="hidden" name="dish_id" value="${dish.id}">
                <input type="submit" value="${edit}">
            </form>
            <c:url value="/ApiController?command=go_to_dish_page&id=${dish.id}" var="go_to_dish_page_command"/>
            <form action="${go_to_dish_page_command}" method="post">
                <input type="hidden" name="dish_id" value="${dish.id}">
                <input type="submit" value="${more_information}">
            </form>
        </div>
    </c:forEach>
    <div class="dish-info">
        <div class="flex-block">
            <div class="block-item">
                <h3><fmt:message key="admin.dishes.new_dish"/></h3>
            </div>
            <div class="block-item">
                <img class="dish-picture"
                     src="../../../images/default_dish.png">
            </div>
            <c:url value="/ApiController?command=go_to_create_dish" var="create_dish_page"/>
            <div id="dish-add-picture" class="block-item">
                <a href="${create_dish_page}">
                <img id="add-icon" class="dish-picture"
                     src="../../../images/add.png"
                     href="">
                </a>
            </div>
            <form action="${create_dish_page}" method="post">
               <input type="submit" value="${create_dish_message}">
            </form>
        </div>
    </div>
    </div>
</div>
</body>
<style>
    body {
        font: 15px 'Roboto', Arial, Helvetica, sans-serif;
    }
    a {
        font-size: 25px;
        text-decoration: none;
    }
    .workspace-flex-container {
        margin-top: 35px;
        display: flex;
        flex-flow: row wrap;
        align-content: space-around;
    }
    .flex-block {
        flex-flow: row nowrap;
        align-content: space-around;
        color: white;
        font-size: 15px;
        margin: 15px;
        padding: 10px;
        width: min-content;
        border-radius: 5px;
        -webkit-box-shadow: 4px 4px 8px 0px rgba(34, 60, 80, 0.15);
        -moz-box-shadow: 4px 4px 8px 0px rgba(34, 60, 80, 0.15);
        box-shadow: 4px 4px 8px 0px rgba(34, 60, 80, 0.15);
    }
    .flex-block:hover {
        -webkit-box-shadow: 4px 4px 8px 0px rgba(34, 60, 80, 0.25);
        -moz-box-shadow: 4px 4px 8px 0px rgba(34, 60, 80, 0.25);
        box-shadow: 4px 4px 8px 0px rgba(34, 60, 80, 0.25);
    }
    .dish-picture {
        height: 200px;
        width: 350px;
    }
    #dish-add-picture {
        height: 205px;
        width: 350px;
    }
    #add-icon {
        height: 90px;
        width: 90px;
    }
    h3 {
        font-size: 30px;
        color: #000000;
    }
    .block-item {
        margin-top: 0px;
        margin-bottom: 0px;
        padding-top: 0px;
        padding-bottom: 0px;
        border: none;
        -webkit-box-shadow: none;
        -moz-box-shadow: none;
        box-shadow: none;
    }
    .block-item:hover {
        border: none;
        -webkit-box-shadow: none;
        -moz-box-shadow: none;
        box-shadow: none;
    }
    #description{
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        justify-content: flex-start;
    }
    .row-item-flexbox{
        display: flex;
        flex-direction: row;
        align-items: center;
        justify-content: flex-start;
    }
    .row-item-flexbox>a{
        font-size: 20px;
        color: #4d4d4d;
        margin: 5px 0px;
    }
    input[type="submit"]{
        font-size: 20px;
        position: center;
        color: #ffffff;
        border: none;
        border-radius: 10px;
        margin: 5px 0px 0px 15px;
        padding: 5px 5px 5px 20px;
        text-align: center;
        width: 90%;
        background-color: #a15566;
    }
    input[type="submit"]:hover {
        background-color: #804451;
    }
</style>
</html>
