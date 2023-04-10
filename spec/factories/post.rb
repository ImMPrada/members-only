FactoryBot.define do
  factory :post do
    association :user
    association :clubhouse

    content do
      [
        Faker::Quote.famous_last_words,
        Faker::Quote.yoda
      ].sample
    end
  end
end
