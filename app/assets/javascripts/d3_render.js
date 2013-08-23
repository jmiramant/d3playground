function clearScreen(){
	$('#graph svg').empty();
	$('.remove').remove();
}

$(document).ready(function() {

	var width = 743,
		height = 530;

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
		.gravity(0.08)
		.friction(0.45)
		.linkDistance(function(d) {
			var dist = 500 - d.target.size * 22;
			if (dist > 200) {
				return dist - 40;
			} else {
				return dist;
			}
		})
		.charge(-300)
		.size([width, height]);

	$('.buttons div').on('click', function() {
		clearScreen();
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
				.attr("cx", function(d) {
					return d.x;
				})
				.attr("cy", function(d) {
					return d.y;
				})
				.attr("class", "node")
				.attr("r", function(i) {
					return i.size;
				})
				.style("fill", function(i) {
					return i.color;
				})
				.call(force.drag);

			node.append("text")
				.attr("dx", 12)
				.attr("dy", ".35em")
				.text(function(d) {
					return d.name;
				});

			node.append("svg:path")
				.attr("transform", function(d) {
					return "translate(" + d.x + "," + d.y + ")";
				});

			function tick(e) {
				var k = 6 * e.alpha;
				graph.nodes.forEach(function(o, i) {
					o.y += i & 1 ? k : -k;
					o.x += i & 2 ? k : -k;
				});

				d3.layout.force().attr("cx", function(d) {
					return d.x;
				})
					.attr("cy", function(d) {
						return d.y;
					});
			}

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