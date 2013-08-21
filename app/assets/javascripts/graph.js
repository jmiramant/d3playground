$(document).ready(function() {
	$('#graph').on('click', 'circle', function() {
		$('.remove').hide();
		var name = ($($(this)[0]).text());
		var x_coord = event.pageX + 20;
		var y_coord = event.pageY - 40;
		$('body').append(
			$('#drilldown')
			.clone()
			.fadeIn()
			.addClass('remove')
			.css("top", y_coord)
			.css("left", x_coord)
		);
	});

	$('#fitscore').trigger('click');

	$('.buttons div').on('click', function() {
		$('.buttons div').removeClass('active');
		$(this).addClass('active');
	});
});