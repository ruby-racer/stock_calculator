require 'rails_helper'

describe 'Stocks management', type: :feature do
  let(:user) {create(:user, password: 'password')}
  let(:new_stock) {Stock.new(name: 'Stock name', unit_price: 10000, duration: 4, interest: 5, user: user)}
  let(:form) {StockForm.new}

  context 'authenticated user' do
    before :each do
      login_as user
    end

    it 'successfully creates new stock' do
      form.visit_page(new_stock_path)
      form.fill_with(new_stock)
      form.submit

      expect(page).to have_content('Stock was successfully created.')
    end

    it "can't create stock without duration" do
      new_stock.duration = nil
      form.visit_page(new_stock_path)
      form.fill_with(new_stock)
      form.submit

      expect(page).to have_content("Duration can't be blank")
    end

    it "can't create stock without interest" do
      new_stock.interest = nil
      form.visit_page(new_stock_path)
      form.fill_with(new_stock)
      form.submit

      expect(page).to have_content("Interest can't be blank")
    end

    it "can't create stock without name" do
      new_stock.name = nil
      form.visit_page(new_stock_path)
      form.fill_with(new_stock)
      form.submit

      expect(page).to have_content("Name can't be blank")
    end

    it 'updates stock' do
      stock = create(:stock, user: user)
      form.visit_page(edit_stock_path(stock))
      stock.name = 'New stock name'
      form.fill_with(stock)
      form.submit('Update Stock')

      expect(page).to have_content('Stock was successfully updated.')
    end

    it "can't update stock with invalid data" do
      stock = create(:stock, user: user)
      form.visit_page(edit_stock_path(stock))
      stock.name = nil
      form.fill_with(stock)
      form.submit('Update Stock')

      expect(page).to have_content("Name can't be blank")
    end

    it 'displays 404 error when accessing not existent stock' do
      form.visit_page(edit_stock_path(-1))

      expect(page.status_code).to eq(404)
    end

    it 'displays alert message after deleting stock' do
      stock = create(:stock, user: user)
      visit stocks_path
      click_on 'Destroy'

      expect(page).to have_content('Stock was successfully destroyed.')
    end

    it 'displays stock info' do
      stock = create(:stock, user: user)
      visit stock_path(stock)

      expect(page).to have_content(stock.name)
    end

    it 'root page displays all stocks' do
      stock1 = create(:stock, user: user, name: 'Stock 1')
      stock2 = create(:stock, user: user, name: 'Stock 2')
      visit stocks_path

      expect(page).to have_content(stock1.name)
      expect(page).to have_content(stock2.name)
    end
  end

  context 'guest user' do
    it "can't create Stocks" do
      visit new_stock_path

      expect(page).to have_content('You need to sign in or sign up before continuing')
    end
    it "doesn't see the 'Add Stock' link" do
      visit root_path

      expect(page).to_not have_content('Add Stock')
    end
  end
end
