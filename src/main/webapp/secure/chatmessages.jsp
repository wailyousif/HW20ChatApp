<%@ page import="com.ironyard.data.ChatUser" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE HTML>
<html>
<head>
    <title>Chat Messages</title>

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
                    var objFormData = new FormData();

                    var msgBoardIdAdd = $("#msgBoardIdAdd").val();
                    objFormData.append('msgBoardId', msgBoardIdAdd);

                    var msgTextAdd = $("#msgTextAdd").val();
                    objFormData.append('msgText', msgTextAdd);

                    var destUrl;

                    if(document.getElementById("msgPicAdd").value != "")
                    {
                        //alert('file selected');
                        destUrl = '/secure/chatmsgs/addwpic';
                        jQuery.each(jQuery('#msgPicAdd')[0].files, function(i, file) {
                            objFormData.append('msgPic', file);
                        });
                    }
                    else
                    {
                        destUrl = '/secure/chatmsgs/addwopic';
                    }

                    $.ajax({
                        cache: false,
                        type: 'POST',
                        contentType: false,
                        url: destUrl,
                        data: objFormData,
                        processData: false,
                        success: function(data) {
                            window.location.href = "/secure/chatmsgs/show?msgBoardId=" + msgBoardIdAdd;
                        }
                    });
                });


                $(document).on("click", ".addMsgLnk", function ()
                {
                    var msgBoardId = $(this).data('msgboardid');
                    $(".modal-body #msgBoardIdAdd").val( msgBoardId );
                });


                $('#pageSize').on('change', function() {
                    document.forms['frmOptions'].submit();
                });

                $('#sortBy').on('change', function() {
                    document.forms['frmOptions'].submit();
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
                <li>                <a href="/secure/msgboards/show">   Message Boards</a></li>
                <li>                <a href="/secure/chatusers/show">        Users</a></li>
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
            <h3>Messages on <c:out value="${msgBoardName}"/></h3>

            <c:if test="${sessionScope.chatUser.getUserPermission().isPostMsgPermission() == true}">
                <div class="row text-right">
                    <a data-toggle="modal" data-target="#msgAddDialog"
                       data-dialogtitle="Create New Message"
                       data-msgboardid="<c:out value="${msgBoardId}"/>"
                       class="btn btn-info addMsgLnk">
                        Add New Message
                    </a>
                </div>
            </c:if>

            <div clas="row">
                <br />
                <div class="col-sm-1"></div>
                <div class="col-sm-2">
                    <c:if test="${listOfChatMsgs.hasPrevious()}">
                        <a href="/secure/chatmsgs/show?page=<c:out value="${listOfChatMsgs.number - 1}"/>&msgBoardId=<c:out value="${msgBoardId}"/>&msgBoardName=<c:out value="${msgBoardName}"/>&pageSize=<c:out value="${pageSizeVal}"/>&sortBy=<c:out value="${sortByVal}"/>">Previous Page <</a>
                    </c:if>
                </div>
                <form id="frmOptions" method="get">
                    <input type="hidden" id="msgBoardId" name="msgBoardId" value="<c:out value="${msgBoardId}"/>"/>
                    <input type="hidden" id="msgBoardName" name="msgBoardName" value="<c:out value="${msgBoardName}"/>"/>
                    <input type="hidden" id="page" name="page" value="0" />
                    <div class="col-sm-3">
                        <label class="control-label" for="pageSize">Page Size:</label>
                        <select id="pageSize" name="pageSize">
                            <c:out value="${pageSizeOpts}" escapeXml="false" />
                        </select>
                    </div>
                    <div class="col-sm-3">
                        <label class="control-label" for="sortBy">Sort By:</label>
                        <select id="sortBy" name="sortBy">
                            <c:out value="${sortByOpts}" escapeXml="false" />
                        </select>
                    </div>
                </form>
                <div class="col-sm-2">
                    <c:if test="${listOfChatMsgs.hasNext()}">
                        <a href="/secure/chatmsgs/show?page=<c:out value="${listOfChatMsgs.number + 1}"/>&msgBoardId=<c:out value="${msgBoardId}"/>&msgBoardName=<c:out value="${msgBoardName}"/>&pageSize=<c:out value="${pageSizeVal}"/>&sortBy=<c:out value="${sortByVal}"/>">> Next Page</a>
                    </c:if>
                </div>
                <div class="col-sm-1"></div>
            </div>

            <hr />
            <div class="col-sm-12">
                <ul class="list-unstyled">
                    <c:forEach items="${listOfChatMsgs.iterator()}" var="aMsg">
                        <li>
                            <div class="row">
                                <c:out value="${aMsg.postTime} "/> by <c:out value="${aMsg.chatUser.displayName} "/>
                                <br />
                                <img src="/ourCoolUploadedFiles/<c:out value="${aMsg.chatUser.smallPhotoFile}"/>" style="width: 50px;" />
                                <br />
                            </div>
                            <div class="row">
                                <div class="col-sm-2"></div>
                                <div class="col-sm-10">
                                    <c:if test="${not empty aMsg.picFileName}">
                                        <img src="/ourCoolUploadedFiles/<c:out value="${aMsg.picFileName}"/>" />
                                        <br /><br />
                                    </c:if>
                                    <c:out value="${aMsg.messageText} "/>
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


<div class="modal fade" id="msgAddDialog" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><div>Create New Message</div></h4>
            </div>

            <div class="modal-body">
                <form id="frmadddlg" method="post" class="form-horizontal" role="form">

                    <input type="hidden" id="msgBoardIdAdd" name="msgBoardIdAdd" value="" />

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="msgTextAdd">Message Text:</label>
                        <div class="col-sm-10">
                            <textarea cols="40" rows="5" class="form-control" id="msgTextAdd" name="msgTextAdd" placeholder="Add Message" value=""></textarea>
                        </div>
                    </div>

                    <div class="row"><br /></div>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="msgPicAdd">Optional Pic:</label>
                        <div class="col-sm-8">
                            <input type="file" class="form-control" id="msgPicAdd" name="msgPicAdd" placeholder="Add a pic from your local machine.">
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
