$(document).ready ->
  width = 743
  height = 560
  color = d3.scale.category10()
  w = 25
  h = 25
  svg = d3.select("#graph").append("svg").attr("width", width).attr("height", height)
  path =
    fitscore: "fitscore_match"
    company: "company_match"
    follower: "following_match"

  force = d3.layout.force().gravity(.05).linkDistance(160).charge(-10).size([width, height])
  $(".buttons div").on "click", ->
    d3.json "/users/" + path[@id], (error, graph) ->
      force.nodes(graph.nodes).links(graph.links).start()
      link = svg.selectAll(".link").data(graph.links).enter().append("line").attr("class", "link").style("stroke-width", 1)
      node = svg.selectAll(".node").data(graph.nodes).enter().append("circle").attr("class", "node").attr("r", (i) ->
        i.size
      ).style("fill", (i) ->
        i.color
      ).call(force.drag)
      node.append("text").attr("dx", 12).attr("dy", ".35em").text (d) ->
        d.name

      force.on "tick", ->
        link.attr("x1", (d) ->
          d.source.x
        ).attr("y1", (d) ->
          d.source.y
        ).attr("x2", (d) ->
          d.target.x
        ).attr "y2", (d) ->
          d.target.y

        node.attr("cx", (d) ->
          d.x
        ).attr "cy", (d) ->
          d.y