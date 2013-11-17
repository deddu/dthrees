$(document).ready ->
  #ctx = document.getCSSCanvasContext("2d", "canv", 400, 400)#
  ctx=document.getElementById("canv").getContext('2d')
  ctx.fillStyle = "#000"

  rand = (min,max)->  min + (Math.random()*(max-min)|1) #return a random int in the range

  refresh = () ->
    ctx.clearRect(0,0,canv.width,canv.height)
    drawtree()

  drawtree = (thick, len, x, y, angle) ->
    #(5,100,200,500,-90* Math.PI / 180.0)
    thick = thick||5
    len = len||100
    x=x||200
    y=y||300
    angle = angle ||-90*Math.PI/180.0
    #branch endpoint
    x1 = x+len*Math.cos(angle)
    y1 = y+len*Math.sin(angle)
    #console.log x1,y1
    # amount of green
    greenness = Math.min( 10 * len, 255)

    ctx.beginPath()
    ctx.strokeStyle ="#000000" #"rgb(0, #{greenness},0)"
    ctx.lineWidth = thick
    ctx.moveTo x, y
    ctx.lineTo x1, y1
    ctx.closePath()
    ctx.stroke()
    numBranches = rand 2, 6
    #console.log numBranches
    for i in [0..numBranches]
      scale = rand(50, 75) / 100
      newThickness = thick * scale;
      newLength = len * scale;
      #console.log "dwawing", newLength
      if (newLength > 20)
        newAngle = angle + rand(-60, 60)  * Math.PI / 180.0
        #console.log "dwawing angle", newAngle
        drawtree(newThickness, newLength, x1, y1, newAngle);

  #console.log "time to dwaw some twee"
  #setInterval drawtree(100,100,0,0,270), 10000
  refresh()



  setInterval refresh , 10000