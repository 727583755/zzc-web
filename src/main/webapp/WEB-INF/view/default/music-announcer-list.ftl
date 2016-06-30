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
    <title>歌手列表</title>
<#include "inc-header-resource.ftl">
<#include "macro.ftl">
</head>

<body>
<div class="container">
    <div class="row">
        <button type="button" class="btn btn-success" onclick="location='${WEB_ROOT_PATH}/admin/musicannouncer/add'">
            新增
        </button>
    </div>
</div>

<div class="container">
    <div class="row">
        <form class="form-inline" action="${WEB_ROOT_PATH}/admin/musicannouncer" method="post" id="myForm">

            <label class="control-label">姓名</label>
            <input type="text" name="search['name']" class="form-control" value="${data.cholder.search['name']}">

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
                <th>姓名</th>
                <th>热度</th>
                <th>歌的数量</th>
                <th>性别</th>
                <th>星座</th>
                <th>专辑数</th>
                <th>国籍</th>
                <th>类型</th>
                <th>图象</th>
                <th>简介</th>
                <th>修改时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <#list data.result as p>
            <tr>
                <td>${p.id}</td>
                <td>${p.name}</td>
                <td>${p.hot}</td>
                <td>${p.songNum}</td>
                <td>${p.sex}</td>
                <td>${p.star}</td>
                <td>${p.albumNum}</td>
                <td>${p.nationality}</td>
                <td>${p.classify}</td>
                <td>
                    <img src="${p.photoUrl}" width="80px" height="80px">
                </td>
                <td>
                    <#if p.introduction?length lt 20 >
                        <a href="#" data-toggle="tooltip" title="${p.introduction}">${p.introduction}</a>
                    <#else>
                        <a href="#" data-toggle="tooltip" title="${p.introduction}">${p.introduction[0..19]}...</a>
                    </#if>
                </td>
                <td>${p.modifyTime}</td>
                <td>
                    <button type="button" class="btn btn-primary" onclick="location='${WEB_ROOT_PATH}/admin/musicannouncer/${p.id}?p=${data.pageNum}'">修改</button>
                    <button type="button" class="btn btn-primary"
                            onclick="location='${WEB_ROOT_PATH}/admin/musicannouncer/delete/${p.id}'">删除
                    </button>
                </td>
            </tr>
            </#list>
            </tbody>
        </table>
    </div>
<@pager url="${WEB_ROOT_PATH}/admin/musicannouncer" data=data/>

</div>
</body>

<script>


</script>

</html>