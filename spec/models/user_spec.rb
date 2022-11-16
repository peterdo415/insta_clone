# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string(255)
#  email            :string(255)      not null
#  salt             :string(255)
#  username         :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#
require 'rails_helper'
require 'debug'

RSpec.describe User, type: :model do
  describe '#like' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }
    it 'いいねできること' do
      expect{user.like(post)}.to change { Like.count }.by(1)
    end
  end

  describe '#unlike' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }
    before do
      user.like(post)
    end
    it 'いいねが解除できること' do
      expect{user.unlike(post)}.to change {Like.count}.by(-1)
    end
  end

  describe '#like?' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }
    let!(:not_like_post) { create(:post) }
    before do
      user.like(post)
    end
    it 'いいねの判定ができること' do
      expect(user.like?(post)).to be true
      expect(user.like?(not_like_post)).to be false
    end
  end

  describe '#follow' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user) }
    it 'フォローできること' do
      expect{user_a.follow(user_b)}.to change {Relationship.count}.by(1)
    end
  end

  describe '#unfollow' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user) }
    before do
      user_a.follow(user_b)
    end
    it 'フォローをフォローを外せること' do
      expect{user_a.unfollow(user_b)}.to change {Relationship.count }.by(-1)
    end
  end

  describe '#following?' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user) }
    context 'フォローしている場合' do
      before do
        user_a.follow(user_b)
      end
      it 'trueを返すこと' do
        expect(user_a.following?(user_b)).to be true
      end
    end

    context 'フォローしていない場合' do
      let!(:user_a) { create(:user) }
      let!(:user_b) { create(:user) }
      it 'falseを返すこと' do
        expect(user_a.following?(user_b)).to be false
      end
    end
  end

  describe '#recent' do
    let(:base_datetime) { Time.current }
    let!(:user_a) { create(:user, created_at: base_datetime) }
    let!(:user_b) { create(:user, created_at: base_datetime.ago(1.day)) }
    let!(:user_c) { create(:user, created_at: base_datetime.ago(2.day)) }
    let!(:user_d) { create(:user, created_at: base_datetime.ago(3.day)) }
    it '新しくアカウントが作られた順にユーザーを取得できる' do
      expect(User.recent(3)).to eq [user_a, user_b, user_c]
    end
  end

  describe '#feed' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user) }
    let!(:user_c) { create(:user) }
    let!(:post_by_user_a) { create(:post, user: user_a) }
    let!(:post_by_user_b) { create(:post, user: user_b) }
    let!(:post_by_user_c) { create(:post, user: user_c) }
    before do
      user_a.follow(user_b)
    end
    subject { user_a.feed }
    it {is_expected.to include post_by_user_a}
    it {is_expected.to include post_by_user_b}
    it {is_expected.not_to include post_by_user_c}
  end
end
