class MatchWordsController < ApplicationController
  def index
    
  end

  # 单词两两组合
  def display_words
    fetch_inserted_words = params[:get_inserted_words]
    convert_words_to_ary = RegExp_split_words(fetch_inserted_words)
    datas = []
    convert_words_to_ary.each_with_index do |i, index|
      for other in index+1..convert_words_to_ary.length-1
        if index == convert_words_to_ary.length-1
          break
        end
        datas.push([convert_words_to_ary[index],convert_words_to_ary[other]])
      end
    end
    render json: datas.to_json
  end

  private
    def RegExp_split_words(str)
      pattern = /^[a-zA-Z]+/
      items = str.scan(pattern)
      items
    end
end