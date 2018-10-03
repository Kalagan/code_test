module Leads
  class LeadApi
    RequestError = Class.new(StandardError)
    ENDPOINT_URL = Rails.application.config.lead_api_base_uri + '/api/v1/create'
    USER_ERROR_MESSAGE = 'An error occured'.freeze

    attr_reader :lead

    def initialize(lead)
      @lead = lead
    end

    def send_lead
      return lead unless lead.valid?

      post
      lead
    end

    private

    def post
      result = HTTParty.post(ENDPOINT_URL, request_params)
      raise RequestError, result unless result.success?
    rescue HTTParty::Error => error
      capture_error(error)
    rescue RequestError => error
      capture_error(error)
    end

    def request_params
      { body: authentication_params.merge(lead_params) }
    end

    def lead_params
      {
        name: lead.name,
        business_name: lead.business_name,
        telephone_number: lead.telephone_number,
        email: lead.email
      }
    end

    def authentication_params
      {
        access_token: Rails.application.config.lead_api_access_token,
        pGUID: Rails.application.config.lead_api_pguid,
        pAccName: Rails.application.config.lead_api_paccname,
        pPartner: Rails.application.config.lead_api_ppartner
      }
    end

    def capture_error(error)
      ErrorCapturer.capture(error)
      lead.errors.add(:base, USER_ERROR_MESSAGE)
    end
  end
end
