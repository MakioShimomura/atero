require 'httpclient'
require 'json'

module Deepl
  class << self

    def translation(words)
      api_key = ENV['DEEPL_KEY']
      uri       = 'https://api-free.deepl.com/v2/translate'
      client    = HTTPClient.new

      params = {
        auth_key: api_key,
        text: words,
        target_lang: "JA"
      }

      response  = client.get(uri, query: params)
      JSON.parse(response.body)['translations'].map { |word| word['text'] }
    end
  end
end