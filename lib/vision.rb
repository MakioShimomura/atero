require 'base64'
require 'json'
require 'net/https'

module Vision
  class << self
    def label_detection(image_file)
      # APIのURL作成
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_API_KEY']}"

      # 画像をbase64にエンコード
      base64_image = Base64.encode64(open(image_file).read)

      # APIリクエスト用のJSONパラメータ
      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              type: 'LABEL_DETECTION'
            }
          ]
        }]
      }.to_json

      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)

      # レスポンスを英語から日本語に翻訳
      translate(JSON.parse(response.body)['responses'][0]['labelAnnotations'].pluck('description').take(3))
    end

    def translate(words)
      url = URI.parse('https://translation.googleapis.com/language/translate/v2')
      params = {
        q: words,
        source: "en",
        target: "ja",
        key: ENV['GOOGLE_API_KEY']
      }
      url.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(url)
      JSON.parse(res.body)['data']['translations'].map { |word| word['translatedText'] }
    end
  end
end