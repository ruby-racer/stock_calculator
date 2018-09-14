require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_numericality_of(:duration).is_greater_than_or_equal_to(1)}
    it {should validate_numericality_of(:interest).is_greater_than(0)}
  end

  describe 'associations' do
    it {should belong_to(:user)}
  end
end
