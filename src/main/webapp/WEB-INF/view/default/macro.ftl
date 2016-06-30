<style>
.pager-a{
	float:left;
	border: 1px solid #dddddd;
	border-left:0;
	line-height:25px;
	padding:0 8px;"
}
</style>
<script>
// 初始加载页面
$(function(){
	// 分页的提交
	$("#pagerId a").click(function(){
		var formId = $("#formId").val();
		var form ;
		if(formId == ""){
			form = $("form");
		} else {
			form = $("#" + formId);
		}
		var action = $(this).attr('href');
		if(action.indexOf('javascript') > 0){
			return true;
		}
        form.attr('action', action);
        form.submit();
        return false;
	});
	
	// 分页跳转到指定页
	$("#queryByPageNum").mouseover(function(){
		var obj = $("#queryByPageNum");
		obj.attr("href",obj.attr("href")+$("#jumpPageNum").val());
	})
	
}); 


</script>

<#macro pager url data formId>
    <div id='pagerId' style="height:30px;margin-top:10px;">
		<div style="float:right;margin-right:10px;">
			<#if data.pageNum == 1>
				<a href="javascript:void();" style="float:left;border: 1px solid #dddddd;line-height:25px;padding:0 5px;">上一页</a>
			<#else>
				<a href="${url}?p=${data.pageNum-1}" style="float:left;border: 1px solid #dddddd;line-height:25px;padding:0 5px;">上一页</a>
			</#if>
			<#list 1..data.maxPageNum as t>
				<#if t == data.pageNum>
					<span style="float:left;border: 1px solid #dddddd;border-left:0;line-height:25px;padding:0 8px;background-color:#f5f5f5;">${t}</span>
				<#else>
					<#if data.maxPageNum lte 7>
						<a href="${url}?p=${t}" class="pager-a">${t}</a>
					<#else>
						<#if t == data.maxPageNum || t == data.maxPageNum-1>
							<a href="${url}?p=${t}" class="pager-a">${t}</a>
						<#else>
							<#if data.pageNum lte 5 && t lte 5>
								<a href="${url}?p=${t}" class="pager-a">${t}</a>
							<#elseif data.pageNum == 5 && (t == 6 || t == 7)>
								<a href="${url}?p=${t}" class="pager-a">${t}</a>
							<#elseif (data.pageNum lt 5 && t == 6) || (data.pageNum == 5 && t == 8)>
								<a href="javascript:void();" class="pager-a">...</a>
							<#elseif data.pageNum gte 6>
								<#if t == 1 || t ==2>
									<a href="${url}?p=${t}" class="pager-a">${t}</a>
								<#elseif t == 3>
									<a href="javascript:void();" class="pager-a">...</a>
								<#elseif t == data.pageNum-2 || t == data.pageNum-1>
									<a href="${url}?p=${t}" class="pager-a">${t}</a>
								<#elseif t == data.pageNum+2 || t == data.pageNum+1>
									<a href="${url}?p=${t}" class="pager-a">${t}</a>
								<#elseif t == data.pageNum+3 && t != data.maxPageNum>
									<a href="javascript:void();" class="pager-a">...</a>
								</#if>
							</#if>
						</#if>
					</#if>
				</#if>
			</#list>
			<#if data.pageNum == data.maxPageNum>
				<a href="javascript:void();" style="float:left;border: 1px solid #dddddd;border-left:0;line-height:25px;padding:0 5px;">下一页</a>
			<#else>
				<a href="${url}?p=${data.pageNum+1}" style="float:left;border: 1px solid #dddddd;border-left:0;line-height:25px;padding:0 5px;">下一页</a>
			</#if>
			<span style="text-align:center;margin-left:12px;">共${data.maxPageNum}页，到第
				<input type="number" id="jumpPageNum" style="width:<#if (data.maxPageNum?length)*13 lt 37>37<#else>${(data.maxPageNum?length)*15}</#if>px;text-align:center" max="${data.maxPageNum}" min="1" value="${data.pageNum}">页
				<span><a href="${url}?p=" id="queryByPageNum" style="border: 1px solid #dddddd;border-left:0;line-height:25px;padding:0 5px;">确定</a></span>
			</span>
			<input type="hidden" id="formId" value="${formId}" />
		</div>
		<label class="control-label" style="float:right;width:120px;text-align:left;margin-left:10px;">共有${data.totalCount}条记录</label>
	</div>
</#macro>
