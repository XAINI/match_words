class MatchWordsController < ApplicationController
  def index
    
  end

  # 保存单词列表
  def insert_word_list
    fetched_words = params[:need_insert_words]
    words_ary = RegExp_split_words_list(fetched_words)
    db_data_ary = match_data_from_db()

    if fetched_words == ""
      render json: "录入内容不能为空".to_json
      return
    end
    if words_ary == []
      render json: "请输入中文或英文词".to_json
      return
    end

    if !db_data_ary.include?(words_ary)
      data_ary = MatchWord.create(words: words_ary)
      if data_ary.save
        render json: {
          message: "保存成功",
          text: data_ary
        }
      else
        render :json => "保存失败".to_json
      end
    else
      render :json => "您输入的单词表已经存在".to_json
    end
  end

  # 删除单词
  def delete_word
    @get_word_ary = MatchWord.find(params[:need_id])
    fetch_words_ary = @get_word_ary.words
    fetch_words_ary.delete(params[:need_value])
    if fetch_words_ary.length > 0
      if @get_word_ary.update_attributes(words:fetch_words_ary)
        render :json => "success".to_json
      else
        render :json => "failure".to_json
      end
    else
      @get_word_ary.destroy
    end
  end

  # 文章录入
  def article_insert
    get_article = params[:article]
    if get_article == ""
      render json: "录入的文章不能为空".to_json
      return
    end

    @article = Article.create(article: get_article)
    if @article.save
      render json:{
        message: "success",
        saved_article: @article
      }
    else
      render json: "failure".to_json
    end
  end

  def analysis_article
    get_article_value = params[:article_value]
    command = %~
      curl -XGET 'localhost:9200/_analyze' -d '
      {
        "analyzer" : "ik",
        "text" : "#{get_article_value}"
      }'
    ~
    analysis_article_to_word = `#{command}`
    render json: analysis_article_to_word
  end

  private
    # 正则表达式处理单词
    def RegExp_split_words_list(words)
      pattern = /^[\u4e00-\u9fa5a-zA-Z]+/
      datas = words.scan(pattern)
      datas
    end

    # 查找数据库中已经存在的单词表
    def match_data_from_db()
      select_data_from_db = []
      all_words_list = MatchWord.all.to_a
      all_words_list.each do |list|
        select_data_from_db.push(list.words)
      end
      select_data_from_db
    end
end