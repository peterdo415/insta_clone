# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
FactoryBot.define do
  factory :post do
    body { Faker::Lorem.sentence }
    user
    after(:build) do |post|
      post.images.attach(io: File.open('spec/fixtures/dummy.jpg'), filename: 'dummy.jpg', content_type: 'image/jpeg')
    end
  end
end
