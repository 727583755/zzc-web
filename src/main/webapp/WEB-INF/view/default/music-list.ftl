<!doctype html>
<html>

<head>
    <meta charset="utf-8"/>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
    <meta name="apple-touch-fullscreen" content="no"/>
    <meta content="telephone=no" name="format-detection"/>
    <meta name="apple-mobile-web-app-capable" content="no"/>
    <title>音乐列表</title>
<#include "inc-header-resource.ftl">
<#include "macro.ftl">
</head>

<body>
<div class="container">
    <div class="row">
        <button type="button" class="btn btn-success" onclick="location='${WEB_ROOT_PATH}/admin/music/add'">新增</button>
    </div>
</div>

<div class="container">
    <div class="row">
        <form class="form-inline" action="${WEB_ROOT_PATH}/admin/music" method="post" id="myForm">
            <label class="control-label">标题</label>
            <input type="text" name="search['title']" class="form-control" value="${data.cholder.search['title']}">

            <label class="control-label">是否上架</label>
            <select name="search['enabled']" class="form-control">
                <option value="" <#if data.cholder.search[ 'enabled']==''>selected</#if>>不限</option>
                <option value="1" <#if data.cholder.search[ 'enabled']=='1'>selected</#if>>上架</option>
                <option value="0" <#if data.cholder.search[ 'enabled']=='0'>selected</#if>>下架</option>
            </select>

            <label class="control-label">热度排序</label>
            <select name="search['hotSort']" class="form-control">
                <option value="" <#if data.cholder.search[ 'hotSort']==''>selected</#if>>不限</option>
                <option value="DESC" <#if data.cholder.search[ 'hotSort']=='DESC'>selected</#if>>从高到低</option>
                <option value="ASC" <#if data.cholder.search[ 'hotSort']=='ASC'>selected</#if>>从低到高</option>
            </select>

            <button type="submit" class="btn btn-primary">搜索</button>
        </form>
    </div>
</div>

<br/>

<div class="container">
    <div class="row">
        <table class="table table-striped table-bordered table-hover">
            <thead>
            <tr>
                <th>ID</th>
                <th>标题</th>
                <th>类型</th>
                <th>专辑id</th>
                <th>专辑名</th>
                <th>比特率</th>
                <th>路径</th>
                <th>大小</th>
                <th>歌手</th>
                <th>时长</th>
                <th>修改时间</th>
                <th>上架</th>
                <th>热度</th>
                <th style="width: 250px;">操作</th>
            </tr>
            </thead>
            <tbody>
            <#list data.result as p>
            <tr>
                <td>${p.id}</td>
                <td>
                    <#if p.title?length lt 10 >
                        <a href="#" data-toggle="tooltip" title="${p.title}">${p.title}</a>
                    <#else>
                        <a href="#" data-toggle="tooltip" title="${p.title}">${p.title[0..9]}...</a>
                    </#if>
                </td>
                <td>${p.type}</td>
                <td>${p.albumId}</td>
                <td>
                    <#if p.albumTitle?length lt 20 >
                        <a href="#" data-toggle="tooltip" title="${p.albumTitle}">${p.albumTitle}</a>
                    <#else>
                        <a href="#" data-toggle="tooltip" title="${p.albumTitle}">${p.albumTitle[0..20]}...</a>
                    </#if>
                </td>
                <td>${p.bitrate}</td>
                <td>
                    <#if p.filePath?length lt 10 >
                        <a href="#" data-toggle="tooltip" title="${p.filePath}">${p.filePath}</a>
                    <#else>
                        <a href="#" data-toggle="tooltip" title="${p.filePath}">${p.filePath[0..9]}...</a>
                    </#if>
                </td>
                <td><#if p.size != null>${p.size/1024/1024}M</#if></td>
                <td>${p.announcerName}</td>
                <td><#if p.duration != null>${p.duration/1000/60%10}:${p.duration/1000/60/10*60%100}</#if></td>
                <td>${p.modifyTime}</td>
                <td id="enabled_${p.id}">${p.enabled}</td>
                <td>${p.hot}</td>
                <td>
                    <a target="_blank" href="${WEB_ROOT_PATH}/admin/music/${p.id}?p=${data.pageNum}">
                        <button type="button" class="btn btn-primary">修改</button>
                    </a>
                    <button type="button" class="btn <#if p.enabled == 0>btn-success<#else>btn-warning</#if>"
                            onclick="changeStatus(${p.id}, this)"><#if p.enabled == 0>上架<#else>下架</#if></button>
                    <button type="button" class="btn btn-primary" onclick="matchAlbum(${p.id}, '${p.albumTitle}')">匹配专辑
                    </button>
                </td>
            </tr>
            </#list>
            </tbody>
        </table>
    </div>
