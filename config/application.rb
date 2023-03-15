require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module QuizApp
  class Application < Rails::Application
    config.load_defaults 7.0
    config.active_storage.variant_processor = :mini_magick

    Rails.application.config.i18n.default_locale = :ja
    Faker::Config.locale = :ja
    
    config.autoload_paths += %W(#{config.root}/lib)

    # タイムゾーンを日本時間に設定
    config.time_zone = 'Asia/Tokyo'

    # デフォルトのロケールを日本（ja）に設定
    config.i18n.default_locale = :ja
  end
end
