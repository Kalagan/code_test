Rails.application.configure do
  config.cache_classes = true
  config.eager_load = false
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{1.hour.seconds.to_i}"
  }

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection = false
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :test
  config.active_support.deprecation = :stderr
  config.cache_store = :null_store

  config.lead_api_paccname = ENV['LEAD_API_PACCNAME']
  config.lead_api_pguid = ENV['LEAD_API_PGUID']
  config.lead_api_ppartner = ENV['LEAD_API_PPARTNER']
  config.lead_api_access_token = ENV['LEAD_API_ACCESS_TOKEN']
  config.lead_api_base_uri = ENV['LEAD_API_URI']
end
