$(document).ready(function() {
	$('#graph').on('click', 'circle', function() {
		$('.remove').hide();
		var x_coord = event.pageX;
		var y_coord = event.pageY;
		$('body').append($('#drilldown')
														.clone()
														.show()
														.addClass('remove')
														.css("top", y_coord)
														.css("left", x_coord)
														);
	});

});