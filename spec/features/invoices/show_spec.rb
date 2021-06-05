require 'rails_helper'

RSpec.describe 'invoice show page' do
  before(:each) do
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @antimerchant = Merchant.create!(name: 'TheOtherOne')
    @customer = Customer.create!(first_name: 'John', last_name: 'Smith')
    @item_1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant.id)
    @item_3 = Item.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, merchant_id: @antimerchant.id)
    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer.id)
    @invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 5, unit_price: 16.3, status: 1, invoice_id: @invoice_1.id, item_id: @item_2.id)
    @invoice_item_3 = InvoiceItem.create!(quantity: 4, unit_price: 19.4, status: 1, invoice_id: @invoice_1.id, item_id: @item_3.id)
  end

  xit 'displays the invoice id, status, created at, and customer name' do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"

    expect(page).to have_content("#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_1.status}")
    expect(page).to have_content("#{@invoice_1.created_at}") #need to parse it to read day of week, month day, year
    expect(page).to have_content("#{@customer.first_name}")
    expect(page).to have_content("#{@customer.last_name}")
  end

  xit 'shows all items on the invoice with their names, quantities, unit prices, and status of the invoice item' do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"

    expect(page).to have_content("Items:")
    expect(page).to have_content("#{@item_1.name}")
    expect(page).to have_content("#{@invoice_item_1.quantity}")
    expect(page).to have_content("#{@invoice_item_1.unit_price}")
    expect(page).to have_content("#{@invoice_item_1.status}")

    expect(page).to have_content("#{@item_2.name}")
    expect(page).to have_content("#{@invoice_item_2.quantity}")
    expect(page).to have_content("#{@invoice_item_2.unit_price}")
    expect(page).to have_content("#{@invoice_item_2.status}")

    expect(page).to have_no_content("#{@item_3.name}")
    expect(page).to have_no_content("#{@invoice_item_3.quantity}")
    expect(page).to have_no_content("#{@invoice_item_3.unit_price}")
    expect(page).to have_no_content("#{@invoice_item_3.status}")
  end

  xit 'can show the total revenue generated by all of the items on the invoice that belong to this merchant' do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"

    expect(page).to have_content("Total Revenue from this Invoice:")
    expect(page).to have_content("#{Invoice.total_revenue_by_merchant(@merchant.id)}")
  end

  xit 'can select a new status for the invoice item, submit the change, and show the new status when submitted' do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"

    page.select('2', from: 'status')
    click_button('Update Item Status')

    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}")
    within('Status:') do
      expect(page).to have_content('2')
    end
  end
end
