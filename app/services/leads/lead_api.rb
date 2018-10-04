module Leads
  class LeadApi
    RequestError = Class.new(StandardError)
    ENDPOINT_URL = Rails.application.config.lead_api_base_uri + '/api/v1/create'
    USER_ERROR_MESSAGE = 'An error occured. Sorry about that!'.freeze

    def self.send_lead(lead)
      new(lead).send_lead
    end

    attr_reader :lead

    def initialize(lead)
      @lead = lead
    end

    def send_lead
      lead.valid? && post
    end

    private

    def post
      Rails.logger.info("Sending Lead to API: #{lead_params}")
      result = HTTParty.post(ENDPOINT_URL, request_params)
      raise RequestError, result unless result.success?

      true
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
        email: lead.email,
        contact_time: lead.contact_time,
        reference: lead.reference,
        notes: lead.notes
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
      false
    end
  end
end
