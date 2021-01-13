# Jungle

A mini e-commerce application built with Rails 4.2 for purposes of teaching Rails by example. Test coverage uses RSpec, Capybara and Poltergeist.

An admin panel is shown to all logged-in users allowing new products, categories, and sales to be added. The admin dashboard shows how many items of each are in their model. 

-------------
SCREENSHOTS

Home page:
https://github.com/mradamt/jungle-rails/blob/master/docs/Home_page.png "Home page"

Cart
https://github.com/mradamt/jungle-rails/blob/master/docs/Cart.png "Cart"

Admin Dashboard
https://github.com/mradamt/jungle-rails/blob/master/docs/Admin_Dashboard.png "Admin Dashboard"

Admin Sales
https://github.com/mradamt/jungle-rails/blob/master/docs/Admin_Sales.png "Admin Sales"

Admin Products
https://github.com/mradamt/jungle-rails/blob/master/docs/Admin_Products.png "Admin Products"

About us
https://github.com/mradamt/jungle-rails/blob/master/docs/About_us.png "About us"

--------

## Setup

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rake db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. (Sign up for a Stripe account)
7. Put Stripe (test) keys into appropriate .env vars
8. Run `bin/rails s -b 0.0.0.0` to start the server

## Stripe Testing

For testing success scenarios use Credit Card # 4242 4242 4242 4242, expiry any date in the future, CVC any 3 digits. 

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe

## Testing
* Capybara
* Poltergeist
* Database_cleaner
