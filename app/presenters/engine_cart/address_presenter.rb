module EngineCart
  class AddressPresenter < Rectify::Presenter
    attribute :object

    def use_billing?
      return false unless address_form('billing').valid? || address_form('shipping').valid?
      address_form('billing').attributes.except(:address_type) == address_form('shipping').attributes.except(:address_type)
    end

    def address_form(address_type)
      forms_has_errors? ? form_with_errors(address_type) : form_without_errors(address_type)
    end

    private

    def form_with_errors(address_type)
      object[address_type.to_sym]
    end

    def forms_has_errors?
      object.is_a?(Hash)
    end

    def form_without_errors(address_type)
      user_adresses = current_person.addresses.find_by(address_type: address_type) if current_person.respond_to?('addresses')
      address = object.addresses.find_by(address_type: address_type) || user_adresses
      address.present? ? AddressForm.from_model(address) : AddressForm.new
    end
  end
end
