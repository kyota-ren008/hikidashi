require 'rails_helper'

describe 'hikidashi管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:post_a) { FactoryBot.create(:post, name: '最初のhikidashi', user: user_a) }
    
  before do
    FactoryBot.create(:post, name:'最初のhikidashi', user: user_a)
    visit login_path
    fill_in 'email', with: login_user.email
    fill_in 'password', with: login_user.password
    click_button 'Login'
  end

  shared_examples_for 'ユーザーAが作成したhikidashiが表示される' do
    it { expect(page).to have_content '最初のhikidashi' }
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it_behaves_like 'ユーザーAが作成したhikidashiが表示される' 
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したhikidashiが表示されない' do
        expect(page).to have_no_content '最初のhikidashi'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit post_path(post_a)
      end

      it_behaves_like 'ユーザーAが作成したhikidashiが表示される'
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }
    let(:post_name) {  '新規作成のテストを書く' } # デフォルトとして設定

    before do
      visit new_post_path
      fill_in 'hikidashi', with: post_name
      click_button 'Create'
    end
    
    context '新規作成画面で名称を入力したとき' do
      let(:post_name) { '新規作成のテストを書く' }
      
      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '新規作成画面で名称を入力しなかったとき' do
      let(:post_name) { '' } #上書き

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content 'hikidashiを入力してください'
        end
      end
    end
  end
end