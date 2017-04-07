FactoryGirl.define do
  factory :product do
    title 'Product Title'
    description 'Product Description'
    product_type 'product'
    status 'active'
    price 15
    
    trait :coupon do
      title { '123456789' }
      product_type 'coupon'
      description ''
      price -10.0
    end

    trait :shipping do
      title 'shipping'
      product_type 'shipping'
      description '3 to 5 days'
      price: 11.0
    end

    trait :with_orders do
      after(:create) do |product|
        create(:order_item, product: product)
      end
    end

  end
end
