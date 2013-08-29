clearScreen = ->
  $("#graph svg").empty()
  $(".remove").remove()
$(document).ready ->
  width = 743
  height = 530
  color = d3.scale.category10()
  w = 25
  h = 25
  svg = d3.select("#graph").append("svg").attr("width", width).attr("height", height)
  path =
    fitscore: "fitscore_match"
    company: "company_match"
    follower: "following_match"

  force = d3.layout.force().gravity(0.08).friction(0.45).linkDistance((d) ->
    dist = 500 - d.target.size * 22
    if dist > 200
      dist - 40
    else
      dist
  ).charge(-300).size([width, height])
  $(".buttons div").on "click", ->
    clearScreen()
    d3.json "/users/" + path[@id], (error, graph) ->
      tick = (e) ->
        k = 6 * e.alpha
        graph.nodes.forEach (o, i) ->
          o.y += (if i & 1 then k else -k)
          o.x += (if i & 2 then k else -k)

        d3.layout.force().attr("cx", (d) ->
          d.x
        ).attr "cy", (d) ->
          d.y

      force.nodes(graph.nodes).links(graph.links).start()
      link = svg.selectAll(".link").data(graph.links).enter().append("line").attr("class", "link").style("stroke-width", 1)
      node = svg.selectAll(".node").data(graph.nodes).enter().append("circle").attr("cx", (d) ->
        d.x
      ).attr("cy", (d) ->
        d.y
      ).attr("class", "node").attr("r", (i) ->
        i.size
      ).style("fill", (i) ->
        i.color
      ).call(force.drag)
      node.append("text").attr("dx", 12).attr("dy", ".35em").text (d) ->
        d.name

      node.append("svg:path").attr "transform", (d) ->
        "translate(" + d.x + "," + d.y + ")"

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




