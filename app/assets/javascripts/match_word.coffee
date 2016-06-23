# 单词两两配对
class Matching
  constructor: (@$eml) ->
    @bind_event()

  # 将单词列表存成一个数组
  # RegExp_convert_to_ary: (words)=>
  #   regexp = new RegExp('\n')
  #   lits = words.split(regexp)
  #   return lits

  # 将单词两两组合 成一个新的数组
  # matching_word_to_new_ary: (word_list)=>
  #   str_array = []
  #   for word in word_list
  #     word_shift = word_list.shift()
  #     for other in word_list
  #       str_array.push([word_shift,other])
  #   return str_array

  # 将组合完成后的单词显示到页面
  # display_ary_data: (ary)=>
  #   for coupe in ary
  #     jQuery(".body .part-right").append("<div class = 'line'></div>")
  #     jQuery(".body .part-right .line:last").append("<label class = 'word-one'>#{coupe[0]}</label> ").append("<label class = 'word-two'>#{coupe[1]}</label> ").append("<button class = 'exchange'>Exchange</button> ").append("<button class = 'done'>Done</button> ").append("<button class = 'delete'>Delete</button>")

  bind_event: ->
    # 进行单词两两组合
    # @$eml.on "click", ".footer-button .match-word", =>
    #   get_words = jQuery(".body .part-left textarea").val()
    #   converted = @RegExp_convert_to_ary(get_words)
    #   convert_to_new_array = @matching_word_to_new_ary(converted)
    #   @display_ary_data(convert_to_new_array)
    #   jQuery(".body .part-left textarea").val("")

    # 交换单词组前后顺序
    @$eml.on "click", ".body .part-right .exchange", ->
      first_word = jQuery(this).parent().find(".word-one").html()
      second_word = jQuery(this).parent().find(".word-two").html()
      jQuery(this).parent().find(".word-one").html(second_word)
      jQuery(this).parent().find(".word-two").html(first_word)

    # 删除本组单词组
    @$eml.on "click", ".body .part-right .delete", ->
      jQuery(this).parent().remove()

    # 确认输出单词组
    @$eml.on "click", ".body .part-right .done", ->
      first_word = jQuery(this).parent().find(".word-one").html()
      second_word = jQuery(this).parent().find(".word-two").html()
      left_text = jQuery(".body .part-left textarea").val()
      if left_text is ""
        jQuery(".body .part-left textarea").val(first_word + " " +second_word)
      else
        jQuery(".body .part-left textarea").val(left_text + '\n'+first_word + " " +second_word)

      jQuery(this).parent().remove()

    # 跳转进入单词录入界面
    @$eml.on "click", ".footer-button .check-in-insert", =>
      window.location.href = "/match_words/insert_word"

    # 跳转进入单词录入界面
    @$eml.on "click", ".footer-button .check-in-article", =>
      window.location.href = "/match_words/article"

