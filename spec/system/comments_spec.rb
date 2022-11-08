require 'rails_helper'

RSpec.describe "Comments", type: :system do
  let!(:user) { create(:user) }
  let!(:post) { create(:post) }
  before do
    login_as(user)
  end

  describe '作成' do
    it 'コメントが作成できること' do
      visit post_path(post)
      within('#form_comment') do
        fill_in "コメント",	with: "sometext"
        click_on '登録する'
      end
      expect(page).to have_content 'sometext'
    end
  end

end
