require 'rails_helper'
require 'debug'

RSpec.describe "SignUp", type: :system do
  describe "ユーザー登録" do
    context "入力情報が正しい場合" do
      it "ユーザー登録が行われること" do
        visit "/signup"
        fill_in 'ユーザー名', with: "こうすけ"
        fill_in 'メールアドレス', with: "kosuke@example.com"
        fill_in 'パスワード', with: "password"
        fill_in 'パスワード確認', with: "password"
        click_on '登録する'

        expect(page).to have_content "ユーザー登録が完了しました"

      end
    end

    context "入力情報が誤っている場合" do
      it "エラーメッセージが表示されること" do
        visit "/signup"
        fill_in 'ユーザー名', with: "kosuke"
        fill_in 'メールアドレス', with: ""
        fill_in 'パスワード', with: "password"
        fill_in 'パスワード確認', with: "password"
        click_on '登録する'

        expect(page).to have_content 'メールアドレスを入力してください'
      end
    end
  end
end
