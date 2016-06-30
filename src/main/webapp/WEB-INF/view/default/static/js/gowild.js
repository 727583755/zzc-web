$(function() {
	$.each($("table thead tr th"), function(i, n) {
		var name = $(n).html();
		var width = name.length * 23;
		$(n).css("min-width", width).css("text-align", "center");
	});
	$("table thead tr").css("background-color", "#c9c9c9");
})