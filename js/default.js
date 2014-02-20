var loc = document.location.href

// Infinite scrolling helpers
// --------------------------------------------------------------------------------

// Should be called on a window's "scroll" event
// Determines if the <tt>waypoint_id</tt> is within the current viewable area and calls
// <tt>callback</tt> if it is.
function paginationWaypoint(waypoint_id, next_id, callback) {
  var distanceTop = $(waypoint_id).offset().top - $(window).height()

  if ($(window).scrollTop() > distanceTop) {
    var link = $(waypoint_id).find(next_id)
    if(link.length > 0) {
      callback(link.attr('href'))
    }
  }
}

// Loads a link and calls a callback on success
//
// FIXME: Called synchronously so that we don't load a page more than once; this was the lazy way out
function paginationLoadPage(link, success) {
  $.ajax(link, {
    async: false,
    cache: false,
    dataType: 'html',
    success: success
  })
}

// Provides a default callback to use with paginationWaypoint
function waypointCallback(link) {
  paginationLoadPage(link, successCallback)
}

// Unescape elements in URLs
// --------------------------------------------------------------------------------
if (loc.match(/&amp;/)) {
  document.location.href = loc.replace(/&amp;/gi, '&')
}
