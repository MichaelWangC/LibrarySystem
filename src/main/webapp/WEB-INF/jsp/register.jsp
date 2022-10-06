<%--
  Created by IntelliJ IDEA.
  User: michael
  Date: 2022/10/3
  Time: 下午3:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/common.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js" ></script>
    <script src="js/js.cookie.js"></script>
</head>
<body background="img/login_bg.jpg">

<div class="col-xs-6 col-md-offset-3" style="padding-top: 100px;position: relative">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">用户注册</h3>
        </div>
        <div class="panel-body">
            <div>

                <div class="form-group" >
                    <label for="name">姓名</label>
                    <input type="text" class="form-control" name="name" id="name"  placeholder="请输入姓名">
                </div>
                <div class="form-group">
                    <label for="employeeId">员工号</label>
                    <input type="text" class="form-control" name="employeeId" id="employeeId" laceholder="请输入员工号">
                </div>
                <div class="form-group">
                    <label  for="password">密码</label>
                    <input  type="password" class="form-control" name="password" id="password">
                </div>
                <div class="form-group">
                    <label  for="passwordConfirm">密码确认</label>
                    <input  type="password" class="form-control" name="passwordConfirm" id="passwordConfirm">
                </div>

                <div class="form-group">
                    <label  for="deptName">部门</label>
                    <input type="text" class="form-control" name="deptName" id="deptName" >
                </div>
                <div class="form-group" >
                    <label for="phone">电话</label>
                    <input type="text" class="form-control" name="phone" id="phone"  >
                </div>

<%--                <input style="align-items: center;" type="submit" value="注册" class="btn btn-success btn-sm"--%>
<%--                       class="text-left">--%>
                <button id="submitBtn" class="btn btn-success btn-sm" class="text-left">注册</button>
                <script>
                    function mySubmit(flag){
                        return flag;
                    }
                    $("#submitBtn").click(function () {
                        if($("#password").val()=='' || $("#passwordConfirm").val()=='' ||$("#name").val()==''||$("#employeeId").val()==''||$("#address").val()==''||$("#phone").val()==''){
                            alert("请填入完整读者信息！");
                            return mySubmit(false);
                        }
                        if ($("#password").val() != $("#passwordConfirm").val() ) {
                            alert("密码两次输入不一致！");
                            return mySubmit(false);
                        }
                        $.ajax({
                            type: "POST",
                            url: "api/reader/addReader",
                            data: {
                                name: $("#name").val(),
                                employeeId: $("#employeeId").val(),
                                deptName: $("#deptName").val(),
                                phone: $("#phone").val(),
                                password: $("#password").val()
                            },
                            dataType: "json",
                            success: function(data) {
                                alert(data.msg)
                                if (data.stateCode == 0) {
                                    window.location.replace("/")
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
