<!doctype html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
		<meta name="apple-touch-fullscreen" content="no" />
		<meta content="telephone=no" name="format-detection" />
		<meta name="apple-mobile-web-app-capable" content="no" />
		<title>技能</title>
		<#include "inc-header-resource.ftl">
		<#include "inc-fine-upload.ftl" />
	</head>

	<body>
		<div class="container">
			<div class="row">
				<form action="${WEB_ROOT_PATH}/admin/skill/save" method="post" class="form-inline">
					<input type="hidden" name="p" value="${p}">
					<input type="hidden" name="id" value="${data.id}">
					<input type="hidden" name="modifyTime" value="${data.modifyTime}">
					
					<label class="control-label">技能名称</label>
					<input type="text" name="skillName" class="form-control" value="${data.skillName}">
					<span class="text-danger">不能为空</span>
					<br/>
                    <label class="control-label">技能代码</label>
                    <input type="text" name="skillCode" class="form-control" value="${data.skillCode}">
                    <span class="text-danger">不能为空(语义组给的代码)</span>
                    <br/>
					<br/>
					<label class="control-label">技能未启用图片地址</label>
					<input type="text" name="skillIconUnused" id="skillIconUnused" style="width:600px;" class="form-control" value="${data.skillIconUnused}">
					<div id="img_unused"></div>
					<br/>
                    <label class="control-label">技能未解锁图片地址</label>
                    <input type="text" name="skillIconLocked" id="skillIconLocked" style="width:600px;" class="form-control" value="${data.skillIconLocked}">
                    <div id="img_locked"></div>
                    <br/>
                    <label class="control-label">技能已解锁图片地址</label>
                    <input type="text" name="skillIconUnlocked" id="skillIconUnlocked" style="width:600px;" class="form-control" value="${data.skillIconUnlocked}">
                    <div id="img_unlocked"></div>
                    <br/>
					<br/>
					<label class="control-label">技能当前状态</label>
                    <select name="skillStatus" class="form-control">
                        <option value="0" <#if data.skillStatus=='0'>selected</#if>>未启用</option>
                        <option value="1" <#if data.skillStatus=='1'>selected</#if>>已解锁</option>
                        <option value="2" <#if data.skillStatus=='2'>selected</#if>>未解锁</option>
                    </select>
					<br/>
                    <label class="control-label">解锁所需金币</label>
                    <input type="text" name="costCoin" class="form-control" value="${data.costCoin}">
                    <br/>
					<br/>
					<label class="control-label">技能描述</label>
					<input type="text" name="skillDesc" class="form-control" value="${data.skillDesc}">
					<span class="text-danger">不能为空</span>
					<br/>
					<br/>
					<button type="submit" id="submitbtn" class="btn btn-primary btn-md">提交保存</button>
					<br/>
				</form>
				<br/>
			</div>

		</div>

	</body>

	<script type="text/template" id="qq-template-gallery">
        <div class="qq-uploader-selector qq-uploader qq-gallery" qq-drop-area-text="Drop files here">
            <div class="qq-total-progress-bar-container-selector qq-total-progress-bar-container">
                <div role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" class="qq-total-progress-bar-selector qq-progress-bar qq-total-progress-bar"></div>
            </div>
            <div class="qq-upload-drop-area-selector qq-upload-drop-area" qq-hide-dropzone>
                <span class="qq-upload-drop-area-text-selector"></span>
            </div>
            <div class="qq-upload-button-selector qq-upload-button">
                <div>上传图片</div>
            </div>
            <span class="qq-drop-processing-selector qq-drop-processing">
                <span>Processing dropped files...</span>
                <span class="qq-drop-processing-spinner-selector qq-drop-processing-spinner"></span>
            </span>
            <ul class="qq-upload-list-selector qq-upload-list" role="region" aria-live="polite" aria-relevant="additions removals">
                <li>
                    <span role="status" class="qq-upload-status-text-selector qq-upload-status-text"></span>
                    <div class="qq-progress-bar-container-selector qq-progress-bar-container">
                        <div role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" class="qq-progress-bar-selector qq-progress-bar"></div>
                    </div>
                    <span class="qq-upload-spinner-selector qq-upload-spinner"></span>
                    <div class="qq-thumbnail-wrapper">
                        <img class="qq-thumbnail-selector" qq-max-size="120" qq-server-scale>
                    </div>
                    <button type="button" class="qq-upload-cancel-selector qq-upload-cancel">X</button>
                    <button type="button" class="qq-upload-retry-selector qq-upload-retry">
                        <span class="qq-btn qq-retry-icon" aria-label="Retry"></span>
                        Retry
                    </button>

                    <div class="qq-file-info">
                        <div class="qq-file-name">
                            <span class="qq-upload-file-selector qq-upload-file"></span>
                            <span class="qq-edit-filename-icon-selector qq-edit-filename-icon" aria-label="Edit filename"></span>
                        </div>
                        <input class="qq-edit-filename-selector qq-edit-filename" tabindex="0" type="text">
                        <span class="qq-upload-size-selector qq-upload-size"></span>
                        <button type="button" class="qq-btn qq-upload-delete-selector qq-upload-delete">
                            <span class="qq-btn qq-delete-icon" aria-label="Delete"></span>
                        </button>
                        <button type="button" class="qq-btn qq-upload-pause-selector qq-upload-pause">
                            <span class="qq-btn qq-pause-icon" aria-label="Pause"></span>
                        </button>
                        <button type="button" class="qq-btn qq-upload-continue-selector qq-upload-continue">
                            <span class="qq-btn qq-continue-icon" aria-label="Continue"></span>
                        </button>
                    </div>
                </li>
            </ul>

            <dialog class="qq-alert-dialog-selector">
                <div class="qq-dialog-message-selector"></div>
                <div class="qq-dialog-buttons">
                    <button type="button" class="qq-cancel-button-selector">Close</button>
                </div>
            </dialog>

            <dialog class="qq-confirm-dialog-selector">
                <div class="qq-dialog-message-selector"></div>
                <div class="qq-dialog-buttons">
                    <button type="button" class="qq-cancel-button-selector">No</button>
                    <button type="button" class="qq-ok-button-selector">Yes</button>
                </div>
            </dialog>

            <dialog class="qq-prompt-dialog-selector">
                <div class="qq-dialog-message-selector"></div>
                <input type="text">
                <div class="qq-dialog-buttons">
                    <button type="button" class="qq-cancel-button-selector">Cancel</button>
                    <button type="button" class="qq-ok-button-selector">Ok</button>
                </div>
            </dialog>
        </div>
    </script>
	
	<script>
		var galleryUploader = new qq.FineUploader({
            element: document.getElementById("img_unused"),
            template: 'qq-template-gallery',
            multiple: false,
            request: {
                endpoint: '${WEB_ROOT_PATH}/admin/skill/imageUpload'
            },
            callbacks: {
				onUpload: function (id, name) {
					
        	    },
				onComplete: function(id, fileName, data) {
					if (data.status == 100) {
						$("#skillIconUnused").val(data.filePath);
					} else {
						alert("上传失败！");
					}
				}
			},
            thumbnails: {
                placeholders: {
                    waitingPath: '${WEB_ROOT_PATH}/static/fine-uploader-5.3.2/placeholders/waiting-generic.png',
                    notAvailablePath: '${WEB_ROOT_PATH}/static/fine-uploader-5.3.2/placeholders/not_available-generic.png'
                }
            },
            validation: {
                allowedExtensions: ['jpeg', 'jpg', 'gif', 'png']
            }
        });
        var galleryUploader2 = new qq.FineUploader({
            element: document.getElementById("img_locked"),
            template: 'qq-template-gallery',
            multiple: false,
            request: {
                endpoint: '${WEB_ROOT_PATH}/admin/skill/imageUpload'
            },
            callbacks: {
                onUpload: function (id, name) {

                },
                onComplete: function(id, fileName, data) {
                    if (data.status == 100) {
                        $("#skillIconLocked").val(data.filePath);
                    } else {
                        alert("上传失败！");
                    }
                }
            },
            thumbnails: {
                placeholders: {
                    waitingPath: '${WEB_ROOT_PATH}/static/fine-uploader-5.3.2/placeholders/waiting-generic.png',
                    notAvailablePath: '${WEB_ROOT_PATH}/static/fine-uploader-5.3.2/placeholders/not_available-generic.png'
                }
            },
            validation: {
                allowedExtensions: ['jpeg', 'jpg', 'gif', 'png']
            }
        });
        var galleryUploader3 = new qq.FineUploader({
            element: document.getElementById("img_unlocked"),
            template: 'qq-template-gallery',
            multiple: false,
            request: {
                endpoint: '${WEB_ROOT_PATH}/admin/skill/imageUpload'
            },
            callbacks: {
                onUpload: function (id, name) {

                },
                onComplete: function(id, fileName, data) {
                    if (data.status == 100) {
                        $("#skillIconUnlocked").val(data.filePath);
                    } else {
                        alert("上传失败！");
                    }
                }
            },
            thumbnails: {
                placeholders: {
                    waitingPath: '${WEB_ROOT_PATH}/static/fine-uploader-5.3.2/placeholders/waiting-generic.png',
                    notAvailablePath: '${WEB_ROOT_PATH}/static/fine-uploader-5.3.2/placeholders/not_available-generic.png'
                }
            },
            validation: {
                allowedExtensions: ['jpeg', 'jpg', 'gif', 'png']
            }
        });
	</script>
	
</html>