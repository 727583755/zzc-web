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
    <title>按专辑批量增加音乐</title>
<#include "inc-header-resource.ftl">
<#include "inc-fine-upload.ftl" />
<#include "inc-autocomplete.ftl">
</head>

<body>
<div class="container">
    <div class="row">
        <label class="control-label">专辑信息：</label>
        <table class="table table-striped table-bordered table-hover">
            <thead>
            <input type="hidden" id="maxIndex" value="0">
            <tr>
                <th>专辑名</th>
                <th>歌手</th>
                <th>专辑信息</th>
                <th>封面图片</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>${data.title}</td>
                <td>${data.announcerName}</td>
                <td>
                <#if data.albumInfo?length lt 20 >
                    <a href="#" data-toggle="tooltip" title="${data.albumInfo}">${data.albumInfo}</a>
                <#else>
                    <a href="#" data-toggle="tooltip" title="${data.albumInfo}">${data.albumInfo[0..19]}...</a>
                </#if>
                </td>
                <td><img src="${data.coverUrl}" width="80px" height="80px"></img></td>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="row">
        <label class="control-label">该专辑已有歌曲列表：</label>
        <table class="table table-striped table-bordered table-hover">
            <thead>
            <input type="hidden" id="maxIndex" value="0">
            <tr>
                <th>歌名</th>
                <th>歌手</th>
                <th>比特率</th>
                <th>路径</th>
                <th>大小</th>
                <th>时长</th>
            </tr>
            </thead>
            <tbody>
            <#list musicList as p>
            <tr>
                <td>${p.title}</td>
                <td>${p.announcerName}</td>
                <td>${p.bitrate}</td>
                <td>
                    <#if p.filePath?length lt 20 >
                        <a href="#" data-toggle="tooltip" title="${p.filePath}">${p.filePath}</a>
                    <#else>
                        <a href="#" data-toggle="tooltip" title="${p.filePath}">${p.filePath[0..19]}...</a>
                    </#if>
                </td>
                <td><#if p.size != null>${p.size/1024/1024}M</#if></td>
                <td><#if p.duration != null>${p.duration/1000/60%10}:${p.duration/1000/60/10*60%100}</#if></td>
            </#list>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="row">
        <form action="${WEB_ROOT_PATH}/admin/musicalbum/batchSave" method="post" class="form-inline">
            <input type="hidden" name="albumTitle" value="${data.title}"/>
            <input type="hidden" name="albumId" value="${data.id}"/>
            <input type="hidden" name="announcerName" value="${data.announcerName}"/>
            <input type="hidden" name="announcerId" value="${data.announcerId}"/>

            <label class="control-label">类别选择：</label><br/>
            <#list typeMap?keys as key>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <label class="control-label">${key}</label>
                <#list typeMap[key] as type>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="type" value="${type}" >&nbsp;${type}&nbsp;&nbsp;
                        </label>
                    </div>
                </#list>
                <br/>
            </#list>
            <br/>
            <label class="control-label">批量上传专辑新歌曲：</label>

            <div id="fileUpload"></div>
            <br/>


            <table class="table table-striped table-bordered table-hover">
                <thead>
                <input type="hidden" id="maxIndex" value="0">
                <tr>
                    <th>歌名</th>
                    <th>热度</th>
                    <th>路径</th>
                    <th>大小</th>
                    <th>时长</th>
                    <th>比特率</th>
                </tr>
                </thead>
                <tbody id="tbodyId">
                </tbody>
            </table>
            <br/>
            <br/>

            <button type="submit" id="submitbtn" class="btn btn-primary btn-md btn-block">提交保存</button>
            <br/>
        </form>
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
    </div>

</div>

</body>

<script>
    var uploader = new qq.FineUploader({
        element: document.getElementById('fileUpload'),
        request: {
            endpoint: '${WEB_ROOT_PATH}/admin/fileUpload/musicFile'
        },
        multiple: true,
        callbacks: {
            onUpload: function (id, name) {
                $("#submitbtn").attr("disabled", true);
            },
            onComplete: function (id, fileName, data) {
                if (data.status == 100) {
                    var maxIndex = $("#maxIndex").val();
                    $("#maxIndex").val(Number(maxIndex) + Number(1));
                    var tr = "<tr>";
                    tr += '<td><input type="text" class="form-control" name="musics[' + maxIndex + '].title" value="' + data.info.title + '"></td>';
                    tr += '<td><input type="text" class="form-control" name="musics[' + maxIndex + '].hot" value="50" ></td>';
                    tr += '<td><input type="text" class="form-control" name="musics[' + maxIndex + '].filePath" value="' + data.filePath + '" readonly="readonly" ></td>';
                    tr += '<td><input type="text" class="form-control" name="musics[' + maxIndex + '].size" value="' + data.info.size + '" readonly="readonly" >' + (data.info.size / 1024 / 1024) + 'M</td>';
                    tr += '<td><input type="text" class="form-control" name="musics[' + maxIndex + '].duration" value="' + data.info.duration + '" readonly="readonly"></td>';
                    tr += '<td><input type="text" class="form-control" name="musics[' + maxIndex + '].bitrate" value="' + data.info.bitrate + '" readonly="readonly" ></td>';
                    tr += "</tr>";
                    $("#tbodyId").append(tr);
                } else {
                    alert("上传失败！");
                }
                $("#submitbtn").attr("disabled", false);
            }
        }
    });

</script>

<script>

    $(function () {
        $("#author").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: webrootpath + "/rest/autocomplete/getSingerByName",
                    dataType: "json",
                    type: "post",
                    data: {
                        name: request.term
                    },
                    success: function (data) {
                        response($.map(data.datas, function (item) {
                            return {
                                label: item.name,
                                value: item.name
                            };
                        }));
                    }
                });
            }
        });

        $("#album").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: webrootpath + "/rest/autocomplete/getAlbum",
                    dataType: "json",
                    type: "post",
                    data: {
                        name: request.term
                    },
                    success: function (data) {
                        response($.map(data.datas, function (item) {
                            return {
                                label: item,
                                value: item
                            };
                        }));
                    }
                });
            }
        });

    })

</script>

</html>