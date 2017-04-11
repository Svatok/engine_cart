# EngineCart
With EngineCart you can add the functionality of the shopping cart to your online store.

1. [Installation](#installation)
2. [Restrictions](#restrictions)
2. [Configuration](#configuration)
3. [Functionality](#Functionality)
    - [Cart](#cart)
    - [Checkout](#checkout)
    - [Orders](#orders)
4. [Examples](#examples)

## Installation
1. Add to your gemfile:
```ruby
gem 'engine_cart', github: 'Svatok/engine_cart', branch: 'dev'
```
2. Execute:
```bash
$ bundle install
```
3. Install EngineCart: 
```bash
$ rails g engine_cart:install PERSON_MODEL PRODUCT_MODEL
```

## Restrictions
You can add EngineCart to project if your products are divided into types:
 - product
 - coupon
 - shipping
 
Also in the product model should be similar to the following scopes:
```ruby
scope :main, -> { where(product_type: 'product') }
scope :coupons, -> { where(product_type: 'coupon') }
scope :shippings, -> { where(product_type: 'shipping') }
```
## Configuration
In `config/initializers/engine_cart.rb`
```ruby
...
# Define person class
config.person_class = 'User'

# Define product class
config.product_class = 'Product'

# Define product price method
config.product_price = 'price'

# Define email from for order
config.email_order = 'engine_cart@example.com'
...
```
## Functionality
### Cart
EngineCart has page with order items on which you can:
 - change the amount of chosen products
 - remove products from the cart
 - apply a coupon code for discount
### Checkout
After filling the cart the user goes to checkout:
 1. Filling billing and shipping addresses
 2. Choose delivery method
 3. Filling payment requisites
 4. Confirm completed information from previous steps
 5. Get success message about finished order and sending of the letter with order details.
### Order
EngineCart provides an opportunity for users to view their orders.

Order has states:
- Waiting for processing
- In progress
- In delivery
- Delivered
## Examples
A simple example without customization:
https://github.com/Svatok/test_store

A more complex example with customization (Bookstore):
https://github.com/Svatok/bookstore_with_engine_cart


## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
