require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_uniqueness_of(:email) }

    describe 'email format' do
      it { is_expected.to allow_value('email@addresse.foo').for(:email) }
      it { is_expected.not_to allow_value('foo').for(:email) }
    end

    describe 'username length' do
      it { is_expected.to validate_length_of(:username).is_at_least(3) }
      it { is_expected.to validate_length_of(:username).is_at_most(20) }
      it { is_expected.not_to allow_value('ab').for(:username) }
      it { is_expected.not_to allow_value('username_with_more_than_20_characters').for(:username) }
      it { is_expected.to allow_value('abcd').for(:username) }
    end
  end

  describe '#clubhouses_as_owner' do
    let(:title) { "TED talks: #{Faker::ProgrammingLanguage.name}" }

    before do
      user = create(:user)
      Clubhouse.with_owner(user, { title: })
      Clubhouse.with_owner(user, { title: })
      Clubhouse.with_owner(user, { title: })
    end

    it 'returns an array of users' do
      expect(described_class.first.clubhouses_as_owner).to all(be_instance_of(Clubhouse))
    end

    it 'returns an array of right size' do
      expect(described_class.first.clubhouses_as_owner.size).to eq(3)
    end
  end

  describe '#clubhouses_as_admin' do
    let(:owner) { create(:user) }
    let(:title) { "TED talks: #{Faker::ProgrammingLanguage.name}" }

    before do
      user = create(:user)
      clubhouse = Clubhouse.with_owner(owner, { title: })
      Membership.create(user:, clubhouse:, role: 'admin')
      clubhouse = Clubhouse.with_owner(owner, { title: })
      Membership.create(user:, clubhouse:, role: 'admin')
      clubhouse = Clubhouse.with_owner(owner, { title: })
      Membership.create(user:, clubhouse:, role: 'admin')
    end

    it 'returns an array of users' do
      expect(described_class.first.clubhouses_as_admin).to all(be_instance_of(Clubhouse))
    end

    it 'returns an array of right size' do
      expect(described_class.first.clubhouses_as_admin.size).to eq(3)
    end
  end

  describe '#clubhouses_as_member' do
    let(:owner) { create(:user) }
    let(:title) { "TED talks: #{Faker::ProgrammingLanguage.name}" }

    before do
      user = create(:user)
      clubhouse = Clubhouse.with_owner(owner, { title: })
      Membership.create(user:, clubhouse:)
      clubhouse = Clubhouse.with_owner(owner, { title: })
      Membership.create(user:, clubhouse:)
      clubhouse = Clubhouse.with_owner(owner, { title: })
      Membership.create(user:, clubhouse:)
    end

    it 'returns an array of users' do
      expect(described_class.first.clubhouses_as_member).to all(be_instance_of(Clubhouse))
    end

    it 'returns an array of right size' do
      expect(described_class.first.clubhouses_as_member.size).to eq(3)
    end
  end
end
