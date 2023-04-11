require 'rails_helper'

RSpec.describe Membership, type: :model do
  subject(:membership) { build(:membership) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to allow_value(Membership::MEMBER_ROLE).for(:role) }
    it { is_expected.to allow_value(Membership::ADMIN_ROLE).for(:role) }
    it { is_expected.to allow_value(Membership::OWNER_ROLE).for(:role) }
    it { is_expected.not_to allow_value('not_a_role').for(:role) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:clubhouse) }
  end
end
