//登录页面的事件
$(function() {
    $('input').iCheck({
        checkboxClass : 'icheckbox_square-blue',
        radioClass : 'iradio_square-blue',
        increaseArea : '20%' // optional
    });
});


$(document).ready(function () {
    // 选择框
    $(".select2").select2();
    // WYSIHTML5编辑器
    $(".textarea").wysihtml5({
        locale: 'zh-CN'
    });
});

$(document).ready(function () {
    // 激活导航位置
    setSidebarActive("admin-datalist");
    // 列表按钮
    $("#dataList td input[type='checkbox']").iCheck({
        checkboxClass: 'icheckbox_square-blue',
        increaseArea: '20%'
    });
    // 全选操作
    $("#selall").click(function () {
        var clicks = $(this).is(':checked');
        if (!clicks) {
            $("#dataList td input[type='checkbox']").iCheck("uncheck");
        } else {
            $("#dataList td input[type='checkbox']").iCheck("check");
        }
        $(this).data("clicks", !clicks);
    });
});

function changePageSize() {
    //获取下拉框的值
    var pageSize = $("#changePageSize").val();
    //向服务器发送请求，改变没页显示条数
    location.href = "findAll.do?page=1&size="
        + pageSize;
}

// 设置激活菜单
function setSidebarActive(tagUri) {
    var liObj = $("#" + tagUri);
    if (liObj.length > 0) {
        liObj.parent().parent().addClass("active");
        liObj.addClass("active");
    }
}






//首页
function ShouYe(size) {
    //向服务器发送请求，改变没页显示条数
    location.href = "findAll.do?page=1&size="+size;
}
//上一页
function Shangyie(pageNum,pageSize) {
    //向服务器发送请求，改变没页显示条数
    location.href = "findAll.do?page="+pageNum+"&size="+pageSize;
}
//中间开启循环
function zhongjianxunhuan(pageNum,pageSize){
    //向服务器发送请求，改变没页显示条数
    location.href = "findAll.do?page="+pageNum+"&size="+pageSize;
}
//下一页
function xiayiye(pageNum,pageSize) {
    //向服务器发送请求，改变没页显示条数
    location.href = "findAll.do?page="+pageNum+"&size="+pageSize;
}
//尾页
function weiye(pages,pageSize) {
    //向服务器发送请求，改变没页显示条数
    location.href = "findAll.do?page="+pages+"&size="+pageSize;
}



//拟态框
// 创建客户

function create1(url) {
    console.log($("#insertform").serialize())
    $.post(url+"/create.do", $("#insertform").serialize(), function (data) {
        if (data == "OK") {
            alert("创建成功！");
            window.location.reload();
        } else if(data=="FAIL") {
            console.log(data)
            alert("创建失败！请检查数据是否正确");
            window.location.reload();
        }else {
            alert(data)
            window.location.reload();
        }
    });
}

//删除事件
function delete1(url,id) {
    if (confirm('确定要删除吗？')) {
        $.post(url+"/delete.do", {"id": id}, function (data) {
            if (data == "OK") {
                alert("删除成功！");
                window.location.reload();
            } else {
                alert(data);
                window.location.reload();
            }
        });
    }
}

//更改事件
function update1(url) {
    if (confirm('确定要修改吗？')) {
        $.post(url+"/update.do", $("#updateform").serialize(), function (data) {
            if (data == "OK") {
                alert("修改成功！");
                window.location.reload();
            }else if(data=="FAIL") {
                console.log(data)
                alert("修改失败！请检查数据是否正确");
                window.location.reload();
            }else {
                alert(data)
                window.location.reload();
            }
        });
    }
}

