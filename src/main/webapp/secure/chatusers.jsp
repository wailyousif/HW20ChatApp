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
                    /*
                    var theForm = $("form#frmadddlg")[0];
                    alert('hello we are about to send the form!');

                    var formData = new FormData(theForm);
                    alert('Wait a minute, we had to set formData...');

                    $.ajax({
                        url: '/secure/chatusers/add',
                        type: 'POST',
                        data: formData,
                        async: false,
                        success: function (data) {
                            window.location.href = "/secure/chatusers/show";
                        },
                        cache: false,
                        contentType: false,
                        processData: false
                    });
                    */

                    /*
                    $.post($(this).attr("action"), formData, function(data) { 
                        window.location.href = "/secure/chatusers/show"; 
                    });
                    */


                    var userNameAdd = $("#userNameAdd").val();
                    var passWordAdd = $("#passWordAdd").val();
                    var displayNameAdd = $("#displayNameAdd").val();

                    var createUserPermAdd = 0;
                    if(document.getElementById('createUserPerm').checked) {
                        createUserPermAdd = 1;
                    }

                    var createMsgBoardPermAdd = 0;
                    if(document.getElementById('createMsgBoardPerm').checked) {
                        createMsgBoardPermAdd = 1;
                    }

                    var postMsgPermAdd = 0;
                    if(document.getElementById('postMsgPerm').checked) {
                        postMsgPermAdd = 1;
                    }

                    var queryString = 'userName=' + userNameAdd +
                            '&passWord=' + passWordAdd +
                            '&displayName=' + displayNameAdd +
                            '&createUserPerm=' + createUserPermAdd +
                            '&createMsgBoardPerm=' + createMsgBoardPermAdd +
                            '&postMsgPerm=' + postMsgPermAdd;

                    var objFormData = new FormData();
                    //var objFile = $(this)[0].files[0];

                    //var userPhotoAdd = $("#userPhoto").files[0];
                    var userPhotoAdd;
                    /*
                    $.get("#userPhoto", function(response) {
                        userPhotoAdd = response;
                        dataIsAvailable();
                    });
                    */


                    //$("#userPhoto").load("userPhoto", function(response){ userPhotoAdd = response; });

                    //objFormData.append('userfile', objFile);


                    objFormData.append('userName', userNameAdd);
                    objFormData.append('passWord', passWordAdd);
                    objFormData.append('displayName', displayNameAdd);
                    objFormData.append('createUserPerm', createUserPermAdd);
                    objFormData.append('createMsgBoardPerm', createMsgBoardPermAdd);
                    objFormData.append('postMsgPerm', postMsgPermAdd);
                    //objFormData.append('userPhoto', userPhotoAdd);

                    jQuery.each(jQuery('#userPhoto')[0].files, function(i, file) {
                        objFormData.append('userPhoto', file);
                    });

                    //alert('userNameAdd=' + userNameAdd);

                    $.ajax({
                        cache: false,
                        type: 'POST',
                        contentType: false,
                        url: '/secure/chatusers/add',
                        data: objFormData,
                        processData: false,
                        success: function(data) {
                            window.location.href = "/secure/chatusers/show";
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
                <li>                    <a href="/secure/msgboards/show">   Message Boards</a></li>
                <li class="active">     <a href="#">                        Users</a></li>
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
            <h3>Users</h3>

            <c:if test="${sessionScope.chatUser.getUserPermission().isCreateUserPermission() == true}">
                <div class="row text-right">
                    <a data-toggle="modal" data-target="#msgboardAddDialog"
                       data-dialogtitle="Create Message Board"
                       class="btn btn-info">
                        Create New User
                    </a>
                </div>
            </c:if>

            <hr />
            <div class="col-sm-12">
                <ul class="list-unstyled">
                    <c:forEach items="${listOfUsers}" var="aUser">
                        <li>
                            <div class="row">
                                <div class="col-sm-3">
                                    User Name:<c:out value="${aUser.getUsername()} "/>
                                </div>
                                <div class="col-sm-5">
                                    Display Name:<c:out value="${aUser.getDisplayName()} "/>
                                </div>
                                <div class="col-sm-4">
                                    <ul>
                                        <c:if test="${aUser.getUserPermission().isCreateUserPermission() == true}">
                                            <li>Can Create Users</li>
                                        </c:if>
                                        <c:if test="${aUser.getUserPermission().isCreateMsgBoardPermission() == true}">
                                            <li>Can Create Message Boards</li>
                                        </c:if>
                                        <c:if test="${aUser.getUserPermission().isPostMsgPermission() == true}">
                                            <li>Can Post <Messages></Messages></li>
                                        </c:if>
                                    </ul>
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
                <h4 class="modal-title"><div>Create New User</div></h4>
            </div>

            <div class="modal-body">
                <form id="frmadddlg" method="post" class="form-horizontal" role="form" action="/secure/chatusers/add">

                    <div class="form-group">
                        <label class="col-sm-4 control-label" for="userNameAdd">User Name:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="userNameAdd" name="userNameAdd" placeholder="Enter User Name" value=""/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-4 control-label" for="passWordAdd">Password:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="passWordAdd" name="passWordAdd" placeholder="Enter Password" value=""/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-4 control-label" for="displayNameAdd">Display Name:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="displayNameAdd" name="displayNameAdd" placeholder="Enter Display Name" value="" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-4"></div>
                        <div class="col-sm-8">
                            <div class="checkbox">
                                <label><input type="checkbox" id="createUserPerm" value="">Create User</label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-4"></div>
                        <div class="col-sm-8">
                            <div class="checkbox">
                                <label><input type="checkbox" id="createMsgBoardPerm" value="">Create Message Board</label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-4"></div>
                        <div class="col-sm-8">
                            <div class="checkbox">
                                <label><input type="checkbox" id="postMsgPerm" value="">Post Message</label>
                            </div>
                        </div>
                    </div>

                    <div class="row"><br /></div>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="userPhoto">User's Photo:</label>
                        <div class="col-sm-8">
                            <input type="file" class="form-control" id="userPhoto" name="userPhoto" placeholder="Pick a file from your local machine.">
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
