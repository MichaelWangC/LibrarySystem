<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>编辑《 ${detail.name}》</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/common.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js" ></script>
    <script>
        $(function () {
            $('#header').load('admin_header.html');
        })
    </script>
</head>
<body background="img/admin_bg.jpg">

<div id="header" style="padding-bottom: 80px"></div>

<div class="col-xs-6 col-md-offset-3" style="position: relative;">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">编辑《 ${detail.name}》</h3>
        </div>
        <div class="panel-body">
            <form action="book_edit_do.html?bookId=${detail.bookId}" method="post" id="addbook" >

                <div class="input-group">
                    <span  class="input-group-addon">书名</span>
                    <input type="text" class="form-control" name="name" id="name" value="${detail.name}">
                </div>
                <div class="input-group">
                    <span class="input-group-addon">作者</span>
                    <input type="text" class="form-control" name="author" id="author" value="${detail.author}" >
                </div>
                <div class="input-group">
                    <span  class="input-group-addon">出版社</span>
                    <input type="text" class="form-control" name="publish" id="publish"  value="${detail.publish}" >
                </div>
                <div class="input-group">
                    <span class="input-group-addon">ISBN</span>
                    <input type="text" class="form-control" name="isbn" id="isbn"  value="${detail.isbn}" >
                </div>
                <div class="input-group">
                    <span  class="input-group-addon">简介</span>
                    <input type="text" class="form-control" name="introduction" id="introduction"  value="${detail.introduction}" >
                </div>
                <div class="input-group">
                    <span class="input-group-addon">语言</span>
                    <input type="text" class="form-control" name="language" id="language" value="${detail.language}" >
                </div>
                <div class="input-group">
                    <span  class="input-group-addon">价格</span>
                    <input type="text" class="form-control" name="price"  id="price" value="${detail.price}">
                </div>
                <div class="input-group">
                    <span class="input-group-addon">出版日期</span>
                    <input type="month" class="form-control" name="pubstr" id="pubstr" value="<fmt:formatDate value="${detail.pubdate}" pattern="yyyy-MM" />">
                </div>
                <div class="input-group">
                    <span  class="input-group-addon">图书分类</span>
                    <div class="dropdown">
                        <%--                <input type="text" class="form-control" name="classId" id="classId" placeholder="请输入分类号">--%>
                        <button class="btn btn-default dropdown-toggle" type="button" id="classIdButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                            <span id="className">${detail.className}</span>
                            <input type="text" class="form-control" name="classId" id="classId" style="display: none;" value="${detail.classId}">
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="classIdButton">
                            <c:forEach items="${classInfos}" var="alog">
                                <li><a onclick="classIdClick(this)" href="javascript:void(0)" value="<c:out value="${alog.classId}"></c:out>"><c:out value="${alog.className}"></c:out></a></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="input-group">
                    <span  class="input-group-addon">数量</span>
                    <input type="text" class="form-control" name="number"  id="number" value="${detail.number}">
                </div>
                <input type="submit" value="确定" class="btn btn-success btn-sm" class="text-left">
                <button id="returnBtn" class="btn btn-sm" class="text-left">返回</button>
                <script>
                    $("#returnBtn").click(function () {
                        window.history.go(-1)
                        return false;
                    })
                    $("#addbook").submit(function () {
                        if($("#name").val()==''||$("#author").val()==''||$("#publish").val()==''||$("#introduction").val()==''||$("#language").val()==''||$("#pubstr").val()==''||$("#classId").val()==''||$("#number").val()==''){
                            alert("请填入完整图书信息！");
                            return false;
                        }
                    })

                    function classIdClick(e) {
                        var value = $(e).attr('value')
                        var valueName = $(e).html()
                        $('#className').html(valueName)
                        $('#classId').val(value)
                    }
                </script>
            </form>
        </div>
    </div>

</div>

</body>
</html>
