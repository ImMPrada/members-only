require 'rails_helper'

RSpec.describe Clubhouse, type: :model do
  subject(:clubhouse) { build(:clubhouse) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:users) }
  end
end
