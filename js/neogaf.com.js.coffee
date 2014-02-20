# Automatically loads the next page of posts when we hit the bottom of the current page
content_id  = 'div#posts'
waypoint_id = 'div.pagenav-bot'
next_id     = 'li.next a'

successCallback = (d) ->
  d = $($.parseHTML(d))
  $(content_id).append d.find(content_id).html()
  $(waypoint_id).replaceWith d.find(waypoint_id)
  removeQuotedImages()
  quoteHighlight()

if $(content_id).length > 0 and $(waypoint_id).find(next_id).length > 0
  $(window).bind "scroll", ->
    paginationWaypoint waypoint_id, next_id, waypointCallback

# Highlight people quoting my posts
quoteHighlight = ->
  $('#posts strong:contains("tsigo")').each ->
    $(this).parent().css("font-size", "2em")
    $(this).parent().css("color", "red")

# Change multiple quoted images into links
removeQuotedImages = ->
  $(".quotearea").each ->
    if $(this).find("img").length > 1
      $(this).find("img").each ->
        src = $(this).attr("src")
        $(this).parent().append "<a href=\"#{src}\">#{src}</a><br/>"
        $(this).remove()

$ ->
  removeQuotedImages()
  quoteHighlight()
