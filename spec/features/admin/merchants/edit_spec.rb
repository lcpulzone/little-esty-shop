require 'rails_helper'

RSpec.describe 'Admin Merchants Edit Page' do
  before :each do
    @merchant1 = Merchant.create!(name: "Tyler", status: 1)
    @merchant2 = Merchant.create!(name: "Jill", status: 1)
    @merchant3 = Merchant.create!(name: "Bob", status: 1)

    visit edit_admin_merchant_path(@merchant1)
  end

  it 'I see prefilled form' do
    expect(current_path).to eq(edit_admin_merchant_path(@merchant1))
    expect(page).to have_field('Name', with: "#{@merchant1.name}")
    expect(page).to have_button('Update Merchant')
  end

  it "if form is properly filled out and submitted" do
    expect(current_path).to eq(edit_admin_merchant_path(@merchant1))

    fill_in 'Name', with: 'Malibu Mickey'
    click_button 'Update Merchant'

    expect(current_path).to eq(admin_merchant_path(@merchant1))
    expect(page).to have_content('Merchant was successfully update!')
    expect(page).to have_content('Malibu Mickey')
  end

  it "if form is NOT properly filled out and submitted" do
    fill_in 'Name', with: ""

    click_button 'Update Merchant'

    expect(page).to have_content("Error: Name can't be blank")
    expect(page).to_not have_content('Malibu Mickey')
  end
end
