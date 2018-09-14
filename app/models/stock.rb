class Stock < ApplicationRecord
  validates_presence_of :name, :interest, :duration, :unit_price
  validates_numericality_of :interest, :unit_price, greater_than: 0
  validates_numericality_of :duration, greater_than_or_equal_to: 1
  belongs_to :user
  monetize :unit_price_cents

  def year_value(year)
    (unit_price_dollars * (1 + interest_decimal) ** year).round(2)
  end

  def unit_price_dollars
    unit_price_cents / 100
  end

  def interest_decimal
    interest.to_d / 100
  end
end
