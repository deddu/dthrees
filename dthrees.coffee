$(document).ready ->

  newSvg = ()->
    return d3.select("#bg")
    .append("svg:svg")
    .attr("width", 400)
    .attr("height", 400)

  ctx= newSvg()


  rand = (min,max)->  min + (Math.random()*(max-min)|1) #return a random int in the range



  drawtree = (thick, len, x, y, angle) ->

    thick = thick||5
    len = len||100
    x=x||200
    y=y||300
    angle = angle ||-90*Math.PI/180.0
    #branch endpoint
    x1 = x+len*Math.cos(angle)
    y1 = y+len*Math.sin(angle)

    myLine = ctx.append("svg:line")
      .attr("x1", x)
      .attr("y1", y)
      .attr("x2", x1)
      .attr("y2", y1)
      .style("stroke", "rgb(6,103,155)")
      .style("stroke-width","#{thick}")
      .style("stroke-opacity","0.5")

    numBranches = rand 2, 6
    for i in [0..numBranches]
      scale = rand(50, 75) / 100
      newThickness = thick * scale;
      newLength = len * scale;

      if (newLength > 20)
        newAngle = angle + rand(-60, 60)  * Math.PI / 180.0
        #console.log "dwawing angle", newAngle
        drawtree(newThickness, newLength, x1, y1, newAngle);

  refresh = () ->
    #fixme : periodically clear svg
    d3.selectAll("line").remove()
    drawtree()

  drawtree()
  $('a.more').on("click", drawtree)
  $('a.new').on("click", refresh)
  #setInterval refresh , 1000