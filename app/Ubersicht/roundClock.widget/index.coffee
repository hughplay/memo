# Read style section for settings (e.g. retina scaling, colors)

# options to set
appearance =
  secDigit: true
  secHand : true
  milTime : true
  showAMPM: false

appearance: appearance

command: "date +%H,%M,%S"

refreshFrequency: 1000

render: (output) -> """
<svg version="1.1" id="clock" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 215 215" enable-background="new 0 0 215 215" xml:space="preserve">
  <defs>
    <marker id="sec-mk" markerHeight="10" markerWidth="5" refX="0" refY="5" orient="auto">
      <polygon points="0,0 0,10 5,5"/>
    </marker>
    <marker id="hr-mk" markerHeight="10" markerWidth="5" refX="0" refY="5" orient="auto">
      <polygon points="0,0 0,10 5,5"/>
    </marker>
  </defs>

  <path id="min-ln" stroke-width="15" stroke-miterlimit="10" d="M107.5,7.5c55.2,0,100,44.8,100,100s-44.8,100-100,100s-100-44.8-100-100S52.3,7.5,107.5,7.5"/>

  <line id="hr-ln" class="line" marker-end="url(#hr-mk)" stroke-miterlimit="10" x1="107" y1="107.5" x2="107" y2="24.5"/>
  <line id="sec-ln" class="line" marker-end="url(#sec-mk)" stroke-miterlimit="10" x1="107" y1="107.5" x2="107" y2="24.5"/>
</svg>

<div id="digits">
  <span id="hr-dig"></span><span id="sign">:</span><span id="min-dig"></span><span id="ampm"></span><div id="sec-dig"></div>
</div>
"""

update: (output) ->
  time = output.split(',')

  circ = Math.PI*2*100

  if ! @appearance.milTime
    if @appearance.showAMPM then $('#ampm').text "pm"
    if time[0] > 12
      time[0] = time[0] - 12
    else if time[0] < 12
      if time[0] < 1 then time[0] = 12
      if @appearance.showAMPM then $('#ampm').text "am"
    time[0] = Number(time[0])

  $('#hr-dig').text time[0]
  $('#min-dig').text time[1]
  if @appearance.secDigit
    $('#sec-dig').text time[2]

  $('#min-ln').css('stroke-dashoffset',circ - ( ( parseInt(time[1]) + ( time[2] / 60 ) ) / 60 ) * circ)
  $('#sec-ln').css('-webkit-transform','rotate('+( time[2] / 60 ) * 360+'deg)')
  $('#hr-ln').css('-webkit-transform','rotate('+( ( parseInt(time[0] % 12) + ( time[1] / 60 ) ) / 12 ) * 360+'deg)')

style: """
  /* Settings */
  main = #121212
  second = rgb(191, 0, 0)
  background = rgba(255,255,255,0.15)
  transitions = false                   // disabled by default to save CPU cycles
  scale = 1                             // set to 2 to scale for retina displays

  /* -- override -- */
  left: 20px !important
  top: 20px !important
  scale = 1
  main = rgba(236, 240, 241, 1)
  orange = rgba(231, 76, 60, 1)
  blue = rgba(52, 152, 219, 1)
  blue_dark = rgba(41, 128, 185, 1)
  dark = rgba(44, 62, 80, 1)

  background = dark
  hour_hand = blue_dark
  second_hand = blue
  min_fill = orange
  time_text = orange
  second_text = main
  box-shadow: 0 0 15px #000;

  text_font = "Aldrich"
  text_size = 50px
  /* -- override -- */

  /* Styles (mod if you want) */
  box-sizing: border-box

  left: 0%
  bottom: 0%
  margin-left: 15px * scale
  margin-bottom: 15px * scale

  width: 225px * scale
  height: 225px * scale

  padding: 5px * scale
  background: background
  border-radius: 112.5px * scale

  svg
    width: 215px * scale
    height: 215px * scale

  #hr-mk polygon
    fill: hour_hand
  #sec-mk polygon
    if #{appearance.secHand}
      fill: second_hand
    else
      fill: none
  .line
    -webkit-transform-origin: 100% 100%    // centers the ticks

    if transitions
      -webkit-transition: -webkit-transform .25s cubic-bezier(0.175, 0.885, 0.32, 1.275)    // this bezier gives the tick a natural bounce
  #min-ln
    stroke: min_fill
    fill: none

    stroke-dasharray: PI*2*100
    stroke-dashoffset: PI*2*100

    if transitions
      -webkit-transition: stroke-dashoffset .5s ease

  #digits
    position: absolute
    left:     50%
    top:      50%
    margin-left: -105px * scale
    margin-top: -30px * scale
    width:    215px * scale

    font-family: text_font
    font-size: text_size * scale
    line-height: 1
    text-align: center
    -webkit-font-smoothing: antialiased    // the transparent bg makes subpixel look bad
    color: time_text

  #hr-dig
    font-family: text_font
    letter-spacing: 0px * scale
  #sign
  	padding-bottom: 50px
  #min-dig
    font-family: text_font
    letter-spacing: 0px * scale
  #ampm
    font-family: text_font
    font-size: 25px * scale
    margin-left: 3px * scale
  #sec-dig
    font-family: text_font
    font-size: 30px * scale
    color: second_text
"""

