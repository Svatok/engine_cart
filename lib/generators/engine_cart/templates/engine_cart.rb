EngineCart.setup do |config|
  # Define person class
  config.person_class = 'User'
  
  # Define product class
  config.product_class = 'Product'

  # Define product price method
  config.product_price = 'price'
  
  # Define email from for order
  config.email_order = 'engine_cart@example.com'
end
