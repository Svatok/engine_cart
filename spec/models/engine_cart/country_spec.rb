require 'rails_helper'

module EngineCart
  RSpec.describe Country, type: :model do
    subject { build :country }

    context 'association' do
      it { should have_many :addresses }
    end
  end
end
