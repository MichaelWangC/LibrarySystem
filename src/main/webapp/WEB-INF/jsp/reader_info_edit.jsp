<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${readercard.name}的主页</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/common.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js" ></script>
    <script>
        $(function () {
            $('#header').load('reader_header.html');
        })
    </script>
</head>
<body background="img/reader_bg.jpg">
<div id="header" style="padding-bottom: 80px"></div>
<div class="col-xs-5 col-md-offset-3">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">
                信息修改
            </h3>
        </div>
        <div class="panel-body">
            <div >
                <div class="input-group">
                    <span  class="input-group-addon">读者证号</span>
                    <input type="text" readonly="readonly" class="form-control" name="readerId" id="readerId" value="${readerinfo.readerId}">
                </div>
                <div class="input-group">
                    <span class="input-group-addon">姓名</span>
                    <input type="text" class="form-control" name="name" id="name" value="${readerinfo.name}" >
                </div>
                <div class="input-group">
                    <span  class="input-group-addon">工号</span>
                    <input type="text" class="form-control" name="employeeId" id="employeeId"  value="${readerinfo.employeeId}" >
                </div>
                <div class="input-group">
                    <span class="input-group-addon">部门</span>
                    <input type="text" class="form-control" name="deptName" id="deptName"  value="${readerinfo.deptName}" >
                </div>
                <div class="input-group">
                    <span  class="input-group-addon">电话</span>
                    <input type="text" class="form-control" name="phone" id="phone"  value="${readerinfo.phone}" >
                </div>
                <br/>
<%--                <input type="submit" value="确定" class="btn btn-success btn-sm" class="text-left">--%>
                <button id="submitBtn" class="btn btn-success btn-sm" class="text-left">确定</button>
                <button id="returnBtn" class="btn btn-sm" class="text-left">返回</button>
                <script>
                    $("#returnBtn").click(function () {
                        window.history.go(-1)
                    })
                    $("#submitBtn").click(function () {
                        if($("#name").val()==''||$("#employeeId").val()==''||$("#deptName").val()==''||$("#phone").val()==''){
                            alert("请填入完整图书信息！");
                            return false;
                        }
                        $.ajax({
                            type: "POST",
                            url: "api/reader/addReader",
                            data: {
                                readerId: ${readerinfo.readerId},
                                name: $("#name").val(),
                                employeeId: $("#employeeId").val(),
                                deptName: $("#deptName").val(),
                                phone: $("#phone").val()
                            },
                            dataType: "json",
                            success: function(data) {
                                alert(data.msg)
                                if (data.stateCode == 0) {
                                    window.location.replace("/reader_info.html")
                                }
                            },
                            error: function (err) {
                                alert(JSON.stringify(err))
                            }
                        })
                    })
                </script>
            </div>
        </div>
    </div>
</div>
</body>
</html>