# 单词录入
class InsertInto
  constructor: (@$eml)->
    @bind_event()

  # 将单词列表通过 ajax 传至后台处理
  # save_word_list: (words) =>
  #   jQuery.ajax
  #     url: "/match_words/insert_word_list",
  #     method: "post",
  #     data: {need_insert_words: words}
  #   .success (msg) =>
  #     if msg.message == "保存成功"
  #       alert msg.message
  #       @display_word_ary_data(msg.text)
  #       jQuery(".body .part-left textarea").val("")
  #     else
  #       alert msg
  #   .error (msg) ->
  #     alert msg

  # 在页面右侧显示保存后的单词
  # display_word_ary_data: (ary)=>
  #   for coupe in ary.words
  #     jQuery(".body .part-right").append("<div class = 'line'></div>")
  #     jQuery(".body .part-right .line:last").append("<label class = 'word'>#{coupe}</label> ").append("<button class = 'done'>Done</button> ").append("<button class = 'delete' id = '#{ary._id.$oid}'>Delete</button>")

  # 将需要删除单词的 id 和 value 传到后台处理
  # destroy_word: (id, value)->
  #   jQuery.ajax
  #     url: "/match_words/delete_word",
  #     method: "delete",
  #     data: {need_id: id, need_value: value}
  #   .success (msg) =>
  #     console.log msg
  #   .error (msg) ->
  #     console.log msg

  bind_event: ->
    # 点击 "保存单词表" 按钮保存单词表
    # @$eml.on "click", ".footer-button .submit_word", (evt)=>
    #   word_list = jQuery(".body .part-left textarea").val()
    #   @save_word_list(word_list)

    # 点击 "delete" 删除不需要的单词
    # @$eml.on "click", ".body .part-right .line .delete", (evt)=>
    #   fetch_id = jQuery(evt.target).closest(".delete").attr("id")
    #   fetch_value = jQuery(evt.target).parent().find(".word").html()
    #   @destroy_word(fetch_id, fetch_value)
    #   jQuery(evt.target).parent().remove()

    # 确认输出单词
    # @$eml.on "click", ".body .part-right .done", ->
    #   fetch_word = jQuery(this).parent().find(".word").html()
    #   left_text = jQuery(".body .part-left textarea").val()
    #   if left_text is ""
    #     jQuery(".body .part-left textarea").val(fetch_word)
    #   else
    #     jQuery(".body .part-left textarea").val(left_text + '\n'+fetch_word)

    #   jQuery(this).parent().remove()

