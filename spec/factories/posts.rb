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
    body { "MyString" }
    user_id { 1 }
  end
end
