class Payment < ApplicationRecord
  attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year
  belongs_to :user

  def self.month_option
    Date::MONTHNAMES.compact.each_with_index.map { |name, i|["#{i + 1} - #{name}", i+1]}
  end

  def self.year_option
    (Date.today.year.. (Date.today.year + 10)).to_a
  end

  def process_payment
    binding.b
    customer = Stripe::Customer.create email: email, card: token
    binding.b
    Stripe::Charge.create customer: customer.id,
                          amount: 1000,
                          description: "Premium",
                          currency: "usd"
  end
end
