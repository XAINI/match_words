class Matching
  constructor: (@$eml) ->
    @bind_event()

  # 将单词通过发 ajax 到后台处理
  through_ajax_get: (words)=>
    jQuery.ajax
      url: "/match_words/display_words",
      method: "get",
      data: {get_inserted_words: words}
    .success (msg) =>
      @display_ary_data(msg)
    .error (msg) ->
      console.log msg

  # 将组合完成后的单词显示到页面
  display_ary_data: (ary)=>
    for coupe in ary
      jQuery(".body .part-right").append("<div class = 'line'></div>")
      jQuery(".body .part-right .line:last").append("<label class = 'word-one'>#{coupe[0]}</label> ").append("<label class = 'word-two'>#{coupe[1]}</label> ").append("<button class = 'exchange'>Exchange</button> ").append("<button class = 'done'>Done</button> ").append("<button class = 'delete'>Delete</button>")

  bind_event: ->
    # 进行单词两两组合
    @$eml.on "click", ".footer-button .submit_word", =>
      get_words = jQuery(".body .part-left textarea").val()
      @through_ajax_get(get_words)
      jQuery(".body .part-left textarea").val("")

    # 交换单词前后顺序
    @$eml.on "click", ".body .part-right .exchange", ->
      first_word = jQuery(this).parent().find(".word-one").html()
      second_word = jQuery(this).parent().find(".word-two").html()
      jQuery(this).parent().find(".word-one").html(second_word)
      jQuery(this).parent().find(".word-two").html(first_word)

    # 删除本组单词
    @$eml.on "click", ".body .part-right .delete", ->
      jQuery(this).parent().remove()

    # 确认输出单词
    @$eml.on "click", ".body .part-right .done", ->
      first_word = jQuery(this).parent().find(".word-one").html()
      second_word = jQuery(this).parent().find(".word-two").html()
      left_text = $(".body .part-left textarea").val()
      if left_text is ""
        jQuery(".body .part-left textarea").val(first_word + " " +second_word)
      else
        jQuery(".body .part-left textarea").val(left_text + '\n'+first_word + " " +second_word)

      jQuery(this).parent().remove()

jQuery(document).on "ready page:load", ->
  if jQuery(".matching_word").length > 0
    new Matching jQuery(".matching_word")