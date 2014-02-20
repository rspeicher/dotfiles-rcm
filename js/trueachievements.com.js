// Injects jQuery and Tipsy to the page since the site's interface is entirely
// dependent on icons that have nothing to do with their function

$(function() {
  // Calendar page uses MooTools which conflicts with jQuery
  // This is the lazy fix
  if (!document.location.href.match(/gamingsessions/)) {
    $('head').append('<link rel="stylesheet" href="http://tsigo.com/tipsy/stylesheets/tipsy.css" type="text/css" />')

    window.onload = function() {
      $('body').append('<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js">')
      $('body').append('<script type="text/javascript" src="http://tsigo.com/tipsy/javascripts/jquery.tipsy.js">')
      setTimeout(function() {
        $('body').append('<script type="text/javascript">$("#page a[title], #page img[title]").tipsy()</script>')
    }, 500)
    }
  }

  // Fix YouTube embeds
  $('div.commentvideo object').each(function() {
    var movie = $(this).children('param[name="movie"]')
    var url   = movie.attr('value').replace(/.*\/v\/([\w-]+).*/, 'http://www.youtube.com/embed/$1?hd=1')

    $(this).parent().append('<iframe width="560" height="315" src="' + url + '" frameborder="0" allowfullscreen></iframe>')
    $(this).remove()
  })

  // Remove Pro ad holder
  $('#divTAProHolder').remove()
})
