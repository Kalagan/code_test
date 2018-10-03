class LeadsController < ApplicationController
  def index; end

  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(lead_params)
    if @lead.send_lead
      redirect_to leads_path, notice: 'Lead was successfully created.'
    else
      render :new
    end
  end

  private

  def lead_params
    params.require(:lead).permit(
      :first_name, :last_name, :business_name, :telephone_number, :email, :contact_time, :reference, :notes
    ).to_h.symbolize_keys
  end
end
