require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TentativeApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.load_defaults 6.1

    # デフォルトの言語を日本語に設定
    config.i18n.default_locale = :ja

    # タイムゾーンを日本時間に設定
    config.time_zone = 'Asia/Tokyo'
    
    # 利用可能なロケールを制限(言語の制限/下記は日本語と英語のみを使用できるという意味)
    # config.i18n.available_locales = [:ja, :en]
  end
end
