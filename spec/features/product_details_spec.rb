require 'rails_helper'

RSpec.feature "Visitor navigates to product details page from home page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 29.95,
        image: open_asset('apparel1.jpg')
      )
    end
  end

  scenario "They see the product's details" do

    # ACT
    visit root_path

    # click 'Details' (link) in first child article of class products
    within first 'div.products article' do
      click_on 'Details'
    end
    
    # VERIFY
    expect(page).to have_content 'Apparel »'
    expect(page).to have_content 'Quantity 10'

  end

end