# 文章录入
class ArticleOperate
  constructor: (@$eml)->
    @bind_event()

  # 将获取到的文章内容传到后台处理
  insert_article_for_ajax: (article)=>
    jQuery.ajax
      url: "/match_words/article_insert",
      method: "post",
      data: {article: article}
    .success (msg) ->
      if msg.message == "success"
        jQuery(".body .part-right textarea").val(msg.saved_article.article)
      else
        alert msg
    .error (msg) ->
      alert msg

  # 将文章发送到后台进行分词处理
  analysis_article: (atcv)=>
    jQuery.ajax
      url: "/match_words/analysis_article",
      method: "post",
      data: {article_value: atcv}
    .success (msg) =>
      @display_word_form_data(msg.tokens)
    .error (msg) ->
      console.log msg

   # 将单词列表通过 ajax 传至后台处理
  save_word_list: (words) =>
    jQuery.ajax
      url: "/match_words/insert_word_list",
      method: "post",
      data: {need_insert_words: words}
    .success (msg) =>
      if msg.message == "保存成功"
        alert msg.message
        @display_word_ary_data(msg.text)
        jQuery(".body .part-left textarea").val("")
      else
        alert msg
    .error (msg) ->
      alert msg

  # 在页面右侧显示保存后的单词
  display_word_ary_data: (ary)=>
    jQuery(".body .part-right textarea").remove()
    jQuery(".body .float-right-bottom-button button").remove()
    for coupe in ary.words
      jQuery(".body .part-right").append("<div class = 'line'></div>")
      jQuery(".body .part-right .line:last").append("<label class = 'word'>#{coupe}</label> ").append("<button class = 'done'>Done</button> ").append("<button class = 'delete' id = '#{ary._id.$oid}'>Delete</button>")

  # 将分好的词显示在页面的左侧文本域
  display_word_form_data: (ary)=>
    for coupe in ary
      left_text = jQuery(".body .part-left textarea").val()
      if left_text is ""
        jQuery(".body .part-left textarea").val("#{coupe.token}")
      else
        jQuery(".body .part-left textarea").val(left_text + '\n'+"#{coupe.token}")

  # 将需要删除单词的 id 和 value 传到后台处理
  destroy_word: (id, value)->
    jQuery.ajax
      url: "/match_words/delete_word",
      method: "delete",
      data: {need_id: id, need_value: value}
    .success (msg) =>
      console.log msg
    .error (msg) ->
      console.log msg

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
    if jQuery(".body .part-right textarea") != []
      jQuery(".body .part-right textarea").remove()
      jQuery(".body .float-right-bottom-button button").remove()
    for coupe in ary
      jQuery(".body .part-right").append("<div class = 'line'></div>")
      jQuery(".body .part-right .line:last").append("<label class = 'word-one'>#{coupe[0]}</label> ").append("<label class = 'word-two'>#{coupe[1]}</label> ").append("<button class = 'exchange'>Exchange</button> ").append("<button class = 'done'>Done</button> ").append("<button class = 'delete'>Delete</button>")

  bind_event: ->
    # 点击 "保存文章" 按钮获取到文章 并调用 ajax
    @$eml.on "click", ".footer-button .submit-article", =>
      article_value = jQuery(".body .part-left textarea").val()
      @insert_article_for_ajax(article_value)

    # 点击分词按钮对文章进行分词
    @$eml.on "click", ".body .float-right-bottom-button .disintegration-article", (evt)=>
      jQuery(".body .part-left textarea").val("")
      get_title_type = jQuery(evt.target).closest(".disintegration-article").attr("data-title-type")
      article_right_value = jQuery(".body .part-right textarea").val()
      @analysis_article(article_right_value)

    # 点击 "保存单词" 按钮保存单词表
    @$eml.on "click", ".footer-button .submit-word", (evt)=>
      jQuery(".body .part-right textarea").val("")
      word_list = jQuery(".body .part-left textarea").val()
      @save_word_list(word_list)

     # 确认输出单词
    @$eml.on "click", ".body .part-right .done", ->
      fetch_word = jQuery(this).parent().find(".word").html()
      left_text = jQuery(".body .part-left textarea").val()
      if left_text is ""
        jQuery(".body .part-left textarea").val(fetch_word)
      else
        jQuery(".body .part-left textarea").val(left_text + '\n'+fetch_word)

      jQuery(this).parent().remove()

    # 点击 "delete" 删除不需要的单词
    @$eml.on "click", ".body .part-right .line .delete", (evt)=>
      fetch_id = jQuery(evt.target).closest(".delete").attr("id")
      fetch_value = jQuery(evt.target).parent().find(".word").html()
      @destroy_word(fetch_id, fetch_value)
      jQuery(evt.target).parent().remove()

    # 进行单词两两组合
    @$eml.on "click", ".footer-button .match-word", =>
      get_words = jQuery(".body .part-left textarea").val()
      converted = @RegExp_convert_to_ary(get_words)
      convert_to_new_array = @matching_word_to_new_ary(converted)
      @display_ary_data(convert_to_new_array)
      jQuery(".body .part-left textarea").val("")

    # 交换单词组前后顺序
    @$eml.on "click", ".body .part-right .exchange", ->
      first_word = jQuery(this).parent().find(".word-one").html()
      second_word = jQuery(this).parent().find(".word-two").html()
      jQuery(this).parent().find(".word-one").html(second_word)
      jQuery(this).parent().find(".word-two").html(first_word)

    # 删除本组单词组
    @$eml.on "click", ".body .part-right .delete", ->
      jQuery(this).parent().remove()

    # 确认输出单词组
    @$eml.on "click", ".body .part-right .done", ->
      left_text = jQuery(".body .part-left textarea").val()
      console.log left_text
      first_word = jQuery(this).parent().find(".word-one").html()
      second_word = jQuery(this).parent().find(".word-two").html()
      if left_text is ""
        jQuery(".body .part-left textarea").val(first_word + " " +second_word)
      else
        jQuery(".body .part-left textarea").val(left_text + '\n'+first_word + " " +second_word)

# 单词两两配对
jQuery(document).on "ready page:load", ->
  if jQuery(".matching_word").length > 0
    new Matching jQuery(".matching_word")

# 单词录入
jQuery(document).on "ready page:load", ->
  if jQuery(".insert-word-list").length > 0
    new InsertInto jQuery(".insert-word-list")

# 文章录入
jQuery(document).on "ready page:load", ->
  if jQuery(".article_insert_page").length > 0
    new ArticleOperate jQuery(".article_insert_page")