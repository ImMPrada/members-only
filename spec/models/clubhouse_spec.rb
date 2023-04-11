require 'rails_helper'

RSpec.describe Clubhouse, type: :model do
  subject(:clubhouse) { build(:clubhouse) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:memberships) }
    it { is_expected.to have_many(:users) }
  end

  describe '.create_with_owner' do
    let(:title) { "TED talks: #{Faker::ProgrammingLanguage.name}" }
    let(:clubhouse_create_with_owner) { described_class.create_with_owner(user, { title: }) }

    describe 'when owner user is nil' do
      let(:user) { nil }

      it 'returns a clubhouse instance' do
        expect(clubhouse_create_with_owner).to be_nil
      end
    end

    describe 'shen there is owner user' do
      let(:user) { create(:user) }

      it 'returns a clubhouse instance' do
        expect(clubhouse_create_with_owner).to be_instance_of(described_class)
      end
    end
  end

  describe '#owners' do
    let(:user) { create(:user) }
    let(:title) { "TED talks: #{Faker::ProgrammingLanguage.name}" }

    before do
      clubhouse = described_class.create_with_owner(user, { title: })

      user = create(:user)
      create(:membership, user:, clubhouse:, role: Membership::OWNER_ROLE)

      user = create(:user)
      create(:membership, user:, clubhouse:, role: Membership::OWNER_ROLE)

      user = create(:user)
      create(:membership, user:, clubhouse:, role: Membership::MEMBER_ROLE)
    end

    it 'returns an array of users' do
      expect(described_class.first.owners).to all(be_instance_of(User))
    end
  end

  describe '#admins' do
    let(:user) { create(:user) }
    let(:title) { "TED talks: #{Faker::ProgrammingLanguage.name}" }

    before do
      clubhouse = described_class.create_with_owner(user, { title: })

      user = create(:user)
      create(:membership, user:, clubhouse:, role: Membership::ADMIN_ROLE)

      user = create(:user)
      create(:membership, user:, clubhouse:, role: Membership::ADMIN_ROLE)

      user = create(:user)
      create(:membership, user:, clubhouse:, role: Membership::MEMBER_ROLE)
    end

    it 'returns an array of users' do
      expect(described_class.first.admins).to all(be_instance_of(User))
    end
  end

  describe '#members' do
    let(:user) { create(:user) }
    let(:title) { "TED talks: #{Faker::ProgrammingLanguage.name}" }

    before do
      clubhouse = described_class.create_with_owner(user, { title: })

      user = create(:user)
      create(:membership, user:, clubhouse:, role: Membership::MEMBER_ROLE)

      user = create(:user)
      create(:membership, user:, clubhouse:, role: Membership::MEMBER_ROLE)

      user = create(:user)
      create(:membership, user:, clubhouse:, role: Membership::MEMBER_ROLE)
    end

    it 'returns an array of users' do
      expect(described_class.first.members).to all(be_instance_of(User))
    end
  end
end
