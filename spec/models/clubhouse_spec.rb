require 'rails_helper'

RSpec.describe Clubhouse, type: :model do
  subject(:clubhouse) { build(:clubhouse) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:memberships) }
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

  describe '#owners' do
    let(:user) { create(:user) }
    let(:title) { "TED talks: #{Faker::ProgrammingLanguage.name}" }

    before do
      clubhouse = described_class.with_owner(user, { title: })

      user = create(:user)
      Membership.create(user:, clubhouse:, role: 'owner')

      user = create(:user)
      Membership.create(user:, clubhouse:, role: 'owner')

      user = create(:user)
      Membership.create(user:, clubhouse:, role: 'member')
    end

    it 'returns an array of users' do
      expect(described_class.first.owners).to all(be_instance_of(User))
    end

    it 'returns an array of right size' do
      expect(described_class.first.owners.size).to eq(3)
    end
  end

  describe '#admins' do
    let(:user) { create(:user) }
    let(:title) { "TED talks: #{Faker::ProgrammingLanguage.name}" }

    before do
      clubhouse = described_class.with_owner(user, { title: })

      user = create(:user)
      Membership.create(user:, clubhouse:, role: 'admin')

      user = create(:user)
      Membership.create(user:, clubhouse:, role: 'admin')

      user = create(:user)
      Membership.create(user:, clubhouse:, role: 'member')
    end

    it 'returns an array of users' do
      expect(described_class.first.admins).to all(be_instance_of(User))
    end

    it 'returns an array of right size' do
      expect(described_class.first.admins.size).to eq(2)
    end
  end

  describe '#members' do
    let(:user) { create(:user) }
    let(:title) { "TED talks: #{Faker::ProgrammingLanguage.name}" }

    before do
      clubhouse = described_class.with_owner(user, { title: })

      user = create(:user)
      Membership.create(user:, clubhouse:)

      user = create(:user)
      Membership.create(user:, clubhouse:)

      user = create(:user)
      Membership.create(user:, clubhouse:)
    end

    it 'returns an array of users' do
      expect(described_class.first.members).to all(be_instance_of(User))
    end

    it 'returns an array of right size' do
      expect(described_class.first.members.size).to eq(3)
    end
  end
end
