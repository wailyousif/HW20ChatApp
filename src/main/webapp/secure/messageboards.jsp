<%@ page import="com.ironyard.data.ChatUser" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE HTML>
<html>
<head>
    <title>MessageBoards</title>

    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        $(document).ready
        (
            function()
            {
                $("#btnSubmitAddDlg").click(function()
                {
                    var msgBoardNameAdd = $("#msgBoardNameAdd").val();

                    $.ajax({
                        cache: false,
                        type: 'POST',
                        url: '/secure/msgboards/add',
                        data: 'msgBoardName=' + msgBoardNameAdd,
                        success: function(data) {
                            window.location.href = "/secure/msgboards/show";
                        }
                    });
                });
            }
        );
    </script>
    <style>
        /* Remove the navbar's default margin-bottom and rounded borders */
        .navbar {
            margin-bottom: 0;
            border-radius: 0;
        }
        /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
        .row.content {height: 450px}
        /* Set gray background color and 100% height */
        .sidenav {
            padding-top: 20px;
            background-color: #f1f1f1;
            height: 100%;
        }
        /* Set black background color, white text and some padding */
        footer {
            background-color: #555;
            color: white;
            padding: 15px;
        }
        /* On small screens, set height to 'auto' for sidenav and grid */
        @media screen and (max-width: 767px) {
            .sidenav {
                height: auto;
                padding: 15px;
            }
            .row.content {height:auto;}
        }
        hr.style8 {
            border-top: 1px solid dimgray;
            border-bottom: 1px solid dimgray;
        }
        hr.style8:after {
            content: '';
            display: block;
            margin-top: 2px;
            border-top: 1px solid dimgray;
            border-bottom: 1px solid dimgray;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">
                <img style="width: 40px;" src="https://www.theironyard.com/etc/designs/theironyard/icons/iron-yard-logo.svg" alt="The Iron Yard" />
            </a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav">
                <li class="active"> <a href="#">                    Message Boards</a></li>
                <li>                <a href="/secure/chatusers/show">   Users</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="/logout"><span class="glyphicon glyphicon-log-out"></span>Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container text-center">
    <div class="row">
        <div class="col-sm-1"></div>
        <div class="col-sm-9 text-left">
            <h3>Message Boards</h3>

            <c:if test="${sessionScope.chatUser.getUserPermission().isCreateMsgBoardPermission() == true}">
                <div class="row text-right">
                    <a data-toggle="modal" data-target="#msgboardAddDialog"
                       data-dialogtitle="Create Message Board"
                       class="btn btn-info">
                        Create Message Board
                    </a>
                </div>
            </c:if>

            <hr />
            <div class="col-sm-12">
                <ul class="list-unstyled">
                    <c:forEach items="${listOfMsgBoards}" var="aMsgBoard">
                        <li>
                            <div class="row">
                                <div class="col-sm-6">
                                    <c:out value="${aMsgBoard.getCreationDate()} "/>
                                </div>
                                <div class="col-sm-6">
                                    <a href="/secure/chatmsgs/show?msgBoardId=<c:out value="${aMsgBoard.getId()}"/>&msgBoardName=<c:out value="${aMsgBoard.getName()}"/>">
                                        <c:out value="${aMsgBoard.name}"/>
                                    </a>
                                </div>
                            </div>
                            <div class="row"><hr /></div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <hr />
        </div>
        <div class="col-sm-2" style="font-size: larger; color: darkcyan;">Welcome, <%=((ChatUser)request.getSession().getAttribute("chatUser")).getDisplayName()%></div>
    </div>

    <hr class="style8" />
</div>


<div class="modal fade" id="msgboardAddDialog" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><div>Create Message Board</div></h4>
            </div>

            <div class="modal-body">
                <form id="frmadddlg" method="post" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label class="col-sm-4 control-label" for="msgBoardNameAdd">Name:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="msgBoardNameAdd" name="msgBoardNameAdd" placeholder="Enter Message Board Name" value=""/>
                        </div>
                    </div>

                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-primary" id="btnSubmitAddDlg" data-dismiss="modal">Save changes</button>
            </div>
        </div>
    </div>
</div>


<footer class="container-fluid text-center">
    <p>SuperChat is a registered trademark of WMY Corporation</p>
</footer>

</body>
</html>
