require 'rails_helper'

RSpec.feature "Visitor navigates to cart after adding an item", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    3.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 29.95,
        image: open_asset('apparel1.jpg')
      )
    end
  end

  scenario "They see their item on the cart page" do

    # ACT
    visit root_path

    # click 'Add' (link) in first child article of class products
    within first 'div.products article' do
      click_on 'Add'
    end

    # Including '(1)' below implicitly checks the cart has been updated
    click_on 'My Cart (1)'
    
    # VERIFY
    expect(page).to have_content 'Unit Price'
    expect(page).to have_content 'TOTAL:	$29.95'

  end

end