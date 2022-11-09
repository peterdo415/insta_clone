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

  describe '更新' do
    let!(:comment) { create(:comment, post: post, user: user) }
    it 'コメントが更新できること' do
      visit post_path(post)
      within "#comment_#{comment.id}" do
        find('.btn-edit').click
      end
      within "#form_comment_#{comment.id}" do
        fill_in 'コメント', with: '更新コメント'
        click_on '更新する'
      end

      expect(page).to have_content '更新コメント'
    end
  end

  describe '削除' do
    let!(:comment) { create(:comment, post: post, user: user) }
    it 'コメントが削除できること' do
      visit post_path(post)
      within "#comment_#{comment.id}" do
        accept_confirm {find('.btn-delete').click}
      end
      expect(page).to_not have_content comment.body
    end
  end

end
