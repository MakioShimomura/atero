require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module QuizApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_storage.variant_processor = :mini_magick

    Rails.application.config.i18n.default_locale = :ja
    #念の為
    Faker::Config.locale = :ja

    # config.paths.add 'lib', eager_load: true # API用に追加
    
    # 参考: https://qiita.com/necojackarc/items/fb76352dbea5bdd83366
    config.autoload_paths += %W(#{config.root}/lib)

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # タイムゾーンを日本時間に設定
    config.time_zone = 'Asia/Tokyo'
     # デフォルトのロケールを日本（ja）に設定
    config.i18n.default_locale = :ja
  end
end
