// Adds a "Mark as viewed" link in the subtext of each Hacker News article, so
// that I can color the link as if I'd viewed it without actually viewing it.
//
// Useful to quickly see which articles are new.

// Given a `subtext` element, which is the collection of links and information
// below an article's headline, extracts the HN ID from the comments link
function getItemId(subtext) {
  if ($('span', subtext).length > 0) {
    return $('a[href^="item"]', subtext).attr('href').replace(/[^\d]+/, '')
  }
  else {
    return '0'
  }
}

function markAsViewed(id) {
  // Given an item id, we fetch the comment link, get its parent (the td), the
  // td's parent (the tr), and then the previous sibling (the tr for the
  // headline itself). If only HN had semantic markup.
  headline_row = $('a[href^="item?id=' + id + '"]').parent().parent().prev()
  $('td.title a', headline_row).css('color', 'rgb(135, 193, 232)')
}

$(function() {
  $('td.subtext').each(function() {
    id = getItemId(this)

    $(this).append(' | <a class="mark-as-viewed" href="#" data-id=' + id + '>Mark as viewed</a>')

    if (localStorage.getItem('viewed:' + id) != null) {
      markAsViewed(id)
    }
  })

  $('a.mark-as-viewed').click(function() {
    localStorage.setItem('viewed:' + $(this).data('id'), true)
    markAsViewed($(this).data('id'))

    return false
  })
})
