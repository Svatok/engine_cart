FactoryGirl.define do
  factory :address, class: EngineCart::Address do
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    address FFaker::Address.street_name
    city FFaker::Address.city
    zip 49000
    phone '+3807777777'
    country_id { create(:country).id }

    trait :shipping do
      address_type :shipping
    end

    trait :billing do
      address_type :billing
    end

    factory :shipping_address, traits: [:shipping]
    factory :billing_address, traits: [:billing]
  end
end
