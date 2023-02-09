require 'httpclient'
require 'json'

module Deepl
  class << self

    # 翻訳
    def translation(words)
      api_key = ENV['DEEPL_KEY']
      uri       = "https://api-free.deepl.com/v2/translate"
      client    = HTTPClient.new

      params = {
        auth_key: api_key,
        text: words,
        target_lang: "JA"
      }

      response  = client.get(uri, query: params)
      # JSON.parse(response.body)['translations']['text']
      JSON.parse(response.body).first[1]
    end

    # 英語を受け取り、翻訳後カタカナ変換
    def kana(eng_words)
      words = translation(eng_words)
      words.map do |i|
        # 漢字でない場合
        if (i["text"] =~ /[一-龠々]/).nil?
          # カタカナでない場合
          if (i["text"] =~ /\p{Katakana}/).nil?
            i["text"].to_kana
          else
            i["text"]
          end
        else
          i["text"].to_hira.to_kana
        end
      end

    end
  end
end