<@pager url="${WEB_ROOT_PATH}/admin/music" data=data formId="myForm"/>

</div>


<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 1000px; height: 600px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">

                </h4>
            </div>
            <div class="modal-body">
                <form class="form-inline">
                    <input type="hidden" id="musicId">
                    <input type="text" class="form-control" placeholder="请输入关键字..." id="searchKey" style="width: 300px;"/>
                    <button type="button" class="btn btn-primary" onclick="search()">搜索</button>
                    <table class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>专辑名</th>
                            <th>歌手</th>
                            <th>专辑信息</th>
                            <th style="width: 250px;">操作</th>
                        </tr>
                        </thead>
                        <tbody id="tbody">
                        </tbody>
                </form>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->

</body>

<script>
    function matchAlbum(musicId, albumTitle) {
        $('#musicId').val(musicId);
        $('#searchKey').val(albumTitle);
        search();
        $('#myModal').modal('show');
    }

    function search() {
        var searchKey = $("#searchKey").val();
        var musicId = $("#musicId").val();
        $.ajax({
            url: "${WEB_ROOT_PATH}/admin/musicalbum/search",
            dataType: "json",
            type: "post",
            data: {
                searchKey: searchKey
            },
            success: function (data) {
                var str = " ";
                for (var i=0; i<data.length; i++) {
                    str += '<tr>';
                    str += '<td>' + data[i].title + '</td>';
                    str += '<td>' + data[i].announcerName + '</td>';
                    str += '<td>' + data[i].albumInfo + '</td>';
                    str += '<td><button type="button" class="btn btn-success btn-block" onclick="match(' + data[i].id + ', '+ musicId +')">匹配</button></td>';
                    str += '</tr>';
                }
                $("#tbody").empty()
                $("#tbody").append(str);
            }
        });
    }

    function match(albumId, musicId) {
        $.ajax({
            url: "${WEB_ROOT_PATH}/admin/music/match",
            dataType: "json",
            type: "post",
            data: {
                albumId: albumId,
                musicId:musicId
            },
            success: function (data) {
                $('#myModal').modal('hide');
            }
        });
    }

    function redirect(id) {
        window.open('${WEB_ROOT_PATH}/admin/musicalbum/story/query/' + id + '?p=${data.pageNum}', '_blank');
    }

    function listenIt(url, who) {
        var audio = '<audio controls>'
        audio += '<source src="' + url + '" type="audio/mpeg">您的浏览器不支持 audio 元素。';
        audio += '<source src="' + url + '" type="audio/ogg">您的浏览器不支持 audio 元素。';
        audio += '</audio>';
        $(who).parent().children().remove("audio");
        $(who).parent().append(audio);
    }

    function deleteStoryTitle(id) {
        var password = window.prompt("输入删除密码：")
        if (password != "" && password != null) {
            window.location = "${WEB_ROOT_PATH}/admin/storyalbum/delete/" + id + "?p=${data.pageNum}&password=" + password;
        }
    }

    function changeStatus(id, who) {
        var enabled = $("#enabled_" + id).text();
        if (enabled == 0) {
            enabled = 1;
            $("#enabled_" + id).text(enabled);
            $(who).addClass("btn-warning");
            $(who).text("下架");
        } else if (enabled == 1) {
            enabled = 0;
            $("#enabled_" + id).text(enabled);
            $(who).removeClass("btn-warning");
            $(who).addClass("btn-success");
            $(who).text("上架");
        }

        $.ajax({
            url: "${WEB_ROOT_PATH}/admin/music/changeStatus",
            dataType: "json",
            type: "post",
            data: {
                id: id,
                enabled: enabled
            },
            success: function (data) {

            }
        });
    }

    function selectTag() {
        $('#myModal').modal('show');
        checkTag();
        $("#submitbtn").bind("click", function () {
            var tagStr = "";
            $("#myContent input:checked").each(function (i) {
                tagStr += $(this).val() + ";";
            });
            $("#tag").val(tagStr);
            $('#myModal').modal('hide');
            $("#myForm").submit();
        })
    }

    function checkTag() {
        var tagStr = $("#tag").val();
        var arr = tagStr.split(";")
        $("#myContent input").each(function (i) {
            if (tagStr.indexOf($(this).val()) != -1) {
                $(this).attr("checked", true);
            }
        });
    }

</script>

</html>