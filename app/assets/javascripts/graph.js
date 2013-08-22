$(document).ready(function() {
	$('#graph').on('click', 'circle', function() {
		var name = $($(this)[0]).children().text();
		$('.remove').remove();
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
		$('#name').html(name);
	});

	$('#fitscore').trigger('click');

	$('.buttons div').on('click', function() {
		$('.buttons div').removeClass('active');
		$(this).addClass('active');
	});
});