require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  # describe 'validations' do
  #   it { should validate_presence_of(:) }
  # end
  #
  # before :each do
  #
  # end
  #
  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
  
  # describe 'instance methods' do
  #   describe '#making a date in readable fashion' do
  #     it '' do
        
  #     end
  #   end
  # end
end
