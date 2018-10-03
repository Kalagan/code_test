class Lead
  include ActiveModel::Model

  attr_reader :first_name, :last_name, :business_name, :telephone_number, :email

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :business_name, presence: true
  validates :telephone_number, presence: true
  validates :email, presence: true

  def initialize(first_name: nil, last_name: nil, business_name: nil, telephone_number: nil, email: nil)
    @first_name = first_name
    @last_name = last_name
    @business_name = business_name
    @telephone_number = telephone_number
    @email = email
  end

  def name
    [first_name, last_name].join(' ')
  end

  def send_lead
    LeadApi.new(self).send_lead
  end
end
