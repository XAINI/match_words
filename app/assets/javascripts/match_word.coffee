class Matching
  constructor: (@$eml) ->
    @bind_event()

  # 将单词列表存成一个数组
  RegExp_convert_to_ary: (words)=>
    regexp = new RegExp('\n')
    lits = words.split(regexp)
    return lits

  # 将单词两两组合 成一个新的数组
  matching_word_to_new_ary: (word_list)=>
    str_array = []
    for word in word_list
      word_shift = word_list.shift()
      for other in word_list
        str_array.push([word_shift,other])
    return str_array

  # 将组合完成后的单词显示到页面
  display_ary_data: (ary)=>
    for coupe in ary
      jQuery(".body .part-right").append("<div class = 'line'></div>")
      jQuery(".body .part-right .line:last").append("<label class = 'word-one'>#{coupe[0]}</label> ").append("<label class = 'word-two'>#{coupe[1]}</label> ").append("<button class = 'exchange'>Exchange</button> ").append("<button class = 'done'>Done</button> ").append("<button class = 'delete'>Delete</button>")

  bind_event: ->
    # 进行单词两两组合
    @$eml.on "click", ".footer-button .submit_word", =>
      get_words = jQuery(".body .part-left textarea").val()
      converted = @RegExp_convert_to_ary(get_words)
      convert_to_new_array = @matching_word_to_new_ary(converted)
      @display_ary_data(convert_to_new_array)
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