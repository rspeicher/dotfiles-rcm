$ ->
  if $('a:contains("Mobile")').length == 1
    hd   = $('a[href^="http://v.giantbomb.com"]:contains("HD")').attr('href')
    play = $("<div class='btn-group'><a href='mpv://#{hd}' class='btn btn-inverse btn-mini' rel='nofollow'><i class='icon icon-play-sign'></i> MPV</a></div>")
    $('a:contains("Mobile")').parents('div.btn-group').before(play)

  # $('div[id^="js-games_video_player_content"]').dblclick ->
  #   $('a[id^="js-vid-windowed"]').click()
  #   $('a[id^="js-vid-windowed"]').trigger('click')
