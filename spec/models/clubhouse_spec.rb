require 'rails_helper'

RSpec.describe Clubhouse, type: :model do
  subject(:clubhouse) { build(:clubhouse) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:users) }
  end

  describe '.with_owner' do
    let(:title) { "TED talks: #{Faker::ProgrammingLanguage.name}" }
    let(:clubhouse_with_owner) { described_class.with_owner(user, { title: }) }

    describe 'when owner user is nil' do
      let(:user) { nil }

      it 'returns a clubhouse instance' do
        expect(clubhouse_with_owner).to be_nil
      end
    end

    describe 'shen there is owner user' do
      let(:user) { create(:user) }

      it 'returns a clubhouse instance' do
        expect(clubhouse_with_owner).to be_instance_of(described_class)
      end
    end
  end
end
