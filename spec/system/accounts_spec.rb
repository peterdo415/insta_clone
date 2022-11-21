require 'rails_helper'

RSpec.describe "Accounts", type: :system do
  describe 'アカウント' do
    let!(:user) { create(:user) }
    before do
      login_as(user)
    end

    context 'アカウント更新' do
      it 'アカウントの更新ができること' do
        find('#navbarDropdownMenuAvatar').click
        click_on 'プロフィール'
        expect(current_path).to eq '/mypage/account/edit'
        attach_file 'user[avatar]', "#{Rails.root}/spec/fixtures/dummy.jpg"
        fill_in 'メールアドレス', with: 'dyson1@example.com'
        fill_in 'ユーザー名', with: 'dyson1'
        click_on '更新する'
        sleep 1
        user.reload
        expect(user.email).to eq 'dyson1@example.com'
        expect(user.username).to eq 'dyson1'
        expect(user.avatar.attached?).to eq true
      end
    end
  end

end
