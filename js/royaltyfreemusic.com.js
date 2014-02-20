$(function() {
  var embed = $('object embed');
  var src = embed.attr('src').replace(/.*soundFile=(.*)$/, "$1");

  $('object').parent().append('<audio src="' + src + '" controls preload="auto" autobuffer autoplay></audio>');
  $('object').remove();
})
