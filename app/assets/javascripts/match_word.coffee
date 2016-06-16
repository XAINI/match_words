class Matching
  constructor: (@$eml) ->
    @bind_event()

  through_ajax_request: (fetch_value)=>
    jQuery.ajax
      url: "/match_words/insert",
      method: "post",
      data: {fetched_value: fetch_value}
    .success (msg) ->
      console.log msg
    .error (msg) ->
      console.log msg

  through_ajax_get: ()=>

  check_into_display_words: () =>
    window.location.href = "/match_words/display_words"


  bind_event: ->
    @$eml.on "click", ".footer-button .submit_word", =>
      fetch_text_area_value = jQuery(".body .part-left textarea").val()
      @through_ajax_request(fetch_text_area_value)
      jQuery(".body .part-right textarea").val(fetch_text_area_value)

    @$eml.on "click", ".body .match-script", =>
      @check_into_display_words()


class DisplayMatching
  constructor: (@$eml) ->
    @bind_event()

  bind_event: ->
    @$eml.on "ready page:load", ".body .part-left", =>


jQuery(document).on "ready page:load", ->
  if jQuery(".matching_word").length > 0
    new Matching jQuery(".matching_word")

jQuery(document).on "ready page:load", ->
  if jQuery(".display_matching_word").length > 0
    new DisplayMatching jQuery(".display_matching_word")
  