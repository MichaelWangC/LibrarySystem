<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>全部图书信息</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/common.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(function () {
            $('#header').load('reader_header.html', {index: 0});
        })
    </script>
</head>
<body background="img/reader_bg.jpg">

<div id="header"></div>

<div style="padding: 20px 550px 10px">
    <form method="post" action="reader_querybook_do.html" class="form-inline" id="searchform">
        <div class="input-group">
            <input type="text" placeholder="输入图书名" class="form-control" id="search" name="searchWord"
                   class="form-control" value="<c:out value="${searchWord}"></c:out>">
            <input type="text" class="form-control" name="classId" id="classId" style="display: none;">
            <span class="input-group-btn">
                <input type="submit" value="搜索" class="btn btn-default">
            </span>
        </div>
    </form>
    <script>
        $("#searchform").submit(function () {
            var val = $("#search").val();
            if (val == '') {
                // alert("请输入关键字");
                // return false;
            }
        })
    </script>
</div>
<div style="position: relative;top: 0%">
    <c:if test="${!empty succ}">
        <div class="alert alert-success alert-dismissable">
            <button type="button" class="close" data-dismiss="alert"
                    aria-hidden="true">
                &times;
            </button>
                ${succ}
        </div>
    </c:if>
    <c:if test="${!empty error}">
        <div class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert"
                    aria-hidden="true">
                &times;
            </button>
                ${error}
        </div>
    </c:if>
</div>
<div class="panel panel-default" style="width: 90%;margin-left: 5%">
    <div class="panel-heading">
        <div class="dropdown">
            <%--                <input type="text" class="form-control" name="classId" id="classId" placeholder="请输入分类号">--%>
            <button class="btn btn-default dropdown-toggle" type="button" id="classIdButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                <span id="className" class="panel-title">全部图书</span>

                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" aria-labelledby="classIdButton">
                <li><a onclick="classIdClick(this)" href="javascript:void(0)" value="">全部图书</a></li>
                <c:forEach items="${classInfos}" var="alog">
                    <li><a class="classid-item" onclick="classIdClick(this)" href="javascript:void(0)" value="<c:out value="${alog.classId}"></c:out>"><c:out value="${alog.className}"></c:out></a></li>
                </c:forEach>
            </ul>
            <script>
                function classIdClick(e) {
                    var value = $(e).attr('value')
                    var valueName = $(e).html()
                    $('#className').html(valueName)
                    $('#classId').val(value)

                    $('#searchform').submit()
                }
                function init() {
                    var classEleList = document.getElementsByClassName('classid-item')
                    var classIdSel = "${classId}"
                    if (!classIdSel) return
                    for (var i=0; i<classEleList.length;i++) {
                        var item = classEleList[i]
                        if (item.getAttribute('value') == classIdSel) {
                            $('#className').html(item.innerHTML)
                            $('#classId').val(classIdSel)
                            break;
                        }
                    }
                }
                init()
            </script>
        </div>
    </div>
    <div class="panel-body">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>书名</th>
                <th>作者</th>
                <th>出版社</th>
                <th>类别</th>
                <th width="120px">剩余数量</th>
                <th>借还</th>
                <th>详情</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${books}" var="book">
                <tr>
                    <td><c:out value="${book.name}"></c:out></td>
                    <td><c:out value="${book.author}"></c:out></td>
                    <td><c:out value="${book.publish}"></c:out></td>
                    <td><c:out value="${book.className}"></c:out></td>
                    <td><c:out value="${book.number}"></c:out></td>

                    <c:set var="flag" value="false"/>
                    <c:forEach var="lend" items="${myLendList}">
                        <c:if test="${lend eq book.bookId}">
                            <c:set var="flag" value="true"/>
                        </c:if>
                    </c:forEach>
                    <c:if test="${flag}">
                        <td><a href="returnbook.html?bookId=<c:out value="${book.bookId}"></c:out>" onclick="javascript:return returnbook('<c:out value="${book.name}"></c:out>')">
                            <button type="button" class="btn btn-danger btn-xs">归还</button>
                        </a></td>
                    </c:if>
                    <c:if test="${not flag}">
                        <c:if test="${book.number>0}">
                            <td><a href="lendbook.html?bookId=<c:out value="${book.bookId}"></c:out>" onclick="javascript:return lendBook('<c:out value="${book.name}"></c:out>')">
                                <button type="button" class="btn btn-primary btn-xs">借阅</button>
                            </a></td>
                        </c:if>
                        <c:if test="${book.number==0}">
                            <td>
                                <button type="button" class="btn btn-defalut btn-xs" disabled="disabled">已空</button>
                            </td>
                        </c:if>
                    </c:if>
                    <td><a href="reader_book_detail.html?bookId=<c:out value="${book.bookId}"></c:out>">
                        <button type="button" class="btn btn-success btn-xs">详情</button>
                    </a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</body>

<script>
    function lendBook(bookName) {
        var msg = "您真的确定要借阅书籍《"+bookName+"》吗？\n\n请确认！";
        if (confirm(msg)==true){
            return true;
        }else{
            return false;
        }
    }
    function returnbook(bookName) {
        var msg = "您真的确定要归还书籍《"+bookName+"》吗？\n\n请确认！";
        if (confirm(msg)==true){
            return true;
        }else{
            return false;
        }
    }
</script>
</html>
