<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String index = request.getParameter("index");
%>
<nav class="navbar navbar-default" role="navigation" style="background-color:#fff">
    <div class="container-fluid">
        <div class="navbar-header" style="margin-left: 8%;margin-right: 1%">
            <a class="navbar-brand " href="reader_main.html"><p class="text-primary" style="font-family: 华文行楷; font-size: 200%; ">我的图书馆</p></a>
        </div>
        <div class="collapse navbar-collapse" id="example-navbar-collapse">
            <ul class="nav navbar-nav navbar-left">
                <li class="tabbar-item active">
                    <a href="reader_books.html" onclick="selTab(0)">
                        图书查询
                    </a>
                </li>
                <li class="tabbar-item">
                    <a href="reader_info.html" onclick="selTab(1)">
                        个人信息
                    </a>
                </li>
                <li class="tabbar-item">
                    <a href="mylend.html" onclick="selTab(2)">
                        我的借还
                    </a>
                </li>
                <li class="tabbar-item">
                    <a href="reader_repasswd.html" onclick="selTab(3)">
                        密码修改
                    </a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="reader_info.html">${readercard.name}, 已登录</a></li>
                <li><a href="login.html">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<script>
    function selTab(index) {
        var tabbarItems = document.getElementsByClassName("tabbar-item")
        var tabbarItem = tabbarItems[index]
        var activeItems = document.getElementsByClassName("active")
        activeItems[0].classList.remove("active")
        tabbarItem.classList.add("active")
    }

    var index="<%=index%>";
    selTab(index)

</script>
