class MatchWordsController < ApplicationController
  def index
    
  end

  def show
    
  end

  def insert_word_list
    fetched_words = params[:need_insert_words]
    words_ary = RegExp_split_words_list(fetched_words)
    db_data_ary = match_data_from_db()

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

  def delete_word
    get_word_ary = MatchWord.find(params[:need_id])
    fetch_words_ary = get_word_ary.words
    fetch_words_ary.delete(params[:need_value])
    if get_word_ary.update_attributes(words:fetch_words_ary)
      render :json => "success"
    else
      render :json => "failure"
    end
  end

  private
    def RegExp_split_words_list(words)
      pattern = /^[a-zA-Z]+/
      datas = words.scan(pattern)
      datas
    end

    def match_data_from_db()
      select_data_from_db = []
      all_words_list = MatchWord.all.to_a
      all_words_list.each do |list|
        select_data_from_db.push(list.words)
      end
      select_data_from_db
    end
end