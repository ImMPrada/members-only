FactoryBot.define do
  factory :comment do
    association :user
    association :post

    content do
      [
        Faker::Quote.famous_last_words,
        Faker::Quote.yoda
      ].sample
    end
  end
end
