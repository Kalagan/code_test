class ErrorCapturer
  def self.capture(error)
    Rails.logger.warn("Error #{error.class}. Message: #{error.message}")

    # TODO: capture error with a error monitoring tool like Sentry
  end
end
