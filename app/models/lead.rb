class Lead
  include ActiveModel::Model

  attr_reader :first_name, :last_name

  validates :first_name, presence: true
  validates :last_name, presence: true

  def initialize(first_name: nil, last_name: nil)
    @first_name = first_name
    @last_name = last_name
  end
end
