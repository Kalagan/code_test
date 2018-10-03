require 'rails_helper'

RSpec.describe Leads::LeadApi do
  let(:lead) do
    Lead.new(
      first_name: 'john',
      last_name: 'wayne',
      business_name: 'acme',
      telephone_number: '07570012345',
      email: 'example@example.com'
    )
  end
  subject { described_class.new(lead) }

  describe '#send' do
    context 'lead is valid', vcr: { cassette_name: :lead_valid } do
      it 'sets no error to the lead' do
        subject.send_lead
        expect(lead.errors.empty?).to eq(true)
      end
    end

    context 'lead is not valid' do
      let(:lead) do
        Lead.new(
          first_name: 'john',
          last_name: 'wayne',
          business_name: 'acme',
          telephone_number: '07570012345'
        )
      end

      it 'sets an error to the lead' do
        subject.send_lead
        expect(lead.errors.full_messages).to eq(["Email can't be blank"])
      end
    end

    context 'token is wrong', vcr: { cassette_name: :lead_wrong_token } do
      before do
        allow(Rails.application.config).to receive(:lead_api_access_token).and_return('xxx')
      end

      it 'sets an error to the lead' do
        subject.send_lead
        expect(lead.errors.full_messages).to eq([described_class::USER_ERROR_MESSAGE])
      end

      it 'captures the error' do
        expect(ErrorCapturer).to receive(:capture).with(described_class::RequestError)
        subject.send_lead
      end
    end
  end
end
