$(document).ready(function() {

		var width = 743,
			height = 560;

		var color = d3.scale.category10();

		var w = 25,
			h = 25;

		var svg = d3.select("#graph").append("svg")
			.attr("width", width)
			.attr("height", height);

		var path = {
			fitscore: "fitscore_match",
			company: "company_match",
			follower: "following_match"
		};

		var force = d3.layout.force()
			.gravity(.03)
			.linkDistance(function(d) {
				return 500 - (d.target.size * 20)
			})
			.charge(-10)
			.size([width, height]);

	$('.buttons div').on('click', function() {
		d3.json("/users/" + path[this.id], function(error, graph) {
			force
				.nodes(graph.nodes)
				.links(graph.links)
				.start();

			var link = svg.selectAll(".link")
				.data(graph.links)
				.enter().append("line")
				.attr("class", "link")
				.style("stroke-width", 1);


			var node = svg.selectAll(".node")
				.data(graph.nodes)
				.enter().append("circle")
				.attr("class", "node")
				.attr("r", function(i) {
					return i.size;
				})
				.style("fill", function(i) {
					return i.color;
				})
				.call(force.tick);

			node.append("text")
				.attr("dx", 12)
				.attr("dy", ".35em")
				.text(function(d) {
					return d.name;
				});

			force.on("tick", function() {
				link.attr("x1", function(d) {
					return d.source.x;
				})
					.attr("y1", function(d) {
						return d.source.y;
					})
					.attr("x2", function(d) {
						return d.target.x;
					})
					.attr("y2", function(d) {
						return d.target.y;
					});

				node.attr("cx", function(d) {
					return d.x;
				})
					.attr("cy", function(d) {
						return d.y;
					});
			});

		});
	});
});