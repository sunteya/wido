# == Schema Information
#
# Table name: article_bodies
#
#  id         :integer          not null, primary key
#  content    :text
#  posted_at  :datetime
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article_body do
    content { Faker::Lorem.paragraphs.join("\n\n") }
  end
end
