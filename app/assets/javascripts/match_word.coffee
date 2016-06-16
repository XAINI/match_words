class Matching
  constructor: (@$eml) ->
    @bind_event()

  through_ajax_request: (fetch_value)=>
    jQuery.ajax
      url: "/match_words/insert",
      method: "post",
      data: {fetched_value: fetch_value}
    .success (msg) ->
      alert "保存成功"
    .error (msg) ->
      console.log msg


  bind_event: ->
    @$eml.on "click", ".footer-button .submit_word", =>
      fetch_text_area_value = jQuery(".body .part-left textarea").val()
      @through_ajax_request(fetch_text_area_value)
      jQuery(".body .part-right textarea").val(fetch_text_area_value)





jQuery(document).on "ready page:load", ->
  if jQuery(".matching_word").length > 0
    new Matching jQuery(".matching_word")
  