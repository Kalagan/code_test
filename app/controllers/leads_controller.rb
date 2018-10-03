class LeadsController < ApplicationController
  def index; end

  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(lead_params)
    @lead.valid?
    render :new
  end

  private

  def lead_params
    params.require(:lead).permit(
      :first_name, :last_name
    ).to_h.symbolize_keys
  end
end
