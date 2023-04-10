FactoryBot.define do
  factory :membership do
    association :user
    association :clubhouse

    role { %w[member admin].sample }
  end
end
