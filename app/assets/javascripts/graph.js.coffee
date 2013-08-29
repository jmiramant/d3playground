$(document).ready ->
  $("#graph").on "click", "circle", ->
    $(".remove").remove()
    name = $($(this)[0]).children().text()
    x_coord = event.pageX + 20
    y_coord = event.pageY - 40
    $("body").append $("#drilldown").clone().show().addClass("remove").css("top", y_coord).css("left", x_coord)
    $("#name").html name

  $("#fitscore").trigger "click"
  $(".buttons div").on "click", ->
    $(".buttons div").removeClass "active"
    $(this).addClass "active"
