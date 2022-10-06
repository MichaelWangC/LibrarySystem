<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>编辑读者信息《 ${readerInfo.readerId}》</title>
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
            <h3 class="panel-title">编辑读者信息《 ${readerInfo.readerId}》</h3>
        </div>
        <div class="panel-body">
            <div>
                <div class="input-group">
                    <span class="input-group-addon">姓名</span>
                    <input type="text" class="form-control" name="name" id="name" value="${readerInfo.name}" >
                </div>
                <div class="input-group">
                    <span  class="input-group-addon">工号</span>
                    <input type="text" class="form-control" name="employeeId" id="employeeId"  value="${readerInfo.employeeId}" >
                </div>
                <div class="input-group">
                    <span class="input-group-addon">部门</span>
                    <input type="text" class="form-control" name="deptName" id="deptName"  value="${readerInfo.deptName}" >
                </div>
                <div class="input-group">
                    <span class="input-group-addon">电话</span>
                    <input type="text" class="form-control" name="phone" id="phone" value="${readerInfo.phone}" >
                </div>

                <button id="submitBtn" class="btn btn-success btn-sm" class="text-left">确定</button>
            </div>
        </div>
    </div>

</div>

<script>
    $("#submitBtn").click(function () {
        if($("#name").val()==''||$("#employeeId").val()==''||$("#deptName").val()==''||$("#phone").val()==''){
            alert("请填入完整读者信息！");
            return false;
        }
        $.ajax({
            type: "POST",
            url: "api/reader/addReader",
            data: {
                readerId: ${readerInfo.readerId},
                name: $("#name").val(),
                employeeId: $("#employeeId").val(),
                deptName: $("#deptName").val(),
                phone: $("#phone").val()
            },
            dataType: "json",
            success: function(data) {
                alert(data.msg)
                if (data.stateCode == 0) {
                    window.location.replace("/allreaders.html")
                }
            },
            error: function (err) {
                alert(JSON.stringify(err))
            }
        })
    })

</script>

</body>
</html>
