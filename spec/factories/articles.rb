# == Schema Information
#
# Table name: articles
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  slug              :string(255)
#  user_id           :integer
#  list_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#  disqus_identifier :string(255)
#  published_at      :datetime
#  revised_at        :datetime
#  state             :string(255)
#  posted_at         :datetime
#  body_id           :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.sentence }
    association :body, factory: :article_body

    trait :published do
      slug { Faker::Internet.slug }
      published_at { Time.current }
      posted_at { published_at }
      state :published
    end
  end
end
