require 'rails_helper'

describe 'leads' do
  describe 'GET /leads' do
    subject { get leads_path }

    it 'renders successfully' do
      subject
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /leads/new' do
    subject { get new_lead_path }

    it 'renders successfully' do
      subject
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /leads/new' do
    let(:params) do
      {
        lead: {
          first_name: 'Bruce'
        }
      }
    end
    subject { post leads_path, params: params }

    it 'renders successfully' do
      subject
      expect(response).to have_http_status(200)
    end

    context 'lead is valid and is sent to the API' do
      before do
        allow(Leads::LeadApi).to receive(:send_lead).and_return(true)
      end

      it 'redirect to leads_path' do
        subject
        expect(response).to redirect_to(leads_path)
      end
    end

    context 'lead is not valid' do
      it 'shows errors' do
        subject
        expect(response.body).to match(CGI.escapeHTML("Last name can't be blank"))
      end
    end
  end
end
